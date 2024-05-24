-- Database: ProyectoBDD
 -- DROP DATABASE IF EXISTS "ProyectoBDD";

CREATE DATABASE "ProyectoBDD" WITH OWNER = POSTGRES ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Mexico.1252' LC_CTYPE = 'Spanish_Mexico.1252' LOCALE_PROVIDER = 'libc' TABLESPACE = PG_DEFAULT CONNECTION
LIMIT = -1 IS_TEMPLATE = FALSE;


-- Database: ProyectoBDD

-- DROP DATABASE IF EXISTS "ProyectoBDD";
DROP TABLE IF EXISTS EMPLEADO CASCADE;
DROP TABLE IF EXISTS TELEFONOS CASCADE;
DROP TABLE IF EXISTS COCINERO CASCADE;
DROP TABLE IF EXISTS MESERO CASCADE;
DROP TABLE IF EXISTS ADMINISTRATIVO CASCADE;
DROP TABLE IF EXISTS PRODUCTO CASCADE;
DROP TABLE IF EXISTS PLATILLO CASCADE;
DROP TABLE IF EXISTS BEBIDA CASCADE;
DROP TABLE IF EXISTS CATEGORIA CASCADE;
DROP TABLE IF EXISTS TICKET CASCADE;
DROP TABLE IF EXISTS asegurado CASCADE;
DROP TABLE IF EXISTS ORDEN CASCADE;
DROP TABLE IF EXISTS factura CASCADE;
DROP TABLE IF EXISTS metodo_pago CASCADE;


CREATE DATABASE "ProyectoBDD"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Mexico.1252'
    LC_CTYPE = 'Spanish_Mexico.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

----------------------------------------------------------
-----------------EMPLEADO---------------------------------
----------------------------------------------------------
CREATE TABLE EMPLEADO(
    NO_EMPLEADO SMALLINT,
    RFC CHAR(13),
    EDAD SMALLINT,
	NOMBRE VARCHAR(100),
    SUELDO NUMERIC(8,2),
    AP_PAT VARCHAR(100),
    AP_MAT VARCHAR(100) NULL,
    DOMICILIO TEXT,
    F_NACIMIENTO DATE,
    FOTO BYTEA,
	TIPO_EMP CHAR(1) 
);
ALTER TABLE EMPLEADO ADD CONSTRAINT PK_NEMPLEADO PRIMARY KEY (NO_EMPLEADO);
ALTER TABLE EMPLEADO ADD CONSTRAINT UQ_RFC UNIQUE (RFC);
ALTER TABLE EMPLEADO ADD CONSTRAINT UQ_NEMPLEADO UNIQUE (NO_EMPLEADO);

CREATE TABLE TELEFONOS(
    TELEFONO CHAR(10),
    NO_EMPLEADO SMALLINT
);
ALTER TABLE TELEFONOS ADD CONSTRAINT PK_TELEFONO PRIMARY KEY (TELEFONO);
ALTER TABLE TELEFONOS ADD CONSTRAINT FK_EMP_TEL FOREIGN KEY (NO_EMPLEADO) REFERENCES EMPLEADO(NO_EMPLEADO) ON DELETE CASCADE;

CREATE TABLE COCINERO(
    NO_EMPLEADO SMALLINT,
    ESPECIALIDAD VARCHAR(100)
);
ALTER TABLE COCINERO ADD CONSTRAINT PK_COCINERO_NEMPLEADO PRIMARY KEY (NO_EMPLEADO);
ALTER TABLE COCINERO ADD CONSTRAINT FK_TIPOEMP FOREIGN KEY (NO_EMPLEADO) REFERENCES EMPLEADO(NO_EMPLEADO);


