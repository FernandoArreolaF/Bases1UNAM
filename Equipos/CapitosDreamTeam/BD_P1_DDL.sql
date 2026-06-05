--Proyecto Final BD Grupo 01
--Equipo CapitosDreamTeam
-- Autores:
--Alvarez Salgado Eduardo Antonio
--Lara Hernández Emmanuel
--Merida Serralde Francisco Jared
--Ponce de León Reyes Bruno
--Zepeda Aparicio Diego Arturo

--Código DDL para generación de tablas en la BD

--- CATEGORIA

-- Creando tabla Categoria
CREATE TABLE CATEGORIA (
    nombreCategoria varchar(40) not null,
    descripcion varchar(200) not null,
    CONSTRAINT categoria_pk PRIMARY KEY(nombreCategoria)
);

--- PRODUCTO

--Creando una secuencia para los productos
CREATE SEQUENCE seq_producto_id
START WITH 1
INCREMENT BY 1;

--Creando tabla Producto
CREATE TABLE PRODUCTO (
    idProducto smallint DEFAULT nextval('seq_producto_id'),
    nombreProducto varchar(50) not null,
    descripcion varchar(250) not null,
    receta varchar(1000) not null,
    precio decimal(10,2) not null,
    cantidadDisponible smallint not null,
    tipoProducto varchar(8) not null, 
    nombreCategoria varchar(40) not null,
    CONSTRAINT producto_pk PRIMARY KEY(idProducto),
    CONSTRAINT producto_nombreCategoria_fk FOREIGN KEY(nombreCategoria) 
        REFERENCES CATEGORIA(nombreCategoria),
    CONSTRAINT producto_cantidadDisponible_chk CHECK(cantidadDisponible >= 0),
    CONSTRAINT producto_tipoProducto_chk CHECK(tipoProducto in ('PLATILLO','BEBIDA'))
);

--- CLIENTE

--Creando una secuencia para los clientes
CREATE SEQUENCE seq_cliente_id
START WITH 1
INCREMENT BY 1;

-- Creando tabla cliente
CREATE TABLE CLIENTE (
    idCliente integer DEFAULT nextval('seq_cliente_id'),
    rfc varchar(13) not null,
    nomPila varchar(50) not null,
    apPaterno varchar(50) not null,
    apMaterno varchar(50) not null,
    domEstado varchar(40) not null,
    domCodigoPostal char(5) not null,
    domColonia varchar(80) not null,
    domCalle varchar(80) not null,
    domNumero varchar(10) not null,
    fechaNacimiento date not null,
    razonSocial varchar(254) not null,
    email varchar(100) not null,
    CONSTRAINT cliente_pk PRIMARY KEY (idCliente),
    CONSTRAINT cliente_rfc_uk UNIQUE(rfc)
);

--- EMPLEADO

--Creando una secuencia para los empleados
CREATE SEQUENCE seq_empleado_num
START WITH 1
INCREMENT BY 1;

--Creando tabla empleado
CREATE TABLE EMPLEADO (
    numeroEmpleado integer DEFAULT nextval('seq_empleado_num'),
    fechaNacimiento date not null,
    rfc varchar(13) not null,
    nomPila varchar(50) not null,
    apPaterno varchar(50) not null,
    apMaterno varchar(50) not null,
    -- Se calculará la edad con el uso de una Vista
    domEstado varchar(40) not null,
    domCodigoPostal char(5) not null,
    domColonia varchar(80) not null,
    domCalle varchar(80) not null,
    domNumero varchar(10) not null,
    sueldo decimal(10,2) not null,
    foto bytea not null,
    CONSTRAINT empleado_pk PRIMARY KEY(numeroEmpleado),
    CONSTRAINT empleado_rfc_uk UNIQUE(rfc)
);

-- Creación de la vista v_empleado que incluye la edad calculada automáticamente
CREATE VIEW v_empleado AS
SELECT
    numeroEmpleado,
    fechaNacimiento,
    rfc,
    nomPila,
    apPaterno,
    apMaterno,
    cast(extract(year from age(fechaNacimiento)) as smallint) as edad,
    domEstado,
    domCodigoPostal,
    domColonia,
    domCalle,
    domNumero,
    sueldo,
    foto
FROM EMPLEADO;

--Creando tabla Telefono_Empleado
CREATE TABLE TELEFONO_EMPLEADO (
    telefono varchar(15) not null,
    numeroEmpleado integer not null,
    CONSTRAINT telefono_empleado_pk PRIMARY KEY(telefono, numeroEmpleado),
    --Se utilizó on delete cascade por si se elimina un registro de empleado,tambien se eliminen sus teléfonos asocaidos
    CONSTRAINT telefono_empleado_numeroEmpleado_fk FOREIGN KEY(numeroEmpleado) 
        REFERENCES EMPLEADO(numeroEmpleado) ON DELETE CASCADE
);

