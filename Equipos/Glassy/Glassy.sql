CREATE TABLE articulo (
    id_articulo    INT PRIMARY KEY,
    marca          VARCHAR(30),
    descripcion    VARCHAR(50),
    precio         NUMERIC(1000)
);

CREATE TABLE cliente (
    rfc            VARCHAR(30) NOT NULL PRIMARY KEY,
    nombrepila     VARCHAR(50),
    codigopostal   int,
    appaterno      VARCHAR,
    apmaterno      VARCHAR(30),
    estado         VARCHAR(30),
    colonia        VARCHAR(30),
    callenumero    VARCHAR(30)
);

CREATE TABLE emailcliente (
    email          VARCHAR NOT NULL,
    cliente_rfc    VARCHAR(30) NOT NULL,
    PRIMARY KEY (email),
    FOREIGN KEY (cliente_rfc) REFERENCES cliente (rfc)
);

CREATE TABLE producto (
    codigobarras   BIGINT NOT NULL PRIMARY KEY,
    preciocompra   NUMERIC(1000),
    foto           BYTEA,
    stock          INTEGER
);

CREATE TABLE producto_articulo (
    producto_codigobarras BIGINT NOT NULL,
    articulo_id_articulo  INTEGER NOT NULL,
    fechacompra           DATE,
    FOREIGN KEY (producto_codigobarras) REFERENCES producto (codigobarras),
    FOREIGN KEY (articulo_id_articulo) REFERENCES articulo (id_articulo)
);

CREATE TABLE proveedor (
    razonsocial    VARCHAR(50) NOT NULL PRIMARY KEY,
    estado         VARCHAR(30),
    codigopostal   int,
    colonia        VARCHAR(30),
    callenumero    VARCHAR,
    nombrepila     VARCHAR(50),
    appaterno      VARCHAR(30),
    apmaterno      VARCHAR
);


CREATE TABLE proveedor_producto (
    proveedor_razonsocial VARCHAR(50) NOT NULL,
    producto_codigobarras BIGINT NOT NULL,
    FOREIGN KEY (proveedor_razonsocial) REFERENCES proveedor (razonsocial),
    FOREIGN KEY (producto_codigobarras) REFERENCES producto (codigobarras)
);

CREATE TABLE telefonoproveedor (
    telefono              VARCHAR(50) NOT NULL,
    proveedor_razonsocial VARCHAR(50) NOT NULL,
    PRIMARY KEY (telefono),
    FOREIGN KEY (proveedor_razonsocial) REFERENCES proveedor (razonsocial)
);

CREATE TABLE venta (
    numeroventa        VARCHAR(10) PRIMARY KEY,
    fechaventa         DATE,
    cantidadtotalpagar NUMERIC,
    cliente_rfc        VARCHAR(30) NOT NULL,
    FOREIGN KEY (cliente_rfc) REFERENCES cliente (rfc)
);

CREATE TABLE venta_articulo (
    cantidad                 INTEGER,
    preciototalpagararticulo NUMERIC,
    articulo_id_articulo     INTEGER NOT NULL,

    venta_numeroventa        VARCHAR(10) NOT NULL,
    FOREIGN KEY (articulo_id_articulo) REFERENCES articulo (id_articulo),
    FOREIGN KEY (venta_numeroventa) REFERENCES venta (numeroventa)
);

--de los regalos, articulos de papeleria, impresiones y recargas

-- Inserciones en la tabla "articulo"
INSERT INTO articulo (id_articulo, marca, descripcion, precio)
VALUES
    (1,'Sigel', 'Cuaderno Profesional', 100.0), 
    (2,'Pritt', 'Lápiz adhesivo', 50.0), 
    (3,'OfficeMax', 'Corrector 5mm x 8 mm', 75.0),
    (4,'JeanBook', 'Carpeta tamaño carta', 120.0),
    (5,'Maped', 'Compás metálico', 80.0),
    (6,'OfficeMax', 'Regla aluminio 30cm', 90.0),
    (7,'Pilot', 'Grapa estándar', 60.0),
	(8,'Totto', 'Lapicera multiuso',299.0)

-- Inserciones en la tabla "cliente"
INSERT INTO cliente (rfc, nombrepila, codigopostal, appaterno, apmaterno, estado, colonia, callenumero)
VALUES
    ('MENP010223', 'Pablo', 10840, 'Meza', 'Nava', 'Cdmx', 'Las Calles', 'Juan Álvarez 203'),
    ('MELM830528', 'Mónica', 64108, 'Méndez', 'Luna', 'Monterrey', 'Plutarco Elias Calles', 'Agua Prieta 42'),
    ('LOMP820628', 'Pablo', 83570, 'López', 'Morales', 'Sonora', 'La Copa', 'Hidalgo 33'),
    ('VACS691110', 'Antonio', 34194, 'Rodríguez', 'Vázquez', 'Durango', 'Valle Verde', 'Margarita 12'),
    ('TOGM900603', 'Mónica', 86400, 'Torres', 'Guzmán', 'Tabasco', 'Centro', 'Ignacio Allende 84'),
    ('SAVL852312', 'Lorena', 87700, 'Saldaña', 'Velazquez', 'Tamaulipas', 'Zona Centro', 'Libertad 68'),
    ('PEGJ198305', 'José', 98619, 'Pérez', 'García', 'Zacatecas', 'Los Pirules', 'Cerro de Sombreretillo');

