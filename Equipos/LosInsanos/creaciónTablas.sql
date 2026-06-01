/* 
Código de la creación de la base de datos y tablas
Fecha: 26/05/2026   
*/

--Creación de base de datos
--CREATE DATABASE restauranteLosInsanos;

--Tabla Empleado
CREATE TABLE EMPLEADO(
    numero_empleado         numeric(10, 0)    NOT NULL,
    rfc_emp                 varchar(13)       NOT NULL,
    nombre_emp              varchar(30)       NOT NULL,
    apellido_paterno_emp    varchar(30)       NOT NULL,
    apellido_materno_emp    varchar(30)       NULL,
    fecha_nacimiento_emp    date              NULL,
    edad                    numeric(3, 0)     NULL,
    sueldo                  numeric(10, 2)    NULL,
    foto                    varchar(30)       NULL,
    estado_emp              varchar(20)       NULL,
    codigo_postal_emp       numeric(5, 0)     NULL,
    colonia_emp             varchar(50)       NULL,
    calle_emp               varchar(50)       NULL,
    numero_emp              varchar(20)       NULL,
    es_cocinero             boolean           NULL,
    es_administrativo       boolean           NULL,
    es_mesero               boolean           NULL,
    CONSTRAINT PK1 PRIMARY KEY (numero_empleado)
);

--Tabla Empleado_Telefono
CREATE TABLE EMPLEADO_TELEFONO(
    id_telefono        varchar(10)       NOT NULL,
    telefono           varchar(12)       NOT NULL,
    numero_empleado    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY (id_telefono)
);

--Tabla Dependiente
CREATE TABLE DEPENDIENTE(
    id_dependiente          varchar(10)       NOT NULL,
    curp                    varchar(16)       NOT NULL,
    numero_empleado         numeric(10, 0)    NOT NULL,
    nombre_dep              varchar(30)       NOT NULL,
    apellido_paterno_dep    varchar(30)       NOT NULL,
    apellido_materno_dep    varchar(30)       NULL,
    CONSTRAINT PK3 PRIMARY KEY (id_dependiente, numero_empleado)
);

--Tabla Cocinero
CREATE TABLE COCINERO(
    numero_empleado    numeric(10, 0)    NOT NULL,
    especialidad       varchar(30)       NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (numero_empleado)
);

--Tabla Administrativo
CREATE TABLE ADMINISTRATIVO(
    numero_empleado    numeric(10, 0)    NOT NULL,
    rol                varchar(30)       NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (numero_empleado)
);

--Tabla Mesero
CREATE TABLE MESERO(
    numero_empleado    numeric(10, 0)    NOT NULL,
    turno              varchar(20)       NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY (numero_empleado)
);

--Tabla Categoria
CREATE TABLE CATEGORIA(
    id_categoria             varchar(10)    NOT NULL,
    nombre_categoria         varchar(30)    NOT NULL,
    descripcion_categoria    varchar(50)    NULL,
    CONSTRAINT PK7 PRIMARY KEY (id_categoria)
);

--Tabla Producto
CREATE TABLE PRODUCTO(
    id_producto             varchar(10)      NOT NULL,
    nombre_producto         varchar(40)      NOT NULL,
    disponibilidad          char(1)          NOT NULL,
    precio                  numeric(8, 2)    NOT NULL,
    receta                  varchar(100)     NULL,
    descripcion_producto    varchar(100)     NULL,
    id_categoria            varchar(10)      NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY (id_producto)
);

--Tabla Cliente
CREATE TABLE CLIENTE(
    rfc_cliente            varchar(13)      NOT NULL,
    email                  varchar(100)     NOT NULL,
    nombre_cl              varchar(30)      NOT NULL,
    apellido_paterno_cl    varchar(30)      NOT NULL,
    apellido_materno_cl    varchar(30)      NULL,
    razon_social           varchar(100)     NULL,
    fecha_nacimiento_cl    date             NULL,
    estado_cl              varchar(20)      NULL,
    codigo_postal_cl       numeric(5, 0)    NULL,
    colonia_cl             varchar(50)      NULL,
    calle_cl               varchar(50)      NULL,
    numero_cl              varchar(20)      NULL,
    CONSTRAINT PK9 PRIMARY KEY (rfc_cliente)
);