--Creando tabla dependiente_empleado
CREATE TABLE DEPENDIENTE_EMPLEADO (
    idDependiente smallint not null,
    numeroEmpleado integer not null,
    curp char(18) not null,
    nomPila varchar(50) not null,
    apPaterno varchar(50) not null,
    apMaterno varchar(50) null, 
    parentesco varchar(40) not null,
    CONSTRAINT dependiente_empleado_pk PRIMARY KEY(idDependiente, numeroEmpleado),
    CONSTRAINT dependiente_empleado_numeroEmpleado_fk FOREIGN KEY(numeroEmpleado) 
        REFERENCES EMPLEADO(numeroEmpleado) ON DELETE CASCADE,
    CONSTRAINT dependiente_empleado_curp_uk UNIQUE(curp)
);

-- Creando tabla tipo_empleado
CREATE TABLE TIPO_EMPLEADO (
    tipoEmpleado varchar(20) not null,
    numeroEmpleado integer not null,
    CONSTRAINT tipo_empleado_pk PRIMARY KEY(tipoEmpleado, numeroEmpleado),
    CONSTRAINT tipo_empleado_numeroEmpleado_fk FOREIGN KEY(numeroEmpleado) 
        REFERENCES EMPLEADO(numeroEmpleado) ON DELETE CASCADE,
    CONSTRAINT tipo_empleado_tipoEmpleado_chk CHECK(tipoEmpleado in ('COCINERO','MESERO','ADMINISTRATIVO'))
);

--Creando tabla de cocinero
CREATE TABLE COCINERO (
    numeroEmpleado integer not null,
    especialidadCocinero varchar(50) not null,
    CONSTRAINT cocinero_pk PRIMARY KEY(numeroEmpleado),
    CONSTRAINT cocinero_numeroEmpleado_fk FOREIGN KEY(numeroEmpleado) 
        REFERENCES EMPLEADO(numeroEmpleado) ON DELETE CASCADE
);

--Creando tabla de mesero
CREATE TABLE MESERO (
    numeroEmpleado integer not null,
    horaEntrada time not null,
    horaSalida time not null,
    CONSTRAINT mesero_pk PRIMARY KEY(numeroEmpleado),
    CONSTRAINT mesero_numeroEmpleado_fk FOREIGN KEY(numeroEmpleado) 
        REFERENCES EMPLEADO(numeroEmpleado) ON DELETE CASCADE
);

--Creando tabla de administrativo
CREATE TABLE ADMINISTRATIVO (
    numeroEmpleado integer not null,
    rolAdministrativo varchar(80) not null,
    CONSTRAINT administrativo_pk PRIMARY KEY(numeroEmpleado),
    CONSTRAINT administrativo_numeroEmpleado_fk FOREIGN KEY(numeroEmpleado) 
        REFERENCES EMPLEADO(numeroEmpleado) ON DELETE CASCADE
);

--- ORDEN

--Creando una secuencia para las órdenes
CREATE SEQUENCE seq_orden_folio
START WITH 1
INCREMENT BY 1;

--Creando tabla de orden
CREATE TABLE ORDEN (
    folio varchar(15) DEFAULT ('ORD-' || to_char(nextval('seq_orden_folio'),'FM0000')),
    fechaOrden timestamp not null, 
    totalAPagar decimal(10,2) DEFAULT 0 not null, --Se hace uso de trigger para calcular el pago total
    numeroEmpleado integer not null,
    CONSTRAINT orden_pk PRIMARY KEY(folio),
    CONSTRAINT orden_numeroEmpleado_fk FOREIGN KEY(numeroEmpleado) 
        REFERENCES MESERO(numeroEmpleado)
);

--- FACTURA

--Creando una secuencia para las facturas
CREATE SEQUENCE seq_factura_id
START WITH 1
INCREMENT BY 1;

--Creando tabla de factura
CREATE TABLE FACTURA (
    idFactura integer DEFAULT nextval('seq_factura_id'),
    fechaFactura timestamp not null,
    folio varchar(15) not null,
    idCliente integer not null,
    CONSTRAINT factura_pk PRIMARY KEY(idFactura),
    CONSTRAINT factura_folio_fk FOREIGN KEY(folio) 
        REFERENCES ORDEN(folio),
    CONSTRAINT factura_idCliente_fk FOREIGN KEY (idCliente) 
        REFERENCES CLIENTE(idCliente)
);

--Creando tabla de detalle_orden
CREATE TABLE DETALLE_ORDEN (
    folio varchar(15) not null,
    idProducto smallint not null,
    cantidad integer not null,
    precioTotalProducto decimal(10,2) DEFAULT 0 not null, --Se hace uso de un trigger para calcular el total
    CONSTRAINT detalle_orden_pk PRIMARY KEY(folio, idProducto),
    CONSTRAINT detalle_orden_folio FOREIGN KEY(folio) 
        REFERENCES ORDEN(folio) ON DELETE CASCADE,
    CONSTRAINT detalle_orden_idProducto_fk FOREIGN KEY (idProducto) 
        REFERENCES PRODUCTO(idProducto)
);
