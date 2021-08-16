--TABLA 1 

INSERT INTO PROVEEDOR(razon_social,nom_prov,calle_prov,colonia_prov,estado_prov,numCalle_prov,cp_prov)
VALUES ('Producto Comercial S.A.', 'Utiles Mexico', 'Mesones','Algarines', 'CDMX', '25', 15585),
	  ('Material escolar S.A.', 'Plumas diamantes', 'Francisco Riu', 'Doctores', 'EDO MEX', '85', 15896),
	  ('Construye maderas S.A.', 'Papeleria Rodriguez', 'Odesa', 'Mixcoac', 'CDMX','52', 45875),
	  ('Comercial blanco S.L.', 'Mayoreo Delfin', 'Crater', 'Senderos', 'CDMX', '754', 69843),
	  ('Grupo papelero S.A.', 'Papelerias Domit', 'Principal', 'Profesionistas', 'CDMX', '4', 57846);

INSERT INTO PROVEEDOR(razon_social,nom_prov,calle_prov,colonia_prov,estado_prov,numCalle_prov,cp_prov)
VALUES ('Fabricados modernos S.L.', 'Fabrica Mex', 'Benito Juarez', 'Santa Ana', 'CDMX', '40', 01856),
	  ('Alianza papelera', 'Sander Papeleria', 'Plata', 'Asturias', 'CDMX', '97', 01739),
	  ('Encuadernado Solis S.A.', 'Papeleria Solis', 'Revolucion', 'Portales', 'CDMX', '634', 20739),
	  ('Producto Innovador S.A.', 'Toledos Max', 'Calvario', 'Centenario', 'CDMX', '854', 99738),
	  ('Fu y asociados S.A.S', 'Ventas Garcia', 'Delfines', 'Pilares', 'CDMX', '26', 75943);


SELECT * FROM PROVEEDOR;
----------------------------------------------------------------------------------------------
--TABLA 2

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(55968452, 1);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5568978091, 2), (5530089900, 2);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5529979901, 3);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5599960024, 4), (5528797745, 4), (5589704532, 4);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5512647964, 5);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5587400873, 6);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5214677900, 7);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5536385902, 8);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5555719421, 9);

INSERT INTO TEL_PROVEEDOR(telefono, id_proveedor) 
VALUES(5592719421, 10);

SELECT * FROM TEL_PROVEEDOR;

----------------------------------------------------------------------------------------------

--TABLA 3

--PAPELERIA

INSERT INTO PRODUCTO(codigo_barras, nom_producto,marca, precio, categoria, descripcion)
VALUES('P56420K1','Pluma negra','BIC',10,'Utiles','Pluma de punta fina'),
	('P45678T4','Goma','FACTIS',8,'Utiles','Goma de migajon'),
	('Q23874U2','Colores 24 piezas','Prismacolor',159,'Utiles','Colores premium'),
	('R45762P4','Tijeras','Dietrix',52,'Utiles','Tijeras profesonales');
	  	  
--COMPUTO 

INSERT INTO PRODUCTO(codigo_barras, nom_producto,marca, precio, categoria, descripcion)
VALUES('B18425Y8','Calculadora cientifica','Casio',350,'Computo','Fx-991-ex'),
	('W23659F7','Tableta 7 pulgadas','Hyundai',3800,'Computo','Tableta escolar'),
	('Q23123G4','Laptop Chrome','Hp',12000,'Computo','Laptop escolar'),
	('R45653F3','Mini Laptop','Asus',15000,'Computo','Laptop xseries');

--IMPRESIONES 

INSERT INTO PRODUCTO(codigo_barras, nom_producto,marca, precio, categoria, descripcion)
VALUES('B78552T1','Impresion Color','S/M',8,'Impresiones','Impresion laser'),
	  ('W34625L2','Impresion B/N','S/M',0.50,'Impresiones','Impresion laser'),
	  ('B05798P3','Escaneo de documento','S/M',10,'Impresiones','La primeras 5 paginas'),
	  ('B56872X4','Ploteo de planos','S/M',25,'Impresiones','Tamaño A4');

--RECARGAS 

INSERT INTO PRODUCTO(codigo_barras, nom_producto,marca, precio, categoria, descripcion)
VALUES('B23335L8','Recarga Telcel 10', 'Movistar',10,'Recargas','Sin comision'),
	  ('R45129U0','Recarga Telcel 20','Recargas',20,'Recargas','Sin comision'),
	  ('B56098R0','Recarga Telcel 50','Recargas',50,'Recargas','Sin comision'),
	  ('K45318K8','Recarga Telcel 200','Recargas',200,'Recargas','Sin comision'),
	  ('V34098G3','Recarga Telcel 500','Recargas',500,'Recargas','Sin comision');


