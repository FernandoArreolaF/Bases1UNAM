------------------------------------------------------------------------------------------------------------------
--                                                                                                              --
--                                              DDL                                                             --
--                                                                                                              --
------------------------------------------------------------------------------------------------------------------


-------------- CREACIÓN DE TABLAS-------------

create database Papeleria;
\c Papeleria;

CREATE TABLE PROVEEDOR(
rs_prov  varchar(30) NOT NULL,
nom_prov varchar(30)  NOT NULL
);

CREATE TABLE ESTADO_COLONIA_PROVEEDOR(
cp_prov int NOT NULL,
estado_prov varchar(30) NOT NULL,
colonia_prov varchar(30) NOT NULL
);

CREATE TABLE CALLE_NUM_PROVEEDOR(
rs_prov varchar(30) NOT NULL,
cp_prov int NOT NULL,
calle_prov varchar(30) NOT NULL,
calle_num_prov int NOT NULL
);

CREATE TABLE TELEFONO_PROVEEDOR(
rs_prov varchar(30) NOT NULL,
telefono varchar(12) NOT NULL
);

CREATE TABLE SUMINISTRA(
rs_prov varchar(30) NOT NULL,
cod_barras varchar(30) NOT NULL,
fecha_compra date NOT NULL,
precio_compra numeric(5,0) NOT NULL
);

CREATE TABLE PRODUCTO(
cod_barras varchar(30) NOT NULL,
nom_prod varchar(30) NOT NULL,
desc_prod varchar(30) NOT NULL,
precio_prod numeric(5,0) NOT NULL,
stock_prod int NOT NULL,
marca_prod varchar(30) NOT NULL,
tipo_producto varchar(30) NOT NULL
);



 
CREATE TABLE PRODUCTO_VENTA(
cod_barras varchar(30) NOT NULL,
num_venta varchar(30)  NOT NULL,
cantidad_producto int NOT NULL,
precio_por_producto numeric(5,0) NOT NULL DEFAULT 0.00
);

CREATE TABLE VENTA(
num_venta varchar(30)  NOT  NULL,
fecha_venta date NOT NULL,
cantidad_a_pagar numeric(5,0) NOT NULL DEFAULT 0.00,
rs_cliente varchar(30) NOT NULL
);


CREATE TABLE CLIENTE(
rs_cliente VARCHAR(30),
nom_cliente VARCHAR(30) NOT NULL,
apPat VARCHAR(30) NOT NULL,
apMat VARCHAR(30) NULL
);

CREATE TABLE ESTADO_COLONIA_CLIENTE(
cp_cliente INTEGER NOT NULL,
estado_cliente VARCHAR(30) NOT NULL,
colonia_cliente VARCHAR(30) NOT NULL
);
CREATE TABLE CALLE_NUM_CLIENTE(
rs_cliente VARCHAR(30),
cp_cliente INTEGER NOT NULL,
calle_cliente VARCHAR(30) NOT NULL,
num_calle_cliente INTEGER NOT NULL
);

CREATE TABLE EMAIL_CLIENTE(
email VARCHAR(30) NOT NULL,
rs_cliente VARCHAR(30) NOT NULL
);


----------------------CREACIÓN DE CONSTRAINTS DE PRIMARY KEY------------------------------- 

--PROVEEDOR

ALTER TABLE Proveedor
ADD CONSTRAINT proveedor_pk PRIMARY KEY (rs_prov);

--TELEFONO_PROVEEDOR

ALTER TABLE TELEFONO_PROVEEDOR
ADD CONSTRAINT telefono_pk PRIMARY KEY (telefono);

--PRODUCTO

ALTER TABLE PRODUCTO
ADD CONSTRAINT producto_pk PRIMARY KEY (cod_barras);

--CLIENTE

ALTER TABLE CLIENTE
ADD CONSTRAINT cliente_pk PRIMARY KEY (rs_cliente);

--EMAIL

ALTER TABLE EMAIL_CLIENTE
ADD CONSTRAINT email_pk PRIMARY KEY (email);

--VENTA

ALTER TABLE VENTA
ADD CONSTRAINT venta_pk PRIMARY KEY (num_venta);

--PRODUCTO_VENTA

ALTER TABLE PRODUCTO_VENTA
ADD CONSTRAINT prod_venta_pk PRIMARY KEY (cod_barras, num_venta);


--SUMINISTRA 

ALTER TABLE SUMINISTRA
ADD CONSTRAINT suministra_pk PRIMARY KEY (rs_prov, cod_barras);



 
------------------CREACIÓN DE CONSTRAINTS DE FOREIGN KEY Y CHECK-----------------------------

--Telefono Proveedor

ALTER TABLE TELEFONO_PROVEEDOR
ADD CONSTRAINT Tel_Prov_FK FOREIGN KEY (rs_prov) REFERENCES PROVEEDOR(rs_prov) ON DELETE CASCADE;

--Suministra
ALTER TABLE SUMINISTRA
ADD CONSTRAINT suminstraRS_FK FOREIGN KEY (rs_prov) REFERENCES PROVEEDOR (rs_prov) ON DELETE CASCADE,
ADD CONSTRAINT suministraCOD_FK FOREIGN KEY (cod_barras) REFERENCES PRODUCTO (cod_barras) ON DELETE CASCADE;
 
--PRODUCTO(Check)

ALTER table producto
ADD CONSTRAINT tipo_product_check 
CHECK (tipo_producto IN ('rg', 'rc', 'ap', 'ip'));

--PRODUCTO (CHECK)
---ALTER TABLE  PRODUCTO
---ADD CONSTRAINT  stock_no_negativo_ck CHECK (stock_prod >= 0);

--PRODUCTO_VENTA
ALTER TABLE PRODUCTO_VENTA
ADD CONSTRAINT cod_barrasPV_FK FOREIGN KEY (cod_barras) REFERENCES
PRODUCTO (cod_barras) ON DELETE CASCADE,
ADD CONSTRAINT num_ventaPV_FK FOREIGN KEY (num_venta) REFERENCES VENTA(num_venta) ON DELETE CASCADE; 


--VENTA
ALTER TABLE VENTA 
ADD CONSTRAINT venta_FK FOREIGN KEY (rs_cliente) REFERENCES
CLIENTE (rs_cliente) ON DELETE CASCADE;


--EMAIL_CLIENTE
ALTER TABLE EMAIL_CLIENTE
ADD CONSTRAINT rs_cliente_FK FOREIGN KEY (rs_cliente) REFERENCES CLIENTE (rs_cliente) ON DELETE CASCADE;






