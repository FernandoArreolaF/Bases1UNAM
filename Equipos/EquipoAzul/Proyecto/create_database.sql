/* ===========================================
   CODIGO - BASE DE DATOS PAPELERIA
   EQUIPO AZUL - Base de Datos Gpo01
   =========================================== */
   
/* TABLA CLIENTE  -  PK=ID_CLIENTE */
CREATE TABLE cliente (
    id_cliente      SERIAL PRIMARY KEY,
    nombre          VARCHAR(100)  NOT NULL,
    ap_matcliente   VARCHAR(100),
    ap_patcliente   VARCHAR(100),

    -- domicilio compuesto
    estado          VARCHAR(100)  NOT NULL,
    codigo_postal   CHAR(5)       NOT NULL,
    colonia         VARCHAR(100)  NOT NULL,
    calle           VARCHAR(100)  NOT NULL,
    numero          VARCHAR(10)   NOT NULL,

    rfc             VARCHAR(13),

    CONSTRAINT uq_cliente_rfc UNIQUE (rfc),
    CONSTRAINT chk_cp_cliente
        CHECK (codigo_postal ~ '^[0-9]{5}$')
);

/* TABLA CORREO_CLIENTE  -  PK=ID_CORREO */
CREATE TABLE correo_cliente (
    id_correo   SERIAL PRIMARY KEY,
    id_cliente  INTEGER      NOT NULL,
    email       VARCHAR(255) NOT NULL,
    CONSTRAINT fk_correo_cliente_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente)
        ON DELETE CASCADE,
    CONSTRAINT chk_email_cliente
        CHECK (POSITION('@' IN email) > 1)
);

/* TABLA PROVEEDOR  -  PK=ID_PROVEEDOR */
CREATE TABLE proveedor (
    id_proveedor    SERIAL PRIMARY KEY,
    razon_social    VARCHAR(150) NOT NULL,
    nombre          VARCHAR(150),

    -- domicilio compuesto
    estado          VARCHAR(100) NOT NULL,
    codigo_postal   CHAR(5)      NOT NULL,
    colonia         VARCHAR(100) NOT NULL,
    calle           VARCHAR(100) NOT NULL,
    numero          VARCHAR(10)  NOT NULL,

    CONSTRAINT uq_proveedor_razon_social UNIQUE (razon_social),
    CONSTRAINT chk_cp_proveedor
        CHECK (codigo_postal ~ '^[0-9]{5}$')
);

/* TABLA TELEFONOS  -  PK=ID_TELEFONO */
CREATE TABLE telefonos (
    id_telefono     SERIAL PRIMARY KEY,
    id_proveedor    INTEGER     NOT NULL,
    movil           VARCHAR(20),
    oficina         VARCHAR(20),
    numero_telefono VARCHAR(20),

    CONSTRAINT fk_telefonos_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES proveedor (id_proveedor)
        ON DELETE CASCADE,

    CONSTRAINT chk_telefonos_no_vacios
        CHECK (movil IS NOT NULL OR oficina IS NOT NULL OR numero_telefono IS NOT NULL)
);

/* TABLA PRODUCTO  -  PK=ID_PRODUCTO */
CREATE TABLE producto (
    id_producto     SERIAL PRIMARY KEY,
    nombre          VARCHAR(150) NOT NULL,
    descripcion     VARCHAR(255),
    marca           VARCHAR(100),
    precio_venta    NUMERIC(10,2) NOT NULL,
    CONSTRAINT chk_precio_venta_pos
        CHECK (precio_venta > 0)
);

/* TABLA INVENTARIO  -  PK=CODIGO DE BARRAS */
CREATE TABLE inventario (
    codigo_barras   VARCHAR(50)   PRIMARY KEY,
    precio_compra   NUMERIC(10,2) NOT NULL,
    fecha_compra    DATE          NOT NULL,
    stock_actual    INTEGER       NOT NULL,
    foto_url        VARCHAR(1000),
    id_producto     INTEGER       NOT NULL,
    id_proveedor    INTEGER       NOT NULL,
    CONSTRAINT fk_inventario_producto
        FOREIGN KEY (id_producto)
        REFERENCES producto (id_producto),
    CONSTRAINT fk_inventario_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES proveedor (id_proveedor),
    CONSTRAINT chk_precio_compra_pos
        CHECK (precio_compra > 0),
    CONSTRAINT chk_stock_no_negativo
        CHECK (stock_actual >= 0)
);
select * from inventario limit 10; 

