CREATE TABLE proveedor (
	razon_Social VARCHAR(100) PRIMARY KEY,
	calle VARCHAR(50) NOT NULL,
	estado VARCHAR(50) NOT NULL,
	ciudad VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	ap_Pat VARCHAR(50) NOT NULL,
	ap_Mat VARCHAR(50) NULL
);
CREATE TABLE telProveedor (
    id_telefono INT PRIMARY KEY,
    razon_Social VARCHAR(100 REFERENCES proveedor(VARCHAR(100),
    telefono VARCHAR(15) NOT NULL
);
CREATE TABLE producto (
    codigoProducto VARCHAR(10) PRIMARY KEY,
    fechaCompra DATE NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
	stock INT NOT NULL,
	foto BYTEA NOT NULL
);
CREATE TABLE venta (
    numeroVenta INT PRIMARY KEY,
    fechaVenta DATE NOT NULL,
    totalVenta NUMERIC(10,2) NOT NULL
);
CREATE TABLE empleado (
    claveEmpleado VARCHAR(10) PRIMARY KEY,
    fechaNacimiento DATE NOT NULL,
    calleEmp VARCHAR(50) NOT NULL,
	estadoEmp VARCHAR(50) NOT NULL,
	ciudadEmp VARCHAR(50) NOT NULL,
	fechaIngreso DATE NOT NULL
);
CREATE TABLE cliente (
    RFC VARCHAR(13) PRIMARY KEY,
	nombreCliente VARCHAR(50) NOT NULL,
	apPatCliente VARCHAR(50) NOT NULL,
	apMatCliente VARCHAR(50) NULL,
	calleCliente VARCHAR(50) NOT NULL,
	estadoCliente VARCHAR(50) NOT NULL,
	ciudadCliente VARCHAR(50) NOT NULL
);
CREATE TABLE emailCliente (
    id_email INT PRIMARY KEY,
    razon_social VARCHAR(100) REFERENCES proveedor(razon_social),
    email_cliente VARCHAR(80) NOT NULL
);



select* from emailCliente
