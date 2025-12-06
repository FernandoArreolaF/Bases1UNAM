/* ============================================================
    PapyrusDB Solutions - Sistema de Gestión para Papelería

    Archivo: [SCRUM-11_Creacion de la base de datos y tablas.sql]
    Descripción:
    En este script se presenta el DDL utilizado para la creación de la base de datos y de las tablas
	definidas a partir del Modelo Relacional. Asimismo, se implementaron verificaciones mediante restricciones
	CHECK con el propósito de satisfacer los requerimientos establecidos y reforzar la integridad de la 
	información, garantizando, entre otros aspectos, que los precios y pagos registrados correspondan a valores 
	positivos. También se incluyeron los constraints de llaves primarias (PK) y foráneas (FK) para mantener la
	correcta relación entre las entidades del sistema. 

    Fecha: [6 de diciembre del 2025]
   ============================================================*/



-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE PapyrusDB_Solutions
    WITH OWNER = postgres
    ENCODING = 'UTF8'
    TEMPLATE = template1;


-- CREACIÓN DE LAS TABLAS

-- TABLA: proveedor
CREATE TABLE proveedor (
    idProveedor   VARCHAR(15) PRIMARY KEY,
    nombre        VARCHAR(45)  NOT NULL,
    razonSocial   VARCHAR(80)  NOT NULL,
    estado        VARCHAR(30)  NOT NULL,
    colonia       VARCHAR(45)  NOT NULL,
    calle         VARCHAR(45)  NOT NULL,
    numero        INTEGER      NOT NULL,
    cp            INTEGER      NOT NULL
);

-- TABLA: telProveedor
CREATE TABLE telProveedor (
    idTelefono   VARCHAR(15) PRIMARY KEY,
    idProveedor  VARCHAR(15) NOT NULL,
    telefono     VARCHAR(15) NOT NULL,
    CONSTRAINT telProveedorFkProv
        FOREIGN KEY (idProveedor)
        REFERENCES proveedor(idProveedor)
);

-- TABLA: producto
CREATE TABLE producto (
    idProducto    VARCHAR(15) PRIMARY KEY,
    marca         VARCHAR(30) NOT NULL,
    descripcion   TEXT        NOT NULL,
    precioVenta   NUMERIC(10,2) NOT NULL,
    categoria     VARCHAR(4) NOT NULL,
    CONSTRAINT productoCategoriaChk
        CHECK (categoria IN ('REGA','PAPE','IMPR','RECA')),
    CONSTRAINT productoPrecioVentaPosChk
        CHECK (precioVenta > 0)
);

-- TABLA: inventario
CREATE TABLE inventario (
    codigoBarras   VARCHAR(15) PRIMARY KEY,
    idProducto     VARCHAR(15) NOT NULL,
    precioCompra   NUMERIC(10,2) NOT NULL,
    foto           BYTEA,
    fechaCompra    DATE        NOT NULL,
    stock          INTEGER     NOT NULL,
    CONSTRAINT inventarioFkProd
        FOREIGN KEY (idProducto)
        REFERENCES producto(idProducto),
    CONSTRAINT inventarioPrecioCompraPosChk
        CHECK (precioCompra > 0),
    CONSTRAINT inventarioStockNoNegChk
        CHECK (stock >= 0)
);

-- TABLA: empleado
CREATE TABLE empleado (
    idEmpleado  VARCHAR(15) PRIMARY KEY,
    nombre      VARCHAR(30) NOT NULL,
    apPat       VARCHAR(30) NOT NULL,
    apMat       VARCHAR(30),
    estado      VARCHAR(30) NOT NULL,
    colonia     VARCHAR(45) NOT NULL,
    calle       VARCHAR(45) NOT NULL,
    numero      INTEGER     NOT NULL,
    cp          INTEGER     NOT NULL,
    telefono    VARCHAR(15) NOT NULL
);

-- TABLA: cliente
CREATE TABLE cliente (
    idCliente  VARCHAR(15) PRIMARY KEY,
    rfc        VARCHAR(13),
    nombre     VARCHAR(30) NOT NULL,
    apPat      VARCHAR(30) NOT NULL,
    apMat      VARCHAR(30),
    estado     VARCHAR(30) NOT NULL,
    colonia    VARCHAR(45) NOT NULL,
    calle      VARCHAR(45) NOT NULL,
    numero     INTEGER     NOT NULL,
    cp         INTEGER     NOT NULL
);

-- TABLA: emailCliente
CREATE TABLE emailCliente (
    idEmail     VARCHAR(18) PRIMARY KEY,
    idCliente   VARCHAR(15) NOT NULL,
    email       VARCHAR(75) NOT NULL,
    CONSTRAINT emailClienteFkCli
        FOREIGN KEY (idCliente)
        REFERENCES cliente(idCliente)
);

-- TABLA: venta
CREATE TABLE venta (
    idVenta      VARCHAR(15) PRIMARY KEY,
    idCliente    VARCHAR(15) NOT NULL,
    idEmpleado   VARCHAR(15) NOT NULL,
    fechaVenta   DATE        NOT NULL,
    pagoTotal    NUMERIC(10,2) NOT NULL,
    CONSTRAINT ventaFkCli
        FOREIGN KEY (idCliente)
        REFERENCES cliente(idCliente),
    CONSTRAINT ventaFkEmp
        FOREIGN KEY (idEmpleado)
        REFERENCES empleado(idEmpleado),
    CONSTRAINT ventaPagoTotalNoNegChk
        CHECK (pagoTotal >= 0),
    CONSTRAINT ventaIdFormatoChk
        CHECK (idVenta ~ '^VENT-[0-9]{3}$')
);

-- TABLA: detalleVenta
CREATE TABLE detalleVenta (
    idProducto              VARCHAR(15) NOT NULL,
    idVenta                 VARCHAR(15) NOT NULL,
    cantidadProducto        INTEGER      NOT NULL,
    precioUnitarioPorProd   NUMERIC(10,2) NOT NULL,
    precioTotalPorProd      NUMERIC(10,2) NOT NULL,

    CONSTRAINT detVentaPkCompuesta
        PRIMARY KEY (idVenta, idProducto),

    CONSTRAINT detvFkProd
        FOREIGN KEY (idProducto)
        REFERENCES producto(idProducto),

    CONSTRAINT detvFkVenta
        FOREIGN KEY (idVenta)
        REFERENCES venta(idVenta),

    CONSTRAINT detVentaCantidadPosChk
        CHECK (cantidadProducto > 0),

    CONSTRAINT detVentaPrecioUnitPosChk
        CHECK (precioUnitarioPorProd > 0),

    CONSTRAINT detVentaPrecioTotalNoNegChk
        CHECK (precioTotalPorProd >= 0)
);

-- TABLA: entrega 
CREATE TABLE entrega (
    idProveedor   VARCHAR(15) NOT NULL,
    idProducto    VARCHAR(15) NOT NULL,
    fechaEntrega  DATE NOT NULL,

    CONSTRAINT entregaPkCompuesta
        PRIMARY KEY (idProveedor, idProducto),

    CONSTRAINT entregaFkProv
        FOREIGN KEY (idProveedor)
        REFERENCES proveedor(idProveedor),

    CONSTRAINT entregaFkProd
        FOREIGN KEY (idProducto)
        REFERENCES producto(idProducto)
);


