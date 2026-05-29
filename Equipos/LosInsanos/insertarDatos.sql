/* 
    Inserción de datos de prueba (10 registros aproximados por tabla)
    Fecha: 28/05/2026
*/

-- Tabla Empleado
INSERT INTO EMPLEADO (numero_empleado, rfc_emp, nombre_emp, apellido_paterno_emp, apellido_materno_emp, fecha_nacimiento_emp, edad, sueldo, foto, estado_emp, codigo_postal_emp, colonia_emp, calle_emp, numero_emp, es_cocinero, es_administrativo, es_mesero) VALUES
(1000000001, 'PAAF050802XYZ', 'Fernando', 'Palacio', 'Amandi', '2005-08-02', 20, 19000.00, 'fer_palacio.png', 'CDMX', 04360, 'Pedregal de Sto Domingo', 'Copilco', '123', true, false, false),
(1000000002, 'VARE880410HJK', 'Eduardo', 'Vargas', 'Ríos', '1988-04-10', 38, 17500.00, 'eduardo_v.png', 'CDMX', 04510, 'Copilco Universidad', 'Cerro del Agua', '102', true, false, false),
(1000000003, 'MORC931201MN3', 'Claudia', 'Morales', 'Cruz', '1993-12-01', 32, 16800.00, 'claudia_m.png', 'EdoMex', 54000, 'Centro', 'Hidalgo', '14', true, false, false),
(1000000004, 'GARM981115ABC', 'Mariana', 'García', 'Rojas', '1998-11-15', 27, 11000.00, 'mariana_g.png', 'CDMX', 04510, 'Copilco Universidad', 'Anacahuita', '9', false, false, true),
(1000000005, 'JIMR950620AA1', 'Ricardo', 'Jiménez', 'Mendoza', '1995-06-20', 30, 11000.00, 'ricardo_j.png', 'CDMX', 04360, 'Pedregal de Sto Domingo', 'Eje 10', '550', false, false, true),
(1000000006, 'SANF010310TR9', 'Fernanda', 'Sánchez', 'Fuentes', '2001-03-10', 25, 10500.00, 'fer_sanchez.png', 'CDMX', 01000, 'San Ángel', 'Revolución', '45', false, false, true),
(1000000007, 'ALVA990922KL2', 'Alejandro', 'Alvarez', 'Ortiz', '1999-09-22', 26, 10500.00, 'alex_a.png', 'CDMX', 03100, 'Del Valle', 'Patriotismo', '721', false, false, true),
(1000000008, 'LOMJ900228HJK', 'Juan', 'López', 'Martínez', '1990-02-28', 36, 24000.00, 'juan_l.png', 'CDMX', 01000, 'San Ángel', 'Insurgentes Sur', '1800', false, true, false),
(1000000009, 'CAST840714LL5', 'Laura', 'Castro', 'Bello', '1984-07-14', 41, 21000.00, 'laura_c.png', 'CDMX', 04000, 'Coyoacán', 'Pacífico', '90', false, true, false),
(1000000010, 'REYG920511MN8', 'Gabriel', 'Reyes', 'Gutiérrez', '1992-05-11', 34, 19500.00, 'gabriel_r.png', 'EdoMex', 53000, 'Satélite', 'Colina', '310', false, true, false),
(1000000011, 'SAMP940312HJK', 'Pedro', 'Samperio', 'Ortiz', '1994-03-12', 32, 17200.00, 'pedro_s.png', 'CDMX', 04340, 'Romero de Terreros', 'Cerro del Hombre', '84', true, false, false),
(1000000012, 'GOLM021124AA2', 'Marta', 'Gómez', 'Luna', '2002-11-24', 23, 10500.00, 'marta_g.png', 'CDMX', 04510, 'Copilco Universidad', 'Filosofía y Letras', '12', false, false, true),
(1000000013, 'VAAL000519XYZ', 'Luis', 'Valenzuela', 'Álvarez', '2000-05-19', 26, 11000.00, 'luis_v.png', 'EdoMex', 54000, 'Centro', 'Morelos', '201', false, false, true),
(1000000014, 'MEJD870108MN9', 'Daniela', 'Mejía', 'Díaz', '1987-01-08', 39, 25000.00, 'daniela_m.png', 'CDMX', 01000, 'San Ángel', 'Avenida Paz', '5', false, true, false),
(1000000015, 'CHIR910830KL4', 'Roberto', 'Chávez', 'Islas', '1991-08-30', 34, 16500.00, 'roberto_c.png', 'CDMX', 04000, 'Coyoacán Centro', 'Malintzin', '112', true, false, false),
(1000000016, 'FUEM960214TR0', 'Mauricio', 'Fuentes', 'Mora', '1996-02-14', 30, 10500.00, 'mauri_f.png', 'CDMX', 03100, 'Del Valle', 'Amores', '915', false, false, true),
(1000000017, 'NAVY891005AB1', 'Yolanda', 'Navarro', 'Vega', '1989-10-05', 36, 19000.00, 'yola_n.png', 'CDMX', 06000, 'Centro Histórico', '5 de Mayo', '40', false, true, false);

