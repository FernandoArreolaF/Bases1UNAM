/* ============================================================
    PapyrusDB Solutions - Sistema de Gestión para Papelería

    Archivo: [SCRUM-18_Para el agregado de información.sql]
    Descripción: En este se muestra el DML empleado en la base de datos incliyendo el agregado de nuevos
	registros y actualizaciones que son necesarias. De haberse necesitado la eliminacion de registros tambien
	se hubierna puesto en este scrip. Finalmente, se añadieron índices destinados a optimizar
	el rendimiento de las consultas.


    Fecha: [6 de diciembre del 2025]
   ============================================================*/

-- PRIMERA INSERCIONES DE PRUEBA 
/*(DESPUES DE LOS PRIMETROS TRIGGERS QUE VALIDAN EL CORREO MINIMO POR CLIENTE, EL DE MANEJO DE STOCK,
PRECIOS Y PAGOS TOTALES)*/


-- TABLAS PRINCIPALES

INSERT INTO proveedor VALUES
('PROV-001', 'Exel del Norte', 'Exel del Norte S.A. de C.V.', 'Nuevo León', 'Cumbres 1er Sector', 'Av. Lázaro Cárdenas', 18,  64920),
('PROV-002', 'CT Internacional', 'CT Internacional del Noroeste S.A. de C.V.','CDMX','Coapa','Calz Acoxpa', 40, 14390),
('PROV-003', 'PCH Mayoreo', 'PCH Mayoreo S.A. de C.V.', 'CDMX', 'Doctores', 'Dr. José María Vértiz', 43, 06720),
('PROV-004', 'DC Mayorista', 'Distribuidor de Cómputo Mayorista S.A. de C.V.', 'Jalisco', 'Jardines del Bosque', 'Av. Mariano Otero', 98, 44520);


INSERT INTO producto VALUES
('PROD-001', 'Casio', 'Calculadora científica FX-95MS', 299.00, 'PAPE'),
('PROD-002', 'Casio', 'Calculadora científica FX-570MS', 450.00, 'PAPE'),
('PROD-003', 'HP', 'Calculadora científica HP10s', 380.00, 'PAPE'),
('PROD-004', 'Manhattan', 'Cable USB-C reforzado 1m', 120.00, 'PAPE'),
('PROD-005', 'Logitech', 'Mouse inalámbrico M185', 259.00, 'PAPE'),
('PROD-006', 'Canon', 'Impresión blanco y negro por hoja', 1.50, 'IMPR'),
('PROD-007', 'HP', 'Impresión color por hoja', 3.00, 'IMPR'),
('PROD-008', 'PlotterPro', 'Impresión tamaño tabloide', 15.00, 'IMPR'),
('PROD-009', 'LaserPrint', 'Escaneo de documentos por hoja', 2.00, 'IMPR'),
('PROD-010', 'FotoExpress', 'Impresión fotográfica 10x15', 6.00, 'IMPR'),
('PROD-011', 'Telcel', 'Recarga electrónica $50', 50.00, 'RECA'),
('PROD-012', 'Movistar', 'Recarga electrónica $100', 100.00, 'RECA'),
('PROD-013', 'AT&T', 'Recarga electrónica $150', 150.00, 'RECA'),
('PROD-014', 'RegalosMX', 'Taza personalizada de cerámica', 150.00, 'REGA'),
('PROD-015', 'PaperGift', 'Agenda 2025 edición premium', 220.00, 'REGA'),
('PROD-016', 'Aurora', 'Peluche de animal de 15 cm', 95.00, 'REGA'),
('PROD-017', 'Creativa', 'Llavero metálico grabado', 40.00, 'REGA'),
('PROD-018', 'DecoArt', 'Tarjeta de regalo decorativa', 25.00, 'REGA');

INSERT INTO empleado VALUES
('EMP-001', 'Alejandro', 'Campos', 'Rodriguez', 'CDMX', 'Narvarte Poniente', 'La Quemada', 120, 03020, '5556123001'),
('EMP-002', 'Jorge','Martínez', 'Huerta', 'CDMX', 'Real del Moral', 'Río Tlalpenco', 55, 06760, '5557348822'),
('EMP-003', 'Sandra', 'Hernández', 'Castro', 'CDMX', 'Del Valle', 'Pilares', 78, 03100, '5588447733'),
('EMP-004', 'Luis', 'Hernández', 'Mendoza', 'CDMX', 'Nápoles','Arizona', 86, 03810, '5578329911'),
('EMP-005', 'Ricardo', 'Mendoza', 'Gómez', 'CDMX', 'Condesa', 'Atlixco', 90, 06170, '5567329988');

