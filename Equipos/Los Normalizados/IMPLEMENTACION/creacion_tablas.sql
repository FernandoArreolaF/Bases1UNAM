
/* ============================================================
   Los Normalizados
   Sistema de gestión para restaurante
   DDL PostgreSQL

   En este script se presenta el DDL utilizado para la creación de la base 
   de datos y las tablas definidas del sistema 
   del restaurante. También se implementan restricciones mediante llaves 
   primarias (PK), llaves foráneas (FK), restricciones UNIQUE y CHECK, con el 
   propósito de mantener la integridad de la información registrada.
   ============================================================ */

-- LIMPIEZA DE TABLAS
DROP TABLE IF EXISTS factura CASCADE;
DROP TABLE IF EXISTS pago CASCADE;
DROP TABLE IF EXISTS detalle_orden CASCADE;
DROP TABLE IF EXISTS orden CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS telefono_empleado CASCADE;
DROP TABLE IF EXISTS dependiente CASCADE;
DROP TABLE IF EXISTS administrativo CASCADE;
DROP TABLE IF EXISTS cocinero CASCADE;
DROP TABLE IF EXISTS horario_mesero CASCADE;
DROP TABLE IF EXISTS mesero CASCADE;
DROP TABLE IF EXISTS persona_fisica CASCADE; -- ¡NUEVO!
DROP TABLE IF EXISTS persona_moral CASCADE;  -- ¡NUEVO!
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS empleado CASCADE;


-- ENTIDAD: EMPLEADO

CREATE TABLE empleado (
    num_empleado INTEGER NOT NULL, 
    nombre VARCHAR(60) NOT NULL,
    ap_pat VARCHAR(20) NOT NULL,
    ap_mat VARCHAR(20) NULL,--Opcional
    edad INTEGER NOT NULL,
    rfc VARCHAR(13) NOT NULL,
    calle VARCHAR(80) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    colonia VARCHAR(80) NOT NULL,
    cp VARCHAR(10) NOT NULL,
    estado VARCHAR(60) NOT NULL,
    sueldo NUMERIC(10,2) NOT NULL,
    fecha_nac DATE NOT NULL,
    foto VARCHAR(100) NOT NULL, --Nombre de la imágen

    CONSTRAINT pk_empleado
        PRIMARY KEY (num_empleado),

    CONSTRAINT uq_empleado_rfc
        UNIQUE (rfc),

    CONSTRAINT chk_empleado_sueldo
        CHECK (sueldo >= 0),

    CONSTRAINT chk_empleado_edad
        CHECK (edad >= 18)
);

-- ATRIBUTO MULTIVALUADO: TELEFONO DE EMPLEADO

