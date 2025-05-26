INSERT INTO cod_p (v_estado, n_cod_postal) VALUES 
('Ciudad de México', 10001),
('Jalisco', 10002),
('Nuevo León', 10003),
('Puebla', 10004),
('Veracruz', 10005),
('Guanajuato', 10006),
('Michoacán', 10007),
('Oaxaca', 10008),
('Chiapas', 10009),
('Baja California', 10010),
('Yucatán', 10011),
('Querétaro', 10012),
('San Luis Potosí', 10013),
('Estado de México', 10014),
('Sinaloa', 10015);

INSERT INTO direccion (v_colonia, v_calle, n_numero, n_id_direccion, n_cod_p_cod_postal) VALUES
('Roma', 'Insurgentes', 101, 1, 10001),
('Condesa', 'Guerrero', 202, 2, 10002),
('Polanco', 'Reforma', 303, 3, 10003),
('Del Valle', 'Cuauhtemoc', 404, 4, 10004),
('Lomas', 'Paseo de la Reforma', 505, 5, 10005);

INSERT INTO categoria (n_clave_cat, v_nombre_cat, v_tipo_cat) VALUES
(1, 'Salas', 'Hogar'),
(2, 'Escritorios', 'Oficina'),
(3, 'Sillas', 'Complementos'),
(4, 'Espejos', 'Utilidades'),
(5, 'Colchones', 'Habitación');

INSERT INTO articulo (v_cod_barras, v_nombre_art, n_precio_compra, n_precio_venta, n_stock, b_fotografia, n_categoria_clave_cat) VALUES
('ART001', 'Sala Enzo II', 30825.00, 43199.99, 10, decode('CAFEBABE', 'hex'), 1),
('ART002', 'Sofá Calm', 21758.00, 36389.99, 8, decode('CAFEBABE', 'hex'), 1),
('ART003', 'Sala Francesa', 11098.00, 18599.99, 10, decode('CAFEBABE', 'hex'), 1),

('ART004', 'Escritorio Celta', 17442.00, 29299.99, 9, decode('CAFEBABE', 'hex'), 2),
('ART005', 'Escritorio Texas', 10659.00, 17899.99, 10, decode('CAFEBABE', 'hex'), 2),
('ART006', 'Escritiotio Ellis', 24505.00, 40899.99, 10, decode('CAFEBABE', 'hex'), 2),

('ART007', 'Silla Quetzal C Negro', 4725.00, 7999.99, 10, decode('CAFEBABE', 'hex'), 3),
('ART008', 'Silla Tamallo C Gris', 4615.00, 7849.99, 10, decode('CAFEBABE', 'hex'), 3),
('ART009', 'Silla Bambú K23', 3956.00, 6559.99, 10, decode('CAFEBABE', 'hex'), 3),

('ART010', 'Espejo de Pie Boston', 7032.00, 11789.99, 10, decode('CAFEBABE', 'hex'), 4),
('ART011', 'Espejo Bourbon', 6186.00, 10489.99, 10, decode('CAFEBABE', 'hex'), 4),
('ART012', 'Espejo Armenia', 6483.00, 10949.99, 10, decode('CAFEBABE', 'hex'), 4),

('ART013', 'Colchón Sealy Matrimonial Blau', 21234.00, 35389.99, 10, decode('CAFEBABE', 'hex'), 5),
('ART014', 'Colchón Spring Air Queen Size Seasons', 29352.00, 51899.99, 10, decode('CAFEBABE', 'hex'), 5),
('ART015', 'Colchón Matrimonial América Healthy', 8681.00, 14599.99, 10, decode('CAFEBABE', 'hex'), 5);

INSERT INTO provedor (v_rfc_prov, v_razon_socialpv, n_telefono_prov, n_cuenta_pago, n_direccion_id_direccion) VALUES
('PROV001', 'Uline Office & Home', 5523456701, 10001, 1),
('PROV002', 'Spring Air', 5523456702, 10002, 2),
('PROV003', 'Sealy', 5523456703, 10003, 3),
('PROV004', 'Sofamex', 5523456704, 10004, 4);

