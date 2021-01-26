-- Database: PAPELERIA

-- DROP DATABASE "PAPELERIA";

CREATE DATABASE "PAPELERIA"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Mexico.1252'
    LC_CTYPE = 'Spanish_Mexico.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
create table PROVEEDOR(
	razon_Social varchar(50) not null,
	nombre varchar(50) not null,
	ap_Pat varchar(80) not null,
	ap_Mat varchar(80),
	calle varchar(40) not null,
	numero smallint not null,
	colonia varchar(40) not null,
	estado varchar (40) not null,
	codigo_Postal int not null,
	
	CONSTRAINT PK_Razon_Social_Prov PRIMARY KEY(razon_Social)
);


create table TELEFONO(
	razon_Social varchar(50) not null,
	telefono bigint not null,
	
	CONSTRAINT PK_Telefono PRIMARY KEY(razon_Social, telefono),
	CONSTRAINT FK_razon_Social FOREIGN KEY (razon_Social) REFERENCES PUBLIC.PROVEEDOR(razon_Social)	
);

create table PRODUCTO(
	codigo_Barras varchar(15) not null,
	stock smallint not null,
	precio_Venta int not null,
	marca varchar(40) not null,
	descripcion varchar(40) not null,
	tipo_Producto varchar(15) not null,
	
	CONSTRAINT PK_Producto PRIMARY KEY (codigo_Barras),
	CONSTRAINT verifica_Precio CHECK((CAST (precio_Venta AS numeric))> 0),
	CONSTRAINT tipo_Producto CHECK(tipo_Producto = 'REGALO' OR tipo_Producto= 'PAPELERIA' or tipo_Producto='RECARGA' or tipo_Producto='IMPRESION'),
	CONSTRAINT verifica_Stock CHECK (stock >= 0)
);

create table SUMINISTRA(
	razon_Social_Proveedor varchar(50) not null,
	codigo_Barras varchar(15) not null,
	precio_Compra int not null,
	fecha_Compra date not null DEFAULT CURRENT_DATE,
	
	CONSTRAINT verfica_Prec CHECK ((CAST(precio_Compra AS numeric)) > 0),
	CONSTRAINT PK_Suministra PRIMARY KEY (razon_Social_Proveedor, codigo_Barras),
	CONSTRAINT FK_razonSocialProv FOREIGN KEY (razon_Social_Proveedor) REFERENCES PUBLIC.PROVEEDOR (razon_Social),
	CONSTRAINT FK_codigoBarras FOREIGN KEY (codigo_Barras) REFERENCES PUBLIC.PRODUCTO (codigo_Barras)
);

create table CLIENTE(
	razon_Social varchar(50) not null,
	nombre varchar(50) not null,
	ap_Pat varchar(80) not null,
	ap_Mat varchar(80),
	estado varchar(40) not null,
	codigo_Postal int not null,
	colonia varchar(60) not null,
	calle varchar(60) not null,
	numero smallint not null,
	
	CONSTRAINT PK_Cliente PRIMARY KEY (razon_Social) 
);

create table EMAIL(
	email varchar(80) not null,
	razon_Social_Cliente varchar(50) not null,
	
	CONSTRAINT PK_Email PRIMARY KEY (email, razon_Social_Cliente),
	CONSTRAINT FK_Razon_Social_Cliente FOREIGN KEY (razon_Social_Cliente) REFERENCES PUBLIC.CLIENTE (razon_Social) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE SEQUENCE noVenta
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 1000
	MINVALUE 1;


CREATE TABLE VENTA(
	no_Venta TEXT NOT NULL DEFAULT 'VENT-0' || nextval('noVenta'::regclass)::TEXT,
	fecha_Venta date not null default current_date,
	total_Venta int,
	razon_Social varchar(50) not null,
	
	CONSTRAINT PK_Venta PRIMARY KEY (no_Venta),
	CONSTRAINT FK_Razon_Social_Client FOREIGN KEY (razon_Social) REFERENCES PUBLIC.CLIENTE (razon_Social)
);

	
CREATE TABLE DETALLE(
	codigo_Barras varchar(15) not null,
	no_Venta text not null,
	cantidad numeric not null,
	total_Prod int,
	
	CONSTRAINT PK_Ingresa PRIMARY KEY(codigo_Barras, no_Venta),
	CONSTRAINT FK_Codigo_Barras FOREIGN KEY (codigo_Barras) REFERENCES PUBLIC.PRODUCTO (codigo_Barras) ON DELETE SET NULL,
	CONSTRAINT FK_No_Venta FOREIGN KEY (no_Venta) REFERENCES PUBLIC.VENTA (no_Venta)
);

CREATE OR REPLACE FUNCTION calculaSubtotal() RETURNS TRIGGER AS $$
DECLARE
no_VentaAct text;
barras varchar(15);
subtotal int;
total int;
BEGIN
	
	no_VentaAct= 'VENT-0'||currval('noventa'::regclass)::text;
	
	barras = (select det.codigo_barras
	FROM PRODUCTO prod
	INNER JOIN DETALLE det ON (det.codigo_Barras = prod.codigo_Barras)
	where det.no_Venta = no_VentaAct and det.total_prod is null);
		
	subtotal= (select det.cantidad * prod.precio_Venta
	FROM PRODUCTO prod
	INNER JOIN DETALLE det ON (det.codigo_Barras = prod.codigo_Barras)
	where det.no_Venta = no_VentaAct and det.total_prod is null);

	
	IF(TG_OP= 'INSERT' )then
	UPDATE DETALLE SET total_Prod = subtotal where detalle.total_prod is null and no_Venta= no_VentaAct;
	
	total=(select SUM(total_Prod) FROM DETALLE det INNER JOIN VENTA vent ON(det.no_Venta = vent.no_venta)
		   where vent.no_Venta= no_VentaAct);
	
	UPDATE VENTA SET total_Venta =total WHERE no_Venta = no_VentaAct;
	RETURN new;
	end if;
		
END;
$$ language plpgsql VOLATILE;

/*Creacion de triggers para campos calculados*/
/*Funcion del trigger para subtotal por producto*/
/*Creación del trigger*/
CREATE TRIGGER calcula_Subtotal 
AFTER INSERT  ON DETALLE FOR EACH ROW 
EXECUTE PROCEDURE calculaSubtotal();

/*Creación de índice
Se opta por la estructura de tipo B-Tree ya que permite
operaciones como >,<,=, entre otros,
se opta por la columna stock de la tabla PRODUCTO
ya que se piden dos requerimientos en los que debemos hacer
comparaciones en ese campo, sera de tipo non- unique
como consecuencia de que la columna podria contener valores repetidos*/
CREATE INDEX inx_stock ON PRODUCTO (stock);


