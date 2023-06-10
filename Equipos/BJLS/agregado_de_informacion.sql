--Inserción datos CP_CLIENTE
INSERT INTO public.CP_CLIENTE (CP_cliente, estado_cliente, colonia_cliente)
VALUES (01000, 'Ciudad de México', 'Colonia Juárez');
INSERT INTO public.CP_CLIENTE (CP_cliente, estado_cliente, colonia_cliente)
VALUES (44100, 'Guadalajara', 'Colonia Americana');
INSERT INTO public.CP_CLIENTE (CP_cliente, estado_cliente, colonia_cliente)
VALUES (37000, 'León', 'Colonia Centro');
INSERT INTO public.CP_CLIENTE (CP_cliente, estado_cliente, colonia_cliente)
VALUES (82110, 'Hermosillo', 'Colonia Las Lomas');
INSERT INTO public.CP_CLIENTE (CP_cliente, estado_cliente, colonia_cliente)
VALUES (52140, 'Metepec', 'Colonia La Asunción');

-- Inserción datos CP_PROVEEDOR
INSERT INTO public.CP_PROVEEDOR (CP_proovedor, estado_proveedor, colonia_proveedor)
VALUES (01090, 'Ciudad de México', 'Colonia Roma Norte');
INSERT INTO public.CP_PROVEEDOR (CP_proovedor, estado_proveedor, colonia_proveedor)
VALUES (66220, 'Nuevo León', 'Colonia San Pedro Garza García');
INSERT INTO public.CP_PROVEEDOR (CP_proovedor, estado_proveedor, colonia_proveedor)
VALUES (37130, 'Guanajuato', 'Colonia León Centro');
INSERT INTO public.CP_PROVEEDOR (CP_proovedor, estado_proveedor, colonia_proveedor)
VALUES (83280, 'Sonora', 'Colonia Villa de Seris');
INSERT INTO public.CP_PROVEEDOR (CP_proovedor, estado_proveedor, colonia_proveedor)
VALUES (55070, 'Estado de México', 'Colonia Satélite');

-- Inserción datos CLIENTE
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('PEGJ810505A78', 'Juan', 'Pérez', 'González', 'Calle Benito Juárez', '789', 01000);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('ROHM880203H45', 'María', 'Rodríguez', 'Hernández', 'Avenida Hidalgo', '456', 44100);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('LOGP800102H91', 'Pedro', 'López', 'García', 'Calle Revolución', '123', 37000);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('GOLL900512L84', 'Laura', 'Gómez', 'López', 'Boulevard Miguel Hidalgo', '987', 82110);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('HEGC870710G45', 'Carlos', 'Hernández', 'González', 'Calle Cuauhtémoc', '654', 52140);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('ROHA851220H34', 'Ana', 'Rodríguez', 'Hernández', 'Avenida Juárez', '321', 01000);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('PEGA910425F64', 'Alejandro', 'Pérez', 'González', 'Calle 5 de Mayo', '789', 44100);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('LOGJ920802M67', 'Javier', 'López', 'García', 'Calle Independencia', '654', 37000);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('GOLL870728M45', 'Lorena', 'Gómez', 'López', 'Boulevard Constitución', '987', 82110);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('PEGM940318L82', 'Manuel', 'Pérez', 'González', 'Calle Allende', '789', 52140);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('ROHF880415A59', 'Fernanda', 'Rodríguez', 'Hernández', 'Avenida Morelos', '456', 01000);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('HEGE910730B72', 'Eduardo', 'Hernández', 'González', 'Calle Reforma', '654', 44100);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('LOGV921212C48', 'Verónica', 'López', 'García', 'Calle Miguel Hidalgo', '123', 37000);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('GOLG880512H25', 'Gabriel', 'Gómez', 'López', 'Boulevard Juárez', '987', 82110);
INSERT INTO public.CLIENTE (RFC_cliente, nombre_cliente, ap_pat_cliente, ap_mat_cliente, calle_cliente, num_cliente, CP_cliente_CP_CLIENTE)
VALUES ('ROHP830920G83', 'Patricia', 'Rodríguez', 'Hernández', 'Avenida Hidalgo', '321', 52140);

