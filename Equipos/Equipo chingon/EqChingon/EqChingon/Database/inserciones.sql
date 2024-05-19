--Empleados
INSERT INTO empleado (num_emp, rfc_emp, nombre_pila_emp, ap_pat_emp, ap_mat_emp, fecha_nac_emp, foto_emp, estado_emp, codigo_postal_emp, colonia_emp, calle_emp, num_dom_emp, sueldo_emp, cocinero, mesero, administrativo)
VALUES
(1, 'RODR800211SF6', 'Juan', 'Pérez', 'González', '1990-05-15', NULL, 'Ciudad de México', '12345', 'Centro', 'Calle 1', 123, 15000.00, TRUE, FALSE, FALSE),
(2, 'SANC861122KN4', 'María', 'López', 'Martínez', '1985-10-20', NULL, 'Ciudad de México', '54321', 'Colonia Norte', 'Calle 2', 456, 18000.00, TRUE, FALSE, FALSE),
(3, 'VELA780224CR8', 'Pedro', 'Ramírez', 'Hernández', '1988-03-10', NULL, 'Ciudad de México', '67890', 'Colonia Sur', 'Calle 3', 789, 17000.00, TRUE, FALSE, FALSE),
(4, 'JKL321098765', 'Ana', 'García', 'Pérez', '1992-07-25', NULL, 'Ciudad de México', '98765', 'Colonia Este', 'Calle 4', 1011, 16000.00, TRUE, FALSE, FALSE),
(5, 'GARC921211GT9', 'Luis', 'Fernández', 'Sánchez', '1995-01-30', NULL, 'Ciudad de México', '13579', 'Colonia Oeste', 'Calle 5', 1213, 15500.00, TRUE, FALSE, FALSE),
(6, 'LOPE890624MZ3', 'Laura', 'Díaz', 'Gómez', '1991-09-05', NULL, 'Ciudad de México', '24680', 'Centro', 'Calle 6', 1415, 14500.00, FALSE, FALSE, TRUE),
(7, 'STU543216789', 'Carlos', 'Martínez', 'Rodríguez', '1989-12-12', NULL, 'Ciudad de México', '36924', 'Colonia Norte', 'Calle 7', 1617, 17500.00, FALSE, FALSE, TRUE),
(8, 'HERN820530PU9', 'Paula', 'Hernández', 'López', '1993-04-18', NULL, 'Ciudad de México', '48215', 'Colonia Sur', 'Calle 8', 1819, 16500.00, FALSE, FALSE, TRUE),
(9, 'YZA789012345', 'Javier', 'Pérez', 'Fernández', '1994-08-20', NULL, 'Ciudad de México', '59124', 'Colonia Este', 'Calle 9', 2021, 16000.00, FALSE, FALSE, TRUE),
(10,'SANC861122KN4', 'Elena', 'Gómez', 'Sánchez', '1996-02-28', NULL, 'Ciudad de México', '63179', 'Colonia Oeste', 'Calle 10', 2223, 15500.00, FALSE, FALSE, TRUE),
(11, 'MART831204HG7', 'Ricardo', 'Martínez', 'García', '1987-11-15', NULL, 'Ciudad de México', '74821', 'Centro', 'Calle 11', 2425, 15000.00, FALSE, TRUE, FALSE),
(12, 'HIJ456789012', 'Mónica', 'López', 'Ramírez', '1990-06-10', NULL, 'Ciudad de México', '89214', 'Colonia Norte', 'Calle 12', 2627, 14500.00, FALSE, TRUE, FALSE),
(13, 'KLM789012345', 'Fernando', 'González', 'Hernández', '1986-01-05', NULL, 'Ciudad de México', '95123', 'Colonia Sur', 'Calle 13', 2829, 17500.00, FALSE, TRUE, FALSEE),
(14, 'NOP567890123', 'Sofía', 'Rodríguez', 'Fernández', '1992-04-30', NULL, 'Ciudad de México', '12345', 'Colonia Este', 'Calle 14', 3031, 17000.00, FALSE, TRUE, FALSE),
(15, 'QRS890123456', 'Daniel', 'Sánchez', 'Martínez', '1998-09-15', NULL, 'Ciudad de México', '24680', 'Colonia Oeste', 'Calle 15', 3233, 15500.00, FALSE, TRUE, FALSE);
--Modificaciones
ALTER TABLE empleado ALTER COLUMN foto_emp DROP NOT NULL;
--BIEN
--Teléfonos
 