/* SECUENCIA PARA FOLIO DE VENTA */
CREATE SEQUENCE seq_folio_venta
    START 1
    INCREMENT 1;

/* TABLA VENTA  -  PK=FOLIO_VENTA */
CREATE TABLE venta (
    folio_venta   VARCHAR(8)   PRIMARY KEY
        DEFAULT ('VENT-' || to_char(nextval('seq_folio_venta'), 'FM000')),
    fecha_venta   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    monto_total   NUMERIC(12,2) NOT NULL DEFAULT 0,
    id_cliente    INTEGER      NOT NULL,
    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente),
    CONSTRAINT chk_folio_venta_formato
        CHECK (folio_venta ~ '^VENT-[0-9]{3}$')
);

/* TABLA DETALLE_VENTA  -  PK=ID_DETALLEVENTA */
CREATE TABLE detalle_venta (
    id_detalleventa   SERIAL PRIMARY KEY,
    folio_venta       VARCHAR(8)   NOT NULL,
    cantidad          INTEGER      NOT NULL,
    precio_aplicadou  NUMERIC(10,2) NOT NULL,
    sumtotal          NUMERIC(12,2) NOT NULL,
    codigo_barras     VARCHAR(50)  NOT NULL,
    CONSTRAINT fk_detalle_venta_venta
        FOREIGN KEY (folio_venta)
        REFERENCES venta (folio_venta)
        ON DELETE CASCADE,
    CONSTRAINT fk_detalle_venta_inventario
        FOREIGN KEY (codigo_barras)
        REFERENCES inventario (codigo_barras),
    CONSTRAINT chk_cantidad_pos
        CHECK (cantidad > 0),
    CONSTRAINT chk_precios_detalle_pos
        CHECK (precio_aplicadou > 0),
    CONSTRAINT chk_sumtotal_no_neg
        CHECK (sumtotal >= 0)
);


/* ===========================================
   ÍNDICES
   =========================================== */
   
--Genera un índice en la tabla inventario para la columna stock_actual, para generar búsquedas rápidas basadas en el stock disponible.
CREATE INDEX IX_inventario_stock
ON inventario USING BTREE (stock_actual);

--Genera un índice en la tabla inventario para la columna id_proveedor, para optimizar las consultas join del inventario con el proveedor.
CREATE INDEX IX_inventario_idproveedor
ON inventario USING BTREE (id_proveedor);


/* ===========================================
   TRIGGERS Y FUNCIONES PARA EL INVENTARIO
   =========================================== */
-- FUNCIÓN BEFORE: valida stock y calcula total por artículo
CREATE OR REPLACE FUNCTION fn_detalle_venta_before()
RETURNS TRIGGER AS
$$
DECLARE
    v_stock_actual INTEGER;
BEGIN
    -- 1) Calcular total por artículo
    NEW.sumtotal := NEW.cantidad * NEW.precio_aplicadou;

    -- 2) Obtener stock actual del inventario
    SELECT stock_actual
    INTO v_stock_actual
    FROM inventario
    WHERE codigo_barras = NEW.codigo_barras;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'No existe inventario para el código de barras %',
            NEW.codigo_barras;
    END IF;

    -- 3) Cancelar si ya no hay stock (0 o negativo)
    IF v_stock_actual <= 0 THEN
        RAISE EXCEPTION
            'VENTA CANCELADA: nuestro stock ya está agotado para el producto % (stock=%)',
            NEW.codigo_barras, v_stock_actual;
    END IF;

    -- 4) Cancelar si la cantidad pedida haría que el stock fuera negativo
    IF v_stock_actual - NEW.cantidad < 0 THEN
        RAISE EXCEPTION
            'VENTA CANCELADA: stock insuficiente para el producto % (stock=%, cantidad pedida=%)',
            NEW.codigo_barras, v_stock_actual, NEW.cantidad;
    END IF;

    -- 5) Cancelar si la venta dejaría el stock exactamente en 0
    IF v_stock_actual - NEW.cantidad = 0 THEN
        RAISE EXCEPTION
            'VENTA CANCELADA: esta venta dejaría el stock en 0 para el producto % (stock actual=%, cantidad pedida=%)',
            NEW.codigo_barras, v_stock_actual, NEW.cantidad;
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER trg_detalle_venta_before
BEFORE INSERT ON detalle_venta
FOR EACH ROW
EXECUTE FUNCTION fn_detalle_venta_before();