--Tabla Orden
CREATE TABLE ORDEN(
    folio              varchar(20)        NOT NULL,
    fecha_hora         timestamp         NOT NULL,
    total_pagar        numeric(8, 2)     NOT NULL,
    rfc_cliente        varchar(13)       NULL,
    numero_empleado    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK10 PRIMARY KEY (folio)
);

--Tabla Orden_Producto
CREATE TABLE ORDEN_PRODUCTO(
    folio                 varchar(20)       NOT NULL,
    id_producto           varchar(10)      NOT NULL,
    total_por_producto    numeric(8, 2)    NOT NULL,
    cantidad_producto     numeric(2, 0)    NOT NULL,
    CONSTRAINT PK14 PRIMARY KEY (folio, id_producto)
);

/*
 Constraints
*/

--Tabla Empleado
ALTER TABLE EMPLEADO
ADD CONSTRAINT UQ_empleado_rfc UNIQUE (rfc_emp);

--Tabla Empleado Telefono
ALTER TABLE EMPLEADO_TELEFONO ADD CONSTRAINT FK_Empleado_Telefono 
    FOREIGN KEY (numero_empleado)
    REFERENCES EMPLEADO(numero_empleado);

--Tabla Dependiente
ALTER TABLE DEPENDIENTE ADD CONSTRAINT FK_Dependiente_Empleado 
    FOREIGN KEY (numero_empleado)
    REFERENCES EMPLEADO(numero_empleado);

ALTER TABLE DEPENDIENTE
ADD CONSTRAINT UQ_curp_dependiente UNIQUE (curp);

CREATE SEQUENCE seq_id_dependiente START WITH 1;
ALTER TABLE DEPENDIENTE 
ALTER COLUMN id_dependiente SET DEFAULT ('DEP' || LPAD(NEXTVAL('seq_id_dependiente')::TEXT, 2, '0'));

--Tabla Cocinero
ALTER TABLE COCINERO ADD CONSTRAINT FK_Cocinero_Empleado 
    FOREIGN KEY (numero_empleado)
    REFERENCES EMPLEADO(numero_empleado);

--Tabla Administrativo
ALTER TABLE ADMINISTRATIVO ADD CONSTRAINT FK_Administrativo_Empleado 
    FOREIGN KEY (numero_empleado)
    REFERENCES EMPLEADO(numero_empleado);

--Tabla Mesero
ALTER TABLE MESERO ADD CONSTRAINT FK_Mesero_Empleado 
    FOREIGN KEY (numero_empleado)
    REFERENCES EMPLEADO(numero_empleado);

--Tabla Producto
ALTER TABLE PRODUCTO ADD CONSTRAINT FK_Producto_Categoria 
    FOREIGN KEY (id_categoria)
    REFERENCES CATEGORIA(id_categoria);

--Tabla Cliente
ALTER TABLE CLIENTE
ADD CONSTRAINT UQ_cliente_email UNIQUE (email);

--Tabla Orden
ALTER TABLE ORDEN ADD CONSTRAINT FK_Orden_Cliente 
    FOREIGN KEY (rfc_cliente)
    REFERENCES CLIENTE(rfc_cliente);

ALTER TABLE ORDEN ADD CONSTRAINT FK_Orden_Mesero 
    FOREIGN KEY (numero_empleado)
    REFERENCES MESERO(numero_empleado);

ALTER TABLE ORDEN ALTER COLUMN total_pagar SET DEFAULT 0;

CREATE SEQUENCE seq_folio_orden START WITH 1;
ALTER TABLE ORDEN 
ALTER COLUMN folio SET DEFAULT ('ORD-' || LPAD(NEXTVAL('seq_folio_orden')::TEXT, 3, '0'));

--Tabla Orden_Producto
ALTER TABLE ORDEN_PRODUCTO ADD CONSTRAINT FK_Orden_Producto__Orden 
    FOREIGN KEY (folio)
    REFERENCES ORDEN(folio);

ALTER TABLE ORDEN_PRODUCTO ADD CONSTRAINT FK_Orden_Producto__Producto 
    FOREIGN KEY (id_producto)
    REFERENCES PRODUCTO(id_producto);


