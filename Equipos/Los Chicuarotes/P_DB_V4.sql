--Creación de las Tablas de nuestra base de datos, basado en el Modelo-Relacional

CREATE TABLE cliente (
    rfc VARCHAR(13) PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    calle VARCHAR(80),
    numero VARCHAR(10),
    colonia VARCHAR(80),
    codigo_postal VARCHAR(10),
    estado VARCHAR(50)
);

CREATE TABLE email_cliente (
    id_email SERIAL PRIMARY KEY,
    rfc_cliente VARCHAR(13) REFERENCES cliente(rfc) ON UPDATE CASCADE ON DELETE CASCADE,
    email VARCHAR(120) NOT NULL
);

CREATE TABLE proveedor (
    id_proveedor SERIAL PRIMARY KEY,
    razon_social VARCHAR(120) NOT NULL,
    nombre_contacto VARCHAR(80),
    calle VARCHAR(80),
    numero VARCHAR(10),
    colonia VARCHAR(80),
    codigo_postal VARCHAR(10),
    estado VARCHAR(50)
);

CREATE TABLE telefono_proveedor (
    id_telefono SERIAL PRIMARY KEY,
    id_proveedor INT REFERENCES proveedor(id_proveedor) ON UPDATE CASCADE ON DELETE CASCADE,
    numero VARCHAR(20) NOT NULL
);

