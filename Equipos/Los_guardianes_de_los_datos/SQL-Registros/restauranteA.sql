
CREATE TABLE empleado
(
    numero_empleado integer NOT NULL,
    foto varchar(500) NOT NULL,
    rfc character varying(13) NOT NULL,
    nombre character varying(60) NOT NULL,
    ap_paterno character varying(60) NOT NULL,
    ap_materno character varying(60) NULL,
    edad smallint NULL,
    sueldo float NOT NULL,
    calle character varying(80) NOT NULL,
    numero smallint NOT NULL,
    cp integer NOT NULL,
    estado character varying(60) NOT NULL,
    colonia character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    es_mesero boolean NOT NULL,
    es_administrativo boolean NOT NULL,
    es_cocinero boolean NOT NULL,
    horario character varying(60) NULL default 'No aplica',
    rol character varying(60) NULL default 'No aplica',
    especialidad character varying(60) NULL default 'No aplica',
    CONSTRAINT pk_empleado PRIMARY KEY (numero_empleado),
    CONSTRAINT ak_rfc UNIQUE (rfc)
);

CREATE TABLE telefono
(
    telefono bigint NOT NULL,
    numero_empleado integer NOT NULL,
    CONSTRAINT pk_telefono PRIMARY KEY (telefono),
    CONSTRAINT fk_telefono_empleado FOREIGN KEY (numero_empleado) REFERENCES 
    empleado (numero_empleado) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE dependiente
(
    curp character varying(18) NOT NULL,
    nombre character varying(60) NOT NULL,
    ap_paterno character varying(60) NOT NULL,
    ap_materno character varying(60) NULL,
    parentesco character varying(30) NOT NULL,
    numero_empleado integer NOT NULL,
    CONSTRAINT pk_dependiente PRIMARY KEY (curp),
    CONSTRAINT fk_dependiente_empleado FOREIGN KEY (numero_empleado) REFERENCES 
    empleado (numero_empleado) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE cliente
(
    rfc character varying(13) NOT NULL,
    email character varying(200) NOT NULL,
    nombre character varying(60) NOT NULL,
    ap_paterno character varying(60) NOT NULL,
    ap_materno character varying(60) NULL,
    fecha_nacimiento date NOT NULL,
    razon_social character varying(150) NOT NULL,
    cp integer NOT NULL,
    estado character varying(60) NOT NULL,
    numero smallint NOT NULL,
    calle character varying(80) NOT NULL,
    colonia character varying(100) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (rfc)
);

CREATE TABLE orden
(
    folio character varying(20) NOT NULL,
    fecha date NOT NULL default now(),
    precio_total real NULL,
    cantidad_total smallint NULL, 
    numero_empleado integer NULL, 
    rfc character varying(13) NULL,
    CONSTRAINT pk_orden PRIMARY KEY (folio),
    CONSTRAINT fk_orden_cliente FOREIGN KEY (rfc) REFERENCES cliente (rfc)
    ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_orden_empleado FOREIGN KEY (numero_empleado) REFERENCES 
    empleado (numero_empleado) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE categoria
(
    id_categoria integer NOT NULL,
    nombre character varying(50)  NOT NULL,
    descripcion character varying(500) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE producto
(
    id_producto integer NOT NULL,
    nombre character varying(150) NOT NULL,
    receta character varying(2000) NOT NULL,
    precio real NOT NULL,
    descripcion character varying(400) NOT NULL,
    disponibilidad boolean NOT NULL,
    tipo_producto character varying(8) NOT NULL,
    con_alcohol boolean NULL,
    platillo_del_dia boolean NULL,
    id_categoria integer NULL,
    cantidad_vendida integer NULL,
    CONSTRAINT pk_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES 
    categoria (id_categoria) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT ck_precio CHECK (precio > 0)
);

CREATE TABLE incluye
(
    folio character varying(20) NOT NULL,
    id_producto integer NOT NULL,
    cantidad_producto integer NOT NULL,
    precio_total_por_producto float NULL,
    CONSTRAINT pk_incluye PRIMARY KEY (folio, id_producto),
    CONSTRAINT fk_incluye_orden FOREIGN KEY (folio) REFERENCES orden (folio)
    ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_incluye_producto FOREIGN KEY (id_producto) REFERENCES 
    producto (id_producto) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT ck_cantidad_producto CHECK (cantidad_producto > 0)
);

--INDICE EN EL NOMBRE DEL PRODUCTO
CREATE INDEX ix_nombre_producto ON producto USING btree (nombre);

--SECUENCIADOR PARA EL FOLIO DE LA ORDEN

CREATE SEQUENCE folio
START WITH 00001
INCREMENT BY 1
MAXVALUE 99999
MINVALUE 00001
NO CYCLE;

--TRIGGER PARA LA EDAD:

CREATE FUNCTION edad_trigger() RETURNS TRIGGER AS $edad_trigger$
BEGIN 
NEW.edad=date_part('year',age(now(),NEW.fecha_nacimiento));
RETURN NEW;
END;
$edad_trigger$ LANGUAGE plpgsql;
CREATE TRIGGER edad_trigger BEFORE INSERT OR UPDATE ON empleado FOR EACH ROW EXECUTE PROCEDURE edad_trigger();

--TRIGGER PARA LA CANTIDAD_TOTAL EN LA ORDEN:

CREATE FUNCTION cantidad_total_trigger() RETURNS TRIGGER AS $cantidad_total$
BEGIN 
IF (TG_OP ='INSERT') THEN
    UPDATE orden SET cantidad_total=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT folio, sum(cantidad_producto) as cantidad_producto from incluye group by folio) as suma WHERE folio=NEW.folio) as resultado) WHERE orden.folio=NEW.folio;
ELSEIF (TG_OP ='UPDATE') THEN
    UPDATE orden SET cantidad_total=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT folio, sum(cantidad_producto) as cantidad_producto from incluye group by folio) as suma WHERE folio=NEW.folio) as resultado) WHERE orden.folio=NEW.folio;
