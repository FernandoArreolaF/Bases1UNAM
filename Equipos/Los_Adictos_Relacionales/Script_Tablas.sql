--Proyecto BD

--TABLAS BASICAS

-- TABLA CATEGORIA
CREATE TABLE CATEGORIA (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion_categoria VARCHAR(250) NOT NULL
);
-- TABLA PRODUCTO
CREATE TABLE PRODUCTO (
    id_producto SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(50) NOT NULL,
    precio_producto NUMERIC(7,2) NOT NULL CHECK (precio_producto > 0),
    stock_producto INTEGER NOT NULL DEFAULT 0 CHECK (stock_producto >= 0),
    disponibilidad_producto BOOLEAN  DEFAULT TRUE,
    receta_producto VARCHAR(250) NULL,
    id_categoria INTEGER NOT NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) 
        REFERENCES CATEGORIA(id_categoria) ON UPDATE CASCADE
);




-- TABLA CLIENTE
CREATE TABLE CLIENTE (
    id_cliente SERIAL PRIMARY KEY,
    rfc_cliente CHAR(12) UNIQUE NOT NULL,
    nombre_cliente VARCHAR(30) NOT NULL,
    apellido_paterno_cliente VARCHAR(30) NOT NULL,
    apellido_materno_cliente VARCHAR(30),
    razon_social VARCHAR(200) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(150) NOT NULL,
    estado_cliente VARCHAR(50) NOT NULL,
    codigo_postal_cliente CHAR(5) NOT NULL CHECK (codigo_postal_cliente ~ '^[0-9]+$'), --CS_6
    colonia_cliente VARCHAR(100) NOT NULL,
    calle_cliente VARCHAR(100) NOT NULL,
    numero_dom_cliente INTEGER NOT NULL
);

-- TABLA EMPLEADO (Padre)
CREATE TABLE EMPLEADO (
    num_empleado SERIAL PRIMARY KEY,
    rfc_empleado CHAR(12) UNIQUE NOT NULL,
    nombre_empleado VARCHAR(30) NOT NULL,
    apellido_paterno_empleado VARCHAR(30) NOT NULL,
    apellido_materno_empleado VARCHAR(30) NULL,
    edad_empleado INTEGER NOT NULL CHECK (edad_empleado >= 18),
    fecha_nacimiento_empleado DATE NOT NULL,
    sueldo NUMERIC(10,2) CHECK (sueldo > 0) NOT NULL,
    codigo_postal_empleado CHAR(5) NOT NULL CHECK (codigo_postal_empleado ~ '^[0-9]+$'), --CS_6
    colonia VARCHAR(50) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero_domicilio INTEGER NOT NULL,
    foto_empleado BYTEA NOT NULL, 
    es_mesero BOOLEAN DEFAULT FALSE,
    es_administrativo BOOLEAN DEFAULT FALSE,
    es_cocinero BOOLEAN DEFAULT FALSE
);




-- TABLA MESERO
CREATE TABLE MESERO (
    num_empleado INTEGER PRIMARY KEY,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    CONSTRAINT fk_mesero_empleado FOREIGN KEY (num_empleado) 
        REFERENCES EMPLEADO(num_empleado) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);



-- TABLA ADMINISTRATIVO
CREATE TABLE ADMINISTRATIVO (
    num_empleado INTEGER PRIMARY KEY,
    rol VARCHAR(30) NOT NULL,
    CONSTRAINT fk_admin_empleado FOREIGN KEY (num_empleado) 
        REFERENCES EMPLEADO(num_empleado) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- TABLA COCINERO
CREATE TABLE COCINERO (
    num_empleado INTEGER PRIMARY KEY,
    especialidad VARCHAR(50) NOT NULL,
    CONSTRAINT fk_cocinero_empleado FOREIGN KEY (num_empleado) 
        REFERENCES EMPLEADO(num_empleado) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);



-- TABLA TELEFONO_EMPLEADO
CREATE TABLE TELEFONO_EMPLEADO (
    num_empleado INTEGER NOT NULL,
    telefono_empleado CHAR(10) NOT NULL,
    PRIMARY KEY (num_empleado, telefono_empleado),
    CONSTRAINT fk_telefono_empleado FOREIGN KEY (num_empleado) 
        REFERENCES EMPLEADO(num_empleado) 
        ON DELETE CASCADE,
	CONSTRAINT ck_telefono_empleado_digitos
		CHECK (telefono_empleado ~ '^[0-9]{10}$')
);

-- TABLA DEPENDIENTE
CREATE TABLE DEPENDIENTE (
    curp_dependiente CHAR(18) PRIMARY KEY,
    num_empleado INTEGER NOT NULL,
    nombre_dependiente VARCHAR(30) NOT NULL,
    apellido_paterno_dependiente VARCHAR(30) NOT NULL,
    apellido_materno_dependiente VARCHAR(30),
    parentesco VARCHAR(30) NOT NULL,
    CONSTRAINT fk_dependiente_empleado FOREIGN KEY (num_empleado) 
        REFERENCES EMPLEADO(num_empleado) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


-- TABLA ORDEN
CREATE TABLE ORDEN (
    folio_orden VARCHAR(10) PRIMARY KEY, --Se necesita Trigger para el generar el folio
    fecha_orden TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_pago NUMERIC(10,2) NOT NULL DEFAULT 0,
    id_cliente INTEGER NOT NULL, -- FK a Cliente
    num_empleado_mesero INTEGER NOT NULL, -- FK a Mesero
    CONSTRAINT fk_orden_cliente FOREIGN KEY (id_cliente) 
        REFERENCES CLIENTE(id_cliente) 
        ON UPDATE CASCADE,
    CONSTRAINT fk_orden_mesero FOREIGN KEY (num_empleado_mesero) 
        REFERENCES MESERO(num_empleado) 
        ON UPDATE CASCADE
);

-- TABLA ORDEN_POR_PRODUCTO
CREATE TABLE ORDEN_POR_PRODUCTO (
    folio_orden VARCHAR(10) NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad_producto INTEGER NOT NULL CHECK (cantidad_producto > 0) DEFAULT 1,
    total_producto NUMERIC(10,2) NOT NULL CHECK (total_producto >= 0),
    PRIMARY KEY (folio_orden, id_producto),
    CONSTRAINT fk_detalle_orden FOREIGN KEY (folio_orden) 
        REFERENCES ORDEN(folio_orden) 
        ON DELETE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) 
        REFERENCES PRODUCTO(id_producto) 
        ON UPDATE CASCADE
);


-- CREACIÓN DE ÍNDICES 


-- Índice en Empleado para búsquedas por nombre
CREATE INDEX idx_empleado_nombre ON EMPLEADO (apellido_paterno_empleado, apellido_materno_empleado, nombre_empleado);

-- Índice en Orden para búsquedas por fecha
CREATE INDEX idx_orden_fecha ON ORDEN (fecha_orden);

-- Índice para ver que no haya duplicados en el RFC de Cliente
CREATE UNIQUE INDEX idx_cliente_rfc ON CLIENTE (rfc_cliente);

