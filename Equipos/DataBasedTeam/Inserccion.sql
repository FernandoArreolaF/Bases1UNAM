-- 1. PROOVEDORES
INSERT INTO PROOVEDOR (idProovedor, primNombre, apPat, estado, colonia, calle, numero, cp, razonSocial)
VALUES 
(1, 'Papelería', 'Luna', 'CDMX', 'Centro', 'Av. Reforma', 122, 01010, 'Papelería Luna S.A.'),
(2, 'Distribuidora', 'Sol', 'CDMX', 'Roma', 'Durango', 77, 02220, 'Distribuidora Sol S.A.');

-- Actualizamos la secuencia para que el siguiente insert sea el 3
SELECT setval('proovedor_idproovedor_seq', 2, true);


-- 2. TELÉFONO PROOVEDOR
INSERT INTO TELEFONO_PROOVEDOR (idProovedor, telefono)
VALUES 
(1, '5511223344'),
(1, '5544556677'),
(2, '5588997766');


-- 3. PRODUCTOS
INSERT INTO PRODUCTO (codigoBarras, descripcion, marca, categoria, foto, precioCompra, precioVenta, fechaCompra, stock)
VALUES 
('750100000001', 'Pluma negra', 'Bic', 'Papeleria', NULL, 4.00, 8.00, '2025-01-20', 70),
('750200000002', 'Cuaderno profesional', 'Scribe', 'Papeleria', NULL, 20.00, 35.00, '2025-01-15', 30),
('750300000003', 'Taza de regalo', 'Totto', 'Regalos', NULL, 40.00, 80.00, '2025-01-10', 20);


-- 4. PROVEE_PRODUCTO
INSERT INTO PROVEE_PRODUCTO (idProovedor, codigoBarras)
VALUES 
(1, '750100000001'), -- Papelería Luna Plumas
(1, '750200000002'), -- Papelería Luna Cuadernos
(2, '750300000003'); -- Dist. Sol provee Tazas


-- 5. CLIENTES
-- El RFC es la PK, así que lo usamos para identificar al cliente
INSERT INTO CLIENTE (rfc, primNombre, apPat, estado, colonia, calle, numero, cp)
VALUES 
('PEJJ900101ABC', 'Juan', 'Pérez', 'CDMX', 'Polanco', 'Homero', 201, 01234),
('LOPM920202XYZ', 'María', 'López', 'CDMX', 'Condesa', 'Amsterdam', 12, 06700);


-- 6. EMAIL_CLIENTE
-- Relacionamos usando el RFC
INSERT INTO EMAIL_CLIENTE (rfc, email)
VALUES 
('PEJJ900101ABC', 'juanp@gmail.com'),
('LOPM920202XYZ', 'marialopez@hotmail.com');


-- 7. VENTA
-- Asumo totalPago = 0.
INSERT INTO VENTA (numVenta, rfc, fechaVenta, totalPago)
VALUES 
(1, 'PEJJ900101ABC', '2025-01-25', 0),
(2, 'LOPM920202XYZ', '2025-01-25', 0);

-- Actualizamos la secuencia del SERIAL de ventas
SELECT setval('venta_numventa_seq', 2, true);


-- 8. CONTIENE_PRODUCTO (Detalle de Venta)
-- Relacionamos la Venta #1 y #2 con los códigos de barras
INSERT INTO CONTIENE_PRODUCTO (numVenta, codigoBarras, cantidad, importe)
VALUES 
(1, '750100000001', 2, 16.00),  -- Venta 1: 2 Plumas
(1, '750200000002', 1, 35.00),  -- Venta 1: 1 Cuaderno
(2, '750300000003', 1, 80.00);  -- Venta 2: 1 Taza
CREATE INDEX idx_producto_stock ON producto(stock);

UPDATE PRODUCTO 
SET stock = stock + 8, 
    fechaCompra = CURRENT_DATE 
WHERE codigoBarras = '750300000003';