-- Inserción PROVEEDOR
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P1', 'Papelería El Progreso S.A.', 'Juan', 'García', 'López', 'Calle 1', '101', 01090);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P2', 'Suministros Escolares y de Oficina Rápido y Fácil Ltda.', 'María', 'Rodríguez', 'Martínez', 'Calle 2', '202', 66220);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P3', 'Distribuidora de Papel y Artículos de Oficina Excelencia S.A.C.', 'Carlos', 'Hernández', 'Sánchez', 'Calle 3', '303', 37130);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P4', 'Almacén de Papelería y Suministros Profesionales S.R.L.', 'Laura', 'González', 'Martínez', 'Calle 4', '404', 83280);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P5', 'Imprenta y Suministros Gráficos Creativos S.A.', 'José', 'López', 'Gómez', 'Calle 5', '505', 55070);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P6', 'Papelería y Librería Moderna E.I.R.L.', 'Ana', 'Pérez', 'García', 'Calle 6', '606', 01090);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P7', 'Distribuidora de Material de Oficina y Papelería Integral Ltda.', 'Francisco', 'Rodríguez', 'Sánchez', 'Calle 7', '707', 66220);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P8', 'Almacén de Suministros Escolares y de Oficina Eficiente S.R.L.', 'Mariana', 'Hernández', 'Gómez', 'Calle 8', '808', 37130);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P9', 'Papelería y Artes Gráficas Innovación Creativa S.A.C.', 'Luis', 'González', 'Martínez', 'Calle 9', '909', 83280);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P10', 'Distribuidora Mayorista de Papelería y Material de Oficina Avance Total S.A.', 'Ana', 'López', 'García', 'Calle 10', '1010', 55070);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P11', 'Papelería El Progreso S.A.', 'Pedro', 'García', 'López', 'Calle 11', '1111', 01090);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P12', 'Suministros Escolares y de Oficina Rápido y Fácil Ltda.', 'María', 'Rodríguez', 'Martínez', 'Calle 12', '1212', 66220);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P13', 'Distribuidora de Papel y Artículos de Oficina Excelencia S.A.C.', 'Carlos', 'Hernández', 'Sánchez', 'Calle 13', '1313', 37130);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P14', 'Almacén de Papelería y Suministros Profesionales S.R.L.', 'Laura', 'González', 'Martínez', 'Calle 14', '1414', 83280);
INSERT INTO public.PROVEEDOR (id_proveedor, razon_social, nombre_proveedor, ap_pat_proveedor, ap_mat_proveedor, calle_proveedor, num_proveedor, CP_proovedor_CP_PROVEEDOR)
VALUES ('P15', 'Imprenta y Suministros Gráficos Creativos S.A.', 'José', 'López', 'Gómez', 'Calle 15', '1515', 55070);

-- Inserción INVENTARIO
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('123456789012', 23);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('ABCDE12345', 18);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('987654321098', 15);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('FGH12345678', 10);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('XWY98765432', 30);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('LKJ54321098', 25);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('QWE98765432', 20);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('POI12345678', 35);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('MNB98765432', 28);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('098765432109', 33);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('JHY54321098', 19);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('BVN98765432', 42);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('KLO12345678', 37);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('RTY98765432', 24);
INSERT INTO public.INVENTARIO (cod_barras, cantidad) VALUES ('NBV54321098', 29);

