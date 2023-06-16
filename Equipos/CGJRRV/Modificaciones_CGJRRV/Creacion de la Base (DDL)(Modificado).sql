create database papeleria_PF;

\c papeleria_PF
--Creación de las tablas de entidades

CREATE TABLE PROVEEDOR 
(prov_razon_Social varchar(50) NOT NULL,
prov_nombre varchar (40),
prov_estado varchar(40) NOT NULL,
prov_CP smallint not null,
prov_colonia varchar(40) not null,
prov_calle varchar (40) NOT NULL, 
prov_numero smallint NOT NULL, 
CONSTRAINT "pk_proveedor" PRIMARY KEY (prov_razon_Social)
);

CREATE TABLE INVENTARIO 
(inv_codigo_Barras bigint NOT NULL,
inv_precio_Compra money not null,
inv_foto_Url text NOT NULL,
inv_fecha_Compra date NOT NULL,
inv_stock smallint NOT NULL, 
inv_modificacion_stock date not null default now(),
CONSTRAINT "pk_inventario" PRIMARY KEY (inv_codigo_Barras)
);

CREATE TABLE PRODUCTO 
(prod_id_Producto SERIAL not null,
prod_codigo_Barras bigint NOT null,
prod_descripcion varchar (150) not null,
prod_precio_Venta money NOT null check(prod_precio_venta > cast(0 as money)),
CONSTRAINT "pk_producto" PRIMARY KEY (prod_id_Producto),
CONSTRAINT "fk_producto" FOREIGN KEY (prod_codigo_Barras) REFERENCES inventario(inv_codigo_Barras) on update cascade on delete restrict
);

create table REGALO
(reg_id_Producto SERIAL not null,
reg_marca_Regalo varchar(50) default 'GENERICO',
reg_categoria_Regalo varchar(50),
CONSTRAINT "pk_regalo" PRIMARY key (reg_id_Producto),
CONSTRAINT "fk_regalo" FOREIGN KEY (reg_id_Producto) REFERENCES PRODUCTO(prod_id_Producto) on update restrict on delete restrict
);

create table ARTICULO
(art_id_Producto SERIAL,
art_marca_Articulo varchar(50) default 'GENERICO',
CONSTRAINT "pk_articulo" PRIMARY KEY (art_id_Producto),
CONSTRAINT "fk_articulo" FOREIGN KEY (art_id_Producto) REFERENCES PRODUCTO(prod_id_Producto) on update restrict on delete restrict
);

create table IMPRESION
(imp_id_Producto SERIAL,
imp_tamaño varchar(50),
imp_formato varchar(50),
CONSTRAINT "pk_impresion" PRIMARY KEY (imp_id_Producto),
CONSTRAINT "fk_impresion" FOREIGN KEY (imp_id_Producto) REFERENCES PRODUCTO(prod_id_Producto) on update restrict on delete restrict
);

create table RECARGA
(rec_id_Producto SERIAL,
rec_compania varchar(50),
CONSTRAINT "pk_recarga" PRIMARY KEY (rec_id_Producto),
CONSTRAINT "fk_recarga" FOREIGN KEY (rec_id_Producto) REFERENCES PRODUCTO(prod_id_Producto) on update restrict on delete restrict
);


CREATE TABLE CLIENTE
(cli_rfc char(13) NOT NULL,
cli_nombre varchar (60) NOT NULL,
cli_ap_Pat varchar (40) NOT NULL,
cli_ap_Mat varchar (40),
cli_estado varchar(40) NOT NULL,
cli_CP smallint not null,
cli_colonia varchar(40) not null,
cli_calle varchar (40) NOT NULL, 
cli_numero smallint NOT NULL,
CONSTRAINT "pk_cliente" PRIMARY KEY (cli_rfc)
);

