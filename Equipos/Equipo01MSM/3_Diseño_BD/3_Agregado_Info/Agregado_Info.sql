---------------------------------------------------
	--AUTOR: 01MSM
	--BD: PROYECTO_FINAL_PAPELERIA
	--DESCRIPCIÓN: AGREGADO DE INFORMACION 
	--FECHA DE CREACIÓN: 17 de enero de 2021
---------------------------------------------------
--TABLA 1 
INSERT INTO PROVEEDOR(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES('Treviño', 'Hermanos Treviño S.A', 'Mesones', 22, 'Centro', 'CDMX', 00129),
	  ('Los 3 Garcia', 'Los Tres Garcia S.A', 'Alfonso Trece', 02, 'Mixcoac', 'CDMX', 01739);

INSERT INTO PROVEEDOR(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES('Solin', 'Papeleria Solin S.A de C.V', 'Primera de palmas', 15, 'Observatorio', 'CDMX', 01520),
	  ('Grupo ABC', 'Grupo ABC SRL', '15 de mayo', 01, 'Centro', 'CDMX', 01830);

INSERT INTO PROVEEDOR(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES('Papeleria Buenavista', 'Papeleria Buenavista S.A de C.V', 'Gardenia', 154, 'Buenavista', 'CDMX', 01237),
	  ('Leo', 'Grupo Leo S.A', 'Cuauhtemoc', 12, 'Prados', 'Estado de Mexico', 02471);

INSERT INTO PROVEEDOR(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES('Super Papeleria Santana', 'Super Papeleria Santana SRL', 'Porfirio Diaz', 1245, 'Granjas', 'Estado de Mexico', 01280),
	  ('Valladolid', 'Papeleria Valladolid S.A', 'Doctor Andrade', 89, 'Doctores', 'CDMX', 01111);

INSERT INTO PROVEEDOR(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES('Papeleria Karen', 'Papeleria Karen S.A ', 'Plutarco Elias Calles', 237, 'Peralvillo', 'CDMX', 01231),
	  ('Monse', 'Papeleria Monse S.A', 'Eje Central', 212, 'Centro', 'CDMX', 01512);

SELECT * FROM PROVEEDOR;
----------------------------------------------------------------------------------------------
--TABLA 2
INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5568978090, 1);-- TREVIÑO

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5568978091, 1);-- TREVIÑO

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5536789900, 2);-- GARCIA

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5529387901, 3);-- SOLIN

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5599910024, 3);-- SOLIN

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5528796745, 4);-- ABC

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5589764532, 5);-- BUENAVISTA

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5512897834, 6);-- LEO

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5524409873, 7);-- SANTANA

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5214678900, 8);-- VALLADOLID

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5532785902, 9);-- KAREN

INSERT INTO TELEFONO_PROVEEDOR(telefono, id_proveedor) 
VALUES(5552719421, 10);-- MONSE

SELECT * FROM TELEFONO_PROVEEDOR;

----------------------------------------------------------------------------------------------
--TABLA 3
INSERT INTO CATEGORIA(nombre_categoria, descripcion_categoria)
VALUES('Regalos','Articulos varios para regalos y decoración');--REGALOS 1

INSERT INTO CATEGORIA(nombre_categoria, descripcion_categoria)
VALUES('Papelería','Articulos relacionados a papeleria');--PAPELERIA 2

INSERT INTO CATEGORIA(nombre_categoria, descripcion_categoria)
VALUES('Impresiones','Servicio de impresiones en varios tamaños, c, b/n');--IMPRESIONES 3

INSERT INTO CATEGORIA(nombre_categoria, descripcion_categoria)
VALUES('Recargas','Servicio de recargas, todas las compañias');--RECARGAS 4

SELECT * FROM CATEGORIA;
----------------------------------------------------------------------------------------------
--TABLA 4
--PAPELERIA 2
INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(5, 'B-16279-01', 'Pluma tinta negra', 'BIC', 2, 3),
	  (3, 'B-12345-00', 'Lapiz 2B', 'BIC', 2, 3);
	  
INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(25, 'B-16239-11', 'Cuaderno cuad. g.', 'NORMA', 2, 4),
	  (100, 'B-12905-02', 'Cuaderno pasta gru.', 'JEANBOOK', 2, 4);

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(2.5, 'B-16234-10', 'Cartulina bca.', 'D-Lux', 2, 5),
	  (150, 'B-12948-09', 'Plumones colores', 'Prismacolor', 2, 5);

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(2.5, 'B-16225-10', 'Goma migajon', 'VEROL', 2, 6),
	  (2.5, 'B-13459-94', 'Sacapuntas', 'Maped', 2, 6);
	  
