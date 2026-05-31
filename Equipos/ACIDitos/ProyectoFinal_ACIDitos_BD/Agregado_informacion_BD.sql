-- ====================================================================
-- 1. TABLAS PADRE (Sin dependencias)
-- ====================================================================

-- Insertamos los empleados base. Aprovechamos el SERIAL para id_empleado (1 a 5).
INSERT INTO empleado (rfc, nombre, apellido_paterno, apellido_materno, fecha_nacimiento, edad, sueldo, estado, codigo_postal, colonia, calle, numero) VALUES
('PELJ900515HDF', 'Juan', 'Pérez', 'López', '1990-05-15', 36, 8500.00, 'CDMX', '06000', 'Centro Histórico', 'Madero', '15'),
('GAFM850820MDF', 'María', 'García', 'Fernández', '1985-08-20', 40, 12000.00, 'CDMX', '04000', 'Coyoacán', 'Allende', '22'),
('RUSC801110HDF', 'Carlos', 'Ruiz', 'Sánchez', '1980-11-10', 45, 18000.00, 'CDMX', '11000', 'Polanco', 'Masaryk', '101'),
('TOVA950228MDF', 'Ana', 'Torres', 'Vega', '1995-02-28', 31, 8500.00, 'CDMX', '06700', 'Roma Norte', 'Álvaro Obregón', '45'),
('LORM920510HDF', 'Luis', 'Ortiz', 'Mendoza', '1992-05-10', 33, 9500.00, 'CDMX', '03100', 'Del Valle', 'Insurgentes Sur', '1045');

-- Insertamos clientes frecuentes.
INSERT INTO cliente (rfc_cliente, nombre, apellido_paterno, apellido_materno, razon_social, email, fecha_nacimiento, estado, codigo_postal, colonia, calle, numero) VALUES
('GOML900101QWE', 'Laura', 'Gómez', 'Lara', 'Consultoría LG SA de CV', 'laura.gomez@empresa.com', '1990-01-01', 'CDMX', '06600', 'Juárez', 'Reforma', '222'),
('DIRR850404RTY', 'Roberto', 'Díaz', 'Ríos', NULL, 'roberto.diaz@correo.com', '1985-04-04', 'Estado de México', '54000', 'Tlalnepantla', 'Sor Juana', '10'),
('SALS880712MNB', 'Sofía', 'Salinas', 'Soto', NULL, 'sofia.ss@correo.com', '1988-07-12', 'CDMX', '01000', 'San Ángel', 'Revolución', '150');

-- Insertamos categorías de menú. (IDs del 1 al 4)
INSERT INTO categoria (nombre, descripcion) VALUES
('Entradas', 'Aperitivos y botanas para compartir'),
('Platos Fuertes', 'Especialidades de la casa'),
('Bebidas', 'Bebidas refrescantes con y sin alcohol'),
('Postres', 'Dulces, pasteles y repostería tradicional');


-- ====================================================================
-- 2. TABLAS HIJAS NIVEL 1 (Dependen de Empleado o Categoría)
-- ====================================================================

-- Asignamos los roles a los empleados insertados previamente según su ID.
INSERT INTO cocinero (id_empleado, especialidad) VALUES
(2, 'Comida Mexicana Tradicional'),
(5, 'Repostería y Postres');

INSERT INTO mesero (id_empleado, horario) VALUES
(1, 'Matutino 08:00 - 16:00'),
(4, 'Vespertino 16:00 - 23:30');

INSERT INTO administrativo (id_empleado, rol) VALUES
(3, 'Gerente General');

-- Información adicional de los empleados.
INSERT INTO telefono (id_empleado, telefono) VALUES
(1, '5512345678'),
(2, '5598765432');

INSERT INTO dependiente (curp, id_empleado, nombre, apellido_paterno, apellido_materno, parentesco) VALUES
('GAFP100101HDFRRC01', 2, 'Pedro', 'García', 'Fernández', 'Hijo');

