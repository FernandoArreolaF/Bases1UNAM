-- Secuencia necesaria para la PK de la tabla Orden
CREATE SEQUENCE seq_folio_orden START WITH 1;


-- Secuencia para el PK de la tabla empleado
CREATE SEQUENCE IF NOT EXISTS seq_empleado_num
    START WITH 1
    INCREMENT BY 1;

-- Tablas relacionadas con Empleado
CREATE TABLE empleado (
    num_empleado SERIAL DEFAULT NEXTVAL('seq_empleado_num'),
    rfc VARCHAR(13) NOT NULL,
    
    nombre_pila VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    
    fecha_nacimiento DATE NOT NULL,
    edad INTEGER, 
    
    estado VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(5) NOT NULL,
    colonia VARCHAR(50) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    numero VARCHAR(10) NOT null,
    
    sueldo NUMERIC(10,2) NOT NULL,
    foto TEXT,

    CONSTRAINT pk_empleado PRIMARY KEY (num_empleado),
    CONSTRAINT uq_empleado_rfc UNIQUE (rfc)
);


CREATE TABLE empleado_telefono (
    num_empleado INTEGER NOT NULL,
    telefono VARCHAR(15) NOT NULL,

    CONSTRAINT pk_empleado_telefono PRIMARY KEY (num_empleado, telefono),
    CONSTRAINT fk_et_empleado FOREIGN KEY (num_empleado) REFERENCES empleado(num_empleado) ON DELETE CASCADE
);


-- Entidades subtipo
CREATE TABLE mesero (
    num_empleado INTEGER NOT NULL,
    horario VARCHAR(50) NOT NULL,

    CONSTRAINT pk_mesero PRIMARY KEY (num_empleado),
    CONSTRAINT fk_mesero_empleado FOREIGN KEY (num_empleado) REFERENCES empleado(num_empleado) ON DELETE CASCADE
);

CREATE TABLE cocinero (
    num_empleado INTEGER NOT NULL,
    especialidad VARCHAR(50) NOT NULL,

    CONSTRAINT pk_cocinero PRIMARY KEY (num_empleado),
    CONSTRAINT fk_cocinero_empleado FOREIGN KEY (num_empleado) REFERENCES empleado(num_empleado) ON DELETE CASCADE
);

CREATE TABLE administrativo (
    num_empleado INTEGER NOT NULL,
    rol VARCHAR(50) NOT NULL,

    CONSTRAINT pk_administrativo PRIMARY KEY (num_empleado),
    CONSTRAINT fk_admin_empleado FOREIGN KEY (num_empleado) REFERENCES empleado(num_empleado) ON DELETE CASCADE
);

-- Entidad debil
CREATE TABLE dependiente (
	num_empleado INTEGER NOT NULL,
    curp VARCHAR(18) NOT NULL,
    
    nombre_pila VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    
    parentesco VARCHAR(30) NOT NULL,

    CONSTRAINT pk_dependiente PRIMARY KEY (curp, num_empleado),
    CONSTRAINT fk_dep_empleado FOREIGN KEY (num_empleado) REFERENCES empleado(num_empleado) ON DELETE CASCADE
);

-- Tablas relacionadas con el producto
CREATE TABLE categoria (
    id_categoria SERIAL,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,

    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE producto (
    id_producto SERIAL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    receta TEXT,
    precio NUMERIC(10,2) NOT NULL,
    disponibilidad BOOLEAN DEFAULT TRUE,
    id_categoria INTEGER NOT null,

    CONSTRAINT pk_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_prod_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- Datos para facturas
CREATE TABLE factura (
    rfc_cliente VARCHAR(13) NOT NULL,
    razon_social VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    
    -- Atributos compuestos aplanados
    nombre_pila VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(5) NOT NULL,
    colonia VARCHAR(50) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    numero VARCHAR(10) NOT NULL,

    CONSTRAINT pk_factura PRIMARY KEY (rfc_cliente)
);

--Tablas relacionadas con la orden
CREATE TABLE orden (
    folio_orden TEXT DEFAULT 'ORD-' || LPAD(NEXTVAL('seq_folio_orden')::TEXT, 3, '0'),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto_total NUMERIC(10,2) DEFAULT 0.00,
    num_empleado_mesero INTEGER NOT NULL,
    rfc_cliente VARCHAR(13), -- Se queda como NULL debido a que no todas las ordenes requieren factura

    CONSTRAINT pk_orden PRIMARY KEY (folio_orden),
    -- Esta FK garantiza de forma nativa que SOLO los meseros levanten órdenes
    CONSTRAINT fk_orden_mesero FOREIGN KEY (num_empleado_mesero) REFERENCES mesero(num_empleado),
    CONSTRAINT fk_orden_cliente FOREIGN KEY (rfc_cliente) REFERENCES factura(rfc_cliente)
);


CREATE TABLE producto_orden(
    folio_orden TEXT NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_total_producto NUMERIC(10,2) DEFAULT 0.00,

    CONSTRAINT pk_detalle_orden PRIMARY KEY (folio_orden, id_producto),
    CONSTRAINT fk_do_orden FOREIGN KEY (folio_orden) REFERENCES orden(folio_orden) ON DELETE CASCADE,
    CONSTRAINT fk_do_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT ck_do_cantidad CHECK (cantidad > 0)
);
