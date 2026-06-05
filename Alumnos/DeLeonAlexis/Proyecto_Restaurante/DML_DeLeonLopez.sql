--EMPLEADOS 
INSERT INTO empleado (rfc, nombre_pila, apellido_paterno, apellido_materno, fecha_nacimiento, estado, codigo_postal, colonia, calle, numero, sueldo) VALUES
-- Meseros (1-10)
('GOMP900101A1A', 'Pedro', 'Gómez', 'Pérez', '1990-01-01', 'CDMX', '06000', 'Centro', 'Madero', '10', 8000.00),
('MARL920202B2B', 'Luis', 'Martínez', 'López', '1992-02-02', 'CDMX', '06100', 'Roma Norte', 'Orizaba', '25', 8000.00),
('RODS950303C3C', 'Sofía', 'Rodríguez', 'Sánchez', '1995-03-03', 'EdoMex', '54000', 'Satélite', 'Circuito', '120', 8500.00),
('HERM980404D4D', 'Miguel', 'Hernández', 'Mendoza', '1998-04-04', 'CDMX', '04000', 'Coyoacán', 'Allende', '45', 8000.00),
('JUAC990505E5E', 'Carlos', 'Juárez', 'Cruz', '1999-05-05', 'CDMX', '03100', 'Del Valle', 'Insurgentes', '101', 8200.00),
('DIAV900606F6F', 'Valeria', 'Díaz', 'Vargas', '1990-06-06', 'CDMX', '06700', 'Condesa', 'Michoacán', '88', 8500.00),
('LOPE930707G7G', 'Elena', 'López', 'Estrada', '1993-07-07', 'EdoMex', '57000', 'Neza', 'Pantitlán', '2', 8000.00),
('GARC960808H8H', 'Ricardo', 'García', 'Ríos', '1996-08-08', 'CDMX', '14000', 'Tlalpan', 'San Fernando', '300', 8200.00),
('PERA990909I9I', 'Ana', 'Pérez', 'Aguilar', '1999-09-09', 'CDMX', '01000', 'San Ángel', 'Revolución', '405', 8000.00),
('SANC911010J0J', 'Jorge', 'Sánchez', 'Castro', '1991-10-10', 'EdoMex', '53000', 'Naucalpan', 'Lomas', '50', 8500.00),
-- Cocineros (11-20)
('VILL900111K1K', 'Daniel', 'Villanueva', 'Ruiz', '1990-11-11', 'CDMX', '06000', 'Centro', 'Donceles', '15', 12000.00),
('ORTJ920112L2L', 'José', 'Ortiz', 'Jiménez', '1992-12-12', 'CDMX', '06100', 'Roma Sur', 'Tonalá', '20', 12500.00),
('RIVE950113M3M', 'Raúl', 'Rivera', 'Navarro', '1995-01-13', 'EdoMex', '54000', 'Satélite', 'Azul', '10', 11000.00),
('FLOR980114N4N', 'María', 'Flores', 'Molina', '1998-02-14', 'CDMX', '04000', 'Coyoacán', 'Hidalgo', '60', 11500.00),
('CRUZ990115O5O', 'Fernanda', 'Cruz', 'Ortiz', '1999-03-15', 'CDMX', '03100', 'Del Valle', 'Amores', '75', 11000.00),
('REYE900116P6P', 'Héctor', 'Reyes', 'Silva', '1990-04-16', 'CDMX', '06700', 'Condesa', 'Tamaulipas', '90', 13000.00),
('MORP930117Q7Q', 'Patricia', 'Morales', 'Paz', '1993-05-17', 'EdoMex', '57000', 'Neza', 'Chimalhuacán', '5', 12000.00),
('AGUI960118R8R', 'Alejandro', 'Aguilar', 'Lara', '1996-06-18', 'CDMX', '14000', 'Tlalpan', 'Insurgentes', '500', 11500.00),
('CAST990119S9S', 'Mónica', 'Castillo', 'Vega', '1999-07-19', 'CDMX', '01000', 'San Ángel', 'Altavista', '10', 11000.00),
('GUTI910120T0T', 'David', 'Gutiérrez', 'Mora', '1991-08-20', 'EdoMex', '53000', 'Naucalpan', 'Verdes', '22', 12500.00),
-- Administrativos (21-30)
('RAMI850121U1U', 'Roberto', 'Ramírez', 'Luna', '1985-09-21', 'CDMX', '06000', 'Centro', 'Tacuba', '8', 18000.00),
('CORT860122V2V', 'Laura', 'Cortés', 'Rojas', '1986-10-22', 'CDMX', '06100', 'Roma Norte', 'Colima', '40', 15000.00),
('ESPI870123W3W', 'Andrés', 'Espinosa', 'Salas', '1987-11-23', 'EdoMex', '54000', 'Satélite', 'Oradores', '7', 16000.00),
('MEND880124X4X', 'Diana', 'Mendoza', 'Blanco', '1988-12-24', 'CDMX', '04000', 'Coyoacán', 'Tres Cruces', '15', 15500.00),
('VARR890125Y5Y', 'Arturo', 'Vargas', 'Romero', '1989-01-25', 'CDMX', '03100', 'Del Valle', 'Coyoacán', '33', 18000.00),
('ROJA900126Z6Z', 'Silvia', 'Rojas', 'Herrera', '1990-02-26', 'CDMX', '06700', 'Condesa', 'Nuevo León', '110', 17000.00),
('DELG910127A1A', 'Eduardo', 'Delgado', 'Pina', '1991-03-27', 'EdoMex', '57000', 'Neza', 'Bordo', '9', 15000.00),
('NAVA920128B2B', 'Carmen', 'Navarro', 'Soto', '1992-04-28', 'CDMX', '14000', 'Tlalpan', 'Viaducto', '210', 16500.00),
('FIGU930129C3C', 'Tomás', 'Figueroa', 'Guzmán', '1993-05-29', 'CDMX', '01000', 'San Ángel', 'Paz', '8', 15000.00),
('PENJ940130D4D', 'Beatriz', 'Peña', 'Juárez', '1994-06-30', 'EdoMex', '53000', 'Naucalpan', 'Florida', '14', 16000.00);