INSERT INTO cliente VALUES
('CLI-001', 'RALJ900215HMX', 'José', 'Ramírez', 'López', 'CDMX', 'Portales Norte', 'Filadelfia', 87, 03303),
('CLI-002', 'GOGG920101HMX', 'Gabriel', 'González', 'García', 'EdoMex', 'Las Américas', 'Av. Central', 76, 55070),
('CLI-003', 'CALL940522HMX', 'Luis', 'Cárdenas', 'López', 'CDMX', 'Iztacalco', 'Sur 16', 10, 08900),
('CLI-004', 'GUOA880311HMX', 'Alejandra', 'Gutiérrez', 'Ortiz', 'CDMX', 'Roma Norte', 'Zacatecas', 65, 06700),
('CLI-005', 'SERI950715HMX', 'Erick', 'Serrano', 'Ríos', 'EdoMex', 'Ciudad Azteca', 'Av. Hank González', 25, 55120);


-- TABLAS DEPENDIENTES

INSERT INTO telProveedor VALUES
('TEL-001', 'PROV-001', '5554889067'),
('TEL-002', 'PROV-002', '5522106060'),
('TEL-003', 'PROV-003', '5557896500'),
('TEL-004', 'PROV-004', '5584044408');

INSERT INTO emailCliente VALUES
('EMA-001', 'CLI-001', 'jose.ramirez@gmail.com'),
('EMA-002', 'CLI-002', 'gab.gon.ga@hotmail.com'),
('EMA-003', 'CLI-003', 'luis.cardenas@outlook.com'),
('EMA-004', 'CLI-004', 'maria.gtz@gmail.com'),
('EMA-005', 'CLI-005', 'erick.serrano@gmail.com');

-- INVENTARIO (1 registro por producto)

INSERT INTO inventario VALUES
('INV-001', 'PROD-001', 220.00, NULL, '2025-01-10', 40),
('INV-002', 'PROD-002', 330.00, NULL, '2025-01-11', 25),
('INV-003', 'PROD-003', 300.00, NULL, '2025-01-12', 30),
('INV-004', 'PROD-004', 80.00, NULL, '2025-01-13', 60),
('INV-005', 'PROD-005', 180.00, NULL, '2025-01-14', 50);

-- ENTREGA 

INSERT INTO entrega (idProveedor, idProducto, fechaEntrega) VALUES
('PROV-001', 'PROD-001', '2025-11-10'),
('PROV-001', 'PROD-002', '2025-11-11'),
('PROV-002', 'PROD-003', '2025-11-12'),
('PROV-003', 'PROD-004', '2025-11-13'),
('PROV-004', 'PROD-005', '2025-11-14');

-- VENTAS

INSERT INTO venta VALUES
('VENT-001', 'CLI-001', 'EMP-001', '2025-12-01', 0),
('VENT-002', 'CLI-002', 'EMP-002', '2025-12-03', 0),
('VENT-003', 'CLI-003', 'EMP-003', '2025-12-04', 0),
('VENT-004', 'CLI-004', 'EMP-004', '2025-12-05', 0),
('VENT-005', 'CLI-005', 'EMP-005', '2025-12-06', 0),
('VENT-006', 'CLI-002', 'EMP-005', '2025-12-03', 0),
('VENT-007', 'CLI-001', 'EMP-003', '2025-12-03', 0);

-- DETALLE VENTA (PK compuesta + triggers)

INSERT INTO detalleVenta (idProducto, idVenta, cantidadProducto) VALUES
('PROD-001', 'VENT-001', 1),
('PROD-004', 'VENT-002', 1),
('PROD-002', 'VENT-003', 1),
('PROD-003', 'VENT-004', 1),
('PROD-005', 'VENT-005', 1),
('PROD-001', 'VENT-006', 1),
('PROD-004', 'VENT-007', 1);


