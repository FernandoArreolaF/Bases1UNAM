CREATE TABLE Categoria(
    id_Categoria    SMALLINT       NOT NULL,
    tipo            VARCHAR(20)    NOT NULL,
    CONSTRAINT PK10 PRIMARY KEY (id_Categoria)
);

CREATE TABLE Cliente(
    RFC           VARCHAR(13)    NOT NULL,
    nombre        VARCHAR(32)    NOT NULL,
    ap_Paterno    VARCHAR(32)    NOT NULL,
    ap_Materno    VARCHAR(32),
    cp            SMALLINT       NOT NULL,
    numero        SMALLINT       NOT NULL, 
    estado        VARCHAR(32)    NOT NULL,
    calle         VARCHAR(32)    NOT NULL,
    colonia       VARCHAR(32)    NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY (RFC)
);

CREATE TABLE Contiene(
    cod_Barras           INTEGER          NOT NULL,
    id_Venta             INTEGER          NOT NULL,
    precio_Total_Art     DECIMAL(7, 2)    NOT NULL,
    cantidad_Articulo    INTEGER          NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (cod_Barras, id_Venta)
);

CREATE TABLE Correo(
    email    VARCHAR(64)    NOT NULL,
    RFC      VARCHAR(13)    NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (email)
);

CREATE TABLE Guarda(
    id_Inventario    SMALLINT         NOT NULL,
    cod_Barras       INTEGER          NOT NULL,
    precio_Compra    DECIMAL(7, 2)    NOT NULL,
    stock            INTEGER          NOT NULL,
    fecha_Compra     DATE             NOT NULL,
    CONSTRAINT PK12 PRIMARY KEY (id_Inventario, cod_Barras)
);

CREATE TABLE Inventario(
    id_Inventario    SMALLINT       NOT NULL,
    nombre           VARCHAR(32),
    CONSTRAINT PK9 PRIMARY KEY (id_Inventario)
);

CREATE TABLE Producto(
    cod_Barras      INTEGER          NOT NULL,
    precio          DECIMAL(7, 2)    NOT NULL,
    marca           VARCHAR(120)     NOT NULL,
    descripcion     VARCHAR(50)      NOT NULL,
    id_Categoria    SMALLINT         NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (cod_Barras)
);

CREATE TABLE Proveedor(
    id_Proveedor    SMALLINT       NOT NULL,
    nombre          VARCHAR(50)    NOT NULL,
    razon_Social    VARCHAR(50)    NOT NULL,
    estado          VARCHAR(50)    NOT NULL,
    colonia         VARCHAR(50)    NOT NULL,
    numero          SMALLINT       NOT NULL,
    cp              SMALLINT       NOT NULL,
    calle           VARCHAR(50)    NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY (id_Proveedor)
);

CREATE TABLE Surte(
    id_Proveedor     SMALLINT    NOT NULL,
    id_Inventario    SMALLINT    NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY (id_Proveedor, id_Inventario)
);

CREATE TABLE Telefono(
    num_Telefono    BIGINT      NOT NULL,
    id_Proveedor    SMALLINT    NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY (num_Telefono)
);

CREATE TABLE Venta(
    id_Venta       INTEGER          NOT NULL,
    fecha_Venta    DATE             NOT NULL,
    pago_Final     DECIMAL(7, 2)    NOT NULL,
    RFC            VARCHAR(13)      NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY (id_Venta)
);

ALTER TABLE Contiene ADD CONSTRAINT RefVenta4 
    FOREIGN KEY (id_Venta)
    REFERENCES Venta(id_Venta)
;

ALTER TABLE Contiene ADD CONSTRAINT RefProducto5 
    FOREIGN KEY (cod_Barras)
    REFERENCES Producto(cod_Barras)
;

ALTER TABLE Correo ADD CONSTRAINT RefCliente2 
    FOREIGN KEY (RFC)
    REFERENCES Cliente(RFC)
;

ALTER TABLE Guarda ADD CONSTRAINT RefInventario11 
    FOREIGN KEY (id_Inventario)
    REFERENCES Inventario(id_Inventario)
;

ALTER TABLE Guarda ADD CONSTRAINT RefProducto12 
    FOREIGN KEY (cod_Barras)
    REFERENCES Producto(cod_Barras)
;


ALTER TABLE Producto ADD CONSTRAINT RefCategoria10 
    FOREIGN KEY (id_Categoria)
    REFERENCES Categoria(id_Categoria)
;

ALTER TABLE Surte ADD CONSTRAINT RefProveedor6 
    FOREIGN KEY (id_Proveedor)
    REFERENCES Proveedor(id_Proveedor)
;

ALTER TABLE Surte ADD CONSTRAINT RefInventario7 
    FOREIGN KEY (id_Inventario)
    REFERENCES Inventario(id_Inventario)
;

ALTER TABLE Telefono ADD CONSTRAINT RefProveedor8 
    FOREIGN KEY (id_Proveedor)
    REFERENCES Proveedor(id_Proveedor)
;

ALTER TABLE Venta ADD CONSTRAINT RefCliente3 
    FOREIGN KEY (RFC)
    REFERENCES Cliente(RFC)
;

--Secuencia para id_Vent
CREATE SEQUENCE Vent
START WITH 1
INCREMENT BY 1;

--Indice de venta
CREATE INDEX id_Vent ON VENTA(id_Venta);

--Modificaciones a la tabla venta
ALTER TABLE Venta ALTER id_Venta SET DEFAULT NEXTVAL('Vent');
ALTER TABLE Venta ALTER fecha_Venta SET DEFAULT current_date;