CREATE TABLE VENTA 
(ven_num_Venta varchar(15) NOT null CHECK (ven_num_venta ~ '^VENT-[0-9]+$'),
ven_fecha_Venta date NOT null,
ven_monto_Total money default 0, 
ven_rfc_Cliente char(13) not null,
CONSTRAINT "pk_venta" PRIMARY KEY (ven_num_Venta),
CONSTRAINT "fk_venta" FOREIGN KEY (ven_rfc_Cliente) REFERENCES CLIENTE(cli_rfc) on update cascade on delete restrict
);



--Creación del sequencia y formato para numVenta de la tabla Venta
create SEQUENCE numVenta_Seq;
SELECT setval('numVenta_Seq',001);

create or replace function num_venta() returns varchar as
$$
select right('000' || nextval('numVenta_Seq')::varchar,4) as id;
$$
language sql;

alter table venta 
ALTER COLUMN ven_num_Venta SET DEFAULT (('VENT-'::text || num_venta()::text))



--Creación del sequencia y formato para numVentaC de la tabla contener
create SEQUENCE numVentaC_Seq;
SELECT setval('numVentaC_Seq',001);

create or replace function num_ventaC() returns varchar as
$$
select right('000' || nextval('numVentaC_Seq')::varchar,4) as id;
$$
language sql;

ALTER TABLE contener ALTER COLUMN ven_num_Venta SET DEFAULT (('VENT-'::text || num_ventaC()::text))
	

--Creación de las tablas de relaciones (M,M)

CREATE TABLE PROVEER
(prov_razon_Social varchar(50) NOT NULL,
inv_codigo_Barras bigint NOT NULL,
cantidad smallint not null check (cantidad > 0),
CONSTRAINT "pk_provee" PRIMARY KEY (prov_razon_Social, inv_codigo_Barras),
CONSTRAINT "fk_proveedor" FOREIGN KEY (prov_razon_Social) REFERENCES PROVEEDOR(prov_razon_Social) on update cascade on delete restrict,
CONSTRAINT "fk_inventario" FOREIGN KEY (inv_codigo_Barras) REFERENCES INVENTARIO(inv_codigo_Barras) on update cascade on delete restrict
);

CREATE TABLE CONTENER
(ven_num_Venta varchar(15) NOT NULL CHECK (ven_num_venta ~ '^VENT-[0-9]+$'),
prod_id_Producto serial NOT NULL,
cont_cantidad_Producto smallint NOT NULL,
cont_monto_parcial money,
CONSTRAINT "pk_contiene" PRIMARY KEY (ven_num_Venta, prod_id_Producto),
CONSTRAINT "fk_venta" FOREIGN KEY (ven_num_Venta) REFERENCES VENTA(ven_num_Venta) on update restrict on delete restrict,
CONSTRAINT "fk_producto" FOREIGN KEY (prod_id_Producto) REFERENCES PRODUCTO(prod_id_Producto) on update restrict on delete restrict
);


--Creación de las tablas de atributos multivaluados
CREATE TABLE TELEFONO
(tel_telefono BIGINT NOT NULL,    -- mejor en espacio y velocidad
tel_proveedor varchar(50) NOT NULL,
tel_codigoTel varchar(4) not null default '+52',
CONSTRAINT "pk_telefono" PRIMARY KEY (tel_telefono),
CONSTRAINT "fk_telefono" FOREIGN KEY (tel_proveedor) REFERENCES PROVEEDOR(prov_razon_Social) on update cascade on delete cascade
);


CREATE TABLE EMAIL
(ema_email varchar(80) NOT NULL,
ema_cliente char(13) NOT NULL,
CONSTRAINT "pk_email" PRIMARY KEY (ema_email),
CONSTRAINT "fk_email" FOREIGN KEY (ema_cliente) REFERENCES CLIENTE(cli_rfc) on update cascade on delete cascade
);



CREATE TABLE RECARGA
(prod_id_recarga int NOT NULL, 
recarga int NOT NULL, 
compañia varchar (50) NOT NULL,
CONSTRAINT "pk_recarga" PRIMARY KEY (recarga),
CONSTRAINT "fk_recarga" FOREIGN KEY (prod_id_recarga) REFERENCES PRODUCTO(prod_id_producto) on update cascade on delete cascade
);