CREATE TABLE telefono_empleado (
    num_empleado INTEGER NOT NULL,
    telefono VARCHAR(20) NOT NULL,

    CONSTRAINT pk_telefono_empleado
        PRIMARY KEY (num_empleado, telefono),

    CONSTRAINT fk_telefono_empleado_empleado
        FOREIGN KEY (num_empleado)
        REFERENCES empleado(num_empleado)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- SUBTIPO: MESERO
-- Especialización parcial y traslapada
CREATE TABLE mesero (
    num_empleado INTEGER NOT NULL,

    CONSTRAINT pk_mesero
        PRIMARY KEY (num_empleado),

    CONSTRAINT fk_mesero_empleado
        FOREIGN KEY (num_empleado)
        REFERENCES empleado(num_empleado)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE horario_mesero (
    num_empleado INTEGER NOT NULL,
    dia_semana VARCHAR(10) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,

    CONSTRAINT pk_horario_mesero
        PRIMARY KEY (num_empleado, dia_semana),

    CONSTRAINT fk_horario_mesero_mesero
        FOREIGN KEY (num_empleado)
        REFERENCES mesero(num_empleado)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT chk_horario_dia
        CHECK (dia_semana IN (
            'Lunes', 'Martes', 'Miércoles', 'Jueves',
            'Viernes', 'Sábado', 'Domingo'
        )),

    CONSTRAINT chk_horario_horas
        CHECK (hora_inicio < hora_fin)
);

-- SUBTIPO: COCINERO
-- Especialización parcial y traslapada

CREATE TABLE cocinero (
    num_empleado INTEGER NOT NULL,
    especialidad VARCHAR(50) NOT NULL,

    CONSTRAINT pk_cocinero
        PRIMARY KEY (num_empleado),

    CONSTRAINT fk_cocinero_empleado
        FOREIGN KEY (num_empleado)
        REFERENCES empleado(num_empleado)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- SUBTIPO: ADMINISTRATIVO
-- Especialización parcial y traslapada

CREATE TABLE administrativo (
    num_empleado INTEGER NOT NULL,
    rol VARCHAR(50) NOT NULL,

    CONSTRAINT pk_administrativo
        PRIMARY KEY (num_empleado),

    CONSTRAINT fk_administrativo_empleado
        FOREIGN KEY (num_empleado)
        REFERENCES empleado(num_empleado)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ENTIDAD DÉBIL: DEPENDIENTE

CREATE TABLE dependiente (
    num_empleado INTEGER NOT NULL,
    id_dependiente INTEGER NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    ap_pat VARCHAR(20) NOT NULL,
    ap_mat VARCHAR(20) NULL,--Opcional
    parentesco VARCHAR(50) NOT NULL,
    curp VARCHAR(18) NOT NULL,

    CONSTRAINT pk_dependiente
        PRIMARY KEY (num_empleado, id_dependiente),

    CONSTRAINT uq_dependiente_curp
        UNIQUE (curp),

    CONSTRAINT fk_dependiente_empleado
        FOREIGN KEY (num_empleado)
        REFERENCES empleado(num_empleado)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ENTIDAD: CLIENTE

CREATE TABLE cliente (
    id_cliente INTEGER NOT NULL,
    rfc VARCHAR(13) NOT NULL,
    email VARCHAR(120) NOT NULL,
    calle VARCHAR(80) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    colonia VARCHAR(80) NOT NULL,
    cp VARCHAR(10) NOT NULL,
    estado VARCHAR(60) NOT NULL,
    tipo_cliente VARCHAR(10) NOT NULL,

    CONSTRAINT pk_cliente
        PRIMARY KEY (id_cliente),

    CONSTRAINT uq_cliente_rfc
        UNIQUE (rfc),

    CONSTRAINT chk_cliente_tipo
        CHECK (tipo_cliente IN ('FISICA', 'MORAL'))
);

CREATE TABLE persona_fisica (
    id_cliente INTEGER NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    ap_pat VARCHAR(20) NOT NULL,
    ap_mat VARCHAR(20) NULL,
    fecha_nac DATE NOT NULL,

    CONSTRAINT pk_persona_fisica
        PRIMARY KEY (id_cliente),

    CONSTRAINT fk_persona_fisica_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE persona_moral (
    id_cliente INTEGER NOT NULL,
    razon_social VARCHAR(250) NOT NULL,

    CONSTRAINT pk_persona_moral
        PRIMARY KEY (id_cliente),

    CONSTRAINT fk_persona_moral_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ENTIDAD: CATEGORIA

CREATE TABLE categoria (
    id_categoria INTEGER,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,

    CONSTRAINT pk_categoria
        PRIMARY KEY (id_categoria),

    CONSTRAINT uq_categoria_nombre
        UNIQUE (nombre)
);

-- ENTIDAD: PRODUCTO
-- Especialización disjunta total: PLATILLO o BEBIDA

CREATE TABLE producto (  
    id_producto INTEGER,
    id_categoria INTEGER NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    receta VARCHAR(500) NULL, --opcional
    precio NUMERIC(10,2) NOT NULL,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    tipo_producto VARCHAR(10) NOT NULL,

    CONSTRAINT pk_producto
        PRIMARY KEY (id_producto),

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_producto_precio
        CHECK (precio >= 0),

    CONSTRAINT chk_producto_tipo
        CHECK (tipo_producto IN ('PLATILLO', 'BEBIDA'))
);

/* 
   SECUENCIA Y FUNCIÓN PARA GENERAR FOLIO DE ORDEN
    */

DROP SEQUENCE IF EXISTS seq_folio_orden CASCADE;

CREATE SEQUENCE seq_folio_orden
START WITH 1
INCREMENT BY 1;

CREATE FUNCTION generar_folio_orden()
RETURNS VARCHAR(10) AS $$
DECLARE
    num_folio INTEGER;
    folio_generado VARCHAR(10);
BEGIN
    num_folio := nextval('seq_folio_orden');

    folio_generado := 'ORD-' || LPAD(num_folio::TEXT, 3, '0');

    RETURN folio_generado;
END;
$$ LANGUAGE plpgsql;

-- ENTIDAD: ORDEN

CREATE TABLE orden (
    folio VARCHAR(10) NOT NULL DEFAULT generar_folio_orden(),
    num_mesero INTEGER NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_pagar NUMERIC(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT pk_orden
        PRIMARY KEY (folio),

    CONSTRAINT fk_orden_mesero
        FOREIGN KEY (num_mesero)
        REFERENCES mesero(num_empleado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_orden_total_pagar
        CHECK (total_pagar >= 0),

    CONSTRAINT chk_orden_folio_formato
        CHECK (folio ~ '^ORD-[0-9]{3}$')
);

-- RELACIÓN M:M CONTIENE
-- ORDEN - PRODUCTO

CREATE TABLE detalle_orden (
    folio VARCHAR(10) NOT NULL,
    id_producto INTEGER NOT NULL,
    cant_prod INTEGER NOT NULL,
    subtotal_prod NUMERIC(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT pk_detalle_orden
        PRIMARY KEY (folio, id_producto),

    CONSTRAINT fk_detalle_orden_orden
        FOREIGN KEY (folio)
        REFERENCES orden(folio)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_orden_producto
        FOREIGN KEY (id_producto)
        REFERENCES producto(id_producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_detalle_orden_cantidad
        CHECK (cant_prod > 0),

    CONSTRAINT chk_detalle_orden_subtotal
        CHECK (subtotal_prod >= 0)
);

-- RELACIÓN M:M PAGA
-- ORDEN - CLIENTE

CREATE TABLE pago (
    folio VARCHAR(10) NOT NULL,
    id_cliente INTEGER NOT NULL,
    porcentaje_pago NUMERIC(5,2) NOT NULL,
    monto_pago NUMERIC(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT pk_pago
        PRIMARY KEY (folio, id_cliente),

    CONSTRAINT fk_pago_orden
        FOREIGN KEY (folio)
        REFERENCES orden(folio)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_pago_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_pago_porcentaje
        CHECK (porcentaje_pago > 0 AND porcentaje_pago <= 100),

    CONSTRAINT chk_pago_monto
        CHECK (monto_pago >= 0)
);

-- ENTIDAD: FACTURA

CREATE TABLE factura (
    id_factura INTEGER,
    folio VARCHAR(10) NOT NULL,
    id_cliente INTEGER NOT NULL,
    fecha_emision TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_factura
        PRIMARY KEY (id_factura),

    CONSTRAINT uq_factura_orden_cliente
        UNIQUE (folio, id_cliente), --Evita más de una factura para el mismo pago.

    CONSTRAINT fk_factura_pago
        FOREIGN KEY (folio, id_cliente)
        REFERENCES pago(folio, id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT -- Garantiza que ese pago exista.
);