--Telefonos 
INSERT INTO empleado_telefono (num_empleado, telefono) VALUES
(1, '5511223344'), (2, '5522334455'), (3, '5533445566'), (4, '5544556677'), (5, '5555667788'),
(11, '5566778899'), (12, '5577889900'), (21, '5588990011'), (22, '5599001122'), (25, '5500112233');


--Subtipos
INSERT INTO mesero (num_empleado, horario) VALUES
(1, 'Matutino'), (2, 'Vespertino'), (3, 'Matutino'), (4, 'Vespertino'), (5, 'Fines de Semana'),
(6, 'Matutino'), (7, 'Vespertino'), (8, 'Nocturno'), (9, 'Matutino'), (10, 'Vespertino');

INSERT INTO cocinero (num_empleado, especialidad) VALUES
(11, 'Parrilla'), (12, 'Salsas y Guarniciones'), (13, 'Pescados y Mariscos'), (14, 'Postres'), (15, 'Entradas'),
(16, 'Parrilla'), (17, 'Panadería'), (18, 'Ensaladas'), (19, 'Comida Tradicional'), (20, 'Postres');

INSERT INTO administrativo (num_empleado, rol) VALUES
(21, 'Gerente General'), (22, 'Contador'), (23, 'Recursos Humanos'), (24, 'Auxiliar Administrativo'), (25, 'Jefe de Compras'),
(26, 'Gerente de Sucursal'), (27, 'Marketing'), (28, 'Auditor de Calidad'), (29, 'Asistente de Dirección'), (30, 'Recepcionista');