CREATE TABLE MESERO(
    NO_EMPLEADO SMALLINT,
    HORARIO TIME
);
ALTER TABLE MESERO ADD CONSTRAINT PK_MESERO_NEMPLEADO PRIMARY KEY (NO_EMPLEADO);
ALTER TABLE MESERO ADD CONSTRAINT FK_TIPOEMP FOREIGN KEY (NO_EMPLEADO) REFERENCES EMPLEADO(NO_EMPLEADO);


CREATE TABLE ADMINISTRATIVO(
    NO_EMPLEADO SMALLINT,
    ROL VARCHAR(100)
);
ALTER TABLE ADMINISTRATIVO ADD CONSTRAINT PK_ADMIN_NEMPLEADO PRIMARY KEY (NO_EMPLEADO);
ALTER TABLE ADMINISTRATIVO ADD CONSTRAINT FK_TIPOEMP FOREIGN KEY (NO_EMPLEADO) REFERENCES EMPLEADO(NO_EMPLEADO);


CREATE TABLE asegurado(
    no_empleado SMALLINT NULL, 
    curp CHAR(18),
    nombre_asegurado VARCHAR(100) NULL,
    parentesco VARCHAR(50) NULL
);
ALTER TABLE asegurado ADD CONSTRAINT PK_ASEGURADO PRIMARY KEY (CURP);

----------------------------------------------------------
-----------------CATEGORIA---------------------------------
----------------------------------------------------------
CREATE TABLE CATEGORIA(
    NOMBRE_CAT VARCHAR(100),
    DESCRIPCION_CAT TEXT
);
ALTER TABLE CATEGORIA ADD CONSTRAINT NOMBRE_CAT_UNIQUE UNIQUE (NOMBRE_CAT);
ALTER TABLE CATEGORIA ADD CONSTRAINT NOMBRE_CAT_PK PRIMARY KEY (NOMBRE_CAT);

INSERT INTO CATEGORIA (NOMBRE_CAT, DESCRIPCION_CAT) 
VALUES ('Platillo', 'Categoría de platillos'),
       ('Bebida', 'Categoría de bebidas');
----------------------------------------------------------
-----------------PRODUCTO---------------------------------
----------------------------------------------------------

CREATE TABLE PRODUCTO (
    ID_PRODUCTO SERIAL,
    PRECIO_PRODUCTO NUMERIC(8,2) NULL,
    DESCRIPCION TEXT NULL,
    RECETA TEXT NULL,
    DISPONIBILIDAD INT NULL, 
    NOMBRE_PROD VARCHAR(100) NULL,
    NOMBRE_CAT VARCHAR(100),
    TIPO CHAR(1) NULL
);
ALTER TABLE PRODUCTO ADD CONSTRAINT ID_PRODUCTO_PK PRIMARY KEY (ID_PRODUCTO);
ALTER TABLE PRODUCTO ADD CONSTRAINT PROD_NOMCAT_FK FOREIGN KEY (NOMBRE_CAT) REFERENCES CATEGORIA(NOMBRE_CAT);
ALTER TABLE PRODUCTO ADD CONSTRAINT TIPO_CK CHECK (TIPO IN ('B', 'P'));

CREATE TABLE PLATILLO(
    ID_PRODUCTO SMALLINT
);
ALTER TABLE PLATILLO ADD CONSTRAINT PROD_PLAT_FK FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO(ID_PRODUCTO);

CREATE TABLE BEBIDA(
    ID_PRODUCTO SMALLINT
);
ALTER TABLE BEBIDA ADD CONSTRAINT PROD_BEB_FK FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO(ID_PRODUCTO);

----------------------------------------------------------
--------------------ORDEN---------------------------------
----------------------------------------------------------
CREATE TABLE ORDEN (
    ID_ORDEN SERIAL,
    FOLIO VARCHAR(20),
    FECHA TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CANTIDAD_PARCIAL_ARTICULO NUMERIC(8,2) DEFAULT 0,
    TOTAL_ORDEN NUMERIC(8,2) DEFAULT 0,
    NO_EMPLEADO SMALLINT NOT NULL
);
ALTER TABLE ORDEN ADD CONSTRAINT PK_IDORDEN PRIMARY KEY (ID_ORDEN);
ALTER TABLE ORDEN ADD CONSTRAINT FK_EMPLEADO FOREIGN KEY (NO_EMPLEADO) REFERENCES EMPLEADO(NO_EMPLEADO) ON DELETE CASCADE;