-- FUNCIÓN AFTER: descuenta stock, lanza alerta y actualiza total de la venta
CREATE OR REPLACE FUNCTION fn_detalle_venta_after()
RETURNS TRIGGER AS
$$
DECLARE
    v_stock_nuevo INTEGER;
BEGIN
    -- 1) Descontar stock
    UPDATE inventario
    SET stock_actual = stock_actual - NEW.cantidad
    WHERE codigo_barras = NEW.codigo_barras
    RETURNING stock_actual INTO v_stock_nuevo;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Error al actualizar inventario para el código de barras %',
            NEW.codigo_barras;
    END IF;

    -- 2) ALERTA de stock bajo (incluye 2,1,0)
    IF v_stock_nuevo < 3 THEN
        RAISE NOTICE
            'ALERTA: stock bajo (% unidades) para el producto %',
            v_stock_nuevo, NEW.codigo_barras;
    END IF;

    -- 3) Actualizar total de la venta completa
    UPDATE venta
    SET monto_total = COALESCE((
        SELECT SUM(sumtotal)
        FROM detalle_venta
        WHERE folio_venta = NEW.folio_venta
    ), 0)
    WHERE folio_venta = NEW.folio_venta;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
select * from producto;
CREATE TRIGGER trg_detalle_venta_after
AFTER INSERT ON detalle_venta
FOR EACH ROW
EXECUTE FUNCTION fn_detalle_venta_after();

/* ===========================================
   INSERTS
   =========================================== */
   