INSERT INTO sucursal (v_clave_suc, n_telefono, n_año_fundacion, n_direccion_id_direccion) VALUES
('SUC001', 5551234001, 1990, 1),
('SUC002', 5551234002, 1991, 2),
('SUC003', 5551234003, 1992, 3),
('SUC004', 5551234004, 1993, 4),
('SUC005', 5551234005, 1994, 5);

INSERT INTO empleado (n_clave_emp, v_rfc_emp, d_fecha_ing, v_curp, v_email_emp, v_nombre, v_ap_paterno, v_ap_mat, n_empleado_clave_emp, v_sucursal_clave_suc, v_tipo, n_direccion_id_direccion, t_contraseña) VALUES
(1, 'EMP001RFC', '2020-01-15', 'CURPEMP001', 'juan.perez@empresa.com', 'Juan', 'Perez', 'Lopez', NULL, 'SUC001', 'Vendedor', 1, 'empPass1'),
(2, 'EMP002RFC', '2020-02-20', 'CURPEMP002', 'maria.garcia@empresa.com', 'Maria', 'Garcia', 'Ramos', 1, 'SUC001', 'Cajero', 2, 'empPass2'),
(3, 'EMP003RFC', '2020-03-25', 'CURPEMP003', 'carlos.lopez@empresa.com', 'Carlos', 'Lopez', 'Martinez', 1, 'SUC002', 'Vendedor', 3, 'empPass3'),
(4, 'EMP004RFC', '2020-04-10', 'CURPEMP004', 'ana.martinez@empresa.com', 'Ana', 'Martinez', 'Rodriguez', 2, 'SUC002', 'Cajero', 4, 'empPass4'),
(5, 'EMP005RFC', '2020-05-05', 'CURPEMP005', 'luis.sanchez@empresa.com', 'Luis', 'Sanchez', 'Hernandez', 2, 'SUC003', 'Vendedor', 5, 'empPass5');


INSERT INTO telefonos (n_num_tel, n_empleado_clave_emp) VALUES
(551200000001, 1),
(551200000002, 2),
(551200000003, 3),
(551200000004, 4),
(551200000005, 5);


INSERT INTO cliente (v_rfc_client, v_razon_social, v_nombre, v_ap_paterno, v_ap_materno, n_telefono, v_email, n_direccion_id_direccion) VALUES
(' ',NULL, NULL, NULL,NULL, NULL,NULL, NULL),
('CLI001RFC', 'Empresa Alfa', 'Roberto', 'Gómez', 'Santana', 562000001, 'roberto@alfacorp.com', 1),
('CLI002RFC', 'Comercial Beta', 'Sofía', 'Lopez', 'Martinez', 562000002, 'sofia@betacorp.com', 2),
('CLI003RFC', 'Servicios Gamma', 'Antonio', 'Ramirez', 'Diaz', 562000003, 'antonio@gammacorp.com', 3),
('CLI004RFC', 'Inversiones Delta', 'Lucía', 'Hernandez', 'Morales', 562000004, 'lucia@deltainv.com', 4),
('CLI005RFC', 'Constructora Epsilon', 'Fernando', 'Soto', 'Gonzalez', 562000005, 'fernando@epsilon.com', 5);

INSERT INTO articulo_provedor (v_articulo_cod_barras, v_provedor_rfc_prov, d_f_inicio_surtido) VALUES
('ART001', 'PROV004', '2020-01-05'),
('ART002', 'PROV004', '2020-02-19'),
('ART003', 'PROV004', '2020-03-31'),
('ART004', 'PROV001', '2022-11-26'),
('ART005', 'PROV001', '2022-06-13'),
('ART006', 'PROV001', '2022-09-13'),
('ART007', 'PROV001', '2022-12-15'),
('ART008', 'PROV001', '2022-09-09'),
('ART009', 'PROV001', '2022-10-23'),
('ART010', 'PROV001', '2023-04-19'),
('ART011', 'PROV001', '2024-04-17'),
('ART012', 'PROV001', '2024-01-02'),
('ART013', 'PROV003', '2024-06-29'),
('ART014', 'PROV002', '2025-02-12'),
('ART015', 'PROV003', '2019-11-18');