ELSEIF (TG_OP ='DELETE') THEN
    UPDATE orden SET cantidad_total=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT folio, sum(cantidad_producto) as cantidad_producto from incluye group by folio) as suma WHERE folio=OLD.folio) as resultado) WHERE orden.folio=OLD.folio;
END IF;
RETURN NULL;
END;
$cantidad_total$ LANGUAGE plpgsql;
CREATE TRIGGER cantidad_total_ins_trigger AFTER INSERT ON incluye FOR EACH ROW EXECUTE PROCEDURE cantidad_total_trigger();
CREATE TRIGGER cantidad_total_upd_trigger AFTER UPDATE ON incluye FOR EACH ROW EXECUTE PROCEDURE cantidad_total_trigger();
CREATE TRIGGER cantidad_total_del_trigger AFTER DELETE ON incluye FOR EACH ROW EXECUTE PROCEDURE cantidad_total_trigger();

--TRIGGER PARA EL PRECIO_TOTAL_POR_PRODUCTO

CREATE FUNCTION precio_total_por_producto_trigger() RETURNS TRIGGER AS $precio_total_por_producto_trigger$
BEGIN
NEW.precio_total_por_producto=(NEW.cantidad_producto)*(SELECT precio from producto WHERE id_producto=NEW.id_producto);
RETURN NEW;
END;
$precio_total_por_producto_trigger$ LANGUAGE plpgsql;
CREATE TRIGGER precio_total_por_producto_trigger BEFORE INSERT OR UPDATE ON incluye FOR EACH ROW EXECUTE PROCEDURE precio_total_por_producto_trigger();

--TRIGGER PARA EL PRECIO_TOTAL DE LA ORDEN:

CREATE FUNCTION precio_total_trigger() RETURNS TRIGGER AS $precio_total$
BEGIN 
IF (TG_OP ='INSERT') THEN
    UPDATE orden SET precio_total=(SELECT precio_total_por_producto from (SELECT precio_total_por_producto from (SELECT folio, sum(precio_total_por_producto) as precio_total_por_producto from incluye group by folio) as suma WHERE folio=NEW.folio) as resultado) WHERE orden.folio=NEW.folio;