-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- INSERCIONES PARA OBSERVAR DE MEJOR MANERA EL COMPORTAMIENTO DE LA DB Y LA CREACIÓN DE LOS DASHBOARD
/*(DESPUES DE LOS TRIGGERS Y FUNCIONES QUE GENERAN PK MEDIANTE SECUENCIAS)*/

-- TABLAS PRINCIPALES

-- Cliente 
INSERT INTO cliente (rfc, nombre, apPat, apMat, estado, colonia, calle, numero, cp) VALUES
('ROGL850715HM0','Roberto','Gómez','Lara','CDMX','Roma Norte','Chiapas',123,06700),
('MAAR920312HM1','María','Arcos','Ramírez','CDMX','Del Valle','Pilares',88,03100),
('HECJ880501HM2','Héctor','Cruz','Jiménez','CDMX','Narvarte','Zempoala',54,03020),
('ALGR900914HM3','Alina','García','Rodríguez','CDMX','Polanco','Homero',610,11550),
('JOMM950227HM4','Jorge','Martínez','Mora','CDMX','Portales','Necaxa',21,03300),
('SAHN870903HM5','Sandra','Hernández','Nava','CDMX','Iztacalco','Oriente 116',443,08200),
('FELP990715HM6','Felipe','López','Paredes','CDMX','Tlalpan','Insurgentes Sur',3855,14000),
('ANRS820430HM7','Ana','Ríos','Soto','CDMX','Coyoacán','Miguel Ángel',77,04030),
('LUGA930112HM8','Luis','García','Álvarez','CDMX','Ajusco','Cumbres',52,04300),
('BECR910629HM9','Berenice','Castro','Rivas','CDMX','Roma Sur','Tonalá',216,06760),
('JUPA940406HM0','Julián','Paredes','Aguilar','CDMX','Del Carmen','Valladolid',14,04100),
('CRVL860518HM1','Carla','Villarreal','López','CDMX','San Ángel','Revolución',1329,01000),
('MORI970223HM2','Montserrat','Ríos','Ibarra','CDMX','Mixcoac','Goya',33,03930),
('EDHE810711HM3','Edgar','Hernández','Espinoza','CDMX','Tacubaya','Jalisco',72,11870),
('ARFU980825HM4','Arturo','Fuentes','Ugalde','CDMX','Coapa','Miramontes',3020,04980),
('PALU890125HM5','Patricia','Luna','Ulloa','CDMX','Juárez','Liverpool',23,06600),
('RAOS850904HM6','Raúl','Osejo','Salas','CDMX','Santa María la Ribera','Naranjo',188,06400),
('YAGR930218HM7','Yazmín','Guerra','Roldán','CDMX','Nápoles','Nueva York',45,03810),
('HUMA920331HM8','Hugo','Martínez','Alfaro','CDMX','Hipódromo','Amsterdam',84,06100),
('MAGO990914HM9','Marco','Gómez','Ortega','CDMX','Condesa','Mazatlán',177,06140),
('ELSA850722HM0','Elsa','Sánchez','Arana','CDMX','Anzures','Ejército Nacional',436,11590),
('DAVR960110HM1','David','Rangel','Ruiz','CDMX','Obrera','Bolívar',235,06800),
('SOMA880925HM2','Sofía','Maldonado','Arias','CDMX','Doctores','Dr. Vértiz',94,06720),
('JUGA900515HM3','Julia','García','Ahumada','CDMX','Lindavista','Monte Albán',30,07300),
('CATO910803HM4','Carmen','Torres','Olivo','CDMX','Industrial','Te',88,07800),
('MAVE870129HM5','Manuel','Vega','Esquivel','CDMX','Magdalena Mixhuca','Sur 16',120,08500),
('POMA950920HM6','Pola','Martínez','Aguirre','CDMX','Granada','Lago Ginebra',29,11520),
('GARE920403HM7','Gaby','Reyes','Estrada','CDMX','Buenavista','Insurgentes Norte',601,06350),
('VIRI991120HM8','Viridiana','Rivas','Ibarra','CDMX','Centro','5 de Mayo',12,06000),
('RUMA830212HM9','Ruth','Martínez','Alonso','CDMX','Roma Norte','Querétaro',155,06700),
('ENAG860427HM0','Enrique','Aguilar','Gutiérrez','CDMX','San Rafael','Sullivan',19,06470),
('SACE980803HM1','Sara','Cervantes','Enríquez','CDMX','Portales','Cafetales',41,03570),
('ROPA930331HM2','Rodrigo','Paredes','Alcántara','CDMX','Narvarte Poniente','La Quemada',63,03030),
('KALO940125HM3','Karen','López','Ocampo','CDMX','Iztacalco','Plutarco Elías Calles',345,08900),
('ALHI970520HM4','Alberto','Hidalgo','Iñiguez','CDMX','Tlacoquemécatl','Pilares',120,03200),
('FEMA850911HM5','Fernanda','Maldonado','Arriaga','CDMX','Roma Sur','Manzanillo',198,06760),
('NARO960214HM6','Nancy','Rojas','Olea','CDMX','Agrícola Oriental','Nte. 174',223,08520),
('SERU990723HM7','Sergio','Ruiz','Uribe','CDMX','Doctores','Dr. Río de la Loza',102,06720),
('JISI880909HM8','Jimena','Silva','Ibáñez','CDMX','Escandón','José Martí',55,11800),
('ALVA920124HM9','Alejandro','Valencia','Arias','CDMX','Guerrero','Mosqueta',200,06300),
('LUCH950715HM0','Lucía','Chávez','Hernández','CDMX','Santa Úrsula','Aztecas',340,04650),
('MORO900821HM1','Mónica','Robles','Ortega','CDMX','San Pedro de los Pinos','1 de Mayo',78,03800),
('DUGA870315HM2','Dulce','García','Amaro','CDMX','Anáhuac','Lago Alberto',320,11320),
('EDVA980602HM3','Eduardo','Vargas','Arias','CDMX','Tacuba','Mar Mediterráneo',18,11410),
('YOME891130HM4','Yolanda','Mendoza','Estrada','CDMX','Roma Norte','Yucatán',45,06700),
('ARPA950407HM5','Araceli','Paz','Alfaro','CDMX','Del Valle','Concepción Béistegui',908,03100),
('TORE920209HM6','Tomás','Reyes','Esparza','CDMX','Narvarte','Luz Saviñón',300,03020),
('GAMO990314HM7','Gabriel','Montiel','Orozco','CDMX','Juárez','Copenhague',14,06600),
('MALO880728HM8','Marisol','López','Oliva','CDMX','Escandón','Agrarismo',266,11800),
('FRHE910921HM9','Froylán','Hernández','Espadas','CDMX','Pensil','Lago Erne',12,11460);


