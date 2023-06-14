BEGIN;

-- BASE DE DATOS

CREATE DATABASE Clarky;

-- TABLAS

CREATE TABLE PROVEDOR(
	rfcPro varchar(13) NOT NULL,
	nombre varchar (40) NOT NULL,
	razonSocial varchar(250) NOT NULL,
	calle varchar(150) NOT NULL,
	colonia varchar(100) NOT NULL, 
	cp int NOT NULL,
	estado varchar(50) NOT NULL, 
	num int NOT NULL,
	CONSTRAINT rfcPro_PK PRIMARY KEY (rfcPro)
);

CREATE TABLE TELEFONO(
	telefono varchar(15) NOT NULL, 
	rfcPro varchar(13) NOT NULL,
	CONSTRAINT tel_PK PRIMARY KEY (telefono),
	CONSTRAINT rfcPro_FK FOREIGN KEY (rfcPro)
	REFERENCES PROVEDOR(rfcPro)
);

CREATE TABLE CLIENTE(
	rfcClien varchar(13) NOT NULL,
	nombre varchar(80) NOT NULL,
	aPaterno varchar(40) NOT NULL, 
	aMaterno varchar(40), 
	cp int NOT NULL,
	estado varchar(45) NOT NULL,
	colonia varchar(70) NOT NULL,  
	calle varchar(80) NOT NULL, 
	num int NOT NULL,
	CONSTRAINT rfcClien_PK PRIMARY KEY (rfcClien)
);

CREATE TABLE EMAIL(
	emails varchar(100) NOT NULL,
	rfcClien varchar(13) NOT NULL,
	CONSTRAINT emails_PK PRIMARY KEY(emails),
	CONSTRAINT rfcClien_FK FOREIGN KEY(rfcClien)
	REFERENCES CLIENTE(rfcClien)
);

CREATE TABLE PRODUCTO(
	codigobarras varchar(14) NOT NULL,
	precio float,
	categoria varchar(25) check (categoria in ('Impresiones','Articulos Papeleria','Regalos','Recargas')) NOT NULL,
	marca varchar(60) NOT NULL,
	descripcion varchar (200) NOT NULL,
	stock int,
	CONSTRAINT rfcClien_PK PRIMARY KEY (codigobarras)
);

CREATE TABLE VENTA(
	idVen varchar(10) NOT NULL,
	fecha date NOT NULL,
	total_venta float,
	rfcclien varchar(13) NOT NULL,
	CONSTRAINT idVen_PK PRIMARY KEY(idVen),
	CONSTRAINT rfcClien_FK FOREIGN KEY(rfcClien)
	REFERENCES CLIENTE(rfcClien)
);

CREATE TABLE SUMINISTRAR(
	id_sum int NOT NULL,
	rfcPro varchar(13) NOT NULL,
	codigoBarras varchar(14) NOT NULL,
	cantidadSuministrar int NOT NULL,
	precio_compra float NOT NULL,
	fecha_compra date NOT NULL,
	CONSTRAINT suministrar_PK PRIMARY KEY(rfcPro, codigoBarras,id_sum),
	CONSTRAINT sum_rfcPro_FK FOREIGN KEY(rfcPro)
	REFERENCES PROVEDOR(rfcPro),
	CONSTRAINT sum_codigoBarras1_FK FOREIGN KEY(codigoBarras)
	REFERENCES PRODUCTO(codigoBarras)
);

CREATE TABLE CONFORMAR(
	codigobarras varchar(14) NOT NULL,
	idven int NOT NULL,
	cantidad int NOT NULL,
	total float NOT NULL,
	utilidad float NOT NULL,
	CONSTRAINT conformar_PK PRIMARY KEY(codigobarras, idven),
	CONSTRAINT conf_codigoBarras2_FK FOREIGN KEY(codigoBarras)
	REFERENCES PRODUCTO(codigobarras),
	CONSTRAINT conf_idVen_FK FOREIGN KEY(idVen)
	REFERENCES VENTA(idven)
);

COMMIT;