ELSEIF (TG_OP ='UPDATE') THEN
    UPDATE orden SET precio_total=(SELECT precio_total_por_producto from (SELECT precio_total_por_producto from (SELECT folio, sum(precio_total_por_producto) as precio_total_por_producto from incluye group by folio) as suma WHERE folio=NEW.folio) as resultado) WHERE orden.folio=NEW.folio;
ELSEIF (TG_OP ='DELETE') THEN
    UPDATE orden SET precio_total=(SELECT precio_total_por_producto from (SELECT precio_total_por_producto from (SELECT folio, sum(precio_total_por_producto) as precio_total_por_producto from incluye group by folio) as suma WHERE folio=OLD.folio) as resultado) WHERE orden.folio=OLD.folio;

END IF;
RETURN NULL;
END;
$precio_total$ LANGUAGE plpgsql;
CREATE TRIGGER precio_total_ins_trigger AFTER INSERT ON incluye FOR EACH ROW EXECUTE PROCEDURE precio_total_trigger();
CREATE TRIGGER precio_total_upd_trigger AFTER UPDATE ON incluye FOR EACH ROW EXECUTE PROCEDURE precio_total_trigger();
CREATE TRIGGER precio_total_del_trigger AFTER DELETE ON incluye FOR EACH ROW EXECUTE PROCEDURE precio_total_trigger();

--TRIGGER PARA CANTIDAD_VENDIDA DE CADA PRODUCTO:

CREATE FUNCTION cantidad_vendida_trigger() RETURNS TRIGGER AS $cantidad_vendida$
BEGIN 
IF (TG_OP ='INSERT') THEN
    UPDATE producto SET cantidad_vendida=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT id_producto, sum(cantidad_producto) as cantidad_producto from incluye group by id_producto) as suma WHERE id_producto=NEW.id_producto) as resultado) WHERE producto.id_producto=NEW.id_producto;
ELSEIF (TG_OP ='UPDATE') THEN
    UPDATE producto SET cantidad_vendida=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT id_producto, sum(cantidad_producto) as cantidad_producto from incluye group by id_producto) as suma WHERE id_producto=NEW.id_producto) as resultado) WHERE producto.id_producto=NEW.id_producto;
ELSEIF (TG_OP ='DELETE') THEN
    UPDATE producto SET cantidad_vendida=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT id_producto, sum(cantidad_producto) as cantidad_producto from incluye group by id_producto) as suma WHERE id_producto=OLD.id_producto) as resultado) WHERE producto.id_producto=OLD.id_producto;
END IF;
RETURN NULL;
END;
$cantidad_vendida$ LANGUAGE plpgsql;
CREATE TRIGGER cantidad_vendida_ins_trigger AFTER INSERT ON incluye FOR EACH ROW EXECUTE PROCEDURE cantidad_vendida_trigger();
CREATE TRIGGER cantidad_vendida_upd_trigger AFTER UPDATE ON incluye FOR EACH ROW EXECUTE PROCEDURE cantidad_vendida_trigger();
CREATE TRIGGER cantidad_vendida_del_trigger AFTER DELETE ON incluye FOR EACH ROW EXECUTE PROCEDURE cantidad_vendida_trigger();

--TRIGGER PARA PRODUCTOS NO DISPONIBLES:

CREATE FUNCTION disponibilidad_producto_trigger() RETURNS TRIGGER AS $disponibilidad_producto_trigger$
BEGIN
IF ((SELECT disponibilidad from producto WHERE id_producto=NEW.id_producto)=false) THEN
    RAISE EXCEPTION 'Producto no disponible por el momento';
END IF;
RETURN NEW;
END;
$disponibilidad_producto_trigger$ LANGUAGE plpgsql;
CREATE TRIGGER disponibilidad_producto_trigger BEFORE INSERT OR UPDATE ON incluye FOR EACH ROW EXECUTE PROCEDURE disponibilidad_producto_trigger();

--TRIGGER PARA QUE UNA ORDEN SOLO SE ASOCIE A UN MESERO:

