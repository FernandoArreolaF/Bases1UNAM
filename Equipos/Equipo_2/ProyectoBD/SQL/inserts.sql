/*
 * Script de inserción de datos para la base de datos de la Mueblería
 *
 * Este script inserta datos de ejemplo para todas las tablas, respetando
 * sus relaciones y restricciones definidas en el esquema.
 */


-- ----------------------------------------------------------
-- CATEGORÍAS DE PRODUCTOS
-- ----------------------------------------------------------
INSERT INTO public."CATEGORIA" (nombre_categoria) VALUES
('Salas'),
('Comedores'),
('Recámaras'),
('Oficina'),
('Decoración'),
('Cocina'),
('Exterior'),
('Iluminación');


-- ----------------------------------------------------------
-- SUCURSALES DE LA MUEBLERÍA
-- ----------------------------------------------------------
INSERT INTO public."SUCURSAL" (estado, numero, codigo_postal, colonia, calle, telefono_sucursal, anio_fundacion) VALUES
('Ciudad de México', '123', '04100', 'Del Valle', 'Insurgentes Sur', '5512345678', 2010),
('Jalisco', '456', '44100', 'Centro', 'Av. Juárez', '3339876543', 2012),
('Nuevo León', '789', '64000', 'Monterrey Centro', 'Constitución', '8183456789', 2015),
('Puebla', '234', '72000', 'Centro Histórico', 'Reforma', '2225678901', 2018),
('Querétaro', '567', '76000', 'Centro', 'Corregidora', '4421234567', 2020);


-- ----------------------------------------------------------
-- CLIENTES REGISTRADOS
-- ----------------------------------------------------------
INSERT INTO public."CLIENTE" (rfc_cliente, nombre, apellido_paterno, apellido_materno, razon_social_cliente, email_cliente, telefono_cliente, estado, calle, codigo_postal, numero, colonia) VALUES
('ROHM800213A45', 'María', 'Rodríguez', 'Hernández', 'María Rodríguez Hernández', 'maria.rodriguez@email.com', '5523456789', 'Ciudad de México', 'Insurgentes', '04100', '123', 'Roma Norte'),
('GALJ790528B67', 'Juan', 'García', 'López', 'Juan García López', 'juan.garcia@email.com', '5534567890', 'Ciudad de México', 'Reforma', '06500', '456', 'Juárez'),
('PEMF850712C89', 'Francisco', 'Pérez', 'Mendoza', 'Francisco Pérez Mendoza', 'francisco.perez@email.com', '3345678901', 'Jalisco', 'Hidalgo', '44100', '789', 'Centro'),
('SAMR900325D01', 'Rosa', 'Sánchez', 'Martínez', 'Rosa Sánchez Martínez', 'rosa.sanchez@email.com', '8156789012', 'Nuevo León', 'Morelos', '64000', '321', 'San Pedro'),
('LOMC880713E23', 'Carlos', 'López', 'Morales', 'Carlos López Morales', 'carlos.lopez@email.com', '2267890123', 'Puebla', 'Juárez', '72000', '654', 'La Paz'),
('GOMV910502F45', 'Verónica', 'González', 'Muñoz', 'Verónica González Muñoz', 'veronica.gonzalez@email.com', '4478901234', 'Querétaro', 'Zaragoza', '76000', '987', 'Centro');


-- ----------------------------------------------------------
-- PROVEEDORES DE MUEBLES Y ARTÍCULOS
-- ----------------------------------------------------------
INSERT INTO public."PROVEEDOR" (rfc, razon_social, telefono, cuenta_pago, colonia, codigo_postal, estado, calle, numero) VALUES
('MUEBLES001MX123456789', 'Muebles Finos S.A. de C.V.', '5545678901', '123456789012345678', 'Industrial Vallejo', '02300', 'Ciudad de México', 'Norte 45', '1023'),
('DECORART002QR234567890', 'Decoraciones Artísticas S.A.', '4456789012', '234567890123456789', 'La Cañada', '76900', 'Querétaro', 'Nogal', '322'),
('ILUMINA003GD345678901', 'Iluminaciones Modernas S.A.', '3367890123', '345678901234567890', 'Tlajomulco', '45640', 'Jalisco', 'Industria', '456'),
('MADFIN004NL456789012', 'Maderas Finas del Norte S.A.', '8178901234', '456789012345678901', 'La Fe', '67117', 'Nuevo León', 'Nogal', '789'),
('TEXTIL005PU567890123', 'Textiles del Sureste S.A.', '2289012345', '567890123456789012', 'Oriente', '72000', 'Puebla', 'Industria', '123');


