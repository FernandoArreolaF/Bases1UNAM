INSERT INTO estado (estado_id, estado) VALUES
(1, 'Ciudad de México'),
(2, 'Jalisco'),
(3, 'Nuevo León');

INSERT INTO empleado (empleado_id, numero_empleado, rfc, nombre, ap_paterno, ap_materno,
                     fecha_nacimiento, edad, sueldo, foto, estado_id, cp, colonia, calle, numero,
                     es_cocinero, es_administrativo, es_mesero)
VALUES (1, 1001, 'GOMP850412HDF', 'Miguel', 'Gómez', 'Pérez',
        '1985-04-12', 41, 18000.00, '\x0123456789abcdef'::bytea, 1, 06700, 'Roma Norte', 'Colima', 45,
        true, false, false);

INSERT INTO cocinero (empleado_id, especialidad) VALUES (1, 'Cocina Mexicana');

INSERT INTO telefono_empleado (telefono_empleado_id, num_telefono, empleado_id) VALUES
(1, '5512345678', 1),
(2, '5509876543', 1);

INSERT INTO dependiente (dependiente_id, curp, parentesco, nombre, ap_paterno, ap_materno, empleado_id)
VALUES (1, 'GOMP850412HDFRND01', 'Cónyuge', 'Rosa', 'Martínez', 'López', 1);

INSERT INTO empleado (empleado_id, numero_empleado, rfc, nombre, ap_paterno, ap_materno,
                     fecha_nacimiento, edad, sueldo, foto, estado_id, cp, colonia, calle, numero,
                     es_cocinero, es_administrativo, es_mesero)
VALUES (2, 1002, 'LOMJ900820JAL', 'Juan', 'López', 'Mora',
        '1990-08-20', 35, 16000.00, '\x0123456789abcdef'::bytea, 2, 44100, 'Centro', 'Av. Juárez', 120,
        true, false, false);

INSERT INTO cocinero (empleado_id, especialidad) VALUES (2, 'Repostería');

INSERT INTO telefono_empleado (telefono_empleado_id, num_telefono, empleado_id) VALUES
(3, '3312345678', 2);

INSERT INTO empleado (empleado_id, numero_empleado, rfc, nombre, ap_paterno, ap_materno,
                     fecha_nacimiento, edad, sueldo, foto, estado_id, cp, colonia, calle, numero,
                     es_cocinero, es_administrativo, es_mesero)
VALUES (3, 2001, 'ROSR880305MDF', 'Sofía', 'Rosas', 'Ramírez',
        '1988-03-05', 38, 22000.00, '\x0123456789abcdef'::bytea, 1, 03100, 'Del Valle', 'Patricio Sanz', 34,
        false, true, false);

INSERT INTO administrativo (empleado_id, rol) VALUES (3, 'Gerente de Restaurante');

INSERT INTO telefono_empleado (telefono_empleado_id, num_telefono, empleado_id) VALUES
(4, '5598765432', 3);

INSERT INTO empleado (empleado_id, numero_empleado, rfc, nombre, ap_paterno, ap_materno,
                     fecha_nacimiento, edad, sueldo, foto, estado_id, cp, colonia, calle, numero,
                     es_cocinero, es_administrativo, es_mesero)
VALUES (4, 3001, 'VEGA950712NLE', 'Ana', 'Vega', 'Álvarez',
        '1995-07-12', 30, 10000.00, '\x0123456789abcdef'::bytea, 3, 64000, 'Monterrey Centro', 'Morelos', 500,
        false, false, true);

INSERT INTO mesero (empleado_id, horario_inicio, horario_final) VALUES (4, '07:00', '15:00');

INSERT INTO telefono_empleado (telefono_empleado_id, num_telefono, empleado_id) VALUES
(5, '8112345678', 4);

INSERT INTO empleado (empleado_id, numero_empleado, rfc, nombre, ap_paterno, ap_materno,
                     fecha_nacimiento, edad, sueldo, foto, estado_id, cp, colonia, calle, numero,
                     es_cocinero, es_administrativo, es_mesero)
VALUES (5, 3002, 'DISA990213CDM', 'Carlos', 'Díaz', 'Sánchez',
        '1999-02-13', 27, 10500.00, '\x0123456789abcdef'::bytea, 1, 03020, 'Escandón', 'José Martí', 89,
        false, false, true);

INSERT INTO mesero (empleado_id, horario_inicio, horario_final) VALUES (5, '14:00', '22:00');

INSERT INTO telefono_empleado (telefono_empleado_id, num_telefono, empleado_id) VALUES
(6, '5544332211', 5);

INSERT INTO dependiente (dependiente_id, curp, parentesco, nombre, ap_paterno, ap_materno, empleado_id)
VALUES (2, 'DISA990213CDMRTS02', 'Hijo', 'Luis', 'Díaz', 'Torres', 5);

INSERT INTO categoria (categoria_id, nombre, descripcion) VALUES
(1, 'Platillos fuertes', 'Platillos principales del menú'),
(2, 'Entradas', 'Entradas y botanas'),
(3, 'Bebidas', 'Bebidas alcohólicas y no alcohólicas'),
(4, 'Postres', 'Postres y dulces');

