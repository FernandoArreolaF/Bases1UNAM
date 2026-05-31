-- 01_ddl_creacion_tablas.sql
-- Script de creacion de tablas para el sistema de restaurante
-- Proyecto Final BD - Grupo 01
-- PostgreSQL

--LIMPIEZA de los datos 

DROP TABLE IF EXISTS DETALLE_ORDEN    CASCADE;
DROP TABLE IF EXISTS ORDEN            CASCADE;
DROP TABLE IF EXISTS BEBIDA           CASCADE;
DROP TABLE IF EXISTS PLATILLO         CASCADE;
DROP TABLE IF EXISTS PRODUCTO         CASCADE;
DROP TABLE IF EXISTS CATEGORIA        CASCADE;
DROP TABLE IF EXISTS CLIENTE_FACT     CASCADE;
DROP TABLE IF EXISTS ADMINISTRATIVO   CASCADE;
DROP TABLE IF EXISTS COCINERO         CASCADE;
DROP TABLE IF EXISTS MESERO           CASCADE;
DROP TABLE IF EXISTS DEPENDIENTE      CASCADE;
DROP TABLE IF EXISTS TELEFONO_EMPLEADO CASCADE;
DROP TABLE IF EXISTS EMPLEADO         CASCADE;

-- TABLA: EMPLEADO
-- Entidad padre de la especializacion

CREATE TABLE EMPLEADO (
    num_empleado    VARCHAR(10)     NOT NULL,
    nombre_pila     VARCHAR(40)     NOT NULL,
    apellido_paterno VARCHAR(40)    NOT NULL,
    apellido_materno VARCHAR(40)    NOT NULL,
    rfc             VARCHAR(13)     NOT NULL,
    fecha_nacimiento DATE           NOT NULL,
    edad            INTEGER         NOT NULL,
    sueldo          NUMERIC(10,2)   NOT NULL CHECK (sueldo > 0),
    foto            BYTEA,
    estado          VARCHAR(40)     NOT NULL,
    codigo_postal   VARCHAR(5)      NOT NULL,
    colonia         VARCHAR(100)    NOT NULL,
    calle           VARCHAR(100)    NOT NULL,
    numero          VARCHAR(10)     NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (num_empleado),
    CONSTRAINT uq_empleado_rfc UNIQUE (rfc)
);



-- TABLA: TELEFONO_EMPLEADO
-- Atributo multivaluado de EMPLEADO