--REGALOS 1
INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(50, 'B-18425-18', 'Chocolates grandes', 'FERRERO', 1, 7),
	  (250, 'B-19789-12', 'Cartera', 'H&M', 1, 7);

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(30, 'B-23905-90', 'Globos decorados', 'TuRegalo', 1, 8),
	  (200, 'B-19999-92', 'Audifonos', 'Pioneer', 1, 8);

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(300, 'B-25901-90', 'Oso peluche', 'Disney', 1, 9),
	  (300, 'B-47593-32', 'Locion', 'Perry Ellis', 1, 9);

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(100, 'B-25902-90', 'Bufanda', 'P&B', 1, 9),
	  (300, 'B-47593-32', 'Perfume', 'DKNY', 1, 9);
	  
--IMPRESIONES 3

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(1, 'B-00000-01', 'Impresion Color', 'MSM', 3, 1),
	  (1.5, 'B-00000-02', 'Impresion B/N', 'MSM', 3, 1),
	  (2, 'B-00000-03', 'Impresion Color Ofi', 'MSM', 3, 1),
	  (2.5, 'B-00000-04', 'Impresion B/N Ofi', 'MSM', 3, 1);

--RECARGAS 4

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(10, 'B-00000-10', 'Recarga Movistar 10', 'Movistar', 4, 1),
	  (20, 'B-00000-20', 'Recarga Movistar 20', 'Movistar', 4, 1),
	  (30, 'B-00000-30', 'Recarga Movistar 30', 'Movistar', 4, 1),
	  (50, 'B-00000-50', 'Recarga Movistar 50', 'Movistar', 4, 1),
	  (100, 'B-00001-00', 'Recarga Movistar 100', 'Movistar', 4, 1),
	  (150, 'B-00001-50', 'Recarga Movistar 150', 'Movistar', 4, 1),
	  (200, 'B-00002-00', 'Recarga Movistar 200', 'Movistar', 4, 1);

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(10, 'B-10000-10', 'Recarga Telcel 10', 'Telcel', 4, 1),
	  (20, 'B-10000-20', 'Recarga Telcel 20', 'Telcel', 4, 1),
	  (30, 'B-10000-30', 'Recarga Telcel 30', 'Telcel', 4, 1),
	  (50, 'B-10000-50', 'Recarga Telcel 50', 'Telcel', 4, 1),
	  (100, 'B-10001-00', 'Recarga Telcel 100', 'Telcel', 4, 1),
	  (150, 'B-10001-50', 'Recarga Telcel 150', 'Telcel', 4, 1),
	  (200, 'B-10002-00', 'Recarga Telcel 200', 'Telcel', 4, 1),
	  (500, 'B-10005-00', 'Recarga Telcel 500', 'Telcel', 4, 1);

INSERT INTO PRODUCTO(precio_unitario, codigo_barras, descripcion_producto,marca_producto, id_categoria, id_proveedor)
VALUES(50, 'B-20000-50', 'Recarga Unefon 50', 'Unefon', 4, 2),
	  (100, 'B-20001-00', 'Recarga Unefon 100', 'Unefon', 4, 2);

SELECT * FROM PRODUCTO;
----------------------------------------------------------------------------------------------
--TABLA 5
INSERT INTO INVENTARIO(id_producto, precio_unitario, stock, precio_compra, fecha_compra)
VALUES (1, 5, 100, 2, '20200507');

INSERT INTO INVENTARIO(id_producto, precio_unitario, stock, precio_compra, fecha_compra)
VALUES (2, 3, 100, .5, '20200507'), (3, 25, 20, 15, '20200507'),(4, 100, 20, 80, '20200507'),
	   (5, 2.5, 50, 1.5, '20200507'), (6, 150, 4, 100, '20200507'),(7, 2.5, 50, 2, '20200507'),
	   (8, 2.5, 50, 2, '20200507');
	   
INSERT INTO INVENTARIO(id_producto, precio_unitario, stock, precio_compra, fecha_compra)
VALUES (9, 50, 10, 40, '20200508'), (10, 250, 2, 230, '20200508'),(11, 30, 10, 20, '20200508'),
	   (12, 200, 2, 180, '20200508'), (13, 300, 4, 280, '20200508'),(14, 300, 2, 280, '20200508'),
	   (15, 100, 5, 50, '20200508'), (16, 300, 2, 280, '20200508');

INSERT INTO INVENTARIO(id_producto, precio_unitario, stock, precio_compra, fecha_compra)
VALUES (17, 1, 1000, .5, '20200509'), (18, 1.5, 1000, 1, '20200509'),(19, 2, 1000, 1.5, '20200509'),
	   (20, 2.5, 1000, 2, '20200509'), (21, 10, 100, 8, '20200509'),(22, 20, 100, 18, '20200509'),
	   (23, 30, 100, 28, '20200509'), (24, 50, 100, 48, '20200509');

