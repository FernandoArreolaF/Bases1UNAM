
CREATE DATABASE papeleria;

\c papeleria
--________________________CREANDO TABLAS_______________________________

CREATE TABLE PROVEEDOR
(
    id_proveedor varchar(10),
    razon_social varchar(30),
    nombre varchar(30),
    calle varchar(40),
    numero int,
    colonia varchar(40),
    codigo_postal int,
    estado varchar(20),
    CONSTRAINT PROVEEDOR_PK PRIMARY KEY (id_proveedor)
);

CREATE TABLE TELEFONO
(
    telefono bigint,
    id_proveedor varchar(10),
    CONSTRAINT TELEFONO_PK PRIMARY KEY (telefono),
    CONSTRAINT PROVEEDOR_TELEFONO_FK FOREIGN KEY(id_proveedor) REFERENCES PROVEEDOR (id_proveedor)
);

CREATE TABLE INVENTARIO
(
    codigo_barras varchar(20),
    fecha_compra varchar(20),
    precio_adquisicion numeric,
    stock bigint,
    CONSTRAINT INVENTARIO_PK PRIMARY KEY (codigo_barras)
);

CREATE TABLE PROVEER
(
    id_proveedor varchar(10),
    codigo_barras varchar(20),
    CONSTRAINT PROVEER_PK PRIMARY KEY (id_proveedor,codigo_barras),
    CONSTRAINT PROVEER_PROVEEDOR_FK FOREIGN KEY(id_proveedor) REFERENCES PROVEEDOR (id_proveedor),
    CONSTRAINT PROVEER_INVENTARIO_FK FOREIGN KEY(codigo_barras) REFERENCES INVENTARIO (codigo_barras)
);

CREATE TABLE CLIENTE
(
    id_cliente varchar(15), 
    rfc varchar(10), --UNIQUE
    nombre varchar(25),
    apPat varchar(25),
    apMat varchar(25) NULL,
    calle varchar(40),
    numero int,
    colonia varchar(40),
    codigo_postal int,
    estado varchar(20),
    CONSTRAINT CLIENTE_PK PRIMARY KEY (id_cliente),
    CONSTRAINT CLIENTE_UK UNIQUE(rfc)   
);



CREATE TABLE MAIL
(
    mail varchar(40),
    id_cliente varchar(15), 
    CONSTRAINT MAIL_PK PRIMARY KEY (mail),
    CONSTRAINT CLIENTE_MAIL_FK FOREIGN KEY(id_cliente) REFERENCES CLIENTE (id_cliente)
);

CREATE TABLE PRODUCTO
(
    id_articulo int, 
    marca varchar(20),
    precio numeric,
    descripcion varchar(50),
    codigo_barras varchar(20),
    CONSTRAINT PRODUCTO_PK PRIMARY KEY (id_articulo),
    CONSTRAINT PRODUCTO_UK UNIQUE(descripcion),
    CONSTRAINT PRODUCTO_INVENTARIO_FK FOREIGN KEY(codigo_barras) REFERENCES INVENTARIO (codigo_barras)
);


CREATE TABLE VENTA
(
    numero_venta varchar(15), 
    fecha_venta varchar(20),
    cantidad_total_pagar numeric,
    id_cliente varchar(15), 
    CONSTRAINT VENTA_PK PRIMARY KEY (numero_venta),
    CONSTRAINT VENTA_CLIENTE_FK FOREIGN KEY(id_cliente) REFERENCES CLIENTE (id_cliente)
);

CREATE TABLE HABER
(
    id_articulo int, 
    numero_venta varchar(15), 
    cantidad_articulos int,
    precio_por_articulo numeric,
    CONSTRAINT HABER_PK PRIMARY KEY (id_articulo,numero_venta),
    CONSTRAINT HABER_PRODUCTO_FK FOREIGN KEY(id_articulo) REFERENCES PRODUCTO (id_articulo),
    CONSTRAINT HABER_VENTA_FK FOREIGN KEY(numero_venta) REFERENCES VENTA (numero_venta)
);

--___________________________________________________________





--En caso necesario, este es el orde de eliminación
--_______________
DROP TABLE TELEFONO;
DROP TABLE HABER;
DROP TABLE PROVEER;
DROP TABLE VENTA;
DROP TABLE MAIL;
DROP TABLE CLIENTE;
DROP TABLE PROVEEDOR;
DROP TABLE PRODUCTO;
DROP TABLE INVENTARIO;