----------------------------------------------------------
-----------------TICKET---------------------------------
----------------------------------------------------------

CREATE TABLE TICKET (
    ID_TICKET SERIAL,
    ID_ORDEN SMALLINT,
    ID_PRODUCTO SMALLINT,
    FOLIO VARCHAR(20),
    TOTAL_PARCIAL_ORDEN NUMERIC(8,2)
);

ALTER TABLE TICKET ADD CONSTRAINT PK_TICKET_ID PRIMARY KEY (ID_TICKET);
ALTER TABLE TICKET ADD CONSTRAINT UQ_TICKET_ID UNIQUE (ID_TICKET);
ALTER TABLE TICKET ADD CONSTRAINT FK_TICKET_PRODUCTO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO(ID_PRODUCTO);
ALTER TABLE TICKET ADD CONSTRAINT FK_TICKET_ORDEN FOREIGN KEY (ID_ORDEN) REFERENCES ORDEN(ID_ORDEN)


----------------------------------------------------------
------------------FACTURA---------------------------------
----------------------------------------------------------

CREATE TABLE factura(
    folio_factura VARCHAR(20),
    domicilio_fiscal TEXT NOT NULL,  
    razon_social VARCHAR(50) NOT NULL,
    rfc CHAR(13), 
    email_cliente VARCHAR(100),   
    telefono_cliente CHAR(10),  
    fnacimiento_cliente DATE,  
    ID_ORDEN SMALLINT
);

ALTER TABLE FACTURA ADD CONSTRAINT FK_ORDEN FOREIGN KEY (ID_ORDEN)
REFERENCES ORDEN(ID_ORDEN);
ALTER TABLE FACTURA ADD CONSTRAINT UQ_FFACTURA UNIQUE (FOLIO_FACTURA);
ALTER TABLE factura ADD CONSTRAINT PK_FACTURA PRIMARY KEY (FOLIO_FACTURA);


CREATE TABLE metodo_pago(
    tipo_pago VARCHAR(50),
    folio_factura VARCHAR(20) NOT NULL
);
ALTER TABLE metodo_pago ADD CONSTRAINT PK_PAGO PRIMARY KEY (TIPO_PAGO);
ALTER TABLE metodo_pago ADD CONSTRAINT FK_PAGO FOREIGN KEY (FOLIO_FACTURA) REFERENCES FACTURA(FOLIO_FACTURA) ON DELETE CASCADE;


----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------


-- Insertar un empleado que también es un mesero
INSERT INTO EMPLEADO (NO_EMPLEADO,RFC, NOMBRE, EDAD, SUELDO, AP_PAT, AP_MAT, DOMICILIO, F_NACIMIENTO, FOTO,TIPO_EMP) 
VALUES (1, 'ABC123456FBFB','DANAE', 30, 2000.00, 'SANCHEZ', 'López', 'Calle 123, Ciudad', '1994-05-10', NULL,'M');

INSERT INTO MESERO (NO_EMPLEADO, HORARIO) 
VALUES (1, '08:00:00');

-- Insertar un empleado que también es un cocinero
INSERT INTO EMPLEADO (NO_EMPLEADO,NOMBRE, RFC, EDAD, SUELDO, AP_PAT, AP_MAT, DOMICILIO, F_NACIMIENTO, FOTO, TIPO_EMP) 
VALUES (2, 'MARCO','DEF1234567890', 35, 2500.00, 'Martínez', 'García', 'Av. Principal 456, Pueblo', '1989-12-15', NULL,'C');

