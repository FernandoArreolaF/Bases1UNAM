-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.3
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
--Autores:
-- Carrillo, Chilpa, Juárez y Nava.

---------------------------------------------------Creación de base de datos
CREATE DATABASE new_database;

---------------------------------------------------Creación de tablas 
-- object: public.PRODUCTO
CREATE TABLE public.PRODUCTO (
	codigo_barras bigint NOT NULL,
	precio_venta numeric(8) NOT NULL,
	precio_compra numeric(8) NOT NULL,
	fotografia bytea NOT NULL,
	stock smallint NOT NULL,
	id_categoria_CATEGORIA integer NOT NULL,
	nombre character varying NOT NULL,
	CONSTRAINT PRODUCTO_pk PRIMARY KEY (codigo_barras)
);

-- object: public.CATEGORIA
CREATE TABLE public.CATEGORIA (
	id_categoria integer NOT NULL,
	marca varchar(50) NOT NULL,
	descripcion text NOT NULL,
	CONSTRAINT CATEGORIA_pk PRIMARY KEY (id_categoria)
);

-- object: public.PROVEEDOR
CREATE TABLE public.PROVEEDOR (
	rfc_provedor char(13) NOT NULL,
	nombre varchar(60) NOT NULL,
	ap_paterno varchar(60) NOT NULL,
	ap_materno varchar(60),
	CONSTRAINT PROVEEDOR_pk PRIMARY KEY (rfc_provedor)
);

-- object: public.CLIENTE
CREATE TABLE public.CLIENTE (
	rfc_cliente char(13) NOT NULL,
	nombre varchar(60) NOT NULL,
	ap_paterno varchar(60) NOT NULL,
	ap_materno varchar(60),
	calle varchar(70) NOT NULL,
	numero smallint NOT NULL,
	estado varchar(60) NOT NULL,
	colonia varchar(60) NOT NULL,
	cp integer NOT NULL,
	CONSTRAINT CLIENTE_pk PRIMARY KEY (rfc_cliente)
);

-- object: public.SUCURSAL
CREATE TABLE public.SUCURSAL (
	id_sucursal varchar(10) NOT NULL,
	razon_social varchar(100) NOT NULL,
	calle varchar(70) NOT NULL,
	numero smallint NOT NULL,
	estado varchar(60) NOT NULL,
	colonia varchar(60) NOT NULL,
	cp smallint NOT NULL,
	CONSTRAINT SUCURSAL_pk PRIMARY KEY (id_sucursal),
	CONSTRAINT razon_social UNIQUE (id_sucursal,razon_social)
);

-- object: public.VENTA
CREATE TABLE public.VENTA (
	id_venta varchar(10) NOT NULL,
	fecha date NOT NULL,
	monto_final float NOT NULL,
	rfc_cliente_CLIENTE char(13) NOT NULL,
	id_sucursal_SUCURSAL varchar(10) NOT NULL,
	CONSTRAINT VENTA_pk PRIMARY KEY (id_venta)
);

-- object: public.telefono 
CREATE TABLE public.telefono (
	rfc_provedor_PROVEEDOR char(13) NOT NULL,
	num_telefono bigint NOT NULL,
	CONSTRAINT telefono_pk PRIMARY KEY (num_telefono)
);

-- object: public.GUARDA
CREATE TABLE public.GUARDA (
	codigo_barras_PRODUCTO bigint NOT NULL,
	id_venta_VENTA varchar(10) NOT NULL,
	cantidad_producto smallint NOT NULL,
	monto_producto float NOT NULL,
	CONSTRAINT GUARDA_pk PRIMARY KEY (codigo_barras_PRODUCTO,id_venta_VENTA)
);

-- object: public.SURTE
CREATE TABLE public.SURTE (
	rfc_provedor_PROVEEDOR char(13) NOT NULL,
	codigo_barras_PRODUCTO bigint NOT NULL,
	fecha_surte date NOT NULL,
	CONSTRAINT SURTE_pk PRIMARY KEY (rfc_provedor_PROVEEDOR,codigo_barras_PRODUCTO)
);

