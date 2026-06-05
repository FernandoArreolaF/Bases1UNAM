--------------------------------------------------------------------------------------------------
--1. Para crear el entorno en donde se alojara la base se ocupa el siguiente fragmento.
--Nota: Si se utiliza pgAdmin se debe de ejecutar primero este bloque y luego conectarse a la base
--manualmente antes de crear las tablas
--------------------------------------------------------------------------------------------------
-- CREATE DATABASE BD_RESTAURANTE
--    WITH -- Esto junto al CREATE me permiten crear la base
--    OWNER = postgres -- Esto define que usuario es el administrador de la base
--    ENCODING = 'UTF8' --Así como en varios lenguajes de estructuración, 
					  --esto ayuda a la base a aceptar acentos y otros caracrteres
--    CONNECTION LIMIT = -1; --Indica que no hay un límite de usuarios permitidos a conectarse
--------------------------------------------------------------------------------------------------
--2. Si se usa la terminal psql se debe de descomentar el siguiente fragmento el cual permite
--conectarse a la base creada
--\c BD_RESTAURANTE

--------------------------------------------------------------------------------------------------

CREATE TABLE empleado (
    id_empleado SERIAL,
    rfc VARCHAR(13) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50),
    fecha_nacimiento DATE NOT NULL,
    edad INT CHECK (edad >= 18),
    sueldo NUMERIC(10,2) CHECK (sueldo >= 0),
    foto BYTEA,
    estado VARCHAR(50),
    codigo_postal VARCHAR(10),
    colonia VARCHAR(80),
    calle VARCHAR(80),
    numero VARCHAR(10)
);

CREATE TABLE cocinero (
    id_empleado INT,
    especialidad VARCHAR(80) NOT NULL
);

CREATE TABLE mesero (
    id_empleado INT,
    horario VARCHAR(80) NOT NULL
);

CREATE TABLE administrativo (
    id_empleado INT,
    rol VARCHAR(80) NOT NULL
);

CREATE TABLE telefono (
    id_telefono SERIAL,
    id_empleado INT NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

CREATE TABLE dependiente (
    curp VARCHAR(18) NOT NULL,
    id_empleado INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50),
    parentesco VARCHAR(40) NOT NULL
);

CREATE TABLE categoria (
    id_categoria SERIAL,
    nombre VARCHAR(80) NOT NULL,
    descripcion TEXT
);

CREATE TABLE producto (
    id_producto SERIAL,
    id_categoria INT NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    descripcion TEXT,
    receta TEXT,
    precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    tipo_producto VARCHAR(10) NOT NULL
);

CREATE TABLE cliente (
    rfc_cliente VARCHAR(13),
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50),
    razon_social VARCHAR(100),
    email VARCHAR(100),
    fecha_nacimiento DATE,
    estado VARCHAR(50),
    codigo_postal VARCHAR(10),
    colonia VARCHAR(80),
    calle VARCHAR(80),
    numero VARCHAR(10)
);

CREATE TABLE orden (
    folio_orden VARCHAR(10),
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(10,2) NOT NULL DEFAULT 0,
    id_mesero INT NOT NULL
);

CREATE TABLE historial_orden (
    id_detalle SERIAL,
    folio_orden VARCHAR(10) NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal NUMERIC(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE factura (
    id_factura SERIAL,
    folio_orden VARCHAR(10) NOT NULL,
    rfc_cliente VARCHAR(13) NOT NULL,
    fecha_factura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE producto ADD CONSTRAINT chk_tipo_producto CHECK (tipo_producto IN ('PLATILLO', 'BEBIDA'));

ALTER TABLE empleado ADD CONSTRAINT pk_empleadoo PRIMARY KEY (id_empleado);

ALTER TABLE cocinero ADD CONSTRAINT pk_cocinero PRIMARY KEY (id_empleado);

ALTER TABLE mesero ADD CONSTRAINT pk_mesero PRIMARY KEY (id_empleado);

ALTER TABLE administrativo ADD CONSTRAINT pk_administrativo PRIMARY KEY (id_empleado);

ALTER TABLE telefono ADD CONSTRAINT pk_telefono PRIMARY KEY (id_telefono);

ALTER TABLE dependiente ADD CONSTRAINT pk_dependiente PRIMARY KEY (id_empleado, curp);

ALTER TABLE categoria ADD CONSTRAINT pk_categoria PRIMARY KEY (id_categoria);

ALTER TABLE producto ADD CONSTRAINT pk_producto PRIMARY KEY (id_producto);

ALTER TABLE cliente ADD CONSTRAINT pk_cliente PRIMARY KEY (rfc_cliente);

ALTER TABLE orden ADD CONSTRAINT pk_orden PRIMARY KEY (folio_orden);

ALTER TABLE historial_orden ADD CONSTRAINT pk_historial_orden PRIMARY KEY (id_detalle);

ALTER TABLE factura ADD CONSTRAINT pk_factura PRIMARY KEY (id_factura);

-- fk creacion de llaves foraneas
ALTER TABLE cocinero ADD CONSTRAINT fk_cocinero_empleado
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);

ALTER TABLE mesero ADD CONSTRAINT fk_mesero_empleado
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);

ALTER TABLE administrativo ADD CONSTRAINT fk_administrativo_empleado
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);

ALTER TABLE telefono ADD CONSTRAINT fk_telefono_empleado
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);

ALTER TABLE dependiente ADD CONSTRAINT fk_dependiente_empleado
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);

ALTER TABLE producto ADD CONSTRAINT fk_producto_categoria
FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);

ALTER TABLE orden ADD CONSTRAINT fk_orden_mesero
FOREIGN KEY (id_mesero) REFERENCES mesero(id_empleado);

ALTER TABLE historial_orden ADD CONSTRAINT fk_historial_orden
FOREIGN KEY (folio_orden) REFERENCES orden(folio_orden);

ALTER TABLE historial_orden ADD CONSTRAINT fk_historial_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE factura ADD CONSTRAINT fk_factura_orden
FOREIGN KEY (folio_orden) REFERENCES orden(folio_orden);

ALTER TABLE factura ADD CONSTRAINT fk_factura_cliente
FOREIGN KEY (rfc_cliente) REFERENCES cliente(rfc_cliente);

-- unique
ALTER TABLE empleado ADD CONSTRAINT uq_empleado_rfc UNIQUE (rfc);

ALTER TABLE factura ADD CONSTRAINT uq_factura_orden UNIQUE (folio_orden);