-- ----------------------------------------------------------
-- ARTÍCULOS DISPONIBLES EN INVENTARIO
-- ----------------------------------------------------------
INSERT INTO public."ARTICULO" (codigo_de_barras, nombre_articulo, fotografia, precio_de_venta, precio_de_compra, stock, "id_categoria_CATEGORIA") VALUES
('ABC123456789', 'Sofá Tres Plazas Milano', 'sofa_milano.jpg', 15990.00, 9590.00, 10, 1),
('DEF234567890', 'Mesa de Comedor Extensible Viena', 'mesa_viena.jpg', 12499.00, 7499.00, 8, 2),
('GHI345678901', 'Cama King Size Barcelona', 'cama_barcelona.jpg', 18900.00, 11340.00, 5, 3),
('JKL456789012', 'Escritorio Ejecutivo Oxford', 'escritorio_oxford.jpg', 8499.00, 5099.00, 12, 4),
('MNO567890123', 'Lámpara de Pie Moderna', 'lampara_pie.jpg', 2950.00, 1770.00, 20, 8),
('PQR678901234', 'Sillón Reclinable Roma', 'sillon_roma.jpg', 7990.00, 4790.00, 15, 1),
('STU789012345', 'Comedor 6 Sillas Toledo', 'comedor_toledo.jpg', 14990.00, 8990.00, 6, 2),
('VWX890123456', 'Buró Minimalista Blanco', 'buro_blanco.jpg', 3499.00, 2099.00, 25, 3),
('YZA901234567', 'Estantería 5 Niveles Industrial', 'estanteria_industrial.jpg', 4299.00, 2579.00, 18, 4),
('BCD012345678', 'Juego de Jardín 4 Piezas', 'jardin_4piezas.jpg', 9990.00, 5990.00, 7, 7);


-- ----------------------------------------------------------
-- EMPLEADOS (TABLA PADRE)
-- ----------------------------------------------------------
-- Primero insertamos todos los empleados en la tabla padre

-- Empleados que serán VENDEDORES
INSERT INTO public."EMPLEADO" (rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor) VALUES
('GALA850103A23', 'GALA850103MDFRRN09', 'ana.garcia@muebleria.com', '2019-03-15', '04100', 'Ciudad de México', 'Insurgentes', 'Del Valle', '123', 1, NULL),
('ROHC880528B45', 'ROHC880528HDFDRR01', 'carlos.rodriguez@muebleria.com', '2020-05-20', '44100', 'Jalisco', 'Juárez', 'Centro', '456', 2, 1),
('PEMJ910712C67', 'PEMJ910712HDFTRN03', 'jose.perez@muebleria.com', '2021-01-10', '64000', 'Nuevo León', 'Constitución', 'Monterrey Centro', '789', 3, 1);

-- Empleados que serán CAJEROS
INSERT INTO public."EMPLEADO" (rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor) VALUES
('SAML750325D89', 'SAML750325MDFNCR04', 'laura.sanchez@muebleria.com', '2018-11-05', '04100', 'Ciudad de México', 'Patricio Sanz', 'Del Valle', '222', 1, 1),
('LOMP870713E01', 'LOMP870713HDFPDR05', 'pedro.lopez@muebleria.com', '2019-07-22', '44100', 'Jalisco', 'Libertad', 'Centro', '333', 2, 2),
('GOMM900502F23', 'GOMM900502MDFNRR06', 'maria.gonzalez@muebleria.com', '2020-03-14', '64000', 'Nuevo León', 'Matamoros', 'Monterrey Centro', '444', 3, 3);

-- Empleados que serán ADMINISTRATIVOS
INSERT INTO public."EMPLEADO" (rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor) VALUES
('DIAT800617G45', 'DIAT800617HDFZRM07', 'tomas.diaz@muebleria.com', '2017-06-30', '04100', 'Ciudad de México', 'Félix Cuevas', 'Del Valle', '555', 1, NULL),
('FLOR820908H67', 'FLOR820908MDFLJC08', 'rocio.flores@muebleria.com', '2018-02-15', '44100', 'Jalisco', 'Pedro Moreno', 'Centro', '666', 2, 7);

-- Empleados que serán SEGURIDAD
INSERT INTO public."EMPLEADO" (rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor) VALUES
('VARJ780314I89', 'VARJ780314HDFRMS09', 'jesus.vargas@muebleria.com', '2019-04-05', '04100', 'Ciudad de México', 'Gabriel Mancera', 'Del Valle', '777', 1, 7),
('TORR810625J01', 'TORR810625MDFRRB10', 'roberto.torres@muebleria.com', '2020-08-12', '44100', 'Jalisco', 'Colón', 'Centro', '888', 2, 8);

-- Empleados que serán LIMPIEZA
INSERT INTO public."EMPLEADO" (rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor) VALUES
('RAMC830907K23', 'RAMC830907HDFMRS11', 'cristina.ramirez@muebleria.com', '2018-05-20', '04100', 'Ciudad de México', 'División del Norte', 'Del Valle', '999', 1, 9),
('HERJ950318L45', 'HERJ950318HDFRMN12', 'juan.hernandez@muebleria.com', '2019-09-10', '44100', 'Jalisco', 'Morelos', 'Centro', '111', 2, 10);