INSERT INTO COCINERO (NO_EMPLEADO, ESPECIALIDAD) 
VALUES (2, 'Parrilla');

-- Insertar un empleado que también es un administrativo
INSERT INTO EMPLEADO (NO_EMPLEADO, NOMBRE,RFC, EDAD, SUELDO, AP_PAT, AP_MAT, DOMICILIO, F_NACIMIENTO, FOTO, TIPO_EMP) 
VALUES (3, 'DAYANA','GHI1234567890', 28, 1800.00, 'López', 'Sánchez', 'Col. Libertad, Municipio', '1996-08-22', NULL,'A');

INSERT INTO ADMINISTRATIVO (NO_EMPLEADO, ROL) 
VALUES (3, 'Recursos Humanos');


-- Insertar tres platillos
INSERT INTO PRODUCTO (ID_PRODUCTO, PRECIO_PRODUCTO, DESCRIPCION, RECETA, DISPONIBILIDAD, NOMBRE_PROD, NOMBRE_CAT, TIPO) 
VALUES (1, 12.50, 'Tacos al pastor', 'Receta de tacos al pastor...', 2, 'Tacos al pastor', 'Platillo', 'P');

INSERT INTO PLATILLO (ID_PRODUCTO) 
VALUES (1);

INSERT INTO PRODUCTO (ID_PRODUCTO, PRECIO_PRODUCTO, DESCRIPCION, RECETA, DISPONIBILIDAD, NOMBRE_PROD, NOMBRE_CAT, TIPO) 
VALUES (2, 9.99, 'Enchiladas verdes', 'Receta de enchiladas verdes...', 2, 'Enchiladas verdes', 'Platillo', 'P');

INSERT INTO PLATILLO (ID_PRODUCTO) 
VALUES (2);

INSERT INTO PRODUCTO (ID_PRODUCTO, PRECIO_PRODUCTO, DESCRIPCION, RECETA, DISPONIBILIDAD, NOMBRE_PROD, NOMBRE_CAT, TIPO) 
VALUES (3, 15.75, 'Pozole rojo', 'Receta de pozole rojo...', 2, 'Pozole rojo', 'Platillo', 'P');

INSERT INTO PLATILLO (ID_PRODUCTO) 
VALUES (3);

-- Insertar tres bebidas
INSERT INTO PRODUCTO (ID_PRODUCTO, PRECIO_PRODUCTO, DESCRIPCION, RECETA, DISPONIBILIDAD, NOMBRE_PROD, NOMBRE_CAT, TIPO) 
VALUES (4, 2.50, 'Agua de horchata', NULL, 5, 'Agua de horchata', 'Bebida', 'B');

INSERT INTO BEBIDA (ID_PRODUCTO) 
VALUES (4);

INSERT INTO PRODUCTO (ID_PRODUCTO, PRECIO_PRODUCTO, DESCRIPCION, RECETA, DISPONIBILIDAD, NOMBRE_PROD, NOMBRE_CAT, TIPO) 
VALUES (5, 3.00, 'Refresco de cola', NULL, 5, 'Refresco de cola', 'Bebida', 'B');

INSERT INTO BEBIDA (ID_PRODUCTO) 
VALUES (5);

INSERT INTO PRODUCTO (ID_PRODUCTO, PRECIO_PRODUCTO, DESCRIPCION, RECETA, DISPONIBILIDAD, NOMBRE_PROD, NOMBRE_CAT, TIPO) 
VALUES (6, 4.50, 'Café americano', NULL, 5, 'Café americano', 'Bebida', 'B');

INSERT INTO BEBIDA (ID_PRODUCTO) 
VALUES (6);

----------------ORDEN ---------------
-- Insertar registros en ORDEN
INSERT INTO ORDEN (FOLIO, CANTIDAD_PARCIAL_ARTICULO, TOTAL_ORDEN, NO_EMPLEADO)
VALUES ('001', 2, 25.00, 1);

