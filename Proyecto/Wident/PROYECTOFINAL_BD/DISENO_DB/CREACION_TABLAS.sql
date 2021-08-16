----------TABLA 1----------
CREATE TABLE PROVEEDOR (
id_proveedor INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
razon_social VARCHAR(25),
nom_prov VARCHAR(25) NOT NULL,
calle_prov VARCHAR(20) NOT NULL,
colonia_prov VARCHAR(20) NOT NULL,
estado_prov VARCHAR(20) NOT NULL,
numCalle_prov VARCHAR(20) NOT NULL,
cp_prov INT NOT NULL,
CONSTRAINT pk_id_proveedor PRIMARY KEY (id_proveedor)
);

----------TABLA 2----------
CREATE TABLE TEL_PROVEEDOR (
telefono VARCHAR(12) NOT NULL,
id_proveedor INT NOT NULL,
CONSTRAINT pk_tel_proveedor PRIMARY KEY (telefono),
CONSTRAINT id_prov_tel FOREIGN KEY(id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);


----------TABLA 3----------
CREATE TABLE PRODUCTO (
codigo_barras VARCHAR(8) NOT NULL,
nom_producto VARCHAR(25) NOT NULL,
marca VARCHAR(20) NOT NULL,
precio DECIMAL NOT NULL,
categoria VARCHAR(20) NOT NULL,
descripcion VARCHAR(30) NOT NULL,
CONSTRAINT pk_codigo_barras PRIMARY KEY (codigo_barras)
);


----------TABLA 4----------
CREATE TABLE VENTA_PROVEEDOR (
id_proveedor INT NOT NULL,
codigo_barras VARCHAR(8) NOT NULL,
fecha_compra DATE NOT NULL,
precio_compra NUMERIC(6,2),
CONSTRAINT fk_id_proveedor FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor),
CONSTRAINT fk_codigo_barras FOREIGN KEY (codigo_barras) REFERENCES PRODUCTO(codigo_barras)
);


----------TABLA 5----------
CREATE TABLE INVENTARIO (
id_inventario  INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
codigo_barras VARCHAR(8) NOT NULL,
stock int NOT NULL,
CONSTRAINT pk_inventario PRIMARY KEY (id_inventario),
CONSTRAINT fk_codigo FOREIGN KEY (codigo_barras) REFERENCES PRODUCTO(codigo_barras)
);


----------TABLA 6----------
CREATE TABLE CLIENTE (
id_cliente INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
rfc VARCHAR(20) NOT NULL,
nom_cliente VARCHAR(20) NOT NULL,
apellido_cliente VARCHAR(20) NOT NULL,
calle_cliente VARCHAR(20) NOT NULL,
numC_cliente VARCHAR(10) NOT NULL,
colonia_cliente VARCHAR(20) NOT NULL,
cp_cliente int NOT NULL, 
estado_cliente VARCHAR(20) NOT NULL,
CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
);


----------TABLA 7----------
CREATE TABLE EMAIL_CLIENTE (
email VARCHAR(20) NOT NULL,
id_cliente INT NOT NULL,
CONSTRAINT pk_email PRIMARY KEY (email),
CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);


----------TABLA 8----------
CREATE TABLE VENTA (
num_venta VARCHAR(10) NOT NULL,
id_cliente INT NOT NULL,
fecha_venta DATE NOT NULL,
cantidad_articulo int NOT NULL,
precio_articulo DECIMAL NOT NULL,
cantidad_total DECIMAL NOT NULL,
CONSTRAINT pk_num_venta PRIMARY KEY (num_venta),
CONSTRAINT fk_cliente_venta FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente) 
);


----------TABLA 9----------
CREATE TABLE DETALLE_COMPRA (
num_venta VARCHAR(10) NOT NULL,
codigo_barras VARCHAR(8) NOT NULL,
CONSTRAINT fk_codigo_barras FOREIGN KEY (codigo_barras) REFERENCES PRODUCTO(codigo_barras),
CONSTRAINT fk_num_venta FOREIGN KEY (num_venta) REFERENCES VENTA(num_venta)
); 


--------------------TABLA 10----------
CREATE TABLE FACTURA ( 
id_factura INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
num_venta VARCHAR(10) NOT NULL,
fecha DATE NOT NULL,
concepto VARCHAR(20),
precio_total DECIMAL,
CONSTRAINT pk_factura PRIMARY KEY (id_factura),
CONSTRAINT fk_num_venta FOREIGN KEY (num_venta ) REFERENCES VENTA(num_venta) 
);
