--------------------------------------------------------------------------------------
-------------------------------------Toci Software------------------------------------
--------------------------------------------------------------------------------------
/*Proyecto Base de datos del quipo toci SOFTWARE.
Integrantes:
*Arreguin Portillo Diana Laura
*Brito Serrano Miguel Ángel
*Marentes Degollado Ian Paul
*Meza Vega Hugo Adrián
*/



--Inserción de información para la base de datos "proyecto"
INSERT INTO estado(codigo_postal, estado) VALUES
(06140,'Ciudad de México'), (03700,'Ciudad de México'), (01210,'Ciudad de México'), (11000,'Ciudad de México'), 
(11435,'Ciudad de México'), (14678,'Ciudad de México'), (08500,'Ciudad de México'), (03300, 'Ciudad de México'),
(51260,'Estado de México'), (56450,'Estado de México'), (03145,'Estado de México'), (72570,'Puebla'), 
(20164,'Aguascalientes');


INSERT INTO proveedor(razon_social, nombre, calle, numero, colonia, codigo_postal) VALUES
('SERVICIOS COMERCIALES AMAZON MEXICO S. DE R.L. DE C.V.', 'Amazon México', 'Cuernavaca', 106, 'Condesa', 06140),
('OFFICE DEPOT DE MEXICO S.A. DE C.V.', 'OFFICE DEPOT', 'Noche paz', 49, 'Santa María Nonoalco', 03700),
('ABASTECEDORA LUMEN S.A. DE C.V.', 'Lumen', 'Las flores', 63, 'San Miguel', 51260),
('HEWLETT PACKARD SERVICIOS PROFESIONALES S. DE R.L. DE C.V.', 'HP México', 'Reforma', 700, 'Santa Fe', 01210),
('REGALOS SIGLO XXI S.A. DE C.V.', 'Regalos siglo XXI', 'Cuernavaca', 120, 'Condesa', 06140),
('JOYERIA CANDILES Y REGALOS S.A. DE C.V.', 'Joyeria Candiles y Regalos', 'Rio Nazas', 3800, 'Jardines de San Manuel', 72570),
('RECARGA DE PRODUCTOS Y SERVICIOS S. DE R.L. DE C.V.', 'MOBILMEX', 'Avenida Parque Via Poniente', 418, 'Santa Anita 4a Sección', 20164),
('MINISO MÉXICO S.A.P.I de C.V.', 'MINISO', 'Boulevard Manuel Avila Camacho', 118, 'Lomas de Chapultepec V Sección', 11000);


INSERT INTO telefonoprov(telefono, razon_social) VALUES
('2154780312','SERVICIOS COMERCIALES AMAZON MEXICO S. DE R.L. DE C.V.'),('5543128790','OFFICE DEPOT DE MEXICO S.A. DE C.V.'),
('4576821435','ABASTECEDORA LUMEN S.A. DE C.V.'),('5643157823','HEWLETT PACKARD SERVICIOS PROFESIONALES S. DE R.L. DE C.V.'),
('5678145321','REGALOS SIGLO XXI S.A. DE C.V.'),('5478012453','JOYERIA CANDILES Y REGALOS S.A. DE C.V.'),
('4576891653','RECARGA DE PRODUCTOS Y SERVICIOS S. DE R.L. DE C.V.'),('5576824526','MINISO MÉXICO S.A.P.I de C.V.');

INSERT INTO cliente(rfc, nombre_pila, ap_paterno, ap_materno, calle, numero, colonia, codigo_postal, passwd) VALUES
('APDL150898JLC', 'Diana Laura', 'Arreguin', 'Portillo', 'Avenida 503', 84, 'San Juan de Aragón', 11435, 'dianalaura'),
('BSMA011296HMC', 'Miguel Ángel', 'Brito', 'Serrano', 'Sur', 12, 'Doctores', 14678, 'miguelangel'),
('MDIP240998QLP', 'Ian Paul', 'Marentes', 'Degollado', 'Avenida 503', 54, 'San Juan de Aragón', 11435,'ianpaul'),
('MVHA150998CZG', 'Hugo Adrián', 'Meza', 'Vega', 'Avenida Sur 4', 84, 'Agrícola Oriental', 08500, 'hugoadrian'),
('LUGA210982PLA', 'Luis', 'García', NULL, 'Miguel Hidalgo', 14, 'San Lorenzo', 56450, 'luisgarcia'),
('SADA240497UZP', 'Alejandra', 'Sánchez', 'Díaz', 'Rumania', 3456, 'Portales Sur', 03300, 'alejandrasanchez'),
('ROLE060695XLM', 'Luis Enrique', 'Rodrigues', NULL , 'Avenida Central', 8, 'Maravillas', 03145, 'luisenrique');

INSERT INTO emailcliente(email, rfc) VALUES
('dlap-16@hotmail.com','APDL150898JLC'),
('angelBrito@hotmail.com', 'BSMA011296HMC'),
('ianpaulmarentes@gmail.com', 'MDIP240998QLP'),
('hamv15@hotmail.com', 'MVHA150998CZG'),
('luga@gmail.com', 'LUGA210982PLA'),
('aleesd@yahoo.com', 'SADA240497UZP'),
('luiserod@hotmail.com', 'ROLE060695XLM');