-- INVENTARIO FALTANTE PARA PRODUCTOS 6 AL 18 DEBIDO A QUE NO HAY EN STOCK
INSERT INTO inventario (codigoBarras, idProducto, precioCompra, foto, fechaCompra, stock) VALUES
('INV-006', 'PROD-006', 120.00, NULL, '2025-01-01', 35),
('INV-007', 'PROD-007', 90.00,  NULL, '2025-01-02', 42),
('INV-008', 'PROD-008', 150.00, NULL, '2025-01-03', 28),
('INV-009', 'PROD-009', 70.00,  NULL, '2025-01-04', 55),
('INV-010', 'PROD-010', 45.00,  NULL, '2025-01-05', 60),
('INV-011', 'PROD-011', 30.00,  NULL, '2025-01-06', 48),
('INV-012', 'PROD-012', 55.00,  NULL, '2025-01-07', 32),
('INV-013', 'PROD-013', 80.00,  NULL, '2025-01-08', 40),
('INV-014', 'PROD-014', 100.00, NULL, '2025-01-09', 52),
('INV-015', 'PROD-015', 160.00, NULL, '2025-01-10', 33),
('INV-016', 'PROD-016', 85.00,  NULL, '2025-01-11', 29),
('INV-017', 'PROD-017', 40.00,  NULL, '2025-01-12', 61),
('INV-018', 'PROD-018', 15.00,  NULL, '2025-01-14', 70);




-- TABLAS DEPENDIENTES

