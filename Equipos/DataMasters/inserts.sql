-- =========================
-- 1) SUPPLIER (20)
-- =========================
INSERT INTO supplier (id_supplier, Name_supplier, Sup_Last_Name, Sup_Last_Name_Mom, legal_enty_type, bussines_name, street, out_num, int_num, neighborhood, state, zip_code, municipality) VALUES
(1,'Alejandro','Ramírez','Gómez','S.A. de C.V.','Papelería Azteca','Av. Reforma',120,NULL,'Juárez','CDMX','06600','Cuauhtémoc'),
(2,'María','Hernández','López','S.A. de C.V.','Impresiones Centro','Av. Juárez',85,3,'Centro','CDMX','06000','Cuauhtémoc'),
(3,'José','Martínez','Pérez','S. de R.L.','Distribuidora del Bajío','Calz. Del Valle',45,NULL,'Del Valle','Nuevo León','66220','San Pedro Garza García'),
(4,'Luisa','García','Santos','S.A. de C.V.','Suministros Occidente','Av. Patria',300,2,'Colomos','Jalisco','44660','Guadalajara'),
(5,'Arturo','Flores','Mendoza','S.A. de C.V.','Mayorista Norte','Blvd. Solidaridad',910,NULL,'Residencial','Sonora','83240','Hermosillo'),
(6,'Daniela','Rojas','Cano','S. de R.L.','Papeles del Centro','Av. Universidad',501,5,'San Ángel','CDMX','01000','Álvaro Obregón'),
(7,'Hugo','Vega','Morales','S.A. de C.V.','TecnoPrint','Av. Lázaro Cárdenas',740,NULL,'Chapultepec','Jalisco','44500','Guadalajara'),
(8,'Patricia','Sánchez','Nava','S.A. de C.V.','Recargas MX','Calz. Ignacio Zaragoza',210,NULL,'Agrícola Oriental','CDMX','08500','Iztacalco'),
(9,'Rubén','Ortiz','García','S.A. de C.V.','OfiSupply','Av. Insurgentes',1500,7,'Roma Norte','CDMX','06700','Cuauhtémoc'),
(10,'Carla','González','Reyes','S. de R.L.','Papelera del Sur','Calle 60',320,NULL,'Centro','Yucatán','97000','Mérida'),
(11,'Sergio','Luna','Campos','S.A. de C.V.','ImprimePlus','Blvd. Bernardo Quintana',2300,NULL,'Arboledas','Querétaro','76140','Querétaro'),
(12,'Mónica','Jiménez','Ibarra','S.A. de C.V.','Surtidora Maya','Av. Kabah',410,NULL,'Supermanzana 21','Quintana Roo','77500','Cancún'),
(13,'Iván','Paredes','Rico','S.A. de C.V.','Mayorista Golfo','Av. Ruiz Cortines',950,NULL,'Anáhuac','Veracruz','91910','Veracruz'),
(14,'Leticia','Aguilar','Trejo','S.A. de C.V.','Impresión Rápida','Av. Universidad',1110,12,'Centro','San Luis Potosí','78000','San Luis Potosí'),
(15,'Néstor','Cuevas','Franco','S. de R.L.','Suministros Laguna','Blvd. Independencia',600,NULL,'Navarro','Coahuila','27000','Torreón'),
(16,'Paola','Nieves','Silva','S.A. de C.V.','Recargas del Pacífico','Av. México',345,NULL,'5 de Diciembre','Jalisco','48350','Puerto Vallarta'),
(17,'Gustavo','Zamora','Salas','S.A. de C.V.','Papelería Centro Norte','Av. Revolución',505,9,'Tacubaya','CDMX','11870','Miguel Hidalgo'),
(18,'Elena','Cervantes','Ochoa','S. de R.L.','OfiMax','Periférico',2500,NULL,'Del Prado','Nuevo León','64000','Monterrey'),
(19,'Rocío','Peña','Durán','S.A. de C.V.','Papel y Tinta','Av. Independencia',88,NULL,'Centro','Puebla','72000','Puebla'),
(20,'Felipe','Mora','Soria','S.A. de C.V.','Red Móvil Recargas','Av. Tecnológico',700,4,'San Lorenzo','Estado de México','52172','Metepec');