-- Inserción datos ARTICULO
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (1, 04.99, 'Bic', 'Pluma negra', 'P', '123456789012');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (2, 04.99, 'Bic', 'Pluma roja', 'P', 'ABCDE12345');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (3, 04.99, 'Bic', 'Pluma verde', 'P', '987654321098');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (4, 04.99, 'Bic', 'Pluma azul', 'P', 'FGH12345678');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (5, 10.25, 'Brands&Gifts', 'Caja de regalo', 'R', 'XWY98765432');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (6, 07.99, 'Brands&Gifts', 'Papel Regalo', 'R', 'LKJ54321098');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (7, 08.99, 'Brands&Gifts', 'Envoltura', 'R', 'QWE98765432');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (8, 05.50, 'Brands&Gifts', 'Moño', 'R', 'POI12345678');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (9, 30.00, 'Telcel', 'Recarga Telefonica', 'R', 'MNB98765432');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (10, 30.00, 'Movistar', 'Recarga Telefonica', 'R', '098765432109');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (11, 30.00, 'AT&T', 'Recarga Telefonica', 'R', 'JHY54321098');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (12, 05.00, 'Tamaño carta a color', 'Impresion', 'I', 'BVN98765432');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (13, 03.00, 'Tamaño carta blanco y negro', 'Impresion', 'I', 'KLO12345678');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (14, 6.50, 'Tamaño oficio a color', 'Impresion', 'I', 'RTY98765432');
INSERT INTO public.ARTICULO (clave_articulo, precio_articulo, marca_articulo, descripcion_articulo, tipo_articulo, cod_barras_INVENTARIO)
VALUES (15, 8.50, 'Tamaño oficio blanco y negro', 'Impresion', 'I', 'NBV54321098');

--Inserción PROVEE
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES ('P1', '123456789012', '2023-06-05', 3.75);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P2', 'ABCDE12345', '2023-06-06', 3.50);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P3', '987654321098', '2023-06-03', 2.50);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P4', 'FGH12345678', '2023-06-02', 1.00);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P5', 'XWY98765432', '2023-06-02', 9.25);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P6', 'LKJ54321098', '2023-06-04', 6.00);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P7', 'QWE98765432', '2023-06-15', 7.50);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P8', 'POI12345678', '2023-06-12', 4.00);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P9', 'MNB98765432', '2023-06-04', 15.00);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P10', '098765432109', '2023-06-09', 20.00);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P11', 'JHY54321098', '2023-06-07', 25.00);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P12', 'BVN98765432', '2023-06-11', 4.50);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P13', 'KLO12345678', '2023-06-05', 2.50);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P14', 'RTY98765432', '2023-06-03', 5.50);
INSERT INTO PROVEE(id_proveedor_PROVEEDOR, cod_barras_INVENTARIO, fecha, precio_compra)
VALUES('P15', 'NBV54321098', '2023-06-04', 7.50);

-- Inserción TELEFONO
-- Primeros 15 registros donde todos los proveedores cuentan con teléfono
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5512345678, 'P1');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5523456789, 'P2');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5534567890, 'P3');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5545678901, 'P4');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5556789012, 'P5');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5567890123, 'P6');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5578901234, 'P7');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5589012345, 'P8');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5590123456, 'P9');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5601234567, 'P10');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5612345678, 'P11');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5623456789, 'P12');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5634567890, 'P13');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5645678901, 'P14');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5656789012, 'P15');
-- Últimos 5 registros con repeticiones
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5667890123, 'P1');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5678901234, 'P2');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5689012345, 'P3');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5690123456, 'P4');
INSERT INTO public.TELEFONO (telefono_proveedor, id_proveedor_PROVEEDOR) VALUES (5701234567, 'P5');

-- Inserción datos EMAIL
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente1@example.com', 'PEGJ810505A78');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente2@example.com', 'ROHM880203H45');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente3@example.com', 'LOGP800102H91');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente4@example.com', 'GOLL900512L84');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente5@example.com', 'HEGC870710G45');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente6@example.com', 'ROHA851220H34');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente7@example.com', 'PEGA910425F64');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente8@example.com', 'LOGJ920802M67');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente9@example.com', 'GOLL870728M45');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente10@example.com', 'PEGM940318L82');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente11@example.com', 'ROHF880415A59');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente12@example.com', 'HEGE910730B72');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente13@example.com', 'LOGV921212C48');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente14@example.com', 'GOLG880512H25');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente15@example.com', 'ROHP830920G83');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente16@example.com', 'PEGJ810505A78');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente17@example.com', 'HEGE910730B72');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente18@example.com', 'GOLL900512L84');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente19@example.com', 'LOGJ920802M67');
INSERT INTO public.EMAIL (email_cliente, RFC_cliente_CLIENTE) VALUES ('cliente20@example.com', 'PEGA910425F64');