-- emailCliente
INSERT INTO emailCliente (idCliente, email) VALUES
('CLI-006','roberto.gomez@gmail.com'),
('CLI-007','maria.arcos@gmail.com'),
('CLI-008','hector.cruz@hotmail.com'),
('CLI-009','alina.garcia@gmail.com'),
('CLI-010','jorge.martinez@yahoo.com'),
('CLI-011','sandra.hernandez@gmail.com'),
('CLI-012','felipe.lopez@hotmail.com'),
('CLI-013','ana.rios@gmail.com'),
('CLI-014','luis.garcia@gmail.com'),
('CLI-015','berenice.castro@hotmail.com'),
('CLI-016','julian.paredes@gmail.com'),
('CLI-017','carla.villarreal@gmail.com'),
('CLI-018','montserrat.rios@hotmail.com'),
('CLI-019','edgar.hernandez@gmail.com'),
('CLI-020','arturo.fuentes@gmail.com'),
('CLI-021','patricia.luna@yahoo.com'),
('CLI-022','raul.osejo@gmail.com'),
('CLI-023','yazmin.guerra@gmail.com'),
('CLI-024','hugo.martinez@hotmail.com'),
('CLI-025','marco.gomez@gmail.com'),
('CLI-026','elsa.sanchez@yahoo.com'),
('CLI-027','david.rangel@gmail.com'),
('CLI-028','sofia.maldonado@gmail.com'),
('CLI-029','julia.garcia@gmail.com'),
('CLI-030','carmen.torres@hotmail.com'),
('CLI-031','manuel.vega@gmail.com'),
('CLI-032','pola.martinez@gmail.com'),
('CLI-033','gaby.reyes@gmail.com'),
('CLI-034','viridiana.rivas@gmail.com'),
('CLI-035','ruth.martinez@gmail.com'),
('CLI-036','enrique.aguilar@hotmail.com'),
('CLI-037','sara.cervantes@gmail.com'),
('CLI-038','rodrigo.paredes@gmail.com'),
('CLI-039','karen.lopez@hotmail.com'),
('CLI-040','alberto.hidalgo@gmail.com'),
('CLI-041','fernanda.maldonado@gmail.com'),
('CLI-042','nancy.rojas@gmail.com'),
('CLI-043','sergio.ruiz@yahoo.com'),
('CLI-044','jimena.silva@gmail.com'),
('CLI-045','alejandro.valencia@gmail.com'),
('CLI-046','lucia.chavez@gmail.com'),
('CLI-047','monica.robles@hotmail.com'),
('CLI-048','dulce.garcia@gmail.com'),
('CLI-049','eduardo.vargas@yahoo.com'),
('CLI-050','yolanda.mendoza@gmail.com'),
('CLI-051','araceli.paz@gmail.com'),
('CLI-052','tomas.reyes@gmail.com'),
('CLI-053','gabriel.montiel@gmail.com'),
('CLI-054','marisol.lopez@gmail.com'),
('CLI-055','froylan.hernandez@gmail.com');


--VENTAS PARA DISTRIBUIR A LO LARGO DE TODO EL PERIODO 2025 Y OBSERVAR EL COMPORTAMIENTO EN EL DASHBOARD.
INSERT INTO venta (idCliente, idEmpleado, fechaVenta, pagoTotal) VALUES
('CLI-012','EMP-003','2025-01-04',0),
('CLI-034','EMP-001','2025-01-15',0),
('CLI-009','EMP-005','2025-01-22',0),
('CLI-028','EMP-004','2025-01-28',0),

('CLI-017','EMP-002','2025-02-03',0),
('CLI-041','EMP-003','2025-02-10',0),
('CLI-006','EMP-001','2025-02-14',0),
('CLI-023','EMP-005','2025-02-27',0),

('CLI-048','EMP-004','2025-03-02',0),
('CLI-015','EMP-005','2025-03-09',0),
('CLI-031','EMP-002','2025-03-15',0),
('CLI-052','EMP-003','2025-03-26',0),

('CLI-020','EMP-001','2025-04-01',0),
('CLI-008','EMP-004','2025-04-12',0),
('CLI-039','EMP-003','2025-04-18',0),
('CLI-027','EMP-005','2025-04-29',0),

('CLI-033','EMP-002','2025-05-02',0),
('CLI-014','EMP-005','2025-05-08',0),
('CLI-045','EMP-003','2025-05-19',0),
('CLI-011','EMP-001','2025-05-28',0),

('CLI-018','EMP-004','2025-06-03',0),
('CLI-050','EMP-003','2025-06-09',0),
('CLI-004','EMP-002','2025-06-17',0),
('CLI-026','EMP-001','2025-06-28',0),

('CLI-021','EMP-005','2025-07-06',0),
('CLI-036','EMP-004','2025-07-10',0),
('CLI-010','EMP-002','2025-07-15',0),
('CLI-055','EMP-003','2025-07-27',0),