----------------------------------------------------------
----------------------------------------------------------

CREATE OR REPLACE FUNCTION verif_mesero() RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT TIPO_EMP FROM EMPLEADO WHERE NO_EMPLEADO = NEW.NO_EMPLEADO) != 'M' THEN
        RAISE EXCEPTION 'EL EMPLEADO NO ES UN MESERO';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verfmesero
BEFORE INSERT ON ORDEN
FOR EACH ROW
EXECUTE FUNCTION verif_mesero();
-------------------------------------------------------------------
--Punto 1 Proyecto--

-------------------------------------------------------------------
CREATE OR REPLACE FUNCTION actualizar_totales_orden() RETURNS TRIGGER AS $$
BEGIN

	--Verificar disponibilidad del producto
	IF (SELECT DISPONIBILIDAD FROM PRODUCTO WHERE ID_PRODUCTO = NEW.ID_PRODUCTO) < 1 THEN
        RAISE EXCEPTION 'No hay disponibilidad del producto ID: %', NEW.ID_PRODUCTO;
    END IF;

    -- Actualizar la disponibilidad del producto
    UPDATE PRODUCTO
    SET DISPONIBILIDAD = DISPONIBILIDAD - 1
    WHERE ID_PRODUCTO = NEW.ID_PRODUCTO;
	
    -- Actualizar la cantidad parcial del artículo
    UPDATE ORDEN
    SET CANTIDAD_PARCIAL_ARTICULO = CANTIDAD_PARCIAL_ARTICULO + NEW.TOTAL_PARCIAL_ORDEN
    WHERE ID_ORDEN = NEW.ID_ORDEN;

    -- Calcular el nuevo total de la orden
    UPDATE ORDEN
    SET TOTAL_ORDEN = (SELECT SUM(T.TOTAL_PARCIAL_ORDEN)
                       FROM TICKET T
                       WHERE T.ID_ORDEN = NEW.ID_ORDEN)
    WHERE ID_ORDEN = NEW.ID_ORDEN;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_totales
AFTER INSERT ON TICKET
FOR EACH ROW
EXECUTE FUNCTION actualizar_totales_orden();

---------------------------------------------------------------
-------------APLICACION----------------------------------------
---------------------------------------------------------------
INSERT INTO ORDEN (FOLIO, NO_EMPLEADO, FECHA)VALUES ('F003',1, '2024-05-15')
-- Inserción de tickets
INSERT INTO TICKET (ID_ORDEN, ID_PRODUCTO, FOLIO, TOTAL_PARCIAL_ORDEN)
VALUES
	    (10,1, 'F12346', 2.50),  -- Tacos al pastor
    (10,1, 'F12346', 3.00),
	(10,3, 'F12346', 2.50);-- Enchiladas verdes   -- Enchiladas verdes

--------------------------------------------------------------------
--------Punto 2 Proyecto- Indice------------------------------------

-- Indice para ver las ordenes generadas en cierta fecha
CREATE INDEX idx_fecha_orden ON ORDEN(FECHA);

-- Consulta para buscar órdenes creadas en un día específico
SELECT * FROM ORDEN
WHERE FECHA::DATE = '2024-05-23';

--------------------------------------------------------------------
--------------PUNTO 3 PROYECTO- N.ORDENES DE UN MESERO--------------