INSERT INTO telefono_emp (telefono, num_emp)
VALUES
(55512346, 1),
(55598765, 2),
(55534567, 3),
(55587654, 4),
(55523456, 5),
(55576543, 6),
(55545678, 7),
(55565432, 8),
(55578901, 9),
(55521098, 10),
(55589012, 11),
(55532109, 12),
(55543210, 13),
(55598766, 14),
(55512345, 15);

--Administrativos 

INSERT INTO administrativo (rol, num_emp_administrativo) VALUES
('Administrador', 1),
('Asistente Administrativo', 2),
('Gerente de Recursos Humanos',3),
('Coordinador Administrativo', 4),
('Asistente de Oficina', 5);


--Cocineros

 INSERT INTO cocinero (especialidad, num_emp_cocinero)
VALUES
    ('Preparación de mariscos', 11),
    ('Postres y repostería', 12),
    ('Bebidas y coctelería', 13),
    ('Cocina de pescados', 14),
    ('Cocina internacional de mariscos', 15);


--Meseros 
INSERT INTO mesero (horario, num_emp_mesero)
VALUES
    ('Turno matutino', 6),
    ('Turno vespertino', 7),
    ('Turno nocturno', 8),
    ('Turno mixto', 9),
    ('Turno flexible', 10);


--Dependiente
INSERT INTO dependiente (curp_dep, num_emp, nombre_pila_dep, ap_pat_dep, ap_mat_dep, parentesco) VALUES
('BCD567890123', 1, 'Juan', 'González', 'Pérez', 'Hijo'),
('CDE678901234', 2, 'María', 'López', 'Martínez', 'Hija'),
('DEF789012345', 3, 'Pedro', 'Sánchez', 'García', 'Hijo'),
('EFG890123456', 4, 'Ana', 'Martínez', 'Rodríguez', 'Hija'),
('FGH901234567', 5, 'Luis', 'Hernández', 'Fernández', 'Hijo');


--Menú

-- Insertar registros en la tabla menu
INSERT INTO menu (id_prod, nombre_prod,receta_prod, precio_unitario_prod, disponibilidad_prod, categoria)
VALUES
(1, 'Ceviche de Camarón', 'Camarones frescos marinados en jugo de limón, con cebolla morada, chile serrano, aguacate y cilantro.', 120.00, true, 'Plato principal'),
(2, 'Filete de Pescado a la Veracruzana', 'Filete de pescado fresco cocinado en salsa de tomate, aceitunas, alcaparras, chiles y cebolla.', 180.00, true,'Plato principal'),
(3, 'Pulpo a la Gallega', 'Pulpo cocido y aderezado con aceite de oliva, pimentón y sal.', 200.00, true,'Plato principal'),
(4, 'Paella Marinera', 'Arroz con una variedad de mariscos como camarones, almejas, mejillones, calamares y pescado, cocinados con azafrán.', 250.00, true, 'Plato principal'),
(5, 'Ensalada de Mariscos', 'Mezcla de mariscos frescos como camarones, pulpo y calamares sobre una cama de lechuga fresca, tomate, pepino y aguacate.', 150.00, true, 'Plato principal'),
(6, 'Aguachile de Camarón', 'Camarones frescos marinados en una salsa de jugo de limón, chile serrano y pepino.', 130.00, true, 'Plato principal'),
(7, 'Cóctel de Camarón', 'Camarones cocidos y enfriados, mezclados con salsa de tomate, cebolla, cilantro, aguacate y jugo de limón.', 110.00, true, 'Entrante'),
(8, 'Tostadas de Atún', 'Tostadas de maíz crujientes cubiertas con atún fresco marinado en salsa de soja, limón y chile.', 160.00, true, 'Entrante'),
(9, 'Gambas al Ajillo', 'Gambas, ajo, aceite de oliva, perejil, guindilla', 170.00, true, 'Entrante'),
(10, 'Pastel de Tres Leches', 'Pastel esponjoso bañado en una mezcla de tres tipos de leche y cubierto con crema batida.', 90.00, true, 'Postre'),
(11, 'Flan de Coco', 'Postre tradicional hecho con crema de coco, leche condensada y huevos, cubierto con caramelo líquido.', 80.00, true, 'Postre'),
(12, 'Cheesecake de Maracuyá', 'Cheesecake suave y cremoso con un toque refrescante de maracuyá, sobre una base de galleta.', 120.00, true, 'Postre'),
(13, 'Mojito de Maracuyá', 'Refrescante cóctel hecho con ron, maracuyá, jugo de limón, hojas de menta y agua mineral.', 100.00, true, 'Bebida'),
(14, 'Margarita de Mango', 'Cóctel clásico con tequila, licor de naranja, mango fresco, jugo de limón y un borde de sal.', 110.00, true, 'Bebida');