-- Tabla Empleado_Telefono
INSERT INTO EMPLEADO_TELEFONO (id_telefono, telefono, numero_empleado) VALUES
('TEL-01', '5512345678', 1000000001),
('TEL-02', '5598765432', 1000000002),
('TEL-03', '5545678901', 1000000003),
('TEL-04', '5532109876', 1000000004),
('TEL-18', '5511223344', 1000000004), 
('TEL-05', '5576543210', 1000000005),
('TEL-06', '5589012345', 1000000006),
('TEL-07', '5565432109', 1000000007),
('TEL-08', '5523456789', 1000000008),
('TEL-19', '5555667788', 1000000008),
('TEL-20', '5599887766', 1000000008),
('TEL-09', '5501234567', 1000000009),
('TEL-10', '5578901234', 1000000010),
('TEL-11', '5534567890', 1000000011),
('TEL-12', '5545678901', 1000000012),
('TEL-21', '5544332211', 1000000012),
('TEL-13', '5556789012', 1000000013),
('TEL-14', '5567890123', 1000000014),
('TEL-15', '5578901234', 1000000015),
('TEL-16', '5589012345', 1000000016),
('TEL-17', '5590123456', 1000000017);

-- Tabla Dependiente
INSERT INTO DEPENDIENTE (curp, numero_empleado, nombre_dep, apellido_paterno_dep, apellido_materno_dep) VALUES
('PAAF750418HDFLLL', 1000000001, 'Alberto', 'Palacio', 'Gómez'),
('VARM150210HDFRR', 1000000002, 'Mateo', 'Vargas', 'Marín'),
('MORL180905MDFSS', 1000000003, 'Luisa', 'Morales', NULL),
('GARR200112HDFNN', 1000000004, 'René', 'García', 'Rojas'),
('JIMS190623HDFZZ', 1000000005, 'Santiago', 'Jiménez', 'Suárez'),
('SANM221102MDFXX', 1000000006, 'Mía', 'Sánchez', 'Fuentes'),
('ALVD140719HDFCC', 1000000007, 'Daniel', 'Alvarez', 'Díaz'),
('LOMF160314MDFGG', 1000000008, 'Flavia', 'López', 'Martínez'),
('CASH120528HDFHH', 1000000009, 'Hugo', 'Castro', 'Bello'),
('REYA170830MDFJJ', 1000000010, 'Andrea', 'Reyes', 'Gutiérrez'),
('SAMP210515HDFLLA', 1000000011, 'Kevin', 'Samperio', 'Lara'),
('CHIA191201MDFBBR', 1000000015, 'Alicia', 'Chávez', 'Bustos');

-- Tabla Cocinero
INSERT INTO COCINERO (numero_empleado, especialidad) VALUES
(1000000001, 'Gastronomía Japonesa'),
(1000000002, 'Sushis y Teppanyaki'),
(1000000003, 'Sopas y Caldos'),
(1000000011, 'Tempura y Frituras'),
(1000000015, 'Cortes y Teppanyaki');

-- Tabla Mesero
INSERT INTO MESERO (numero_empleado, turno) VALUES
(1000000004, 'Matutino'),
(1000000005, 'Vespertino'),
(1000000006, 'Matutino'),
(1000000007, 'Vespertino'),
(1000000012, 'Vespertino'),
(1000000013, 'Nocturno'),
(1000000016, 'Nocturno');

--Tabla Administrativo
INSERT INTO ADMINISTRATIVO (numero_empleado, rol) VALUES
(1000000008, 'Gerente de Sucursal'),
(1000000009, 'Contador General'),
(1000000010, 'Supervisor de Operaciones'),
(1000000014, 'Recursos Humanos'),
(1000000017, 'Auditor Interno');

-- Tabla Categoria
INSERT INTO CATEGORIA (id_categoria, nombre_categoria, descripcion_categoria) VALUES
('CAT-01', 'Bebidas', 'Bebidas tradicionales japonesas'),
('CAT-02', 'Platillos Fuertes', 'Especialidades culinarias y platos fuertes'),
('CAT-03', 'Postres', 'Dulces, repostería y postres tradicionales');