-- =========================
-- 2) PRODUCT (20)
-- =========================
INSERT INTO product (id_product, brand, sale_price, description) VALUES
(1,'Kraftex',39.90,'Lápiz HB de grafito premium'),
(2,'PaperPlus',79.00,'Cuaderno profesional raya 100 hojas'),
(3,'OfficeMX',129.00,'Resma papel bond carta 75 g'),
(4,'InkJetPro',349.00,'Cartucho tinta negra 662 XL'),
(5,'Canon',399.00,'Tóner impresora láser 128'),
(6,'HP',299.00,'Paquete 500 hojas fotocopia'),
(7,'Staedtler',59.00,'Marcadores permanentes 4 pzas'),
(8,'BIC',49.00,'Plumas cristal 10 pzas azules'),
(9,'Telcel',50.00,'Recarga telefónica $50'),
(10,'AT&T',100.00,'Recarga telefónica $100'),
(11,'Movistar',150.00,'Recarga telefónica $150'),
(12,'Unefon',200.00,'Recarga telefónica $200'),
(13,'Epson',5.00,'Impresión b/n por hoja'),
(14,'Epson',12.00,'Impresión color por hoja'),
(15,'Xerox',3.00,'Fotocopia por hoja'),
(16,'HP',25.00,'Impresión fotográfica 10x15'),
(17,'Norma',89.00,'Carpeta de palanca tamaño carta'),
(18,'Scribe',45.00,'Block de notas adhesivas 100 hjs'),
(19,'Maped',79.00,'Tijeras escolares 6"'),
(20,'Artline',65.00,'Resaltadores pastel 6 pzas');

-- =========================
-- 3) CLIENT (20)
-- =========================
INSERT INTO client (id_client, client_name, rfc, client_last_name, client_last_name_mom, email, street_c, out_num_c, int_num_c, neighborhood_c, state_c, zip_code_c, municipality_c) VALUES
(1,'Juan Carlos','JUCA851231ABC','Moreno','López','juan.moreno@example.com','Av. Reforma',10,NULL,'Juárez','CDMX','06600','Cuauhtémoc'),
(2,'Ana Sofía','ANSO9002151K2','Gutiérrez',NULL,'ana.gtz@example.com','Insurgentes Sur',1358,5,'Del Valle','CDMX','03100','Benito Juárez'),
(3,'Miguel Ángel','MIAN9201019Z1','Pérez','García','miguel.perez@example.com','Terranova',300,NULL,'Providencia','Jalisco','44630','Guadalajara'),
(4,'Valeria','VALE950630LMN','Hernández','Ramírez','valeria.hdz@example.com','Av. Lázaro Cárdenas',900,NULL,'Chapultepec','Jalisco','44160','Guadalajara'),
(5,'Ricardo','RICO880512QW8','Santos','Nava','ricardo.santos@example.com','Blvd. Independencia',700,NULL,'Navarro','Coahuila','27000','Torreón'),
(6,'Mariana','MARI000714TT3','Flores','Cano','mariana.flores@example.com','Av. Universidad',450,2,'Copilco','CDMX','04360','Coyoacán'),
(7,'Roberto','ROBE991210AA9','Luna','Reyes','roberto.luna@example.com','Av. Ruiz Cortines',2000,NULL,'Anáhuac','Veracruz','91910','Veracruz'),
(8,'Patricia','PATR810903BD4','Aguilar','Trejo','paty.aguilar@example.com','Av. Patria',560,NULL,'Colomos','Jalisco','44660','Guadalajara'),
(9,'Héctor','HECT891220JK7','Serrano','Ibarra','hector.serrano@example.com','Periférico',2500,NULL,'Del Prado','Nuevo León','64000','Monterrey'),
(10,'Carolina','Caro930205ZT2','Mendoza',NULL,'caro.mendoza@example.com','Calle 60',320,NULL,'Centro','Yucatán','97000','Mérida'),
(11,'Santiago','SANT040405PP1','Rico','Campos','santiago.rico@example.com','Av. Revolución',505,9,'Tacubaya','CDMX','11870','Miguel Hidalgo'),
(12,'Daniela','DANI020102XK8','Peña','Durán','daniela.pena@example.com','Ignacio Zaragoza',210,NULL,'Agrícola Oriental','CDMX','08500','Iztacalco'),
(13,'Fernanda','FERN970927H2Q','González','Silva','fernanda.glez@example.com','Insurgentes',1500,7,'Roma Norte','CDMX','06700','Cuauhtémoc'),
(14,'Alberto','ALBE990101CDE','Jiménez','Ochoa','alberto.jmz@example.com','Av. Independencia',88,NULL,'Centro','Puebla','72000','Puebla'),
(15,'Ximena','XIME011213R9S','Zamora','Salas','ximena.zamora@example.com','Av. Kabah',410,NULL,'SM 21','Quintana Roo','77500','Cancún'),
(16,'Emilio','EMIL950707Y7A','Cervantes','Franco','emilio.cv@example.com','Av. México',345,NULL,'5 de Diciembre','Jalisco','48350','Puerto Vallarta'),
(17,'Sofía','SOFI031201B6T','Cuevas','Nieves','sofia.cuevas@example.com','Av. Revolución',120,NULL,'San Lorenzo','EdoMex','52172','Metepec'),
(18,'Diego','DIEG940930ZP5','García','Rojas','diego.garcia@example.com','Blvd. B. Quintana',2300,NULL,'Arboledas','Querétaro','76140','Querétaro'),
(19,'Paulina','PAUL980417LQ3','Sánchez',NULL,'paulina.sanchez@example.com','Av. Universidad',1110,12,'Centro','SLP','78000','San Luis Potosí'),
(20,'Mauricio','MAUR900101TT9','Ortiz','Campos','mauricio.ortiz@example.com','Av. Tecnológico',700,4,'San Lorenzo','EdoMex','52172','Metepec');