/* Inserts tabla cliente */
INSERT INTO cliente (nombre, ap_matcliente, ap_patcliente, estado, codigo_postal, colonia, calle, numero,rfc) VALUES
('Juan', 'Pérez', 'García', 'Ciudad de México', '06020', 'Centro', 'Calle Perú', '891', '123456710ABCD'),
('Sebastian', 'Torres', 'Mendoza', 'Ciudad de México', '15900', 'Moctezuma', 'Avenida 27 de Febrero', '89', '123456789ABCD'),
('Andrea', 'Aguilar', 'Salgado', 'Ciudad de México', '03100', 'Del Valle', 'Avenida Insurgentes', '333', '223456789ABCD'),
('Mateo', 'Ramírez', 'Martínez', 'Ciudad de México', '03300', 'Portales', 'División del Norte', '789', '323456789ABCD'),
('Sofía', 'Herrera', 'Ocampo', 'Ciudad de México', '04510', 'Pedregal de Santo Domingo', 'Avenida Universidad', '123', '423456789ABCD'),
('Daniel', 'Montiel', 'Farías', 'Ciudad de México', '03104', 'Narvarte', 'Viaducto Miguel Alemán', '456', '523456789ABCD'),
('Lucía', 'Velasco', 'Castañeda', 'Ciudad de México', '04200', 'Campestre Churubusco', 'Río Churubusco', '23', '623456789ABCD'),
('Rodrigo', 'Escobar', 'Robledo', 'Ciudad de México', '04470', 'Toriello Guerra', 'Calzada de Tlalpan', '900', '723456789ABCD'),
('Valeria', 'Pineda', 'Esquivel', 'Ciudad de México', '06600', 'Juárez', 'Calle París', '100', '823456789ABCD'),
('Ignacio', 'Duarte', 'Porras', 'Ciudad de México', '04000', 'Del Carmen', 'Emiliano Zapata', '711', '923456789ABCD'),
('Camila', 'Rivas', 'Zamudio', 'Ciudad de México', '03020', 'Obrera', 'Calle Morelos', '17', 'A23456789ABCD'),
('Eduardo', 'Moreno', 'Jiménez', 'Jalisco', '44160', 'Americana', 'Avenida México', '234', 'EMJ850620KLM2'),
('Patricia', 'Soto', 'Navarro', 'Jalisco', '44910', 'Del Fresno', 'Calle 8 de Julio', '99', 'PSN880914NO2P'),
('Miguel', 'Castillo', 'Reyes', 'Jalisco', '44600', 'Santa Teresa', 'Avenida Chapultepec', '890', 'MCR9203052QRS'),
('Gabriela', 'Flores', 'Medina', 'Jalisco', '44560', 'Obrera', 'Paseo Montejo', '345', 'GFM870711TUV2'),
('Francisco', 'Rojas', 'Acosta', 'Jalisco', '44700', 'San Andrés', 'Boulevard Agua Prieta', '678', '2FRA891123WXY'),
('Alejandro', 'González', 'Quintero', 'Nuevo León', '64000', 'Centro', 'Avenida Constitución', '234', '1AGQ860418ZAB'),
('Isabela', 'Martínez', 'López', 'Nuevo León', '64090', 'Zaragoza', 'Calle Zaragoza', '567', 'IML910725CDE2'),
('Fernando', 'Valdez', 'Ríos', 'Nuevo León', '64010', 'Centro', 'Paseo Santa Lucía', '242', 'FVR880512FGH1'),
('Cristina', 'Mendoza', 'Cortés', 'Nuevo León', '64020', 'Barrio Antiguo', 'Boulevard Barrio Antiguo', '144', 'CMC930809IJK4'),
('Arturo', 'Sandoval', 'Muñoz', 'Nuevo León', '64530', 'Mitras Sur', 'Avenida Universidad', '898', 'ASM870621LMN3');


/* Inserts tabla correo_cliente */
INSERT INTO correo_cliente (id_cliente, email) VALUES
(1, 'juan.perez@coldmail.com'),
(2, 'sebastian.torres@kmail.com'),
(3, 'andrea.aguilar@coldmail.com'),
(4, 'mateo.ramirez@kmail.com'),
(5, 'sofia.herrera@kmail.com'),
(6, 'daniel.montiel@coldmail.com'),
(7, 'lucia.velasco@coldmail.com'),
(8, 'rodrigo.escobar@coldmail.com'),
(9, 'valeria.pineda@coldmail.com'),
(10, 'ignacio.duarte@kmail.com'),
(11, 'camila.rivas@coldmail.com'),
(12, 'eduardo.moreno@coldmail.com'),
(13, 'patricia.soto@kmail.com'),
(14, 'miguel.castillo@coldmail.com'),
(15, 'gabriela.flores@coldmail.com'),
(16, 'francisco.rojas@coldmail.com'),
(17, 'alejandro.gonzalez@coldmail.com'),
(18, 'isabela.martinez@coldmail.com'),
(19, 'fernando.valdez@coldmail.com'),
(20, 'cristina.mendoza@coldmail.com'),
(21, 'arturo.sandoval@kmail.com');

/* Inserts tabla proveedor */
INSERT INTO proveedor (razon_social, nombre, estado, codigo_postal, colonia, calle, numero) VALUES
('Dunder Mifflin, Inc.', 'Miguel Soto', 'Ciudad de México', '03104', 'Colonia Del Valle', 'Calle Magnolias', '218'),
('Suministros Copilco', NULL, 'Ciudad de México', '04360', 'Colonia Copilco el Alto', 'Calle Cerro del Agua', '392'),
('Paplería mayoreo', NULL, 'Estado de México', '52970', 'Colonia Bosques de Echegaray', 'Avenida de las Fuentes', '314'),
('Oficinas y más S.A. de C.V.', 'Laura Gómez', 'Ciudad de México', '03100', 'Colonia Nápoles', 'Calle Perú', '95'),
('Papelería Central', 'Fernando López', 'Ciudad de México', '06760', 'Colonia Centro', 'Avenida 20 de Noviembre', '39'),
('Tekcel', 'Ana Martínez', 'Ciudad de México', '01210', 'Colonia Santa Fe', 'Avenida Vasco de Quiroga', '10');

