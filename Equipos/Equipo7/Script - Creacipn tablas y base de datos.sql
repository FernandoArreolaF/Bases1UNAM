CREATE DATABASE proyectoFinal;

CREATE TABLE empleado(
	num_empleado int NOT NULL,
	ap_paterno varchar(30) NOT NULL,
	ap_mateno varchar(30) NOT NULL,
	nombre varchar(30) NOT NULL,
	edad smallint NOT NULL,
	rfc varchar(13) NOT NULL,
	fecha_nac date NOT NULL,
	sueldo int NOT NULL,
	foto varchar(100),
	estado varchar(30) NOT NULL,
	colonia varchar(60) NOT NULL,
	calle varchar(60) NOT NULL,
	numero smallint NOT NULL,
	cp int NOT NULL,
	admin_rol varchar(50),
	cocin_especialidad varchar(50),
	mesero_hora_inicio time,
	mesero_hora_fin time,
	CONSTRAINT empleado_pk PRIMARY KEY (num_empleado)
);

CREATE TABLE cliente(
	rfc varchar(13) NOT NULL,
	ap_paterno varchar(30) NOT NULL,
	ap_mateno varchar(30) NOT NULL,
	nombre varchar(30) NOT NULL,
	estado varchar(30) NOT NULL,
	colonia varchar(60) NOT NULL,
	calle varchar(60) NOT NULL,
	numero smallint NOT NULL,
	cp int NOT NULL,
	fecha_nac date NOT NULL,
	razon_social varchar(10),
	email varchar(50) NOT NULL,
	CONSTRAINT cliente_pk PRIMARY KEY (rfc)
);

CREATE TABLE dependiente(
	curp char(18) NOT NULL,
	ap_paterno varchar(30) NOT NULL,
	ap_mateno varchar(30) NOT NULL,
	nombre varchar(30) NOT NULL,
	parentesco varchar(30) NOT NULL,
	num_empleado int NOT NULL,
	CONSTRAINT dependiente_pk PRIMARY KEY (curp)
);

CREATE TABLE categoria(
	nombre varchar(20) NOT NULL,
	descripcion varchar(150) NOT NULL,
	CONSTRAINT categoria_pk PRIMARY KEY (nombre)
);

CREATE TABLE producto(
	nombre varchar(30) NOT NULL,
	descripcion varchar(200) NOT NULL,
	precio float NOT NULL,
	disponibilidad boolean NOT NULL, 
	receta varchar(5000),
	tipo char(1) NOT NULL,
	num_empleado int NOT NULL,
	nombre_categoria varchar(20) NOT NULL,
	CONSTRAINT producto_pk PRIMARY KEY (nombre)
);

CREATE TABLE orden(
	folio char(7) NOT NULL,
	total float NOT NULL DEFAULT 0,
	fecha date NOT NULL,
	num_empleado int NOT NULL,
	rfc_cliente varchar(13),
	CONSTRAINT orden_pk PRIMARY KEY (folio)
);