-- =========================
-- 4) SALE_STATUS (20)
-- =========================
INSERT INTO sale_status (id_sale_status, description, status) VALUES
(1,'Registrada','A'),
(2,'Confirmada','A'),
(3,'Pagada','A'),
(4,'Facturada','A'),
(5,'Cancelada','I'),
(6,'En surtido','A'),
(7,'Empacada','A'),
(8,'En reparto','A'),
(9,'Entregada','A'),
(10,'Devuelta','I'),
(11,'Pago pendiente','A'),
(12,'Revisión de pago','A'),
(13,'En caja','A'),
(14,'Cerrada','A'),
(15,'Anulada por cliente','I'),
(16,'Por recoger en tienda','A'),
(17,'Preparando factura','A'),
(18,'Reembolsada','I'),
(19,'En espera de stock','A'),
(20,'Lista para envío','A');

-- =========================
-- 5) SALE (20)  (sale_number cumple ^VENT-\d{3,}$)
-- =========================
INSERT INTO sale (sale_number, sale_date, total_amount, id_client) VALUES
('VENT-001','2025-10-03',399.00,1),
('VENT-002','2025-10-05',178.00,2),
('VENT-003','2025-10-07',520.00,3),
('VENT-004','2025-10-09',250.00,4),
('VENT-005','2025-10-12',980.00,5),
('VENT-006','2025-10-15',145.00,6),
('VENT-007','2025-10-18',320.00,7),
('VENT-008','2025-10-21',760.00,8),
('VENT-009','2025-10-24',115.00,9),
('VENT-010','2025-10-28',230.00,10),
('VENT-011','2025-11-02',78.00,11),
('VENT-012','2025-11-05',640.00,12),
('VENT-013','2025-11-09',812.00,13),
('VENT-014','2025-11-12',65.00,14),
('VENT-015','2025-11-16',495.00,15),
('VENT-016','2025-11-19',349.00,16),
('VENT-017','2025-11-22',420.00,17),
('VENT-018','2025-11-25',150.00,18),
('VENT-019','2025-11-28',299.00,19),
('VENT-020','2025-12-01',999.00,20);

-- =========================
-- 6) HISTORICAL_STATUS_ORDER (20)
-- =========================
INSERT INTO historical_status_order (id_his_sta_ord, status_date, id_sale_status, sale_number) VALUES
(1,'2025-10-03',1,'VENT-001'),
(2,'2025-10-05',3,'VENT-002'),
(3,'2025-10-07',6,'VENT-003'),
(4,'2025-10-09',3,'VENT-004'),
(5,'2025-10-12',4,'VENT-005'),
(6,'2025-10-15',11,'VENT-006'),
(7,'2025-10-18',8,'VENT-007'),
(8,'2025-10-21',9,'VENT-008'),
(9,'2025-10-24',14,'VENT-009'),
(10,'2025-10-28',3,'VENT-010'),
(11,'2025-11-02',1,'VENT-011'),
(12,'2025-11-05',17,'VENT-012'),
(13,'2025-11-09',4,'VENT-013'),
(14,'2025-11-12',5,'VENT-014'),
(15,'2025-11-16',16,'VENT-015'),
(16,'2025-11-19',3,'VENT-016'),
(17,'2025-11-22',20,'VENT-017'),
(18,'2025-11-25',2,'VENT-018'),
(19,'2025-11-28',9,'VENT-019'),
(20,'2025-12-01',3,'VENT-020');