-- ----------------------------------------------------------
-- TABLAS HIJAS DE EMPLEADOS (ESPECIALIZACIÓN)
-- ----------------------------------------------------------

-- VENDEDORES
INSERT INTO public."VENDEDOR" (numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor)
SELECT numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor
FROM public."EMPLEADO"
WHERE numero_empleado IN (1, 2, 3);

-- CAJEROS
INSERT INTO public."CAJERO" (numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor)
SELECT numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor
FROM public."EMPLEADO"
WHERE numero_empleado IN (4, 5, 6);

-- ADMINISTRATIVOS
INSERT INTO public."ADMINISTRATIVO" (numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor)
SELECT numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor
FROM public."EMPLEADO"
WHERE numero_empleado IN (7, 8);

-- SEGURIDAD
INSERT INTO public."SEGURIDAD" (numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor)
SELECT numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor
FROM public."EMPLEADO"
WHERE numero_empleado IN (9, 10);

-- LIMPIEZA
INSERT INTO public."LIMPIEZA" (numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor)
SELECT numero_empleado, rfc_empleado, curp, email_empleado, fecha_ingreso, codigo_postal, estado, calle, colonia, numero, "id_sucursal_SUCURSAL", numero_supervisor
FROM public."EMPLEADO"
WHERE numero_empleado IN (11, 12);


-- ----------------------------------------------------------
-- TELÉFONOS DE EMPLEADOS (ANTES DE ELIMINAR DE LA TABLA PADRE)
-- ----------------------------------------------------------
INSERT INTO public."TELEFONO_EMPLEADO" (telefono_empleado, "numero_empleado_EMPLEADO") VALUES
('5523456789', 1),
('5534567890', 1), -- El empleado 1 tiene dos teléfonos
('3345678901', 2),
('8156789012', 3),
('2267890123', 4),
('4478901234', 5),
('5545678901', 6),
('4456789012', 7),
('3367890123', 8),
('8178901234', 9),
('2289012345', 10),
('5523457890', 11),
('5534568901', 12);


-- ----------------------------------------------------------
-- ELIMINACIÓN DE REGISTROS DUPLICADOS (DESPUÉS DE INSERTAR TELÉFONOS)
-- ----------------------------------------------------------
-- Eliminamos los registros de la tabla padre que ya están en las tablas hijas
-- para mantener la restricción de exclusión (un empleado solo puede ser de un tipo)
DELETE FROM ONLY public."EMPLEADO" WHERE numero_empleado IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);


-- ----------------------------------------------------------
-- RELACIÓN ENTRE ARTÍCULOS Y PROVEEDORES
-- ----------------------------------------------------------
INSERT INTO public."ES_SURTIDO" (fecha_surtido_cada_articulo, "codigo_de_barras_ARTICULO", "rfc_PROVEEDOR") VALUES
('2025-03-10', 'ABC123456789', 'MUEBLES001MX123456789'),
('2025-03-15', 'DEF234567890', 'MUEBLES001MX123456789'),
('2025-03-12', 'GHI345678901', 'MADFIN004NL456789012'),
('2025-03-20', 'JKL456789012', 'DECORART002QR234567890'),
('2025-03-18', 'MNO567890123', 'ILUMINA003GD345678901'),
('2025-03-14', 'PQR678901234', 'MUEBLES001MX123456789'),
('2025-03-22', 'STU789012345', 'MUEBLES001MX123456789'),
('2025-03-25', 'VWX890123456', 'MADFIN004NL456789012'),
('2025-03-16', 'YZA901234567', 'DECORART002QR234567890'),
('2025-03-28', 'BCD012345678', 'MUEBLES001MX123456789'),
-- Algunos artículos tienen múltiples proveedores
('2025-03-10', 'ABC123456789', 'TEXTIL005PU567890123'),
('2025-03-15', 'DEF234567890', 'MADFIN004NL456789012'),
('2025-03-12', 'GHI345678901', 'DECORART002QR234567890');