CREATE FUNCTION mesero_a_orden_trigger() RETURNS TRIGGER AS $mesero_a_orden_trigger$
BEGIN
IF ((SELECT es_mesero from empleado WHERE numero_empleado=NEW.numero_empleado)=false) THEN
    RAISE EXCEPTION 'El empleado que se intenta asociar a la orden no es mesero';
ELSEIF (NOT EXISTS(SELECT numero_empleado from empleado WHERE numero_empleado=NEW.numero_empleado)) THEN
    RAISE EXCEPTION 'El empleado que se intenta asociar a la orden no existe en la base de datos';
END IF;
RETURN NEW;
END;
$mesero_a_orden_trigger$ LANGUAGE plpgsql;
CREATE TRIGGER mesero_a_orden_trigger BEFORE INSERT OR UPDATE ON orden FOR EACH ROW EXECUTE PROCEDURE mesero_a_orden_trigger();

--FUNCION PARA EL FOLIO DE LA ORDEN

CREATE OR REPLACE FUNCTION folio_orden() RETURNS VARCHAR AS $folio_orden$
DECLARE identificador varchar(8);
BEGIN
identificador:=CONCAT('ORD-',CAST((SELECT nextval('folio')) AS VARCHAR));
RETURN identificador;
END;
$folio_orden$  LANGUAGE plpgsql;

--FUNCION EMPLEADOS-MESERO CANTIDAD DE ORDENES Y MONTO CON RAISE EXCEPTION

CREATE OR REPLACE FUNCTION mesero_ordenes_al_dia_bdd_function 
(
    num_empleado int
)
returns table(numero_empleado int,numero_ordenes bigint, precio_total_ordenes real)
LANGUAGE plpgsql AS
$func$
BEGIN
    IF((SELECT es_Mesero from empleado WHERE empleado.numero_empleado=num_empleado)=FALSE) THEN
        RAISE EXCEPTION 'No es mesero';
    ELSEIF (EXISTS(SELECT empleado.numero_empleado from empleado WHERE empleado.numero_empleado=num_empleado)) THEN 
        return query
        SELECT DISTINCT empleado.numero_empleado,(select count(orden.numero_empleado) as numero_ordenes from orden WHERE orden.numero_empleado=num_empleado and extract(year from fecha)=extract(year from now()) and extract(month from fecha)=extract(month from now()) and extract(day from fecha)=extract(day from now())),(select sum(orden.precio_total) as precio_total_ordenes from orden WHERE orden.numero_empleado=num_empleado and extract(year from fecha)=extract(year from now()) and extract(month from fecha)=extract(month from now()) and extract(day from fecha)=extract(day from now())) from empleado WHERE es_mesero=TRUE AND empleado.numero_empleado=num_empleado;
    ELSE
        RAISE EXCEPTION 'No existe el empleado';
   END IF;
END
$func$;

--FUNCION EMPLEADOS-MESERO CANTIDAD DE ORDENES Y MONTO CON TABLAS VACIAS

CREATE OR REPLACE FUNCTION mesero_ordenes_al_dia_function
(
    num_empleado int
)
returns table(numero_empleado int,numero_ordenes bigint, precio_total_ordenes real)
LANGUAGE plpgsql AS
$func$
BEGIN
    IF (EXISTS(SELECT empleado.numero_empleado from empleado WHERE empleado.numero_empleado=num_empleado) AND (SELECT es_Mesero from empleado WHERE empleado.numero_empleado=num_empleado)=TRUE) THEN
        return query
        SELECT DISTINCT empleado.numero_empleado,(select count(orden.numero_empleado) as numero_ordenes from orden WHERE orden.numero_empleado=num_empleado and extract(year from fecha)=extract(year from now()) and extract(month from fecha)=extract(month from now()) and extract(day from fecha)=extract(day from now())),(select sum(orden.precio_total) as precio_total_ordenes from orden WHERE orden.numero_empleado=num_empleado and extract(year from fecha)=extract(year from now()) and extract(month from fecha)=extract(month from now()) and extract(day from fecha)=extract(day from now())) from empleado WHERE es_mesero=TRUE AND empleado.numero_empleado=num_empleado;
    END IF;
        