-- Inserciones en la tabla "emailcliente"
INSERT INTO emailcliente (email, cliente_rfc)
VALUES
    ('fraheyounnutu@hotmail.com', 'MENP010223'),
    ('luquateubegreu@gmail.com', 'MELM830528'),
    ('haprapeijicroi@gmail.com', 'LOMP820628'),
    ('gubumoutose@hotmail.com', 'VACS691110'),
    ('koicajotiso@gmail.com', 'TOGM900603'),
    ('tamerappeuna@hotmail.com', 'SAVL852312'),
    ('voreucenetra-7847@gmail.com', 'PEGJ198305');

-- Inserciones en la tabla "producto"
INSERT INTO producto (codigobarras, preciocompra, foto, stock)
VALUES
    (123456789, 10.0, NULL, 50),
    (987654321, 20.0, NULL, 30),
    (456789123, 15.0, NULL, 20),
    (321654987, 8.0, NULL, 40),
    (789123456, 12.0, NULL, 15),
    (654987321, 25.0, NULL, 25),
    (987123456, 18.0, NULL, 35);
	


-- Inserciones en la tabla "producto_articulo"
INSERT INTO producto_articulo (producto_codigobarras, articulo_id_articulo, fechacompra)
VALUES
    (123456789, 1, '2023-05-01'),
    (987654321, 2, '2023-05-02'),
    (456789123, 3, '2023-05-03'),
    (321654987, 4, '2023-05-04'),
    (789123456, 5, '2023-05-05'),
    (654987321, 6, '2023-05-06'),
    (987123456, 7, '2023-05-07');

-- Inserciones en la tabla "proveedor"
INSERT INTO proveedor (razonsocial, estado, codigopostal, colonia, callenumero, nombrepila, appaterno, apmaterno)
VALUES
    ('CRECE COMPUTACION, S.A. DE C.V', 'Jalisco', 44100, 'Moderna', 'Jose Guadalupe Montenegro 2393', 'Pascual', 'Ruiz', 'López'),
    ('IMPREJAL, S.A. DE C.V', 'Jalisco', 44290, 'Jardines del Bosque', 'Nicolas Romero 518', 'Lydia', 'Martinez', 'Chavez'),
    ('ALBE INTERNACIONAL SA DE CV', 'Jalisco', 45010, 'Colonia3', 'Calzada Norte 7336', 'Flora', 'Camara', 'Orozco'),
    ('PLASTICOS Y METALES MYC, S.A. DE C.V.', 'Estado de México', 52600, 'Santiago Tianguistengo', 'Santiago Chapultepec 709', 'Melanie', 'Medrano', 'Bermudez'),
    ('GRUPO AVESTRUZ, S.A DE.C.V.', 'Jalisco', 44900, 'Del Fresno', 'Pelicano 2135', 'Mónica', 'Cortes', 'Sánchez'),
    ('LONAS LORENZO, S.A. DE C.V.', 'Jalisco', 44190, 'Moderna', 'Av 8 de julio', 'Hugo', 'Fonseca', 'Alegre'),
    ('JOSÉ RICARDO NISHIMURA TORRES S.A. DE C.V.', 'Tamaulipas', 44200, 'Artesanos', 'Independencia 110', 'Noelia', 'Tovar', 'Periz');

-- Inserciones en la tabla "proveedor_producto"
INSERT INTO proveedor_producto (proveedor_razonsocial, producto_codigobarras)
VALUES
    ('CRECE COMPUTACION, S.A. DE C.V', 123456789),
    ('IMPREJAL, S.A. DE C.V', 987654321),
    ('ALBE INTERNACIONAL SA DE CV', 456789123),
    ('PLASTICOS Y METALES MYC, S.A. DE C.V.', 321654987),
    ('GRUPO AVESTRUZ, S.A DE.C.V.', 789123456),
    ('LONAS LORENZO, S.A. DE C.V.', 654987321),
    ('JOSÉ RICARDO NISHIMURA TORRES S.A. DE C.V.', 987123456);

-- Inserciones en la tabla "telefonoproveedor"
INSERT INTO telefonoproveedor (telefono, proveedor_razonsocial)
VALUES
    ('3336156444', 'CRECE COMPUTACION, S.A. DE C.V'),
    ('3338254769', 'IMPREJAL, S.A. DE C.V'),
    ('3312537000', 'ALBE INTERNACIONAL SA DE CV'),
    ('5558123402', 'PLASTICOS Y METALES MYC, S.A. DE C.V.'),
    ('3338106699', 'GRUPO AVESTRUZ, S.A DE.C.V.'),
    ('3336503541', 'LONAS LORENZO, S.A. DE C.V.'),
    ('3335630862', 'JOSÉ RICARDO NISHIMURA TORRES S.A. DE C.V.');