CREATE TABLE TELEFONO_EMPLEADO (
    num_empleado    VARCHAR(10)     NOT NULL,
    telefono        VARCHAR(15)     NOT NULL,
    CONSTRAINT pk_telefono PRIMARY KEY (num_empleado, telefono),
    CONSTRAINT fk_telefono_empleado FOREIGN KEY (num_empleado)
        REFERENCES EMPLEADO (num_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- TABLA: DEPENDIENTE

CREATE TABLE DEPENDIENTE (
    dependiente_id  INTEGER         NOT NULL DEFAULT nextval('dependiente_id_seq'),
    num_empleado    VARCHAR(10)     NOT NULL,
    nombre          VARCHAR(40)     NOT NULL,
    ap_paterno      VARCHAR(40)     NOT NULL,
    ap_materno      VARCHAR(40)     NOT NULL,
    curp            VARCHAR(18)     NOT NULL,
    parentesco      VARCHAR(30)     NOT NULL,
    CONSTRAINT pk_dependiente PRIMARY KEY (dependiente_id),
    CONSTRAINT uq_dependiente_curp UNIQUE (curp),
    CONSTRAINT fk_dependiente_empleado FOREIGN KEY (num_empleado)
        REFERENCES EMPLEADO (num_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- TABLA: COCINERO (subtipo de EMPLEADO)

CREATE TABLE COCINERO (
    num_empleado    VARCHAR(10)     NOT NULL,
    especialidad    VARCHAR(100)    NOT NULL,
    CONSTRAINT pk_cocinero PRIMARY KEY (num_empleado),
    CONSTRAINT fk_cocinero_empleado FOREIGN KEY (num_empleado)
        REFERENCES EMPLEADO (num_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- TABLA: MESERO (subtipo de EMPLEADO)

CREATE TABLE MESERO (
    num_empleado    VARCHAR(10)     NOT NULL,
    horario         VARCHAR(50)     NOT NULL,
    CONSTRAINT pk_mesero PRIMARY KEY (num_empleado),
    CONSTRAINT fk_mesero_empleado FOREIGN KEY (num_empleado)
        REFERENCES EMPLEADO (num_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- TABLA: ADMINISTRATIVO (subtipo de EMPLEADO)

CREATE TABLE ADMINISTRATIVO (
    num_empleado    VARCHAR(10)     NOT NULL,
    rol             VARCHAR(50)     NOT NULL,
    CONSTRAINT pk_administrativo PRIMARY KEY (num_empleado),
    CONSTRAINT fk_administrativo_empleado FOREIGN KEY (num_empleado)
        REFERENCES EMPLEADO (num_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- TABLA: CATEGORIA

CREATE TABLE CATEGORIA (
    categoria_id    INTEGER         NOT NULL DEFAULT nextval('categoria_id_seq'),
    nombre          VARCHAR(40)     NOT NULL,
    descripcion     TEXT            NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (categoria_id)
);



-- TABLA: PRODUCTO
-- Incluye platillos y bebidas (discriminado por tipo)

CREATE TABLE PRODUCTO (
    producto_id     INTEGER         NOT NULL DEFAULT nextval('producto_id_seq'),
    nombre          VARCHAR(40)     NOT NULL,
    descripcion     TEXT            NOT NULL,
    precio          NUMERIC(8,2)    NOT NULL CHECK (precio > 0),
    disponibilidad  BOOLEAN         NOT NULL DEFAULT TRUE,
    receta          TEXT            NOT NULL,
    categoria_id    INTEGER         NOT NULL,
    tipo            VARCHAR(10)     NOT NULL CHECK (tipo IN ('platillo', 'bebida')),
    CONSTRAINT pk_producto PRIMARY KEY (producto_id),
    CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria_id)
        REFERENCES CATEGORIA (categoria_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);



-- TABLA: PLATILLO (subtipo de PRODUCTO)

CREATE TABLE PLATILLO (
    producto_id     INTEGER         NOT NULL,
    CONSTRAINT pk_platillo PRIMARY KEY (producto_id),
    CONSTRAINT fk_platillo_producto FOREIGN KEY (producto_id)
        REFERENCES PRODUCTO (producto_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- TABLA: BEBIDA (subtipo de PRODUCTO)

CREATE TABLE BEBIDA (
    producto_id     INTEGER         NOT NULL,
    CONSTRAINT pk_bebida PRIMARY KEY (producto_id),
    CONSTRAINT fk_bebida_producto FOREIGN KEY (producto_id)
        REFERENCES PRODUCTO (producto_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- TABLA: CLIENTE_FACT
-- Clientes que solicitan factura

CREATE TABLE CLIENTE_FACT (
    rfc             VARCHAR(13)     NOT NULL,
    nombre_cliente  VARCHAR(40)     NOT NULL,
    apellido_paterno VARCHAR(40)    NOT NULL,
    apellido_materno VARCHAR(40)    NOT NULL,
    fecha_nacimiento DATE           NOT NULL,
    email           VARCHAR(60)     NOT NULL,
    estado          VARCHAR(40)     NOT NULL,
    codigo_postal   VARCHAR(5)      NOT NULL,
    colonia         VARCHAR(40)     NOT NULL,
    numero          VARCHAR(10)     NOT NULL,
    calle           VARCHAR(100)    NOT NULL,
    razon_social    VARCHAR(150)    NOT NULL,
    CONSTRAINT pk_cliente_fact PRIMARY KEY (rfc)
);



-- TABLA: ORDEN

CREATE TABLE ORDEN (
    folio           VARCHAR(10)     NOT NULL,
    fecha           DATE            NOT NULL DEFAULT CURRENT_DATE,
    hora            TIME            NOT NULL DEFAULT CURRENT_TIME,
    total           NUMERIC(10,2)   NOT NULL DEFAULT 0.00,
    num_empleado    VARCHAR(10)     NOT NULL,
    rfc             VARCHAR(13),
    CONSTRAINT pk_orden PRIMARY KEY (folio),
    CONSTRAINT fk_orden_mesero FOREIGN KEY (num_empleado)
        REFERENCES MESERO (num_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_orden_cliente FOREIGN KEY (rfc)
        REFERENCES CLIENTE_FACT (rfc)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);



-- TABLA: DETALLE_ORDEN
-- Entidad asociativa entre ORDEN y PRODUCTO

CREATE TABLE DETALLE_ORDEN (
    folio           VARCHAR(10)     NOT NULL,
    producto_id     INTEGER         NOT NULL,
    cantidad        INTEGER         NOT NULL CHECK (cantidad > 0),
    precio_platillo NUMERIC(8,2)    NOT NULL CHECK (precio_platillo > 0),
    CONSTRAINT pk_detalle_orden PRIMARY KEY (folio, producto_id),
    CONSTRAINT fk_detalle_orden FOREIGN KEY (folio)
        REFERENCES ORDEN (folio)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (producto_id)
        REFERENCES PRODUCTO (producto_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);



-- VERIFICACION: mostrar tablas creadas 
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


