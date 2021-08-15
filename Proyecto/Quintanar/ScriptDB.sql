CREATE DATABASE papeleria;

\c papeleria;

DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS consumo CASCADE;
DROP TABLE IF EXISTS email CASCADE;
DROP TABLE IF EXISTS impresion CASCADE;
DROP TABLE IF EXISTS inventario CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS proveedor CASCADE;
DROP TABLE IF EXISTS recarga CASCADE;
DROP TABLE IF EXISTS telefono CASCADE;
DROP TABLE IF EXISTS tipoproducto CASCADE;

CREATE TABLE cliente(
RFC varchar(13) NOT NULL,
NombreCliente varchar(70) NOT NULL ,
EstadoCliente varchar(70) NOT NULL,
ColoniaCliente varchar(70) NOT NULL,
CalleCliente varchar(70) NOT NULL,
CPCliente int NOT NULL,
NumeroCliente int NOT NULL,
CONSTRAINT cliente_PK PRIMARY KEY (RFC),
CONSTRAINT CPCliente_CK CHECK (CPCliente > 0 ),
CONSTRAINT NumeroCliente_CK CHECK (NumeroCliente > 0 )
);

CREATE TABLE email(
Email varchar(50) NOT NULL,
RFC varchar(13) NOT NULL,
CONSTRAINT email_PK PRIMARY KEY (Email),
CONSTRAINT email_cliente_FK FOREIGN KEY (RFC) REFERENCES cliente(RFC) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE proveedor(
RazonSocial varchar(30) NOT NULL,
NombreProv varchar(70) NOT NULL,
EstadoProv varchar(70) NOT NULL,
ColoniaProv varchar(70) NOT NULL,
CalleProv varchar(70) NOT NULL,
CPProv int NOT NULL,
NumeroProv int NOT NULL,
CONSTRAINT proveedor_PK PRIMARY KEY (RazonSocial),
CONSTRAINT CPProv_CK CHECK (CPProv > 0 ),
CONSTRAINT NumeroProv_CK CHECK (NumeroProv > 0 )
);

CREATE TABLE telefono(
Telefono bigint NOT NULL,
RazonSocial varchar(30) NOT NULL,
CONSTRAINT telefono_PK PRIMARY KEY (Telefono),
CONSTRAINT telefono_proveedor_FK FOREIGN KEY (RazonSocial) REFERENCES proveedor (RazonSocial) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT telefono_CK CHECK (telefono > 0)
);

CREATE TABLE inventario(
CodigoBarras bigint NOT NULL,
PrecioCompra numeric(8,2) NOT NULL,
FechaCompra date NOT NULL,
Stock int NOT NULL,
CONSTRAINT inventario_PK PRIMARY KEY (CodigoBarras),
CONSTRAINT stock_CK CHECK (stock > 0),
CONSTRAINT precioCompra_CK CHECK (precioCompra > 0),
CONSTRAINT codigoBarras_CK CHECK (codigoBarras > 0)
);

CREATE TABLE tipoproducto(
IDTipoProd serial,
TipoProducto varchar(30) NOT NULL,
CONSTRAINT tipoproducto_PK PRIMARY KEY (IDTipoProd)
);

CREATE TABLE producto(
CodigoBarras bigint NOT NULL,
PrecioProd numeric(8,2) NOT NULL,
Marca varchar(15) NOT NULL,
DescripcionProd varchar(30) NOT NULL,
IDTipoProd int NOT NULL,
CONSTRAINT producto_PK PRIMARY KEY (CodigoBarras),
CONSTRAINT productoCodBar_inventario_FK FOREIGN KEY (CodigoBarras) REFERENCES inventario (CodigoBarras) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT producto_tipoproducto_FK FOREIGN KEY (IDTipoProd) REFERENCES tipoproducto (IDTipoProd) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT PrecioProd_CK CHECK (precioprod > 0),
CONSTRAINT IDTipoProd_CK CHECK (idTipoProd > 0)
);

CREATE TABLE impresion(
IDImpresion serial,
TamañoHoja varchar(15) NOT NULL,
TipoImpresion varchar(15) NOT NULL,
PrecioServ numeric(4,2) NOT NULL,
DescripcionServ varchar(30) NOT NULL,
CONSTRAINT impresion_PK PRIMARY KEY (IDImpresion),
CONSTRAINT PrecioServ_CK CHECK (PrecioServ > 0)
);

CREATE TABLE recarga(
IDRecarga serial,
Compañia varchar(30) NOT NULL,
PrecioRecarga numeric(8,2) NOT NULL,
DescripcionServ varchar(30) NOT NULL,
CONSTRAINT recarga_PK PRIMARY KEY (IDRecarga),
CONSTRAINT PrecioRecarga_CK CHECK (PrecioRecarga > 0)
);

CREATE TABLE consumo(
NoVenta serial,
FechaVenta date NOT NULL DEFAULT CURRENT_DATE,
CantidadArticulo int NOT NULL,
PrecioArticulo numeric(8,2) NOT NULL,
CodigoBarras bigint,
IDImpresion int,
IDRecarga int,
Total int GENERATED ALWAYS AS (CantidadArticulo*PrecioArticulo) STORED,
CONSTRAINT consumo_PK PRIMARY KEY (NoVenta),
CONSTRAINT consumoCodBar_inventario_FK FOREIGN KEY (CodigoBarras) REFERENCES inventario (CodigoBarras) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT consumo_Impresion_FK FOREIGN KEY (IDImpresion) REFERENCES impresion (IDImpresion) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT consumo_recarga_FK FOREIGN KEY (IDRecarga) REFERENCES recarga (IDRecarga) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT CantidadArticulo_CK CHECK (CantidadArticulo > 0),
CONSTRAINT PrecioArticulo_CK CHECK (PrecioArticulo > 0)
);