-- ----------------------------------------------------------
-- REGISTRO DE VENTAS
-- ----------------------------------------------------------
INSERT INTO public."VENTA" (folio, fecha_venta, monto_total, cantidad_total_articulo, "id_sucursal_SUCURSAL", "rfc_cliente_CLIENTE", "numero_empleado_VENDEDOR", "numero_empleado_CAJERO") VALUES
('MBL-001', '2025-04-15 10:30:00', 15990.00, 1, 1, 'ROHM800213A45', 1, 4),
('MBL-002', '2025-04-15 14:45:00', 24998.00, 2, 1, 'GALJ790528B67', 1, 4),
('MBL-003', '2025-04-16 11:20:00', 18900.00, 1, 2, 'PEMF850712C89', 2, 5),
('MBL-004', '2025-04-16 16:50:00', 8499.00, 1, 2, 'SAMR900325D01', 2, 5),
('MBL-005', '2025-04-17 09:15:00', 11489.00, 2, 3, 'LOMC880713E23', 3, 6),
('MBL-006', '2025-04-17 13:40:00', 9990.00, 1, 1, 'GOMV910502F45', 1, 4),
('MBL-007', '2025-04-18 15:25:00', 21980.00, 3, 2, 'ROHM800213A45', 2, 5);


-- ----------------------------------------------------------
-- DETALLES DE LAS VENTAS (ARTÍCULOS VENDIDOS)
-- ----------------------------------------------------------
INSERT INTO public."DETALLE_VENTA" (cantidad_por_articulo, monto_por_articulo, "codigo_de_barras_ARTICULO", "folio_VENTA") VALUES
(1, 15990.00, 'ABC123456789', 'MBL-001'),
(1, 12499.00, 'DEF234567890', 'MBL-002'),
(1, 18900.00, 'GHI345678901', 'MBL-003'),
(1, 8499.00, 'JKL456789012', 'MBL-004'),
(1, 2950.00, 'MNO567890123', 'MBL-005'),
(1, 9990.00, 'BCD012345678', 'MBL-006'),
(2, 6999.00, 'VWX890123456', 'MBL-007');

-- ----------------------------------------------------------
-- FACTURAS EMITIDAS
-- ----------------------------------------------------------
INSERT INTO public."FACTURA" ("rfc_cliente_CLIENTE", "folio_VENTA") VALUES
('ROHM800213A45', 'MBL-001'),
('GALJ790528B67', 'MBL-002'),
('PEMF850712C89', 'MBL-003'),
('SAMR900325D01', 'MBL-004'),
('LOMC880713E23', 'MBL-005');

-- ----------------------------------------------------------
-- ACTUALIZACION DE DATOS
-- ----------------------------------------------------------
-- 1) Se actualiza nombres y apellidos paternos para cada empleado (apellido_materno queda NULL)
UPDATE public."EMPLEADO" SET nombre = 'Ana',    apellido_paterno = 'García'   WHERE rfc_empleado = 'GALA850103A23';
UPDATE public."EMPLEADO" SET nombre = 'Carlos', apellido_paterno = 'Rodríguez' WHERE rfc_empleado = 'ROHC880528B45';
UPDATE public."EMPLEADO" SET nombre = 'José',   apellido_paterno = 'Pérez'     WHERE rfc_empleado = 'PEMJ910712C67';

UPDATE public."EMPLEADO" SET nombre = 'Laura',  apellido_paterno = 'Sánchez'   WHERE rfc_empleado = 'SAML750325D89';
UPDATE public."EMPLEADO" SET nombre = 'Pedro',  apellido_paterno = 'López'     WHERE rfc_empleado = 'LOMP870713E01';
UPDATE public."EMPLEADO" SET nombre = 'María',  apellido_paterno = 'González'  WHERE rfc_empleado = 'GOMM900502F23';

UPDATE public."EMPLEADO" SET nombre = 'Tomás',  apellido_paterno = 'Díaz'      WHERE rfc_empleado = 'DIAT800617G45';
UPDATE public."EMPLEADO" SET nombre = 'Rocío',  apellido_paterno = 'Flores'    WHERE rfc_empleado = 'FLOR820908H67';

UPDATE public."EMPLEADO" SET nombre = 'Jesús',  apellido_paterno = 'Vargas'    WHERE rfc_empleado = 'VARJ780314I89';
UPDATE public."EMPLEADO" SET nombre = 'Roberto',apellido_paterno = 'Torres'    WHERE rfc_empleado = 'TORR810625J01';

UPDATE public."EMPLEADO" SET nombre = 'Cristina',apellido_paterno = 'Ramírez'  WHERE rfc_empleado = 'RAMC830907K23';
UPDATE public."EMPLEADO" SET nombre = 'Juan',   apellido_paterno = 'Hernández' WHERE rfc_empleado = 'HERJ950318L45';

-- 2) Se revisa que no queden NULL en nombre/apellido_paterno
SELECT * FROM public."EMPLEADO" WHERE nombre IS NULL OR apellido_paterno IS NULL;

-- 3) Se grega las restricciones NOT NULL
ALTER TABLE public."EMPLEADO"
  ALTER COLUMN nombre SET NOT NULL,
  ALTER COLUMN apellido_paterno SET NOT NULL;

-- ----------------------------------------------------------
-- FIN DEL SCRIPT
-- ----------------------------------------------------------