-- Tabla Producto
INSERT INTO PRODUCTO (id_producto, nombre_producto, disponibilidad, precio, receta, descripcion_producto, id_categoria) VALUES
('PROD-01', 'Té Verde Matcha', 'S', 45.00, 'Matcha ceremonial, agua caliente', 'Delicioso té verde japonés', 'CAT-01'),
('PROD-02', 'Ramen de Shoyu', 'S', 140.00, 'Caldo de pollo, fideos, cerdo chashu, huevo', 'Sopa de fideos tradicional', 'CAT-02'),
('PROD-03', 'Mochi de Fresa', 'S', 55.00, 'Masa de arroz aglutinado, relleno de fresa', 'Postre dulce tradicional', 'CAT-03'),
('PROD-04', 'Sake Caliente', 'S', 95.00, 'Arroz fermentado servido a 40 grados', 'Bebida alcohólica tradicional', 'CAT-01'),
('PROD-05', 'Katsudon', 'S', 150.00, 'Arroz, chuleta de cerdo empanizada, huevo, cebolla', 'Tazón de arroz con chuleta', 'CAT-02'),
('PROD-06', 'Calpico Natural', 'S', 40.00, 'Agua, concentrado de Calpico, hielo', 'Bebida refrescante láctica', 'CAT-01'),
('PROD-07', 'Takoyaki', 'S', 85.00, 'Harina, pulpo, jengibre marinado, salsa takoyaki', 'Bolitas de masa rellenas de pulpo', 'CAT-02'),
('PROD-08', 'Dorayaki', 'S', 50.00, 'Panqueque tierno relleno de anko (alubia dulce)', 'Postre favorito de Doraemon', 'CAT-03'),
('PROD-09', 'Yakitori de Pollo', 'S', 75.00, 'Brochetas de pollo, salsa tare, cebollín', 'Brochetas a la parrilla (3 piezas)', 'CAT-02'),
('PROD-10', 'Helado de Matcha', 'S', 48.00, 'Base de helado artesanal, matcha premium', 'Helado cremoso de té verde', 'CAT-03');

-- Tabla Cliente
INSERT INTO CLIENTE (rfc_cliente, email, nombre_cl, apellido_paterno_cl, apellido_materno_cl, razon_social, fecha_nacimiento_cl, estado_cl, codigo_postal_cl, colonia_cl, calle_cl, numero_cl) VALUES
('XAXX010101000', 'publico@general.com', 'Público', 'General', NULL, 'Público General', NULL, NULL, NULL, NULL, NULL, NULL),
('GOMA850315HJK', 'ana.gomez@mail.com', 'Ana', 'Gómez', 'Martínez', NULL, '1985-03-15', 'CDMX', 04360, 'Pedregal de Sto Domingo', 'Copilco', '45'),
('RODR921020XYZ', 'roberto.diaz@mail.com', 'Roberto', 'Díaz', 'Rodríguez', 'Díaz Consultores S.A.', '1992-10-20', 'CDMX', 04510, 'Copilco Universidad', 'Cerro del Agua', '12'),
('HELM990105ABC', 'maria.hernandez@mail.com', 'María', 'Hernández', 'López', NULL, '1999-01-05', 'EdoMex', 54000, 'Centro', 'Av. Juárez', '204'),
('PERF900712UVW', 'francisco.perez@mail.com', 'Francisco', 'Pérez', 'Flores', NULL, '1990-07-12', 'CDMX', 01000, 'San Ángel', 'Altavista', '8'),
('SANL960824TR1', 'lucia.sanchez@mail.com', 'Lucía', 'Sánchez', 'Nieto', 'Comercializadora SAN S.A.', '1996-08-24', 'CDMX', 03100, 'Del Valle', 'Insurgentes Sur', '1420'),
('TORJ881130MN4', 'jorge.torres@mail.com', 'Jorge', 'Torres', 'Valdez', NULL, '1988-11-30', 'CDMX', 04000, 'Coyoacán Centro', 'Hidalgo', '57'),
('RAME930514LL9', 'elena.ramirez@mail.com', 'Elena', 'Ramírez', 'Castro', NULL, '1993-05-14', 'EdoMex', 53000, 'Satélite', 'Circuito Historiadores', '11'),
('CAST820402KLO', 'tomas.castro@mail.com', 'Tomás', 'Castro', 'Ruiz', 'Restaurantera Altiplano', '1982-04-02', 'CDMX', 06000, 'Centro Histórico', 'Madero', '88'),
('VALS011218AA3', 'sofia.valdez@mail.com', 'Sofía', 'Valdez', 'Suárez', NULL, '2001-12-18', 'CDMX', 04340, 'Romero de Terreros', 'Fresnos', '29'),
('ALMM871102JK3', 'miguel.almonte@mail.com', 'Miguel', 'Almonte', 'Solís', NULL, '1987-11-02', 'CDMX', 04360, 'Pedregal de Sto Domingo', 'Anacahuita', '10'),
('BAEP950125AA9', 'patricia.baez@mail.com', 'Patricia', 'Báez', 'Peña', 'Consultoría Báez SC', '1995-01-25', 'CDMX', 04510, 'Copilco Universidad', 'Edzná', '4'),
('Cajg020614XYZ', 'gabriel.castro@mail.com', 'Gabriel', 'Castro', 'Jiménez', NULL, '2002-06-14', 'EdoMex', 54000, 'Centro', 'Zaragoza', '404'),
('DIAM910909LL2', 'monica.diaz@mail.com', 'Mónica', 'Díaz', 'Vargas', NULL, '1991-09-09', 'CDMX', 01000, 'San Ángel', 'Frontera', '11'),
('ESCO840520MN6', 'oscar.escalante@mail.com', 'Óscar', 'Escalante', 'Tello', 'Sistemas Escalante SA', '1984-05-20', 'CDMX', 03100, 'Del Valle', 'Gabriel Mancera', '512');