SELECT * FROM PRODUCTO;
----------------------------------------------------------------------------------------------


--TABLA 4--
INSERT INTO VENTA_PROVEEDOR(id_proveedor, codigo_barras, fecha_compra, precio_compra)
VALUES(1,'W23659F7','2021-05-25',2750),
	(4,'P56420K1','2021-02-21',6),
	(8,'B18425Y8','2021-07-30',200),
	(3,'Q23874U2','2021-07-05',99);

SELECT * FROM VENTA_PROVEEDOR;

----------------------------------------------------------------------------------------------

--TABLA 5
INSERT INTO INVENTARIO(codigo_barras,stock)
VALUES ('P56420K1',200),
	('P45678T4',120),
	('Q23874U2',10),
	('R45762P4',25),
	('B18425Y8',4),
	('W23659F7',6),
	('Q23123G4',2),
	('R45653F3',1);

SELECT * FROM INVENTARIO;

----------------------------------------------------------------------------------------------

--TABLA 6
INSERT INTO CLIENTE(rfc, nom_cliente, apellido_cliente, calle_cliente, numC_cliente, colonia_cliente, cp_cliente, estado_cliente)
VALUES ('FEROA09H0148', 'Rodrigo', 'Fernandez', 'Ficus', '65', 'Bosques', 15748, 'CDMX'),
		('MENFA95G4578','Fabricio','Mendez','Federal','967','Doctores',58796,'CDMX'),
		('DOMCA58R5874','Carolina','Dominguez','Sendero','85','Wester',58796,'PUEBLA'),
		('MONSA00P6452','Saul','Montes','Tulipan','30','Santa Lucia',58796,'CDMX'),
		('ASPJU11K6507','Julia','Aspe','Odesa','14','Lomas del fresno',58796,'MORELOS');

INSERT INTO CLIENTE(rfc, nom_cliente, apellido_cliente, calle_cliente, numC_cliente, colonia_cliente, cp_cliente, estado_cliente)
VALUES ('CARRA04T9865','Raul','Carranza','Toledo','20','Anzures',58796,'GUANAJUATO'),
	   ('GUIDI96T5201','Diego','Guillen','Volcanes','1015','Nuevo mundo',58796,'EDO MEX'),
	   ('VERFA45K6532','Fabiola','Vergara','Copernico','10','Salinas',58796,'MORELOS'),
	   ('TORRU74F1096','Rubi','Torres','Dominicana','63','Federaciones',58796,'CDMX'),
	   ('ROBME00P9510','Melisa','Robles','Giulia','85','Franco',58796,'CDMX');

SELECT * FROM CLIENTE;

----------------------------------------------------------------------------------------------

--TABLA 7

INSERT INTO EMAIL_CLIENTE(email, id_cliente) 
VALUES ('ferroo@gmail.com', 1),
		('demuter@gmail.com', 2),
		('caro_dop@gmail.com', 3),
		('color_rosa@gmail.com', 3),
		('sasasa97@gmail.com', 4),
		('jul_aspe89@gmail.com', 5),
		('rulocar@hotmail.com', 6),
		('yeyojr@gmail.com', 7),
		('faby_ofi@gmail.com', 8),
		('rubicita@gmail.com', 9),
		('mielamari@gmail.com', 10);

SELECT * FROM EMAIL_CLIENTE;

----------------------------------------------------------------------------------------------

--TABLA 8

INSERT INTO VENTA(num_venta,id_cliente,fecha_venta,cantidad_articulo,precio_articulo,cantidad_total)
VALUES('VENT-001',1,'2021-07-24',2,10,20),
	('VENT-002',5,'2021-07-20',5,159,795),
	('VENT-003',2,'2021-07-20',1,15000,15000),
	('VENT-004',8,'2021-07-15',2,8,16),
	('VENT-005',7,'2021-07-12',1,380,380),
	('VENT-006',4,'2021-07-10',5,10,20),
	('VENT-007',2,'2021-07-05',3,52,156);

SELECT * FROM VENTA;

----------------------------------------------------------------------------------------------

--TABLA 9
INSERT INTO DETALLE_COMPRA (num_venta,codigo_barras)
VALUES ('VENT-001','P56420K1'),
	('VENT-002','Q23874U2'),
	('VENT-003','R45653F3'),
	('VENT-004','P45678T4'),
	('VENT-005','W23659F7'),
	('VENT-006','P56420K1'),
	('VENT-007','R45762P4');

SELECT * FROM DETALLE_COMPRA;

---------------------------------------------------------------------------------------------

--TABLA 10--

INSERT INTO FACTURA (num_venta,fecha,concepto,precio_total)
VALUES('VENT-003','2021-07-20','Compra de laptop',1500),
	('VENT-005','2021-07-12','Compra de tableta',3800);

SELECT * FROM FACTURA;