INSERT INTO INVENTARIO(id_producto, precio_unitario, stock, precio_compra, fecha_compra)
VALUES (25, 100, 100, 90, '20200509'), (26, 150, 100, 140, '20200509'),(27, 200, 100, 180, '20200509'),
	   (28, 10, 100, 8, '20200509'), (29, 20, 100, 18, '20200509'),(30, 30, 100, 28, '20200509'),
	   (31, 50, 100, 48, '20200509'), (32, 100, 100, 90, '20200509');

INSERT INTO INVENTARIO(id_producto, precio_unitario, stock, precio_compra, fecha_compra)
VALUES (33, 150, 100, 140, '20200509'), (34, 200, 100, 180, '20200509'),(35, 500, 10, 480, '20200509'),
	   (36, 50, 100, 48, '20200509'), (37, 100, 100, 90, '20200509');

SELECT * FROM INVENTARIO;

----------------------------------------------------------------------------------------------
--TABLA 6
INSERT INTO CLIENTE(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES ('Alma Rodriguez Martinez','ROMAA09H0', 'Paseo de duraznos', 15, 'Bosques', 'CDMX', 01520),
		('Iván Maldonado Aldape','ALMAI12F0', 'Cañada 2', 23, 'Cañada', 'CDMX', 01530);

INSERT INTO CLIENTE(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES ('Sofia Rivas Silva','SIRIS89H0', 'Providencia', 52, 'San Rafael', 'CDMX', 01230),
		('Ana Gutierrez Lopez','LOGUA89H0', 'Doctor Vertiz', 3, 'Doctores', 'CDMX', 01110);

INSERT INTO CLIENTE(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES ('Pedro Robles Gil','GIROP78H0', 'Girasoles', 1, 'Barrio Norte', 'CDMX', 02320),
		('Paula Larregui Maya','MALAP89H1', 'Compositores', 5, 'Valbuena', 'CDMX', 03210);

INSERT INTO CLIENTE(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES ('Jose Zuñiga Morrison','MOZUJ78H1', 'Campeche', 12, 'Roma Norte', 'CDMX', 04098),
		('Luis Gutierrez Pereda','PEGUL63H1', 'Horacio', 125, 'Polanco', 'CDMX', 01190);

INSERT INTO CLIENTE(nombre, razon_social, calle, numero, colonia, estado, codigo_postal)
VALUES ('Beatriz Santos Palomino','PASAB73H0', 'Alfonso Trece', 1, 'Molino de Rosas', 'CDMX', 04800),
		('Salma Jimenez Reyes','REJIS23H1', 'Jardines', 45, 'Porfirio Diaz', 'Estado de Mexico', 09878);

SELECT * FROM CLIENTE;
----------------------------------------------------------------------------------------------
--TABLA 7

INSERT INTO EMAIL_CLIENTE(email, id_cliente) 
VALUES ('almaneni@gmail.com', 1),
		('ivam12@gmail.com', 2),
		('sofirivas_silva@gmail.com', 3),
		('anita1_guti@hotmail.com', 4),
		('lic_pedro_robles@gmail.com', 5),
		('pau_zoe92@hotmail.com', 6),
		('morrison_jos@gmail.com', 7),
		('luis_lust@gmail.com', 8),
		('sanpa_bea@gmail.com', 9),
		('salma89-jim-re@gmail.com', 10);

SELECT * FROM EMAIL_CLIENTE;

----------------------------------------------------------------------------------------------
--TABLA 8

INSERT INTO VENTA(numero_venta, id_cliente, fecha_venta)
VALUES('VENT-001', 1, '20201202'), ('VENT-002', 2, '20201115'), ('VENT-003', 3, '20201119'),
	('VENT-004', 4, '20201015'), ('VENT-005', 5, '20210105'), ('VENT-006', 1, '20201115'),
	('VENT-007', 6, '20200920'), ('VENT-008', 7, '20201125'), ('VENT-009', 9, '20210105'),
	('VENT-010', 10, '20210110');

INSERT INTO VENTA(numero_venta, id_cliente, fecha_venta)
VALUES('VENT-011', 8, '20201202');

SELECT * FROM VENTA;

----------------------------------------------------------------------------------------------
--TABLA 9
INSERT INTO VENTA_DETALLES(numero_venta, id_producto, precio_unitario, cantidad)
VALUES('VENT-001',1,5,2), ('VENT-002',1,5,10), ('VENT-003',18,1.5,20),('VENT-004',9,50,1),
		('VENT-005',26,150,1), ('VENT-006',13,300,1), ('VENT-007',37,100,1),
		('VENT-008',2,3,1), ('VENT-009',6,150,1), ('VENT-010',12,200, 1), ('VENT-011',21,10,2);

SELECT * FROM VENTA_DETALLES;
