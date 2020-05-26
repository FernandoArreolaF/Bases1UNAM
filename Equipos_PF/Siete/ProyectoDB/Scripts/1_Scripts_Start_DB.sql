/*---------------------------------------
-----------------------------------------
----------------------------------------
------	BLOQUE PARA INICIALIZAR LA BASE--
--------------------------------------------
-------------------------------------------
------------------------------------------
---------------------------------------------
-------------------------------------------*/
create database armenta;
\c armenta

create table inventario(
	cod_barras int,
	precio_compra float,
	fecha_compra date,
	stock int,
	constraint inv_pri primary key(cod_barras)
);

CREATE TABLE Regiones(
	CP int,
	edo varchar (20),
	colonia varchar (20),
	primary key(CP)
);

create table proveedor(
	id_prov int,
	rs_prov varchar (20),
	nombre_prov varchar (60),
	calle_prov varchar (20),
	num_prov int,
	cp int,
	constraint prov_pri primary key(id_prov),
	CONSTRAINT cp_fk FOREIGN KEY (cp) REFERENCES regiones(cp)
);
create table cliente(
	id_cliente int,
	rs_cliente varchar (20),
	nombre_cliente varchar (60),
	calle_cliente varchar (20),
	num_cliente int,
	cp int,
	constraint cliente_pri primary key(id_cliente),
	CONSTRAINT cp_fk FOREIGN KEY (cp) REFERENCES regiones(cp)
);

create table telefono(
	telefono int,
	id_prov int,
	constraint telefono_pri primary key(telefono, id_prov),
	constraint tel_fk foreign key (id_prov) references proveedor(id_prov) on delete cascade
);
create table email(
	email varchar(50),
	id_cliente int,
	constraint email_pri primary key(email, id_cliente),
	constraint email_fk foreign key (id_cliente) references cliente(id_cliente) on delete cascade
);
create table marcas(
	id_prov int,
	marca varchar(20),
	constraint marcas_pri primary key(marca,id_prov),
	constraint id_prov_FK foreign key(id_prov) references proveedor(id_prov)
);

create table producto_detalles(
	cod_barras int,
	precio_venta float,
	descripcion varchar(80),
	id_prov int,
	constraint producto_detalles_pri primary key(cod_barras),
	constraint cod_barras_FK foreign key (cod_barras) references inventario(cod_barras) on delete cascade,
	constraint id_prov_FK foreign key (id_prov) references proveedor(id_prov)
);
create table producto_codigo(
	id_prod int,
	cod_barras int,
	constraint producto_codigo_pri primary key(id_prod,cod_barras),
	CONSTRAINT cod_barras_FK FOREIGN KEY (cod_barras) REFERENCES producto_detalles(cod_barras) ON DELETE CASCADE
);

create table venta(
	id_venta varchar(30),
	id_cliente int,
	fecha_venta date,
	pago_total float,
	constraint venta_pri primary key(id_venta),
	constraint id_cliente_fk foreign key(id_cliente) references cliente(id_cliente)
);
create table venta_detalles(
	id_venta varchar(30),
	cod_barras int,
	cant_articulos int,
	precio_articulos float,
	constraint venta_detalles_pri primary key(id_venta, cod_barras),
	constraint cod_barras_venta_fk foreign key(cod_barras) references inventario(cod_barras),
	constraint id_venta_fk foreign key(id_venta) references venta(id_venta) on delete cascade
);