('CLI-032','EMP-001','2025-08-04',0),
('CLI-029','EMP-005','2025-08-11',0),
('CLI-044','EMP-003','2025-08-20',0),
('CLI-003','EMP-004','2025-08-28',0),

('CLI-025','EMP-002','2025-09-03',0),
('CLI-051','EMP-001','2025-09-12',0),
('CLI-007','EMP-005','2025-09-17',0),
('CLI-040','EMP-003','2025-09-26',0),

('CLI-016','EMP-004','2025-10-03',0),
('CLI-047','EMP-003','2025-10-11',0),
('CLI-022','EMP-002','2025-10-18',0),
('CLI-053','EMP-001','2025-10-29',0),

('CLI-024','EMP-005','2025-11-02',0),
('CLI-001','EMP-005','2025-11-07',0),
('CLI-030','EMP-002','2025-11-15',0),
('CLI-043','EMP-004','2025-11-22',0),
('CLI-019','EMP-003','2025-11-27',0),
('CLI-054','EMP-001','2025-11-30',0);


-- DETALLE DE VENTA. SE INCLUYERON UN RANGO DE PRODUCTOS POR VENTA DE 1 A 5 Y ALGUNOS CASOS EXTRAORDINARIOS.
-- VENT-008 (4 productos)
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-008','PROD-001',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-001'
UNION ALL
SELECT 'VENT-008','PROD-002',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-002'
UNION ALL
SELECT 'VENT-008','PROD-003',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-003'
UNION ALL
SELECT 'VENT-008','PROD-004',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-004';

-- VENT-009 (4 productos)
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-009','PROD-005',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-005'
UNION ALL
SELECT 'VENT-009','PROD-006',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-006'
UNION ALL
SELECT 'VENT-009','PROD-007',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-007'
UNION ALL
SELECT 'VENT-009','PROD-008',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-008';

-- VENT-010 (venta "extraordinaria": 7 productos)
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-010','PROD-009',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-009'
UNION ALL
SELECT 'VENT-010','PROD-010',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-010'
UNION ALL
SELECT 'VENT-010','PROD-011',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-011'
UNION ALL
SELECT 'VENT-010','PROD-012',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-012'
UNION ALL
SELECT 'VENT-010','PROD-013',4, p.precioVenta, p.precioVenta*4 FROM producto p WHERE p.idProducto='PROD-013'
UNION ALL
SELECT 'VENT-010','PROD-014',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-014'
UNION ALL
SELECT 'VENT-010','PROD-015',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-015';

-- VENT-011
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-011','PROD-016',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-016'
UNION ALL
SELECT 'VENT-011','PROD-017',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-017'
UNION ALL
SELECT 'VENT-011','PROD-018',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-018'
UNION ALL
SELECT 'VENT-011','PROD-001',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-001';

-- VENT-012
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-012','PROD-002',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-002'
UNION ALL
SELECT 'VENT-012','PROD-003',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-003'
UNION ALL
SELECT 'VENT-012','PROD-004',4, p.precioVenta, p.precioVenta*4 FROM producto p WHERE p.idProducto='PROD-004'
UNION ALL
SELECT 'VENT-012','PROD-005',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-005';

-- VENT-013
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-013','PROD-006',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-006'
UNION ALL
SELECT 'VENT-013','PROD-007',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-007'
UNION ALL
SELECT 'VENT-013','PROD-008',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-008'
UNION ALL
SELECT 'VENT-013','PROD-009',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-009';

-- VENT-014
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-014','PROD-010',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-010'
UNION ALL
SELECT 'VENT-014','PROD-011',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-011'
UNION ALL
SELECT 'VENT-014','PROD-012',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-012'
UNION ALL
SELECT 'VENT-014','PROD-013',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-013';

-- VENT-015
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-015','PROD-014',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-014'
UNION ALL
SELECT 'VENT-015','PROD-015',4, p.precioVenta, p.precioVenta*4 FROM producto p WHERE p.idProducto='PROD-015'
UNION ALL
SELECT 'VENT-015','PROD-016',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-016'
UNION ALL
SELECT 'VENT-015','PROD-017',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-017';