-- Tabla Orden
INSERT INTO ORDEN (folio, fecha_hora, total_pagar, rfc_cliente, numero_empleado) VALUES
('ORD-001', '2026-05-01 12:30:00', 335.00, 'GOMA850315HJK', 1000000004),
('ORD-002', '2026-05-03 15:45:00', 45.00,  'XAXX010101000', 1000000004),
('ORD-003', '2026-05-06 19:20:00', 198.00, 'RODR921020XYZ', 1000000005),
('ORD-004', '2026-05-10 14:10:00', 235.00, 'HELM990105ABC', 1000000005),
('ORD-005', '2026-05-12 13:15:00', 135.00, 'PERF900712UVW', 1000000006),
('ORD-006', '2026-05-15 21:00:00', 300.00, 'SANL960824TR1', 1000000006),
('ORD-007', '2026-05-18 16:35:00', 170.00, 'TORJ881130MN4', 1000000007),
('ORD-008', '2026-05-22 11:50:00', 200.00, 'RAME930514LL9', 1000000007),
('ORD-009', '2026-05-25 18:25:00', 98.00,  'CAST820402KLO', 1000000004),
('ORD-010', '2026-05-28 14:40:00', 225.00, 'VALS011218AA3', 1000000005),
('ORD-011', '2026-05-05 14:20:00', 125.00, 'ALMM871102JK3', 1000000012),
('ORD-012', '2026-05-08 20:15:00', 290.00, 'BAEP950125AA9', 1000000013),
('ORD-013', '2026-05-11 13:40:00', 45.00,  'XAXX010101000', 1000000012),
('ORD-014', '2026-05-14 19:10:00', 440.00, 'Cajg020614XYZ', 1000000013),
('ORD-015', '2026-05-17 15:30:00', 135.00, 'DIAM910909LL2', 1000000016),
('ORD-016', '2026-05-20 21:45:00', 190.00, 'ESCO840520MN6', 1000000016),
('ORD-017', '2026-05-22 14:00:00', 280.00, 'GOMA850315HJK', 1000000004),
('ORD-018', '2026-05-24 16:22:00', 96.00,  'RODR921020XYZ', 1000000012),
('ORD-019', '2026-05-26 20:10:00', 225.00, 'XAXX010101000', 1000000013),
('ORD-020', '2026-05-28 11:15:00', 375.00, 'HELM990105ABC', 1000000016);

--Tabla Orden_Producto
INSERT INTO ORDEN_PRODUCTO (folio, id_producto, total_por_producto, cantidad_producto) VALUES
('ORD-001', 'PROD-02', 280.00, 2),
('ORD-001', 'PROD-03', 55.00,  1),
('ORD-002', 'PROD-01', 45.00,  1),
('ORD-003', 'PROD-05', 150.00, 1),
('ORD-003', 'PROD-10', 48.00,  1),
('ORD-004', 'PROD-02', 140.00, 1),
('ORD-004', 'PROD-04', 95.00,  1),
('ORD-005', 'PROD-06', 50.00,  1),
('ORD-006', 'PROD-05', 300.00, 2),
('ORD-010', 'PROD-07', 170.00, 2),
('ORD-011', 'PROD-09', 75.00,  1),
('ORD-011', 'PROD-08', 50.00,  1),
('ORD-012', 'PROD-04', 190.00, 2),
('ORD-012', 'PROD-10', 100.00, 2),
('ORD-013', 'PROD-01', 45.00,  1),
('ORD-014', 'PROD-02', 280.00, 2),
('ORD-014', 'PROD-07', 160.00, 2),
('ORD-015', 'PROD-04', 95.00,  1),
('ORD-015', 'PROD-06', 40.00,  1),
('ORD-016', 'PROD-04', 190.00, 2),
('ORD-017', 'PROD-02', 280.00, 2),
('ORD-018', 'PROD-10', 96.00,  2),
('ORD-019', 'PROD-05', 150.00, 1),
('ORD-019', 'PROD-09', 75.00,  1),
('ORD-020', 'PROD-02', 280.00, 2),
('ORD-020', 'PROD-04', 95.00,  1);