INSERT INTO producto(id_producto, descripcion, precio_unidad, stock, precio_proveedor, utilidad, fecha_compra, marca, codigo_barras) VALUES
(1, 'Recarga telefónica telcel', 100, 100, 90, 0, '2021/01/12', NULL, NULL),
(2, 'Recarga telefónica AT&T', 100, 100, 90, 0,NULL, NULL, NULL),
(3, 'Impresión blanco y negro', 2, 200, 1, 0, NULL, NULL, NULL),
(4, 'Impresión a color', 8, 200, 5, 0, NULL, NULL, NULL),
(5, 'Lápiz', 10, 50, 5, 10, '2021/08/1', 'STAEDTLER', '17892351'),
(6, 'Pluma', 15, 100, 10, 15,'2021/08/1', 'STAEDTLER', '16820915'),
(7, 'Paquete de gomas', 35, 50, 25, 0, '2021/02/1', 'FACTIS', '43813701'),
(8, 'Paquete de 500 hojas blancas', 800, 20, 700, 0,'2021/03/14', 'SCRIBE', '76193291'),
(9, 'Tijeras', 30, 50, 20, 0, '2021/08/1', 'Maped', '16239874'),
(10, 'Resistol chico', 15, 50, 10, 0, '2021/04/5', 'RESISTOL', '41871209'),
(11, 'Regla', 10, 50, 5, 5, '2021/02/20', 'Maped', '01024567'),
(12, 'Paquete de colores 48pzs', 500, 10, 400, 0, '2021/01/16', 'PRISMACOLOR', '51231087'),
(13, 'Calculadora fx-991EX', 500, 10, 420, 0, '2021/07/23', 'CASIO', '43030465'),
(14, 'Cuaderno forma francesa cuadro chico', 35, 50, 29, 6, '2021/02/15', 'SCRIBE','43021465'),
(15, 'Cuaderno forma francesa cuadro grande', 35, 50, 29, 0, '2021/02/15', 'SCRIBE','53031465'),
(16, 'Sacapuntas', 125, 50, 100, 0, '2021/03/16', 'STAEDTLER', '17892362'),
(17, 'Engrapadora', 250, 50, 220, 0, '2021/07/15', 'PILOT', '98157621'),
(18, 'Paquete de plumones', 600, 30, 550, 0, '2021/08/01', 'ZEBRA', '31879012'),
(19, 'Tarjeta de regalo', 350, 3, 320, 210, '2021/05/20', 'Atraerte', '81845672'), 
(20, 'Caja para regalo', 200, 30, 170, 60, '2021/03/10', 'Hallmark', '21013402'), 
(21, 'Peluche', 250, 10, 230, 40, '2021/01/01', 'MINISO', '71789345'),
(22, 'Collar de regalo', 120, 2, 100, 160, '2021/02/15', NULL, '13023465');

INSERT INTO tipo(id_tipo, descrip_tipo) VALUES
(1, 'Recarga telefónica'),(2, 'Regalo'),(3, 'Impresión'),(4, 'Articulo de papeleria');

INSERT INTO tipoproducto(id_producto, id_tipo) VALUES
(1, 1), (2,1), (3,3), (4,3), (5,4), (6,4), (7,4), (8,4), (9,4), (10,4),
(11,4), (12,4), (13,4), (14,4), (15,4), (16,4), (17,4), (18,4), (19,2), (20,2), (21,2),
(22,2);

INSERT INTO suministra(razon_social, id_producto) VALUES
('RECARGA DE PRODUCTOS Y SERVICIOS S. DE R.L. DE C.V.',1), ('RECARGA DE PRODUCTOS Y SERVICIOS S. DE R.L. DE C.V.',2), 
('HEWLETT PACKARD SERVICIOS PROFESIONALES S. DE R.L. DE C.V.',3), ('HEWLETT PACKARD SERVICIOS PROFESIONALES S. DE R.L. DE C.V.',4), 
('OFFICE DEPOT DE MEXICO S.A. DE C.V.',5), ('OFFICE DEPOT DE MEXICO S.A. DE C.V.',6), ('ABASTECEDORA LUMEN S.A. DE C.V.',7), 
('OFFICE DEPOT DE MEXICO S.A. DE C.V.',8), ('OFFICE DEPOT DE MEXICO S.A. DE C.V.',9), ('ABASTECEDORA LUMEN S.A. DE C.V.',10),
('OFFICE DEPOT DE MEXICO S.A. DE C.V.',11), ('OFFICE DEPOT DE MEXICO S.A. DE C.V.',12), ('OFFICE DEPOT DE MEXICO S.A. DE C.V.',13), 
('OFFICE DEPOT DE MEXICO S.A. DE C.V.',14), ('OFFICE DEPOT DE MEXICO S.A. DE C.V.',15), ('ABASTECEDORA LUMEN S.A. DE C.V.',16), 
('ABASTECEDORA LUMEN S.A. DE C.V.',17), ('ABASTECEDORA LUMEN S.A. DE C.V.',18), ('SERVICIOS COMERCIALES AMAZON MEXICO S. DE R.L. DE C.V.',19), 
('SERVICIOS COMERCIALES AMAZON MEXICO S. DE R.L. DE C.V.',20), ('MINISO MÉXICO S.A.P.I de C.V.',21),
('REGALOS SIGLO XXI S.A. DE C.V.',22);

INSERT INTO venta(num_venta,rfc, fecha_venta, monto_total) VALUES
(idventa() ,'APDL150898JLC', '10/08/21', 110.00), (idventa() ,'MDIP240998QLP', '10/08/21', 900.00);

INSERT INTO tiene(num_venta, id_producto, precio_unidad, cantidad_articulo, precio_total_xarticulo) VALUES
('VENT-1', 5, 10.00, 2, 20.00), ('VENT-1', 6, 15.00, 3, 45.00), ('VENT-1', 11, 10.00, 1, 10.00),
('VENT-1', 14, 35.00, 1, 35.00), ('VENT-2', 20, 200.00, 2, 400.00), ('VENT-2', 21, 250.00, 2, 500.00);