-- Inserciones en la tabla "venta"
INSERT INTO venta (numeroventa, fechaventa, cantidadtotalpagar, cliente_rfc)
VALUES
    ('VENT-001', '2023-05-01', 500.0, 'MENP010223'),
    ('VENT-002', '2023-05-02', 400.0, 'MELM830528'),
    ('VENT-003', '2023-05-03', 225.0, 'LOMP820628'),
    ('VENT-004', '2023-05-04', 720.0, 'VACS691110'),
    ('VENT-005', '2023-05-05', 320.0, 'TOGM900603'),
    ('VENT-006', '2023-05-06', 630.0, 'SAVL852312'),
    ('VENT-007', '2023-05-07', 120.0, 'PEGJ198305');

-- Inserciones en la tabla "venta_articulo"
INSERT INTO venta_articulo (cantidad, preciototalpagararticulo, articulo_id_articulo, venta_numeroventa)
VALUES
    (5, 500.0, 1, 'VENT-001'),
    (8, 400.0, 2, 'VENT-002'),
    (3, 225.0, 3, 'VENT-003'),
    (6, 720.0, 4, 'VENT-004'),
    (4, 320.0, 5, 'VENT-005'),
    (7, 630.0, 6, 'VENT-006'),
    (2, 120.0, 7, 'VENT-007');

--1.-Generación automática de una vista para asemejarse a una factura de compra:

CREATE VIEW factura_compra AS
SELECT v.numeroventa, v.fechaventa, c.nombrepila || ' ' || c.appaterno || ' ' || c.apmaterno AS cliente, 
a.descripcion AS articulo, va.cantidad, va.preciototalpagararticulo
FROM venta v
JOIN cliente c ON v.cliente_rfc = c.rfc
JOIN venta_articulo va ON v.numeroventa = va.venta_numeroventa
JOIN articulo a ON va.articulo_id_articulo = a.id_articulo;

SELECT * FROM factura_compra;

----------------------------------------------------------------------------------------
SELECT PRECIO FROM ARTICULO;
SELECT CANTIDAD, VENTA_NUMEROVENTA FROM VENTA_ARTICULO;
SELECT NUMEROVENTA, FECHAVENTA FROM VENTA
SELECT CANTIDAD, PRECIOTOTALPAGARARTICULO FROM VENTA_ARTICULO;


--2.-Obtener la cantidad total vendida y la ganancia correspondiente
--en una fecha o período de fechas:

SELECT SUM(va.cantidad) AS cantidad_total, SUM(va.preciototalpagararticulo) AS ganancia_total
FROM venta v
JOIN venta_articulo va ON v.numeroventa = va.venta_numeroventa
WHERE v.fechaventa BETWEEN '2023-05-01' AND '2023-05-31';

--3.-Decrementar el stock al vender un artículo, emitir alertas y 
--actualizar el total a pagar:


--4.-Obtener el nombre de los productos con menos de 3 en stock:

SELECT descripcion FROM articulo JOIN producto_articulo ON articulo.id_articulo = producto_articulo.articulo_id_articulo
JOIN producto ON producto_articulo.producto_codigobarras = producto.codigobarras
WHERE producto.stock < 3;

--Ya que no tenemos productos con un stock menor a 3, modificamos la tabla y nuestro producto con id=7
-- ya solo tiene 2 en stock

UPDATE producto SET stock = 2 WHERE stock=35;

SELECT DESCRIPCION FROM ARTICULO WHERE ID_ARTICULO = 7;


--5.-Obtener la utilidad de un producto dado su código de barras:

SELECT (va.preciototalpagararticulo - (pr.preciocompra * 5)) AS utilidad
FROM venta_articulo va
JOIN articulo a ON va.articulo_id_articulo = a.id_articulo
JOIN producto_articulo pa ON a.id_articulo = pa.articulo_id_articulo
JOIN producto pr ON pa.producto_codigobarras = pr.codigobarras
WHERE pr.codigobarras = 123456789;

------------------------------------------------------------------------------------------------

SELECT producto_codigobarras, articulo_id_articulo FROM producto_articulo;
SELECT codigobarras,preciocompra FROM producto;
SELECT cantidad, preciototalpagararticulo, articulo_id_articulo FROM venta_articulo;


--6.-Crear un índice a elegir

--Consultas antes de la creación del índice

EXPLAIN ANALYZE SELECT * FROM cliente ORDER BY rfc;

EXPLAIN ANALYZE SELECT * FROM cliente WHERE rfc = 'MENP010223';

--Creación del índice

CREATE INDEX idx_cliente_rfc ON cliente (rfc);

--Realizamos las mismas consultas

EXPLAIN ANALYZE SELECT * FROM cliente ORDER BY rfc;

EXPLAIN ANALYZE SELECT * FROM cliente WHERE rfc = 'MENP010223';