CREATE TABLE producto (
    codigo_barras VARCHAR(30) PRIMARY KEY,
    marca VARCHAR(50),
    descripcion VARCHAR(200),
    tipo VARCHAR(50),
    precio_compra DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    fecha_compra DATE,
    foto VARCHAR(200),
    id_proveedor INT REFERENCES proveedor(id_proveedor) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE venta (
    folio_venta VARCHAR(20) PRIMARY KEY,
    rfc_cliente VARCHAR(13) REFERENCES cliente(rfc) ON UPDATE CASCADE ON DELETE SET NULL,
    fecha_venta TIMESTAMP,
    monto_total DECIMAL(10,2)
);

CREATE TABLE detalle_venta (
    folio_venta VARCHAR(20) REFERENCES venta(folio_venta) ON UPDATE CASCADE ON DELETE CASCADE,
    codigo_barras VARCHAR(30) REFERENCES producto(codigo_barras) ON UPDATE CASCADE ON DELETE CASCADE,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario_aplicado DECIMAL(10,2),
    subtotal_articulo DECIMAL(10,2),
    PRIMARY KEY (folio_venta, codigo_barras)
);


-- ---------------------------------------------------------------
-- 1. PROVEEDOR (Solo 1 registro) por que modificamos esta parte
-- ---------------------------------------------------------------
INSERT INTO proveedor (razon_social, nombre_contacto, calle, numero, colonia, codigo_postal, estado)
VALUES ('Distribuidora Papelera Nacional S.A. de C.V.', 'Roberto Suministros', 'Av. Industrial', '500', 'Parque Industrial', '50000', 'EdoMex');

-- ---------------------------------------------------------------
-- 2. TELEFONO PROVEEDOR (Solo 1 registro, asociado a un solo proveedor) Ya que lo modificamos
-- ---------------------------------------------------------------
INSERT INTO telefono_proveedor (id_proveedor, numero)
VALUES (1, '55-1234-5678');

-- ---------------------------------------------------------------
-- 3. CLIENTES (Ampliamos a 10 clientes)
-- ---------------------------------------------------------------
-- Cliente 1
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('XAXX010101000', 'Cliente Generico Mostrador', 'Conocido', 'S/N', 'Centro', '00000', 'CDMX');

-- Cliente 2
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('HERN850505H22', 'Hugo Hernández', 'Calle de las Flores', '12', 'Jardines', '04500', 'CDMX');

-- Cliente 3
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('PERZ900101H11', 'Juan Pérez', 'Av. Reforma', '101', 'Centro', '06000', 'CDMX');

-- Cliente 4
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('GARC880202M33', 'Ana García', 'Calle Pino', '45', 'Bosques', '11000', 'CDMX');

-- Cliente 5
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('LOPE920303H44', 'Carlos López', 'Av. Insurgentes', '200', 'Roma', '06700', 'CDMX');

-- Cliente 6
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('MART850404M55', 'Elena Martínez', 'Calle Roble', '8', 'Del Valle', '03100', 'CDMX');

-- Cliente 7
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('SANC990505H66', 'Miguel Sánchez', 'Av. Universidad', '1500', 'Copilco', '04360', 'CDMX');

-- Cliente 8
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('RODR800606M77', 'Lucía Rodríguez', 'Calle Madero', '20', 'Histórico', '06010', 'CDMX');

-- Cliente 9
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('TORR950707H88', 'David Torres', 'Calle 5 de Mayo', '300', 'Centro', '50000', 'EdoMex');

-- Cliente 10
INSERT INTO cliente (rfc, nombre, calle, numero, colonia, codigo_postal, estado)
VALUES ('FLOR980808M99', 'Sofía Flores', 'Av. Central', '55', 'Aragón', '57000', 'EdoMex');

-- ---------------------------------------------------------------
-- 4. EMAILS DE CLIENTES (10 registros, uno por cliente)
-- ---------------------------------------------------------------
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('XAXX010101000', 'facturacion@papeleria.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('HERN850505H22', 'hugo.h@email.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('PERZ900101H11', 'juan.perez@mail.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('GARC880202M33', 'ana.garcia@mail.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('LOPE920303H44', 'carlos.lopez@mail.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('MART850404M55', 'elena.mtz@mail.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('SANC990505H66', 'miguel.sanchez@mail.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('RODR800606M77', 'lucia.rdz@mail.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('TORR950707H88', 'david.torres@mail.com');
INSERT INTO email_cliente (rfc_cliente, email) VALUES ('FLOR980808M99', 'sofia.flores@mail.com');

-- ---------------------------------------------------------------
-- 5. PRODUCTOS (Ampliamos a 10 productos)
-- REGLA: Todos con id_proveedor = 1 (La modificación que dijo Fer)
-- ---------------------------------------------------------------

-- 1. Papelería
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('750100000001', 'Scribe', 'Cuaderno Profesional Raya', 'Papelería', 15.50, 28.00, 100, '2025-01-10', 'foto_cuaderno.jpg', 1);

-- 2. Regalos
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('880900000002', 'Hallmark', 'Bolsa de Regalo Grande', 'Regalos', 12.00, 35.00, 40, '2025-01-12', 'foto_bolsa.jpg', 1);

-- 3. Servicio
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('SERV-IMP-001', 'HP', 'Impresión B/N Hoja Carta', 'Impresiones', 0.50, 2.00, 5000, '2025-01-01', 'icon_print.png', 1);

-- 4. Servicio
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('SERV-REC-050', 'Telcel', 'Recarga Tiempo Aire $50', 'Recargas', 48.00, 50.00, 1000, '2025-01-01', 'icon_telcel.png', 1);

-- 5. Papelería
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('750100000005', 'Bic', 'Bolígrafo Punto Medio Azul', 'Papelería', 3.00, 7.00, 200, '2025-01-15', 'foto_pluma.jpg', 1);

-- 6. Papelería
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('750100000006', 'Dixon', 'Lápiz Mirado No. 2', 'Papelería', 2.50, 6.00, 150, '2025-01-15', 'foto_lapiz.jpg', 1);

-- 7. Papelería
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('750100000007', 'Maped', 'Juego de Geometría', 'Papelería', 25.00, 55.00, 30, '2025-01-18', 'foto_geo.jpg', 1);

-- 8. Papelería - Articulo caro
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('750100000008', 'Casio', 'Calculadora Científica', 'Papelería', 150.00, 280.00, 15, '2025-01-20', 'foto_calcu.jpg', 1);

-- 9. Regalos
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('880900000009', 'Fiesta', 'Papel Envoltura Colores', 'Regalos', 3.00, 10.00, 80, '2025-01-22', 'foto_papel.jpg', 1);

-- 10. Stock Bajo
INSERT INTO producto (codigo_barras, marca, descripcion, tipo, precio_compra, precio_venta, stock, fecha_compra, foto, id_proveedor)
VALUES ('750100000010', 'Pritt', 'Pegamento en Barra Grande', 'Papelería', 18.00, 40.00, 2, '2025-01-25', 'foto_pritt.jpg', 1);

-- ---------------------------------------------------------------
-- 6. VENTAS
-- REGLA: Formato VENT-XXX (Lo puso el profe en el pdf)
-- ---------------------------------------------------------------

-- Venta 1 (Hugo)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-001', 'HERN850505H22', '2025-11-01 10:00:00', 91.00);

-- Venta 2 (Generico)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-002', 'XAXX010101000', '2025-11-01 12:30:00', 4.00);

-- Venta 3 (Juan Perez compró 1 calculadora)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-003', 'PERZ900101H11', '2025-11-02 09:15:00', 280.00);

-- Venta 4 (Ana Garcia compró 5 plumas y 2 lápices)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-004', 'GARC880202M33', '2025-11-02 11:00:00', 47.00);

-- Venta 5 (Carlos Lopez compró 1 Juego de Geometría)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-005', 'LOPE920303H44', '2025-11-03 14:20:00', 55.00);

-- Venta 6 (Elena compró 10 impresiones)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-006', 'MART850404M55', '2025-11-03 16:45:00', 20.00);

-- Venta 7 (Miguel Sanchez compró 1 Recarga de 50)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-007', 'SANC990505H66', '2025-11-04 10:30:00', 50.00);

-- Venta 8 (Lucia compró 3 plumas)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-008', 'RODR800606M77', '2025-11-04 13:00:00', 21.00);

-- Venta 9 (David compró 1 cuaderno y 1 pluma)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-009', 'TORR950707H88', '2025-11-05 09:00:00', 35.00);

-- Venta 10 (Sofia compró 2 envolturas)
INSERT INTO venta (folio_venta, rfc_cliente, fecha_venta, monto_total)
VALUES ('VENT-010', 'FLOR980808M99', '2025-11-05 18:00:00', 20.00);

-- ---------------------------------------------------------------
-- 7. DETALLE DE VENTA (Desglose de productos por venta)
-- ---------------------------------------------------------------

-- Venta 1 (2 Cuadernos, 1 Bolsa)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-001', '750100000001', 2, 28.00, 56.00);

INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-001', '880900000002', 1, 35.00, 35.00);

-- Venta 2 (2 Impresiones)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-002', 'SERV-IMP-001', 2, 2.00, 4.00);

-- Venta 3 (1 Calculadora)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-003', '750100000008', 1, 280.00, 280.00);

-- Venta 4 (5 Plumas, 2 Lápices)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-004', '750100000005', 5, 7.00, 35.00);
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-004', '750100000006', 2, 6.00, 12.00);

-- Venta 5 (1 Juego Geometría)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-005', '750100000007', 1, 55.00, 55.00);

-- Venta 6 (10 Impresiones)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-006', 'SERV-IMP-001', 10, 2.00, 20.00);

-- Venta 7 (1 Recarga)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-007', 'SERV-REC-050', 1, 50.00, 50.00);

-- Venta 8 (3 Plumas)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-008', '750100000005', 3, 7.00, 21.00);

-- Venta 9 (1 Cuaderno, 1 Pluma)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-009', '750100000001', 1, 28.00, 28.00);
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-009', '750100000005', 1, 7.00, 7.00);

-- Venta 10 (2 Envolturas)
INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado, subtotal_articulo)
VALUES ('VENT-010', '880900000009', 2, 10.00, 20.00);
-- ---------------------------------------------------------------
-- 8. ÍNDICES Y OPTIMIZACIÓN
-- ---------------------------------------------------------------
-- Se crea un índice de tipo (Non-Clustered) en la fecha de venta para mejorar la busqueda
-- y acelerar los reportes de ganancias por periodo evitando leer toda la tabla secuencialmente.
-- Al ser Non-Clustered, permite que la tabla acepte inserciones rápidas (ventas) sin tener 
-- que reordenarse cada vez que vendemos algo.
CREATE INDEX idx_venta_fecha ON venta(fecha_venta);