END
$func$;

--FUNCION FECHA CANTIDAD DE VENTAS Y ORDENES, Y MONTO CON RAISE EXCEPTION

CREATE OR REPLACE FUNCTION cantidad_monto_ventas_fecha_bdd_function
(
    fecha_ingresada date
)
returns table(fecha date, cantidad_ordenes bigint, cantidad_ventas bigint,monto_total_ventas real)
LANGUAGE plpgsql AS
$func$
BEGIN
    IF (EXISTS(SELECT orden.fecha from orden WHERE orden.fecha=fecha_ingresada)) THEN 
        return query
        SELECT DISTINCT orden.fecha,(select count(orden.folio) as cantidad_ordenes from orden WHERE orden.fecha=fecha_ingresada),(select sum(orden.cantidad_total) as cantidad_ventas from orden WHERE orden.fecha=fecha_ingresada),(select sum(orden.precio_total) as monto_total_ventas from orden WHERE orden.fecha=fecha_ingresada) from orden WHERE orden.fecha=fecha_ingresada;
    ELSE
        RAISE EXCEPTION 'No hay ventas en esa fecha';
   END IF;
        
END
$func$;

--FUNCION FECHA CANTIDAD DE VENTAS Y ORDENES, Y MONTO CON TABLAS VACIAS

CREATE OR REPLACE FUNCTION cantidad_monto_ventas_fecha_function
(
    fecha_ingresada date
)
returns table(fecha date, cantidad_ordenes bigint, cantidad_ventas bigint,monto_total_ventas real)
LANGUAGE plpgsql AS
$func$
BEGIN
    IF (EXISTS(SELECT orden.fecha from orden WHERE orden.fecha=fecha_ingresada)) THEN 
        return query
        SELECT DISTINCT orden.fecha,(select count(orden.folio) as cantidad_ordenes from orden WHERE orden.fecha=fecha_ingresada),(select sum(orden.cantidad_total) as cantidad_ventas from orden WHERE orden.fecha=fecha_ingresada),(select sum(orden.precio_total) as monto_total_ventas from orden WHERE orden.fecha=fecha_ingresada) from orden WHERE orden.fecha=fecha_ingresada;
    
   END IF;
        
END
$func$;

--FUNCION FECHAS CANTIDAD DE VENTAS Y ORDENES, Y MONTO CON RAISE EXCEPTION

CREATE OR REPLACE FUNCTION cantidad_monto_ventas_fechas_bdd_function
(
    fecha_de_inicio date,
    fecha_de_fin date
)
returns table(fecha_inicio date, fecha_fin date,cantidad_ordenes bigint,cantidad_ventas bigint,monto_total_ventas real)
LANGUAGE plpgsql AS
$func$
BEGIN
    IF (EXISTS(SELECT orden.fecha from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin)) THEN 
        return query
        SELECT DISTINCT fecha_de_inicio,fecha_de_fin,(select count(orden.folio) as cantidad_ordenes from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin),(select sum(orden.cantidad_total) as cantidad_ventas from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin),(select sum(orden.precio_total) as monto_total_ventas from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin) from orden;
    ELSE
        RAISE EXCEPTION 'No hay ventas entre esas fechas';
   END IF;
        
END
$func$;

--FUNCION FECHAS CANTIDAD DE VENTAS Y ORDENES, Y MONTO CON TABLAS VACIAS

CREATE OR REPLACE FUNCTION cantidad_monto_ventas_fechas_function 
(
    fecha_de_inicio date,
    fecha_de_fin date
)
returns table(fecha_inicio date, fecha_fin date, cantidad_ordenes bigint,cantidad_ventas bigint,monto_total_ventas real)
LANGUAGE plpgsql AS
$func$
BEGIN
    IF (EXISTS(SELECT orden.fecha from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin)) THEN 
        return query
        SELECT DISTINCT fecha_de_inicio,fecha_de_fin,(select count(orden.folio) as cantidad_ordenes from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin),(select sum(orden.cantidad_total) as cantidad_ventas from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin),(select sum(orden.precio_total) as monto_total_ventas from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin) from orden;
    
   END IF;
        