-- =========================
-- 7) PHONE_NUMBER (20)  [enteros <= 2147483647]
-- =========================
INSERT INTO phone_number (supplier_phone_number, id_supplier) VALUES
(1500000001,1),(1500000002,2),(1500000003,3),(1500000004,4),(1500000005,5),
(1500000006,6),(1500000007,7),(1500000008,8),(1500000009,9),(1500000010,10),
(1500000011,11),(1500000012,12),(1500000013,13),(1500000014,14),(1500000015,15),
(1500000016,16),(1500000017,17),(1500000018,18),(1500000019,19),(1500000020,20);

-- =========================
-- 8) PROVIDES (20)  (pares proveedor-producto)
-- =========================
INSERT INTO provides (id_supplier, id_product) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,9),(9,10),(10,11),
(11,12),(12,13),(13,14),(14,15),(15,16),
(16,17),(17,18),(18,19),(19,20),(20,8);

-- =========================
-- 9) IS_SOLD (20)  (líneas de venta)
-- =========================
INSERT INTO is_sold (sale_number, id_product, total_product, quantity, unit_price) VALUES
('VENT-001',5,399.00,1,399.00),
('VENT-002',2,158.00,2,79.00),
('VENT-003',3,258.00,2,129.00),
('VENT-003',7,262.00,2,131.00),
('VENT-004',8,245.00,5,49.00),
('VENT-005',6,598.00,2,299.00),
('VENT-005',4,382.00,1,382.00),
('VENT-006',1,119.70,3,39.90),
('VENT-007',17,267.00,3,89.00),
('VENT-008',3,516.00,4,129.00),
('VENT-008',20,260.00,4,65.00),
('VENT-009',13,15.00,3,5.00),
('VENT-010',14,120.00,10,12.00),
('VENT-011',2,78.00,1,78.00),
('VENT-012',5,399.00,1,399.00),
('VENT-012',18,90.00,2,45.00),
('VENT-013',4,349.00,1,349.00),
('VENT-013',6,299.00,1,299.00),
('VENT-014',20,65.00,1,65.00),
('VENT-015',15,300.00,100,3.00);

-- =========================
-- 10) MERCHANDISE (8 de 1..8)
-- =========================
INSERT INTO merchandise (id_product) VALUES
(1),(2),(3),(4),(5),(6),(7),(8);

-- =========================
-- 11) PRINT (4: 13,14,15,16)
-- =========================
INSERT INTO print (id_product) VALUES
(13),(14),(15),(16);

-- =========================
-- 12) PHONE_RECHARGE (4: 9..12)
-- =========================
INSERT INTO phone_recharge (id_product) VALUES
(9),(10),(11),(12);

-- =========================
-- 13) STATIONERY_ITEM (4: 17..20)
-- =========================
INSERT INTO stationery_item (id_product) VALUES
(17),(18),(19),(20);

-- =========================
-- 14) INVENTORY (20; uno por producto)
-- =========================
INSERT INTO inventory (id_product, barcode, purchase_price, purchase_date, stock, photo_url) VALUES
(1,'750000000001',25.50,'2025-09-20',200,'https://example.com/img/p1.jpg'),
(2,'750000000002',60.00,'2025-09-18',180,'https://example.com/img/p2.jpg'),
(3,'750000000003',95.00,'2025-09-15',120,'https://example.com/img/p3.jpg'),
(4,'750000000004',280.00,'2025-09-22',40,'https://example.com/img/p4.jpg'),
(5,'750000000005',320.00,'2025-09-25',25,'https://example.com/img/p5.jpg'),
(6,'750000000006',210.00,'2025-09-17',150,'https://example.com/img/p6.jpg'),
(7,'750000000007',40.00,'2025-09-19',90,'https://example.com/img/p7.jpg'),
(8,'750000000008',30.00,'2025-09-23',160,'https://example.com/img/p8.jpg'),
(17,'750000000017',65.00,'2025-09-21',70,'https://example.com/img/p17.jpg'),
(18,'750000000018',30.00,'2025-09-21',140,'https://example.com/img/p18.jpg'),
(19,'750000000019',52.00,'2025-09-21',90,'https://example.com/img/p19.jpg'),
(20,'750000000020',48.00,'2025-09-21',110,'https://example.com/img/p20.jpg');