--Dependientes (Entidad debil)
INSERT INTO dependiente (num_empleado, curp, nombre_pila, apellido_paterno, apellido_materno, parentesco) VALUES
(1, 'GOMP120101HDFXXX01', 'Luisito', 'Gómez', 'Reyes', 'Hijo'), (2, 'MARL450202MDFXXX02', 'María', 'López', 'Martínez', 'Madre'),
(3, 'RODS150303HDFXXX03', 'Carlos', 'Rodríguez', 'Sánchez', 'Hijo'), (4, 'HERM180404MDFXXX04', 'Luz', 'Hernández', 'Mendoza', 'Hija'),
(11, 'VILL100111HDFXXX05', 'Danielito', 'Villanueva', 'Ruiz', 'Hijo'), (12, 'ORTJ500112MDFXXX06', 'Josefina', 'Jiménez', 'Ortiz', 'Madre'),
(21, 'RAMI150121HDFXXX07', 'Roberto Jr', 'Ramírez', 'Luna', 'Hijo'), (22, 'CORT160122MDFXXX08', 'Ana', 'Cortés', 'Rojas', 'Hija'),
(25, 'VARR170125HDFXXX09', 'Arturito', 'Vargas', 'Romero', 'Hijo'), (30, 'PENJ180130MDFXXX10', 'Camila', 'Peña', 'Juárez', 'Hija');


--Categoria y producto
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES
(1, 'Entradas', 'Platillos pequeños para comenzar'), (2, 'Sopas y Cremas', 'Caldos, sopas y cremas calientes'),
(3, 'Cortes de Carne', 'Carnes a la parrilla y cortes finos'), (4, 'Aves', 'Platillos preparados con pollo o pato'),
(5, 'Pescados y Mariscos', 'Productos frescos del mar'), (6, 'Tacos', 'Variedad de tacos tradicionales'),
(7, 'Ensaladas', 'Opciones frescas y saludables'), (8, 'Postres', 'Dulces y pasteles para terminar'),
(9, 'Bebidas sin Alcohol', 'Refrescos, aguas frescas y jugos'), (10, 'Bebidas con Alcohol', 'Cervezas, vinos y coctelería');

INSERT INTO producto (id_producto, nombre, descripcion, receta, precio, disponibilidad, id_categoria) VALUES
(1, 'Guacamole Tradicional', 'Aguacate machacado con pico de gallo', 'Aguacate, tomate, cebolla, chile serrano, limón, sal', 120.00, TRUE, 1),
(2, 'Queso Fundido', 'Queso manchego derretido con chorizo', 'Queso manchego, chorizo, tortillas de harina', 150.00, TRUE, 1),
(3, 'Sopa de Tortilla', 'Caldillo de tomate con julianas de tortilla frita', 'Caldo de pollo, tomate, tortilla, aguacate, crema, queso panela', 95.00, TRUE, 2),
(4, 'Rib Eye 400g', 'Corte jugoso a la parrilla', 'Rib eye de res, sal en grano, pimienta', 450.00, TRUE, 3),
(5, 'Pechuga a la Cordon Bleu', 'Pechuga empanizada rellena de jamón y queso', 'Pechuga de pollo, jamón, queso manchego, pan molido', 220.00, TRUE, 4),
(6, 'Salmón a las Finas Hierbas', 'Filete de salmón horneado', 'Salmón fresco, romero, tomillo, mantequilla', 320.00, TRUE, 5),
(7, 'Tacos al Pastor (Orden)', '5 tacos de carne de cerdo marinada', 'Carne de cerdo, adobo de achiote, piña, cilantro, cebolla', 110.00, TRUE, 6),
(8, 'Ensalada César', 'Lechuga orejona, crutones y aderezo césar', 'Lechuga, queso parmesano, crutones, aderezo', 130.00, TRUE, 7),
(9, 'Pastel de Chocolate', 'Rebanada de pastel de chocolate amargo', 'Harina, cacao, huevo, mantequilla, azúcar', 85.00, TRUE, 8),
(10, 'Limonada Mineral', 'Jugo de limón natural con agua mineral', 'Agua mineral, limón, jarabe natural', 45.00, TRUE, 9);


