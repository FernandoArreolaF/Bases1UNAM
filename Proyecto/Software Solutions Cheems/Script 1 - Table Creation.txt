CREATE TABLE proveedor(
	razon_social varchar(100),
	nombre varchar(100) not null,
	calle varchar(60) not null,
	numero int not null,
	cp int not null,
	colonia varchar(60) not null,
	estado varchar(60) not null,
	CONSTRAINT proveedor_PK PRIMARY KEY (razon_social)
	);
	
CREATE TABLE telefono(
	telefono bigint,
	razon_social varchar(100) not null,
	CONSTRAINT telefono_PK PRIMARY KEY (telefono),
	CONSTRAINT fk_proveedor
	FOREIGN KEY (razon_social)
	REFERENCES proveedor(razon_social)
	ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE inventario(
	codigo_barras varchar(50),
	cantidad_stock int not null,
	marca varchar(50) not null,
	precio float not null,
	descripcion varchar(100) not null,
	CONSTRAINT inventario_PK PRIMARY KEY (codigo_barras)
	);	

CREATE TABLE suministra(
	razon_social varchar(100),
	codigo_barras varchar(50),
	fecha_compra date not null,
	precio_adquirido float not null,
	CONSTRAINT suministra_PK 
	PRIMARY KEY(razon_social, codigo_barras),
	CONSTRAINT proveedor_FK
	FOREIGN KEY (razon_social)
	REFERENCES proveedor(razon_social)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT inventario_FK
	FOREIGN KEY (codigo_barras)
	REFERENCES inventario(codigo_barras)
	ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE cliente(
	id_cliente varchar(50),
	nombre varchar (100) not null,
	rfc varchar(30) not null,
	calle varchar(60) not null,
	numero int not null,
	cp int not null,
	colonia varchar(60) not null,
	estado varchar(60) not null,
	email varchar (60) not null,
	CONSTRAINT cliente_PK PRIMARY KEY (id_cliente)
	);

CREATE TABLE venta(
	num_venta varchar(20),
	fecha_venta date not null,
	cantidad_total float not null,
	id_cliente varchar (50),
	CONSTRAINT venta_PK PRIMARY KEY (num_venta),
	CONSTRAINT cliente_FK
	FOREIGN KEY (id_cliente)
	REFERENCES cliente(id_cliente)
	ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE pertenece(
	codigo_barras varchar (50),
	num_venta varchar (20) not null,
	cantidad_articulo int not null,
	precio_total_articulo float not null,
	CONSTRAINT pertenece_pk PRIMARY KEY(codigo_barras, num_venta),
	CONSTRAINT inventario_FK
	FOREIGN KEY (codigo_barras)
	REFERENCES inventario(codigo_barras)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT venta_FK
	FOREIGN KEY (num_venta)
	REFERENCES venta(num_venta)
	ON DELETE CASCADE ON UPDATE CASCADE
	);