-- object: empleado_fk | type: CONSTRAINT --
-- ALTER TABLE producto DROP CONSTRAINT IF EXISTS empleado_fk CASCADE;
ALTER TABLE producto ADD CONSTRAINT producto_empleado_fk FOREIGN KEY (num_empleado)
REFERENCES empleado(num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: categoria_fk | type: CONSTRAINT --
-- ALTER TABLE producto DROP CONSTRAINT IF EXISTS categoria_fk CASCADE;
ALTER TABLE producto ADD CONSTRAINT producto_categoria_fk FOREIGN KEY (nombre_categoria)
REFERENCES categoria(nombre) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: empleado_fk | type: CONSTRAINT --
-- ALTER TABLE dependiente DROP CONSTRAINT IF EXISTS empleado_fk CASCADE;
ALTER TABLE dependiente ADD CONSTRAINT dependiente_empleado_fk FOREIGN KEY (num_empleado)
REFERENCES empleado(num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: telefono | type: TABLE --
-- DROP TABLE IF EXISTS telefono CASCADE;
CREATE TABLE telefono(
	telefono int8 NOT NULL,
	num_empleado int NOT NULL,
	CONSTRAINT telefono_pk PRIMARY KEY (telefono)
);

-- object: empleado_fk | type: CONSTRAINT --
-- ALTER TABLE telefono DROP CONSTRAINT IF EXISTS empleado_fk CASCADE;
ALTER TABLE telefono ADD CONSTRAINT telefono_empleado_fk FOREIGN KEY (num_empleado)
REFERENCES empleado(num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: empleado_fk | type: CONSTRAINT --
-- ALTER TABLE orden DROP CONSTRAINT IF EXISTS empleado_fk CASCADE;
ALTER TABLE orden ADD CONSTRAINT orden_empleado_fk FOREIGN KEY (num_empleado)
REFERENCES empleado(num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: productos_orden | type: TABLE --
-- DROP TABLE IF EXISTS productos_orden CASCADE;
CREATE TABLE productos_orden(
	id_productos_orden int,
	nombre_producto varchar(30) NOT NULL,
	folio_orden char(7) NOT NULL,
	total_por_producto float NOT NULL,
	cantidad smallint NOT NULL,
	CONSTRAINT productos_orden_pk PRIMARY KEY (id_productos_orden)
);
-- ddl-end --

CREATE SEQUENCE seq_id_productos_orden AS integer START 1 OWNED BY productos_orden.id_productos_orden;
ALTER TABLE productos_orden ALTER COLUMN id_productos_orden SET DEFAULT nextval('seq_id_productos_orden');

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE productos_orden DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE productos_orden ADD CONSTRAINT productos_orden_producto_fk FOREIGN KEY (nombre_producto)
REFERENCES producto(nombre) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: orden_fk | type: CONSTRAINT --
-- ALTER TABLE productos_orden DROP CONSTRAINT IF EXISTS orden_fk CASCADE;
ALTER TABLE productos_orden ADD CONSTRAINT productos_orden_orden_fk FOREIGN KEY (folio_orden)
REFERENCES orden(folio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: cliente_fk | type: CONSTRAINT --
-- ALTER TABLE orden DROP CONSTRAINT IF EXISTS cliente_fk CASCADE;
ALTER TABLE orden ADD CONSTRAINT orden_cliente_fk FOREIGN KEY (rfc_cliente)
REFERENCES cliente(rfc) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

GRANT ALL ON proyectofinal.* TO 'equipo7'@'localhost' IDENTIFIED BY '1*hjUjksO(74PL';
GRANT ALL ON proyectofinal.* TO 'equipo7'@'127.0.0.1' IDENTIFIED BY '1*hjUjksO(74PL';


CREATE SEQUENCE seq_id_orden AS integer START 1;

/* Función y trigger que formatean el folio de una nueva orden*/
CREATE OR REPLACE FUNCTION formateo_folio_orden()
RETURNS trigger AS $$
BEGIN
    NEW.folio = concat('ORD-', to_char(nextval('seq_id_orden'), 'fm000'));
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER formato_folio_orden 
BEFORE INSERT ON orden
FOR EACH ROW
    EXECUTE PROCEDURE formateo_folio_orden();
    

/* Función y trigger que actualiza los valores de las órdenes, tanto a nivel producto como a nivel total*/
CREATE OR REPLACE FUNCTION actualizacion_orden()
RETURNS trigger AS $$
BEGIN

    IF TG_OP = 'INSERT' AND EXISTS(select 1 from productos_orden where nombre_producto = NEW.nombre_producto AND folio_orden = NEW.folio_orden) = true  THEN
        RAISE EXCEPTION SQLSTATE '90001' USING MESSAGE = 'Ese producto ya se encuentra en la orden, actualiza su cantidad';
    ELSE
        IF (SELECT disponibilidad FROM producto WHERE nombre=NEW.nombre_producto) = true THEN
            NEW.total_por_producto = NEW.cantidad * (SELECT precio FROM producto WHERE nombre=NEW.nombre_producto);

            IF EXISTS(SELECT 1 FROM orden WHERE folio=NEW.folio_orden) = true THEN
               UPDATE orden SET total = anterior.total+NEW.total_por_producto FROM (SELECT total from orden where folio=NEW.folio_orden) AS anterior where folio = NEW.folio_orden;
            ELSE
                RAISE EXCEPTION SQLSTATE '90003' USING MESSAGE ='Esa orden no existe';
            END IF;

        ELSE
            RAISE EXCEPTION SQLSTATE '90002' USING MESSAGE ='El producto ya no se encuentra disponible';
        END IF;
     END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER actualizar_orden
BEFORE INSERT OR UPDATE on productos_orden
FOR EACH ROW
EXECUTE PROCEDURE actualizacion_orden()


/* Se elige usar HASH pues solo se harán comparaciones de tipo = */
create index empleado_orden_index on orden USING HASH(num_empleado);


/* Función para obtener la información de ordenes por empleado */
CREATE OR REPLACE FUNCTION ordenes_por_empleado(n_empleado int)
RETURNS TABLE(num_emp int, total_ordenes bigint, total_cobrado float)
AS $$
BEGIN

    RETURN QUERY select num_empleado, count(*), sum(total) from orden where num_empleado = $1 group by num_empleado;
END;
$$
LANGUAGE plpgsql;


/* Vista para obtener los detalles del producto más vendido */
CREATE VIEW producto_mas_vendido AS
    SELECT * FROM producto WHERE nombre = (SELECT nombre_producto FROM productos_orden GROUP BY nombre_producto ORDER BY COUNT(*) DESC LIMIT 1);

/* Vista para obtener los nombres de los productos no disponibles */
CREATE VIEW productos_no_disponibles (nombre_producto) AS
SELECT nombre FROM producto WHERE disponibilidad = false;

/* Función para generar una vista de forma dinámica */
CREATE OR REPLACE FUNCTION generar_vista_factura(f_orden text) 
RETURNS void
AS $$
BEGIN
    EXECUTE 'CREATE OR REPLACE VIEW vista_factura AS ' || '
        SELECT po.nombre_producto AS concepto, p.precio, po.cantidad, po.total_por_producto as total FROM
        productos_orden po join producto p on nombre_producto = nombre WHERE folio_orden = ' || quote_literal(f_orden);
END;$$
LANGUAGE plpgsql;


/*Función para obtener las ventas y el total cobrado durante un periodo*/
CREATE OR REPLACE FUNCTION reporte_parcial(inicio date, fin date) 
RETURNS TABLE(ventas_del_periodo bigint, cobro_total_del_periodo float) AS $$
BEGIN
   RETURN QUERY SELECT count(*), sum(total) from orden where fecha between inicio and fin; 
END;$$
LANGUAGE plpgsql;