END
$func$;

--FUNCION QUE RECIBE EL FOLIO DE LA ORDEN DEL CLIENTE Y MUESTRA SU FACTURA

CREATE OR REPLACE FUNCTION factura(folio_Orden varchar) RETURNS void AS 
$$
DECLARE
	registro RECORD;
	registro2 RECORD;
	cur_producto CURSOR FOR
	SELECT 
		orden.folio AS Folio,
    	incluye.id_producto AS idProducto,
  	 	producto.nombre AS Producto,
		producto.precio AS Precio,
    	incluye.cantidad_producto AS Cantidad,
    	incluye.precio_total_por_producto AS PrecioPorProducto
   FROM cliente
     JOIN orden ON cliente.rfc::text = orden.rfc::text
     JOIN incluye ON orden.folio::text = incluye.folio::text
     JOIN producto ON incluye.id_producto = producto.id_producto
WHERE folio_Orden = orden.folio;

BEGIN
	SELECT UPPER(cliente.razon_social) AS RazonSocial,
    cliente.rfc AS RFC,
    concat(cliente.calle, ' ', cliente.numero, ' ', cliente.colonia, ' ', cliente.cp, ' ', cliente.estado, ' ') AS Direccion,
    concat(cliente.nombre, ' ', cliente.ap_paterno, ' ', cliente.ap_materno, ' ') AS Nombre,
    cliente.email AS Email,
    cliente.fecha_nacimiento AS FechaNacimiento,
    orden.folio AS Folio,
    orden.fecha AS Fecha,
    orden.cantidad_total AS CantidadTotal,
    orden.precio_total AS PrecioTotal
   INTO registro
   FROM cliente
     JOIN orden ON cliente.rfc::text = orden.rfc::text
     JOIN incluye ON orden.folio::text = incluye.folio::text
     JOIN producto ON incluye.id_producto = producto.id_producto
WHERE folio_Orden = orden.folio
GROUP BY cliente.rfc, orden.folio;

-- Encabezado de la factura
	RAISE NOTICE '- - -  % - - -', registro.RazonSocial;
	RAISE NOTICE '';
	RAISE NOTICE 'Folio de la orden: %', registro.Folio;
	RAISE NOTICE 'Fecha: %', registro.Fecha;
 	RAISE NOTICE 'FACTURAR A %', registro.Nombre;
	RAISE NOTICE 'Dirección: %', registro.Direccion;
	RAISE NOTICE 'RFC: %', registro.RFC;
	RAISE NOTICE 'Email: %', registro.Email;


-- Cuerpo de la factura
	OPEN cur_producto;
	FETCH cur_producto INTO registro2;
	
	RAISE NOTICE '';
	RAISE NOTICE 'Cantidad|Descripcion    |Precio    |Importe';
	
	WHILE(registro2.Folio = folio_Orden) LOOP
		RAISE NOTICE '  %     | %         | %     | %', registro2.Cantidad, registro2.Producto, registro2.Precio, registro2.PrecioPorProducto;
		FETCH cur_producto INTO registro2;
	END LOOP;
	
	CLOSE cur_producto;
	
-- Fin de la factura
	RAISE NOTICE '';
	RAISE NOTICE 'Cantidad total de productos: %', registro.CantidadTotal;
	RAISE NOTICE 'Importe total: %', registro.PrecioTotal;
END
$$ LANGUAGE 'plpgsql';

--VISTA DEL PLATILLO MAS VENDIDO

CREATE VIEW platillo_mas_vendido_view AS SELECT * from producto WHERE cantidad_vendida=(SELECT MAX(cantidad_vendida) from producto WHERE tipo_producto='Platillo') AND tipo_producto='Platillo';

--VISTA DE LOS PRODUCTOS NO DISPONIBLES

CREATE VIEW productos_no_disponibles_view AS
SELECT nombre AS "Productos no disponibles"
FROM producto
WHERE disponibilidad=FALSE;