CREATE OR REPLACE FUNCTION consultar_ordenes_mesero(numero_empleado integer) 
RETURNS TABLE (cantidad_ordenes INTEGER, total_pagado NUMERIC) AS $$
-- Parámetros:
--   - numero_empleado: El número de empleado del mesero a consultar.
-- Retorna:
--   - Una tabla con dos columnas:
--       - cantidad_ordenes: La cantidad de órdenes realizadas por el mesero.
--       - total_pagado: El total pagado en esas órdenes.
BEGIN
    IF EXISTS (SELECT 1 FROM MESERO WHERE NO_EMPLEADO = numero_empleado) THEN
        RETURN QUERY
        SELECT
            COUNT(*)::INTEGER AS cantidad_ordenes,
            SUM(ORDEN.TOTAL_ORDEN) AS total_pagado
        FROM ORDEN
        WHERE
            NO_EMPLEADO = numero_empleado
            AND DATE(FECHA) = CURRENT_DATE;
    ELSE
        RAISE EXCEPTION 'Error: El número de empleado no corresponde a un mesero.';
    END IF;
   --Si el número de empleado no corresponde a un mesero, se genera una excepción.

END;
$$ LANGUAGE plpgsql;
SELECT * FROM consultar_ordenes_mesero(2)


--------------------------------------------------------------------
-----------Punto 4- Vista del Platillo Más Vendido------------------
CREATE OR REPLACE VIEW platillo_mas_vendido AS
SELECT p.ID_PRODUCTO, p.NOMBRE_PROD, SUM(t.TOTAL_PARCIAL_ORDEN) AS total_vendido
FROM PRODUCTO p
JOIN PLATILLO pl ON p.ID_PRODUCTO = pl.ID_PRODUCTO
JOIN TICKET t ON p.ID_PRODUCTO = t.ID_PRODUCTO
WHERE p.TIPO = 'P'
GROUP BY p.ID_PRODUCTO, p.NOMBRE_PROD
ORDER BY total_vendido DESC
LIMIT 1;

SELECT * FROM platillo_mas_vendido;
--------------------------------------------------------------------
----------------Punto 5- Nombre Productos NO Disponibles -----------
SELECT * FROM PRODUCTO
-- Función para consultar los productos no disponibles
CREATE OR REPLACE FUNCTION productos_no_disponibles()
RETURNS TABLE (nombre_prod VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT p.NOMBRE_PROD 
    FROM PRODUCTO p
    WHERE p.DISPONIBILIDAD = 0;
END;
$$ LANGUAGE plpgsql;

--Llamado a la funcion
SELECT * FROM productos_no_disponibles();

--------------------------------------------------------------------
------------------Punto 6 - VISTA FACTURA---------------------------
CREATE VIEW Vista_Factura AS
SELECT
    f.folio_factura,
    f.domicilio_fiscal,
    f.razon_social,
    f.rfc,
    f.email_cliente,
    f.telefono_cliente,
	m.tipo_pago,
    o.fecha AS fecha_orden,
    o.total_orden AS total_parcial_orden
FROM
    factura f
INNER JOIN metodo_pago m ON f.folio_factura = m.folio_factura
INNER JOIN orden o ON f.id_orden = o.id_orden;

INSERT INTO FACTURA VALUES ('FACTURA001','AV. DEL IMAN','GASTRONOMICA SA CV','GEDP045204','joel234@gmail.com','5567642466','03-06-2001',10)

INSERT INTO METODO_PAGO (TIPO_PAGO,FOLIO_FACTURA)
	VALUES('TARJETA DEBITO','FACTURA001')

SELECT * FROM Vista_Factura
--------------------------------------------------------------------
----------------PUNTO 7 - NUM Y MONTO TOTAL VENTAS -----------------

CREATE OR REPLACE FUNCTION ventas_por_periodo(fecha_inicio DATE, fecha_fin DATE) 
RETURNS TABLE(cantidad_ventas INTEGER, monto_total NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(*)::INTEGER AS cantidad_ventas,
        SUM(TICKET.TOTAL_PARCIAL_ORDEN) AS monto_total
    FROM 
        TICKET
    JOIN 
        ORDEN ON TICKET.ID_ORDEN = ORDEN.ID_ORDEN
    WHERE 
        ORDEN.FECHA BETWEEN fecha_inicio AND fecha_fin;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM ventas_por_periodo('2024-05-01', '2024-05-25');