--Entrada
INSERT INTO entrante(id_prod) VALUES
(7), -- Cóctel de Camarón
(8), -- Tostadas de Atún
(9); -- Gambas al Ajillo

--Plato Principal
-- Insertar registros en la tabla "PLATO_PRINCIPAL"
INSERT INTO plato_principal (id_prod)
VALUES
(1), -- Ceviche de Camarón
(2), -- Filete de Pescado a la Veracruzana
(3), -- Pulpo a la Gallega
(4), -- Paella Marinera
(5), -- Ensalada de Mariscos
(6); -- Aguachile de Camarón


--Postre
-- Insertar registros en la tabla "POSTRE"
INSERT INTO postre (id_prod)
VALUES
(10), -- Pastel de Tres Leches
(11), -- Flan de Coco
(12); -- Cheesecake de Maracuyá


--Bebida
-- Insertar registros en la tabla "BEBIDA"
INSERT INTO bebida (id_prod)
VALUES
(13), -- Mojito de Maracuyá
(14); -- Margarita de Mango


--Orden
INSERT INTO orden(folio_orden, fecha_orden, num_emp_administrativo, num_emp_mesero)
VALUES
('ORD-001', CURRENT_TIMESTAMP, 1, 6),
('ORD-002', CURRENT_TIMESTAMP, 2, 7),
('ORD-003', CURRENT_TIMESTAMP, 3, 8),
('ORD-004', CURRENT_TIMESTAMP, 4, 9),
('ORD-005', CURRENT_TIMESTAMP, 5, 10);



--Contiene
INSERT INTO contiene (id_prod, folio_orden, cantidad_prod) VALUES
(1, 'ORD-001', 2),
(2, 'ORD-002', 1),
(3, 'ORD-003', 3),
(4, 'ORD-004', 2),
(5, 'ORD-005', 1);


--Factura
INSERT INTO factura (rfc_cli, folio_orden, nombre_pila_cli, ap_pat_cli, ap_mat_cli, estado_cli, codigo_postal_cli, colonia_cli, calle_cli, num_dom_cli, razon_social_cli, email_cli, fecha_nac_cli) VALUES
('ABC123456789', 'ORD-001', 'Juan', 'González', 'Pérez', 'Ciudad de México', '12345', 'Centro', 'Calle 123', 456, 'Juan González S.A. de C.V.', 'juan@example.com', '1990-05-15'),
('XYZ987654321', 'ORD-002', 'María', 'López', 'Martínez', 'Guadalajara', '54321', 'Reforma', 'Avenida Principal', 789, 'López Martínez Hermanos', 'maria@example.com', '1988-12-10'),
('DEF456789123', 'ORD-003', 'Pedro', 'Sánchez', 'García', 'Monterrey', '67890', 'Independencia', 'Calle Libertad', 1011, 'Pedro Sánchez Construcciones', 'pedro@example.com', '1995-08-20'),
('GHI654321987', 'ORD-004', 'Ana', 'Martínez', 'Rodríguez', 'Puebla', '98765', 'Juárez', 'Calle 456', 1213, 'Ana Rodríguez Arquitectura', 'ana@example.com', '1985-03-25'),
('JKL321987654', 'ORD-005', 'Luis', 'Hernández', 'Fernández', 'Toluca', '23456', 'San Miguel', 'Calle Flores', 1415, 'Luis Fernández Abogados', 'luis@example.com', '1992-10-05');