-- VENT-016 (extraordinaria)
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-016','PROD-018',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-018'
UNION ALL
SELECT 'VENT-016','PROD-001',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-001'
UNION ALL
SELECT 'VENT-016','PROD-002',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-002'
UNION ALL
SELECT 'VENT-016','PROD-003',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-003'
UNION ALL
SELECT 'VENT-016','PROD-004',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-004'
UNION ALL
SELECT 'VENT-016','PROD-005',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-005'
UNION ALL
SELECT 'VENT-016','PROD-006',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-006';

-- VENT-017
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-017','PROD-007',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-007'
UNION ALL
SELECT 'VENT-017','PROD-008',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-008'
UNION ALL
SELECT 'VENT-017','PROD-009',4, p.precioVenta, p.precioVenta*4 FROM producto p WHERE p.idProducto='PROD-009'
UNION ALL
SELECT 'VENT-017','PROD-010',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-010';

-- VENT-018
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-018','PROD-011',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-011'
UNION ALL
SELECT 'VENT-018','PROD-012',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-012'
UNION ALL
SELECT 'VENT-018','PROD-013',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-013'
UNION ALL
SELECT 'VENT-018','PROD-014',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-014';

-- VENT-019
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-019','PROD-015',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-015'
UNION ALL
SELECT 'VENT-019','PROD-016',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-016'
UNION ALL
SELECT 'VENT-019','PROD-017',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-017'
UNION ALL
SELECT 'VENT-019','PROD-018',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-018';

-- VENT-020 (extraordinaria)
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-020','PROD-001',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-001'
UNION ALL
SELECT 'VENT-020','PROD-002',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-002'
UNION ALL
SELECT 'VENT-020','PROD-003',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-003'
UNION ALL
SELECT 'VENT-020','PROD-004',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-004'
UNION ALL
SELECT 'VENT-020','PROD-005',4, p.precioVenta, p.precioVenta*4 FROM producto p WHERE p.idProducto='PROD-005'
UNION ALL
SELECT 'VENT-020','PROD-006',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-006'
UNION ALL
SELECT 'VENT-020','PROD-007',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-007';


-- VENT-021
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-021','PROD-008',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-008'
UNION ALL
SELECT 'VENT-021','PROD-009',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-009'
UNION ALL
SELECT 'VENT-021','PROD-010',3, p.precioVenta, p.precioVenta*3 FROM producto p WHERE p.idProducto='PROD-010'
UNION ALL
SELECT 'VENT-021','PROD-011',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-011';

-- VENT-022
INSERT INTO detalleVenta (idVenta, idProducto, cantidadProducto, precioUnitarioPorProd, precioTotalPorProd)
SELECT 'VENT-022','PROD-012',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-012'
UNION ALL
SELECT 'VENT-022','PROD-013',2, p.precioVenta, p.precioVenta*2 FROM producto p WHERE p.idProducto='PROD-013'
UNION ALL
SELECT 'VENT-022','PROD-014',4, p.precioVenta, p.precioVenta*4 FROM producto p WHERE p.idProducto='PROD-014'
UNION ALL
SELECT 'VENT-022','PROD-015',1, p.precioVenta, p.precioVenta*1 FROM producto p WHERE p.idProducto='PROD-015';


-- ACTUALIZACIÓN MASIVA DEL pagoTotal DESPUES DE AGREGAR LOS REGISTROS EN LA TABLA detalleVenta
UPDATE venta v
SET pagoTotal = COALESCE((
    SELECT SUM(d.precioTotalPorProd)
    FROM detalleVenta d
    WHERE d.idVenta = v.idVenta
), 0);


-- CREACIÓN DE LOS ÍNDICES PARA AGILIZAR LAS CONSULTAS

-- ÍNDICE SOBRE detalleVenta(idVenta)
-- Permite recuperar rápidamente todos los productos relacionados con un idVenta específico.
CREATE INDEX idx_detalleVenta_idVenta
ON detalleVenta (idVenta);

-- ÍNDICE SOBRE inventario(stock)
-- Facilita la identificación de productos con inventario bajo, alto o en rangos específicos.
CREATE INDEX idx_inventario_stock
ON inventario (stock);

-- ÍNDICE SOBRE producto(categoria)
-- Permite ejecutar de manera más eficiente consultas filtradas por tipos de productos.
CREATE INDEX idx_producto_categoria
ON producto (categoria);