/* Inserts tabla telefonos */
INSERT INTO telefonos (id_proveedor, movil, oficina, numero_telefono) VALUES
(1, '5512345670', null, '5556781234'),
(2, null, '5551234565', '5575699876'),
(3, null, '5554321987', null),
(4, '5598765432', null, '5559876543'),
(5, '5587654321', null, '5553456789'),
(6, '5552468333', '5552468101', '5552468999');

/* Inserts tabla producto */
INSERT INTO producto (nombre, descripcion, marca, precio_venta) VALUES
('Bolígrafo Azul', 'Bolígrafo de tinta azul, punta fina', 'Vic', 3.50),
('Paquete de colores', 'Set de 12 colores para dibujo y pintura', 'Mapita Premium', 200.00),
('Paquete de hojas blancas', 'Paquete con 500 hojas tamaño carta', 'Papel Dunder', 350.00),
('Resaltadores Fluorescentes', 'Set de 4 resaltadores de colores fluorescentes', 'Stabilla', 99.99),
('Cuaderno Profesional', 'Cuaderno de 100 hojas, tamaño carta, rayado', 'Normas', 188.50),
('Impresiones BN', 'Servicio de impresiones en blanco', null, 1.50),
('Impresiones Color', 'Servicio de impresiones a color', null, 5.00),
('Recarga 50', 'Recarga de datos móviles', null, 50.00),
('Recarga 100', 'Recarga de datos móviles', null, 100.00),
('Recarga 200', 'Recarga de datos móviles', null, 200.00),
('Llaveros', 'Llaveros con temática de la ciudad', 'VisitaMX', 75.99),
('Tazas', 'Tazas de cerámica con diseños de la ciudad', 'VisitaMX', 120.99),
('Playeras', 'Playeras de algodón con estampados urbanos', 'Regalos Juanita', 150.98),
('Postales', 'Set de postales con imágenes de la ciudad', 'Visita MX', 60.99),
('Imanes para refrigerador', 'Imanes con diseños representativos de la ciudad', 'Visita MX', 80.99),
('Mochilas', 'Mochilas resistentes', 'TheSouthFace', 1300.99),
('Libretas de notas', 'Libretas pequeñas para notas rápidas', 'Depósito de oficina', 30.50),
('Paquete de lápices', 'Set de 10 lápices', 'Depósito de oficina', 20.75),
('Posters decorativos', 'Posters de superhéroes', 'Marbel', 149.99),
('Bolsas reutilizables', 'Bolsas ecológicas', 'Depósito de oficina', 45.99);