-- Factura 
INSERT INTO factura (rfc_cliente, razon_social, email, fecha_nacimiento, nombre_pila, apellido_paterno, apellido_materno, estado, codigo_postal, colonia, calle, numero) VALUES
('XAXX010101000', 'Público en General', 'ventas@restaurante.com', '1990-01-01', 'Público', 'General', 'NA', 'CDMX', '00000', 'NA', 'NA', 'SN'),
('GOBJ800510ABC', 'Juan Gómez Bernal', 'juan.gomez@mail.com', '1980-05-10', 'Juan', 'Gómez', 'Bernal', 'CDMX', '03400', 'Álamos', 'Galicia', '144'),
('PERM850615DEF', 'María Pérez Muñoz', 'mariap@mail.com', '1985-06-15', 'María', 'Pérez', 'Muñoz', 'EdoMex', '54050', 'Santa Cruz', 'Hidalgo', '22'),
('LOPS901220GHI', 'Sergio López Soto', 'slopez@empresa.com', '1990-12-20', 'Sergio', 'López', 'Soto', 'CDMX', '06500', 'Cuauhtémoc', 'Río Lerma', '90'),
('RAMA750330JKL', 'Ana Ramírez Arce', 'anita.ramirez@mail.com', '1975-03-30', 'Ana', 'Ramírez', 'Arce', 'CDMX', '14200', 'Jardines', 'Picacho', '88'),
('DIAH820911MNO', 'Hugo Díaz Hernández', 'hugo.diaz@empresa.com', '1982-09-11', 'Hugo', 'Díaz', 'Hernández', 'EdoMex', '57200', 'La Perla', 'Sur 20', '41'),
('VARM950425PQR', 'Mónica Vargas Mota', 'moni.v@mail.com', '1995-04-25', 'Mónica', 'Vargas', 'Mota', 'CDMX', '01040', 'Campestre', 'Revolución', '1100'),
('CRUR881116STU', 'René Cruz Ramos', 'rcruz@mail.com', '1988-11-16', 'René', 'Cruz', 'Ramos', 'CDMX', '03100', 'Del Valle', 'Amores', '55'),
('GUTL920708VWX', 'Laura Gutiérrez Luna', 'lgutierrez@mail.com', '1992-07-08', 'Laura', 'Gutiérrez', 'Luna', 'EdoMex', '53100', 'Lomas Verdes', 'Colina', '12'),
('HERF990119YZA', 'Fernando Hernández Flores', 'fer.hf@mail.com', '1999-01-19', 'Fernando', 'Hernández', 'Flores', 'CDMX', '06700', 'Condesa', 'Mexicali', '6');

-- Orden
INSERT INTO orden (num_empleado_mesero, rfc_cliente) VALUES
(1, 'GOBJ800510ABC'),
(2, 'PERM850615DEF'),
(3, 'LOPS901220GHI'),
(4, 'XAXX010101000'), 
(5, 'RAMA750330JKL'),
(6, 'DIAH820911MNO'),
(7, 'XAXX010101000'),
(8, 'CRUR881116STU'),
(9, 'GUTL920708VWX'),
(10, 'HERF990119YZA');

--Productos por orden
INSERT INTO producto_orden (folio_orden, id_producto, cantidad) VALUES
-- Orden 1
('ORD-001', 1, 1), 
('ORD-001', 3, 1),  
('ORD-001', 2, 1), 
-- Orden 2 
('ORD-002', 4, 1), 
('ORD-002', 10, 2), 
('ORD-002', 9, 1),  
-- Orden 3 
('ORD-003', 4, 2), 
('ORD-003', 1, 1), 
('ORD-003', 8, 1), 
-- Orden 4 
('ORD-004', 7, 3), 
-- Orden 5 
('ORD-005', 6, 1), 
('ORD-005', 8, 1), 
-- Orden 6 
('ORD-006', 5, 2), 
('ORD-006', 2, 2), 
-- Orden 7 
('ORD-007', 8, 2), 
-- Orden 8 
('ORD-008', 3, 1),  
('ORD-008', 5, 2), 
-- Orden 9 
('ORD-009', 9, 1),  
('ORD-009', 10, 1), 
-- Orden 10 
('ORD-010', 4, 1), 
('ORD-010', 6, 1), 
('ORD-010', 1, 1);