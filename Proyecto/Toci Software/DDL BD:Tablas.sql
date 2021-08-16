--------------------------------------------------------------------------------------
-------------------------------------Toci Software------------------------------------
--------------------------------------------------------------------------------------
/*Base de datos del quipo toci SOFTWARE.
Integrantes:
*Arreguin Portillo Diana Laura
*Brito Serrano Miguel Ángel
*Marentes Degollado Ian Paul
*Meza Vega Hugo Adrián
*/



--Creación de nuestra base de datos para el proyecto proyecto.
CREATE DATABASE proyecto
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

--------------------------------------------------------------------------------------
-------------------------------------Comentario---------------------------------------
--------------------------------------------------------------------------------------
/*A continuación, están todas las sentencias DDL para la creación de las tablas de nuestra 
base de datos*/

CREATE TABLE ESTADO(
codigo_postal int NOT NULL,
estado varchar(50) NOT NULL,
CONSTRAINT ESTADO_pk PRIMARY KEY (codigo_postal)
);

CREATE TABLE PROVEEDOR(
	razon_social varchar(100) NOT NULL,
	nombre varchar(80) NOT NULL,
	calle varchar(50) NOT NULL,
	numero int NOT NULL,
	colonia varchar(100) NOT NULL,
	codigo_postal int NOT NULL,
	CONSTRAINT PROVEEDOR_pk PRIMARY KEY (razon_social),
	CONSTRAINT PROVEEDOR_fk0 FOREIGN KEY (codigo_postal) REFERENCES ESTADO(codigo_postal) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE TELEFONOPROV(
	telefono varchar(20) NOT NULL,
	razon_social varchar(100) NOT NULL,
	CONSTRAINT TELEFONOPROV_pk PRIMARY KEY (telefono),
	CONSTRAINT TELEFONOPROV_fk0 FOREIGN KEY (razon_social) REFERENCES PROVEEDOR(razon_social) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PRODUCTO(
	id_producto int NOT NULL,
	descripcion varchar(250) NOT NULL,
	precio_unidad decimal(10,2) NOT NULL,
	stock int NOT NULL,
	precio_proveedor decimal(10,2) NOT NULL,
	utilidad decimal(10,2) NOT NULL,
	fecha_compra DATE ,
	marca varchar(50) ,
	codigo_barras varchar(30) ,
	CONSTRAINT PRODUCTO_pk PRIMARY KEY (id_producto) 
);

CREATE TABLE CLIENTE(
	rfc varchar(13) NOT NULL,
	nombre_pila varchar(30) NOT NULL,
	ap_paterno varchar(30) NOT NULL,
	ap_materno varchar(30),
	calle varchar(50) NOT NULL,
	numero int NOT NULL,
	colonia varchar(100) NOT NULL,
	codigo_postal int NOT NULL,
	passwd varchar(50) NOT NULL DEFAULT 'password',
	CONSTRAINT CLIENTE_pk PRIMARY KEY (rfc),
	CONSTRAINT cliente_fk0 FOREIGN KEY (codigo_postal) REFERENCES ESTADO(codigo_postal) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE SUMINISTRA(
	razon_social varchar(100) NOT NULL,
	id_producto int NOT NULL,
	CONSTRAINT SUMINISTRA_pk PRIMARY KEY (razon_social,id_producto),
	CONSTRAINT SUMINISTRA_fk0 FOREIGN KEY (razon_social) REFERENCES PROVEEDOR(razon_social) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT SUMINISTRA_fk1 FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TIPO(
	id_tipo int NOT NULL,
	descrip_tipo varchar(30) NOT NULL,
	CONSTRAINT TIPO_pk PRIMARY KEY (id_tipo)
);

CREATE TABLE TIPOPRODUCTO(
	id_producto int NOT NULL,
	id_tipo int NOT NULL,
	CONSTRAINT TIPOPRODUCTO_pk PRIMARY KEY (id_producto, id_tipo),
	CONSTRAINT TIPOPRODUCTO_fk0 FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT TIPOPRODUCTO_fk1 FOREIGN KEY (id_tipo) REFERENCES TIPO(id_tipo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE EMAILCLIENTE(
	email varchar(50) NOT NULL,
	rfc varchar(13) NOT NULL,
	CONSTRAINT EMAILCLIENTE_pk PRIMARY KEY (email),
	CONSTRAINT EMAILCLIENTE_fk0 FOREIGN KEY (rfc) REFERENCES CLIENTE(rfc) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE VENTA(
	num_venta varchar(8) NOT NULL,
	rfc varchar(13) NOT NULL,
	fecha_venta DATE NOT NULL,
	monto_total decimal(10,2) NOT NULL,
	CONSTRAINT VENTA_pk PRIMARY KEY (num_venta),
	CONSTRAINT VENTA_fk0 FOREIGN KEY (rfc) REFERENCES CLIENTE(rfc) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TIENE(
	num_venta varchar(8) NOT NULL,
	id_producto int NOT NULL,
	precio_unidad decimal(10,2) NOT NULL,
	cantidad_articulo int NOT NULL,
	precio_total_xarticulo decimal(10,2) NOT NULL,
	CONSTRAINT TIENE_pk PRIMARY KEY (num_venta,id_producto),
	CONSTRAINT TIENE_fk0 FOREIGN KEY (num_venta) REFERENCES VENTA(num_venta) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT TIENE_fk1 FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);