-- Insertamos el menú del restaurante. (IDs del 1 al 9)
INSERT INTO producto (id_categoria, nombre, descripcion, receta, precio, disponibilidad, tipo_producto) VALUES
(1, 'Guacamole con Totopos', 'Tradicional guacamole', 'Aguacate, cebolla, tomate, cilantro, limón', 85.00, TRUE, 'PLATILLO'),
(2, 'Enchiladas Suizas', 'Enchiladas en salsa verde', 'Tortilla, pollo, salsa verde, queso asadero', 135.00, TRUE, 'PLATILLO'),
(2, 'Tacos al Pastor', 'Orden de 5 tacos', 'Carne de cerdo marinada, tortilla, piña', 110.00, TRUE, 'PLATILLO'),
(3, 'Agua de Horchata', 'Agua de arroz 500ml', 'Arroz, canela, azúcar, agua, leche', 35.00, TRUE, 'BEBIDA'),
(3, 'Refresco de Cola', 'Lata 355ml', 'N/A', 30.00, TRUE, 'BEBIDA'),
(4, 'Flan Napolitano', 'Rebanada de flan casero', 'Leche evaporada, leche condensada, huevo, vainilla', 65.00, TRUE, 'PLATILLO'),
(4, 'Pastel de Tres Leches', 'Rebanada clásica', 'Harina, mezcla tres leches, crema batida, durazno', 75.00, TRUE, 'PLATILLO'),
(4, 'Churros con Azúcar', 'Orden de 4 churros', 'Masa para churros, aceite, azúcar, canela', 55.00, TRUE, 'PLATILLO'),
(3, 'Café de Olla', 'Taza de 250ml', 'Café molido, agua, piloncillo, canela, clavo', 40.00, TRUE, 'BEBIDA');


-- ====================================================================
-- 3. TABLAS TRANSACCIONALES (Detonan los Triggers)
-- ====================================================================

-- Insertamos órdenes. Pasamos folio_orden en NULL para que el trigger asigne 'ORD-00X'.
INSERT INTO orden (folio_orden, id_mesero) VALUES
(NULL, 1), -- Será ORD-001
(NULL, 4), -- Será ORD-002
(NULL, 1), -- Será ORD-003
(NULL, 4); -- Será ORD-004

-- Insertamos los detalles de la orden. 
-- Pasamos precio_unitario en NULL para que el trigger lo asigne y calcule el subtotal.
INSERT INTO historial_orden (folio_orden, id_producto, cantidad) VALUES
-- Orden 1 (Mesero 1)
('ORD-001', 2, 2), -- 2 Enchiladas (ID 2)
('ORD-001', 4, 2), -- 2 Aguas (ID 4)
-- Orden 2 (Mesera 4)
('ORD-002', 1, 1), -- 1 Guacamole (ID 1)
('ORD-002', 3, 2), -- 2 Órdenes de tacos (ID 3)
('ORD-002', 5, 3), -- 3 Refrescos (ID 5)
-- Orden 3 (Mesero 1)
('ORD-003', 2, 1), -- 1 Enchiladas (ID 2)
('ORD-003', 9, 1), -- 1 Café de Olla (ID 9)
('ORD-003', 6, 1), -- 1 Flan (ID 6)
('ORD-003', 8, 1), -- 1 Churros (ID 8)
-- Orden 4 (Mesera 4)
('ORD-004', 1, 2), -- 2 Guacamoles (ID 1)
('ORD-004', 5, 2), -- 2 Refrescos (ID 5)
('ORD-004', 7, 2); -- 2 Pasteles (ID 7)

-- Insertamos facturas vinculadas a órdenes específicas
INSERT INTO factura (folio_orden, rfc_cliente) VALUES
('ORD-001', 'GOML900101QWE'),
('ORD-003', 'SALS880712MNB');