-------------------------------------------------------Estableciendo las Condiciones 
-- object: PRODUCTO_fk
ALTER TABLE public.GUARDA ADD CONSTRAINT PRODUCTO_fk FOREIGN KEY (codigo_barras_PRODUCTO)
REFERENCES public.PRODUCTO (codigo_barras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- object: VENTA_fk
ALTER TABLE public.GUARDA ADD CONSTRAINT VENTA_fk FOREIGN KEY (id_venta_VENTA)
REFERENCES public.VENTA (id_venta) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- object: PROVEEDOR_fk
ALTER TABLE public.SURTE ADD CONSTRAINT PROVEEDOR_fk FOREIGN KEY (rfc_provedor_PROVEEDOR)
REFERENCES public.PROVEEDOR (rfc_provedor) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- object: PRODUCTO_fk
ALTER TABLE public.SURTE ADD CONSTRAINT PRODUCTO_fk FOREIGN KEY (codigo_barras_PRODUCTO)
REFERENCES public.PRODUCTO (codigo_barras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- object: CATEGORIA_fk
ALTER TABLE public.PRODUCTO ADD CONSTRAINT CATEGORIA_fk FOREIGN KEY (id_categoria_CATEGORIA)
REFERENCES public.CATEGORIA (id_categoria) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- object: PROVEEDOR_fk
ALTER TABLE public.telefono ADD CONSTRAINT PROVEEDOR_fk FOREIGN KEY (rfc_provedor_PROVEEDOR)
REFERENCES public.PROVEEDOR (rfc_provedor) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- object: CLIENTE_fk
ALTER TABLE public.VENTA ADD CONSTRAINT CLIENTE_fk FOREIGN KEY (rfc_cliente_CLIENTE)
REFERENCES public.CLIENTE (rfc_cliente) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- object: SUCURSAL_fk
ALTER TABLE public.VENTA ADD CONSTRAINT SUCURSAL_fk FOREIGN KEY (id_sucursal_SUCURSAL)
REFERENCES public.SUCURSAL (id_sucursal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

---------------------------------------------------------------- Realizando las consultas requeridas
--Calculando la utilidad de los productos. 
CREATE OR REPLACE FUNCTION calcular_utilidad(p_codigo_barras bigint)
  RETURNS TABLE (
    codigo_barras bigint,
    utilidad numeric,
    veces_vendido integer,
    utilidad_total numeric
  ) AS $$
BEGIN
  RETURN QUERY
  SELECT P.codigo_barras,
         (P.precio_venta - P.precio_compra) AS utilidad,
         COUNT(G.id_venta_VENTA)::integer AS veces_vendido,
         (P.precio_venta - P.precio_compra) * COUNT(G.id_venta_VENTA)::numeric AS utilidad_total
  FROM PRODUCTO P
  JOIN GUARDA G ON P.codigo_barras = G.codigo_barras_PRODUCTO
  WHERE P.codigo_barras = p_codigo_barras
  GROUP BY P.codigo_barras, P.precio_venta, P.precio_compra;
END;
$$ LANGUAGE plpgsql;
--Haciendo la consulta
select *
from calcular_utilidad(14325);

--Actualización del stock 
CREATE OR REPLACE FUNCTION actualizar_stock() RETURNS TRIGGER AS $$
DECLARE
    codigoIngresado integer;
    codigoAlmacenado integer;
    stockAlmacenado smallint;
BEGIN
    codigoIngresado := NEW.codigo_barras_producto;

    SELECT codigo_barras INTO codigoAlmacenado
    FROM producto
    WHERE codigo_barras = NEW.codigo_barras_producto;

    SELECT stock INTO stockAlmacenado
    FROM producto
    WHERE codigo_barras = NEW.codigo_barras_producto;

    IF NEW.cantidad_producto < stockAlmacenado AND
	NEW.cantidad_producto > 0 THEN
        UPDATE producto
        SET stock = stock - NEW.cantidad_producto;
    ELSE
	RAISE NOTICE 'Número de productos no disponible o agotados.';
	RAISE NOTICE 'Intente ingresar una cantidad menor';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Creando un disparador
CREATE TRIGGER actualizar_stock
AFTER INSERT ON guarda
FOR EACH ROW
EXECUTE FUNCTION actualizar_stock();

--Consulta
CREATE OR REPLACE FUNCTION stock_minimo()
RETURNS SETOF producto as $$
BEGIN
    RETURN QUERY
    SELECT * FROM producto WHERE stock < 3;
END;
 $$ LANGUAGE plpgsql;
 
--Creación para insertar un cliente nuevo
CREATE OR REPLACE FUNCTION insertar_cliente(
	rfc character(13), 
	name character varying(60), 
	 ap_paterno character varying(60),
	 ap_materno character varying(60),
	calle character varying(70),
	numero smallint,
	 estado character varying(60),
	colonia character varying(60),
	cp integer
	)

RETURNS VOID AS $$
BEGIN
    INSERT INTO cliente(  rfc_cliente, nombre, ap_paterno, ap_materno, calle, numero, estado, colonia, cp)
    VALUES (rfc, name, ap_paterno, ap_materno, calle, numero, estado, colonia, cp);
END;
$$ LANGUAGE plpgsql;

--Creación para realizar una nueva venta
CREATE OR REPLACE FUNCTION ingresar_venta(
    p_id_venta character varying(10),
    p_fecha date,
    p_rfc_cliente character(13),
    p_id_sucursal character varying(10),
    p_codigo_barras bigint,
    p_cantidad_producto smallint,
)
RETURNS void AS $$
BEGIN

    INSERT INTO venta (id_venta, fecha, rfc_cliente_cliente, id_sucursal_sucursal)
    VALUES (p_id_venta, p_fecha, p_rfc_cliente, p_id_sucursal);


    INSERT INTO guarda (codigo_barras_producto, id_venta_venta, cantidad_producto)
    VALUES (p_codigo_barras, p_id_venta, p_cantidad_producto);

    RETURN;
END;
$$ LANGUAGE plpgsql;

------------------------
CREATE OR REPLACE VIEW TICKET_VISTA AS 
SELECT s.id_sucursal,v.id_venta,v.fecha,d.codigo_barras_producto,p.nombre, d.cantidad_producto, d.monto_producto,v.monto_final 
FROM 
venta v inner join guarda d on v.id_venta=d.id_venta_venta
inner join sucursal 
s on v.id_sucursal_sucursal=s.id_sucursal
inner join 
producto p on p.codigo_barras=d.codigo_barras_producto;

-------------------------
CREATE OR REPLACE FUNCTION estado_fecha(fecha_inicio date, fecha_fin date DEFAULT NULL)
RETURNS TABLE (monto_total_venta integer,ganancias integer) AS $$
BEGIN
 IF fecha_fin IS NULL THEN
     RETURN QUERY
     SELECT CAST(SUM(d.cantidad_producto * p.precio_venta) AS integer) AS monto_total_venta, CAST(SUM(d.cantidad_producto * (p.precio_venta - p.precio_compra)) AS integer) AS ganancias
     FROM venta v
     JOIN guarda d ON v.id_venta = d.id_venta_venta
     JOIN producto p ON d.codigo_barras_producto = p.codigo_barras
             WHERE fecha = fecha_inicio;
 ELSE
 RETURN QUERY
SELECT CAST(SUM(d.cantidad_producto * p.precio_venta) AS integer) AS monto_total_venta, CAST(SUM(d.cantidad_producto * (p.precio_venta - p.precio_compra)) AS integer) AS ganancias
FROM venta v
JOIN guarda d ON v.id_venta = d.id_venta_venta
JOIN producto p ON d.codigo_barras_producto = p.codigo_barras
     WHERE fecha >= fecha_inicio AND fecha <= fecha_fin;
 END IF;
END;
$$ LANGUAGE plpgsql;


---------------------------
CREATE SEQUENCE secuencia_ventas;

CREATE OR REPLACE FUNCTION generar_id_ventas() 
RETURNS text AS $$
DECLARE
    nuevo_id text;
BEGIN
    nuevo_id := 'VENT-' || to_char(nextval('secuencia_ventas'), 'FM000');
    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

INSERT INTO VENTA VALUES (generar_id_ventas(), '05/06/2023')


CREATE OR REPLACE VIEW ticket AS
SELECT P.codigo_barras, P.nombre, G.cantidad_producto, G.monto_producto,
       V.id_venta, V.fecha, V.monto_final, V.rfc_cliente_cliente, V.id_sucursal_sucursal,
       SUM(G.monto_producto) OVER (PARTITION BY V.id_venta) AS monto_total
FROM Producto P
JOIN Guarda G ON P.codigo_barras = G.codigo_barras_producto
JOIN Venta V ON V.id_venta = G.id_venta_venta;