/* Inserts tabla inventario */
INSERT INTO inventario (codigo_barras, precio_compra, fecha_compra, stock_actual, foto_url, id_producto, id_proveedor) VALUES
('1704175696639', 2.50,'2025-06-10', 32, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX_8Fbhoh0T3AKojiz3DfQV3b1QDdE4lkOOQ&s',1, 2),
('1704175696640', 120.00, '2025-06-10', 24, 'https://unionpapelera.com.mx/pub/media/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/0/8/08258_1.jpg', 2, 3),
('1704175696641', 200.50, '2025-06-10', 15, 'https://www.officedepot.com.mx/medias/6892.jpg-1200ftw?context=bWFzdGVyfHJvb3R8MjEwNTMxfGltYWdlL2pwZWd8YURaaUwyaG1NUzh4TURNME9UZ3lNak0zT0RBeE5DODJPRGt5TG1wd1oxOHhNakF3Wm5SM3wyMGU3NTUwYTdmNjdhMTQzZDY4OTJlZWEzY2IzOTE1MmIxY2MwZDZlYmQyMzlhZmVmMTI3OGQ4MTQ4NTgxNTcx', 3, 1),
('1704175696642', 60.20, '2025-06-10', 40, 'https://m.media-amazon.com/images/I/71y9f1CKxsL.jpg', 4, 4),
('1704175696643', 120.10, '2025-06-10', 6, 'https://pedidos.com/_next/image?url=https%3A%2F%2Fpedidos.com%2Fmyfotos%2FxLarge_v3%2F(v3)(X)SCR-CUA-S7970.webp&w=1080&q=75',5, 3),
('1704175696644', 0.50, '2025-04-03', 100, null, 6, 5),
('1704175696645', 1.80, '2025-04-03', 100, null, 7, 5),
('1704175696646', 48.00, '2025-04-03', 100, null, 8, 6),
('1704175696647', 96.00, '2025-04-03', 100, null, 9, 6),
('1704175696648', 192.00, '2025-04-03', 100, null, 10, 6),
('1704175696649', 50.30, '2025-01-15', 33, 'https://promocionalesymas.com/wpvf/wp-content/uploads/2020/05/LLM1510.jpg', 11, 2),
('1704175696650', 80.40, '2025-01-15', 18, 'https://m.media-amazon.com/images/I/41C8J21sBbL._AC_UF894,1000_QL80_.jpg', 12, 2),
('1704175696651', 100.40, '2025-01-15', 5, 'https://i.etsystatic.com/22755890/r/il/bea9fa/5989780659/il_300x300.5989780659_e2nh.jpg', 13, 2),
('1704175696652', 50.20, '2025-01-15', 5, 'https://i.etsystatic.com/47100129/r/il/0b3cb0/6047580912/il_300x300.6047580912_8oef.jpg', 14, 3),
('1704175696653', 64.80, '2025-08-29', 12, 'https://m.media-amazon.com/images/I/81UUJ+NmiqL._AC_UF894,1000_QL80_.jpg', 15, 3),
('1704175696654', 800.50, '2025-08-29',2, 'https://deportehabitat.com.mx/media/catalog/product/cache/24f6d5c179bfc57bccbad8d4fc372b83/T/h/TheNorthFace-Terra40-Mochila-AsphaltGreyTNFBlack-1_22.jpg', 16, 4),
('1704175696655', 20.00, '2025-08-29', 38, 'https://articulospromocionaleskw.com/wp-content/uploads/mini-libreta-de-plastico-pasta-dura-y-forpromotional.jpg', 17, 5),
('1704175696656', 15.00, '2025-08-29', 35, 'https://unionpapelera.com.mx/pub/media/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/2/z/2zs.jpg', 18, 5),
('1704175696657', 100.00, '2025-08-29', 3, 'https://larryfire.files.wordpress.com/2010/07/364ae15b60e9bcbf9d64330b398af31e.jpg?w=468&h=596', 19, 4),
('1704175696658', 30.99, '2025-08-29', 22, 'https://http2.mlstatic.com/D_NQ_NP_618204-MLM46364680871_062021-O-bolsas-ecologicas-reutilizables-45-x-35-x-12-cm-50-piezas.webp', 20, 5);

/* Inserts tabla venta */
INSERT INTO venta (monto_total, id_cliente) VALUES
(35, 1),
(750, 2),
(200, 3),
(1300.99, 4),
(499.94, 5),
(400.69, 6),
(30.50, 7),
(5, 8),
(488.47, 9),
(50, 10),
(1.50, 11),
(51.25, 12),
(60.99,13),
(149.99, 14);

/* Inserts tabla detalle_venta */
INSERT INTO detalle_venta (folio_venta, cantidad, precio_aplicadou, sumtotal, codigo_barras) VALUES
('VENT-001', 10, 3.50, 35.00, '1704175696639'),
('VENT-002', 2,200.00, 400.00, '1704175696640'),
('VENT-002', 1,350.00, 350.00, '1704175696641'),
('VENT-003', 1, 200.00, 200.00, '1704175696648'),
('VENT-004', 1,1300.99, 1300.99, '1704175696654'),
('VENT-005', 3, 75.99, 227.97, '1704175696649'),
('VENT-005', 1, 120.99, 120.99, '1704175696650'),
('VENT-005', 1, 150.98, 150.98, '1704175696651'),
('VENT-006', 5, 45.99, 229.95, '1704175696658'),
('VENT-006', 1, 149.99, 149.99, '1704175696657'),
('VENT-006', 1, 20.75, 20.75, '1704175696656'),
('VENT-007', 1, 30.50, 30.50, '1704175696655'),
('VENT-008', 1, 5.00, 5.00, '1704175696645'),
('VENT-009', 3, 99.99, 299.97, '1704175696642'),
('VENT-009', 1, 188.50, 188.50, '1704175696643'),
('VENT-010', 1, 50.00, 50.00, '1704175696647'),
('VENT-011', 1, 1.50, 1.50, '1704175696644'),
('VENT-012', 1, 30.50, 30.50, '1704175696655'),
('VENT-012', 1, 20.75, 20.75, '1704175696656'),
('VENT-013', 1, 60.99, 60.99, '1704175696652'),
('VENT-014', 1, 149.99, 149.99, '1704175696657');


/* ===========================================
   VISTA TIPO FACTURA
   =========================================== */
   
CREATE OR REPLACE VIEW vista_factura AS
SELECT
    v.folio_venta,
    v.fecha_venta,
    v.monto_total,

    -- Datos del cliente
    c.id_cliente,
    c.nombre            AS nombre_cliente,
    c.ap_patcliente,
    c.ap_matcliente,
    c.rfc               AS rfc_cliente,
    c.estado            AS estado_cliente,
    c.codigo_postal     AS cp_cliente,
    c.colonia           AS colonia_cliente,
    c.calle             AS calle_cliente,
    c.numero            AS numero_cliente,
    cc.email            AS email_cliente,

    -- Detalle de los artículos
    dv.id_detalleventa,
    dv.codigo_barras,
    p.nombre            AS nombre_producto,
    p.marca             AS marca_producto,
    p.descripcion       AS descripcion_producto,
    dv.cantidad,
    dv.precio_aplicadou AS precio_unitario,
    dv.sumtotal         AS subtotal_linea

FROM venta v
JOIN cliente c
    ON v.id_cliente = c.id_cliente
LEFT JOIN correo_cliente cc       -- Por si algún cliente tuviera más de 1 correo
    ON cc.id_cliente = c.id_cliente
JOIN detalle_venta dv
    ON dv.folio_venta = v.folio_venta
JOIN inventario i
    ON dv.codigo_barras = i.codigo_barras
JOIN producto p
    ON i.id_producto = p.id_producto;


/* ===========================================
   CONSULTA GANANCIA
   =========================================== */

/* TOTAL VENDIDO EN UNA FECHA */
CREATE OR REPLACE FUNCTION ventaTotalFecha (fechaConsulta DATE)
RETURNS TABLE(fecha date,
			  total_vendido numeric,
			  ganancia numeric
			 )
AS $$
BEGIN

	RETURN QUERY
	SELECT DATE(v.fecha_venta) AS fecha,
    	   SUM(dv.sumtotal) AS total_vendido,
    	   SUM( (dv.precio_aplicadou - i.precio_compra) * dv.cantidad ) AS ganancia
	FROM venta v
	JOIN detalle_venta dv
    	ON dv.folio_venta = v.folio_venta
	JOIN inventario i
    	ON dv.codigo_barras = i.codigo_barras
	WHERE DATE(v.fecha_venta) = fechaConsulta   --Cambiamos la fecha  
	GROUP BY DATE(v.fecha_venta);
	
END;
$$ LANGUAGE plpgsql;

--Llama a la función ventaTotalFecha con formato necesario 'AAAA-MM-DD'
select * from ventaTotalFecha ('2025-11-27');

/* TOTAL VENDIDO Y GANANCIA ENTRE DOS FECHAS */
CREATE OR REPLACE FUNCTION ventaTotalEntreFechas (fechaInicioConsulta DATE, 
												  fechaFinalConsulta DATE DEFAULT NULL)
RETURNS TABLE(fecha date,
			  total_vendido numeric,
			  ganancia numeric
			 )
AS $$
BEGIN

	--Si la fecha final es null se asigna la fecha actual
	fechaFinalConsulta := COALESCE(fechaFinalConsulta, now());
	
	RETURN QUERY
	SELECT DATE(v.fecha_venta) AS fecha,
    	   SUM(dv.sumtotal) AS total_vendido,
    	   SUM( (dv.precio_aplicadou - i.precio_compra) * dv.cantidad ) AS ganancia
	FROM venta v
	JOIN detalle_venta dv
    	ON dv.folio_venta = v.folio_venta
	JOIN inventario i
	    ON dv.codigo_barras = i.codigo_barras
	WHERE DATE(v.fecha_venta)
    	BETWEEN fechaInicioConsulta AND fechaFinalConsulta
	GROUP BY DATE(v.fecha_venta)
	ORDER BY fecha;
	
END;
$$ LANGUAGE plpgsql;

select folio_venta,fecha_venta,nombre_cliente,nombre_producto,cantidad,subtotal_linea from vista_factura limit 5;

--Llama a la función ventaTotalEntreFechas con formato necesario 'AAAA-MM-DD', puede o no tener fecha final de consulta
SELECT * FROM ventaTotalEntreFechas('2025-11-01', '2025-12-08');

/* GANANCIA TOTAL */
CREATE OR REPLACE FUNCTION gananciaTotal ()
RETURNS TABLE(ganancia numeric)
AS $$
BEGIN

	RETURN QUERY
	SELECT
    	SUM( (dv.precio_aplicadou - i.precio_compra) * dv.cantidad ) AS ganancia_total
	FROM detalle_venta dv
	JOIN inventario i
	    ON dv.codigo_barras = i.codigo_barras;
	
END;
$$ LANGUAGE plpgsql;

--Llama a la función gananciaTotal
SELECT * FROM gananciaTotal();


--Llama a la vista vista_factura
SELECT *
FROM vista_factura
WHERE folio_venta = 'VENT-001'
ORDER BY id_detalleventa;


/* ===========================================
   FUNCIONES ESPECIALES DE NEGOCIO
   =========================================== */

--Función que regrese utilidad dada un código de barras.
CREATE OR REPLACE FUNCTION utilidadPorProducto (codigoB varchar)
RETURNS TABLE(codigo_barras varchar,
			  nombre varchar,
			  cantidad_vendido integer,
			  utilidad numeric
			 )
AS $$
BEGIN

	RETURN QUERY
	SELECT DV.codigo_barras,
		   PR.nombre,
		   DV.cantidad,
		   --Operación que calcula la utilidad del producto
		   SUM( (DV.precio_aplicadou-I.precio_compra) * DV.cantidad )
	FROM inventario I
	INNER JOIN producto PR
		ON I.id_producto = PR.id_producto
	INNER JOIN detalle_venta DV
		ON I.codigo_barras = DV.codigo_barras
	WHERE I.codigo_barras = codigoB
	GROUP BY (DV.codigo_barras,
		   PR.nombre,
		   DV.cantidad);
	
END;
$$ LANGUAGE plpgsql;

--Llama a la función utilidadPorProducto(character varying)
SELECT * FROM utilidadPorProducto('1704175696641');

--Función que regrese productos con stock < 3.
CREATE FUNCTION stockBajo ()
RETURNS TABLE(codigo_barras varchar,
			  nombre varchar,
			  fecha_compra date,
			  stock_actual integer,
			  proveedor varchar,
			  movil varchar,
			  oficina varchar,
			  numero_telefono varchar
			  )
AS $$
BEGIN

	RETURN QUERY
	SELECT I.codigo_barras, 
		   PR.nombre,
		   I.fecha_compra, 
		   I.stock_actual,
		   P.nombre,
		   T.movil,
		   T.oficina,
		   T.numero_telefono
	FROM inventario I
	INNER JOIN proveedor P
		ON I.id_proveedor = P.id_proveedor
	INNER JOIN telefonos T
		ON I.id_proveedor = T.id_proveedor
	INNER JOIN producto PR
		ON I.id_producto = PR.id_producto
	WHERE I.stock_actual <= 3;
	
END;
$$
LANGUAGE plpgsql;

--Llama a la función stockBajo()
SELECT * FROM stockBajo();