INSERT INTO producto (producto_id, nombre, descripcion, precio, disponibilidad,
                      es_platillo, es_bebida, receta, categoria_id)
VALUES
(1, 'Enchiladas Suizas', 'Tortillas rellenas de pollo bañadas en salsa verde y gratinadas con queso', 145.00, true,
 true, false, 'Freír tortillas, rellenar con pollo deshebrado, bañar con salsa verde, agregar queso y gratinar', 1),
(2, 'Tacos al Pastor', 'Tacos de cerdo adobado con piña, cebolla y cilantro', 18.00, true,
 true, false, 'Marinar cerdo en adobo, cocer en trompo, servir en tortilla con piña, cebolla y cilantro', 1),
(3, 'Guacamole', 'Guacamole tradicional con totopos', 85.00, true,
 true, false, 'Moler aguacate con cebolla, jitomate, chile y limón, acompañar con totopos', 2),
(4, 'Agua de Horchata', 'Bebida refrescante de arroz, canela y vainilla', 35.00, true,
 false, true, 'Remojar arroz con canela, licuar, colar y endulzar con vainilla', 3),
(5, 'Margarita Clásica', 'Coctel de tequila, licor de naranja y limón', 110.00, true,
 false, true, 'Mezclar tequila, triple sec y jugo de limón, agitar y servir en copa escarchada', 3),
(6, 'Pastel de Tres Leches', 'Pastel esponjoso bañado en tres leches', 75.00, true,
 true, false, 'Hornear bizcocho, perforar y bañar con mezcla de leche evaporada, condensada y crema', 4);

INSERT INTO orden (orden_id, folio, fecha_orden, total, empleado_id) VALUES
(1, DEFAULT, '2026-05-29 14:30:00', 216.00, 4),
(2, DEFAULT, '2026-05-29 15:10:00', 305.00, 4),
(3, DEFAULT, '2026-05-29 19:20:00', 128.00, 5);

INSERT INTO orden_producto (total_producto, cantidad_producto, orden_id, producto_id) VALUES
(36.00, 2, 1, 2),
(145.00, 1, 1, 1),
(35.00, 1, 1, 4);

INSERT INTO orden_producto (total_producto, cantidad_producto, orden_id, producto_id) VALUES
(85.00, 1, 2, 3),
(220.00, 2, 2, 5);

INSERT INTO orden_producto (total_producto, cantidad_producto, orden_id, producto_id) VALUES
(75.00, 1, 3, 6),
(35.00, 1, 3, 4),
(18.00, 1, 3, 2);

INSERT INTO cliente (cliente_id, rfc, razon_social, fecha_nacimiento, nombre, ap_paterno, ap_materno,
                     email, estado_id, cp, colonia, calle, numero)
VALUES
(1, 'CAMI920315DFR', 'Carlos Mendoza', '1992-03-15', 'Carlos', 'Mendoza', 'Íñiguez',
 'carlos.mendoza@email.com', 1, 06100, 'Condesa', 'Amsterdam', 255),
(2, 'LOPA880710JLN', 'Ana López', '1988-07-10', 'Ana', 'López', 'Arriaga',
 'ana.lopez@email.com', 2, 44600, 'Providencia', 'Rubén Darío', 120),
(3, 'GAPM950527NLE', 'Mariana García', '1995-05-27', 'Mariana', 'García', 'Peralta',
 'mariana.garcia@email.com', 3, 66220, 'San Pedro', 'Calzada del Valle', 400);

INSERT INTO factura (factura_id, fecha_factura, cliente_id, orden_id) VALUES
(1, '2026-05-29 15:00:00', 1, 1),
(2, '2026-05-29 15:45:00', 2, 2),
(3, '2026-05-29 19:50:00', 3, 3);

SELECT setval('estado_id_seq', (SELECT MAX(estado_id)::bigint FROM estado));
SELECT setval('empleado_id_seq', (SELECT MAX(empleado_id)::bigint FROM empleado));
SELECT setval('telefono_empleado_id_seq', (SELECT MAX(telefono_empleado_id)::bigint FROM telefono_empleado));
SELECT setval('dependiente_id_seq', (SELECT MAX(dependiente_id)::bigint FROM dependiente));
SELECT setval('categoria_id_seq', (SELECT MAX(categoria_id)::bigint FROM categoria));
SELECT setval('producto_id_seq', (SELECT MAX(producto_id)::bigint FROM producto));
SELECT setval('orden_id_seq', (SELECT MAX(orden_id)::bigint FROM orden));
SELECT setval('factura_folio_seq', (SELECT COUNT(*)::bigint FROM orden));
SELECT setval('orden_producto_id_seq', (SELECT MAX(orden_producto_id)::bigint FROM orden_producto));
SELECT setval('cliente_id_seq', (SELECT MAX(cliente_id)::bigint FROM cliente));
SELECT setval('factura_id_seq', (SELECT MAX(factura_id)::bigint FROM factura));
