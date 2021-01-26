
insert into PROVEEDOR (razon_Social, nombre, ap_Pat, ap_Mat, calle, numero, colonia, estado, codigo_Postal ) values
('DISEÑOS PAPELERIA', 'Juan', 'Montenegro', '', 'Los Prados', 877, 'Chilpancingo de los Bravo', 'Guerrero', 76294),
('PAPELERIA Warolh', 'Antonio', 'Santa', 'Cruz', 'Av Universidad', 252, 'El Recreo', 'Tabasco', '86020'),
('Mediterraneo', 'Mario', 'Alvarado', 'Cervantes', 'Juarez', 702, 'Cuauhtemoc', 'Chihuahua', 31500),
('La Bonita', 'Juan', 'Casas', '', 'Nuevo Leon', 233, 'Cuahutemoc', 'Estado de México', 52438),
('Lawnscape', 'Jose Emanuel', 'Rojano', 'Olivan', 'Jose Vasconcelos',32 , 'Miguel Hidalgo', 'Ciudad de Mexico', 86352),
('Entretejidos', 'Maria Rosa', 'Vizuete', 'Alcazar', 'Gonzalitos e Insurgentes',773 , 'Vista Hermosa', 'Monterrey', 66420),
('Cargo Papeleria', 'Sonia', 'Mendez', 'Reverte', 'Constitucion',23 , 'El parque', 'Sinaloa',81259),
('Recreativa', 'Rocio ', 'Souza', '', 'Av. Resurgimiento',57 , 'Prado', 'Campeche',24030 ),
('Papeleria Edicion', 'Ignacio', 'Quintero', '', 'Ejercito Nacional', 3560, 'San Juan', 'Guanajuato',92754 ),
('Kashmere', 'Gabriel', 'Carpio', 'Avalos', 'Providencia',726 , 'Valle Centro', 'Ciudad de México',03100),
('Bereska', 'Rafael', 'Boca', '', 'Portal de Flores',10 ,'Oaxaca Centro', 'Oaxaca',68000),
('UV', 'Lorenzo', 'Rodas', 'Contreras', 'Reforma',987, 'Independencia', 'Estado de Mexico',50100 ),
('Evoka', 'Lidia', 'Zarco', 'Camacho', 'Av.Juarez',907 , 'Periodistas', 'Hidalgo',42000 ),
('La dorada', 'Ines', 'Espino', 'Munuera', 'Morelos',125 , 'Centro', 'Tamaulipas', 28964),
('La Tribu del Papel', 'Lucia', 'Valencia', 'Olle', 'Tomas Fernandez',8450 , 'Ciduad Juarez', 'Chihuahua',32000 ),
('Papeleria Atlas', 'Catalina', 'Castellon', 'Portero', 'Biologos',42 , 'Iztapalapa', 'Ciudad de México', 23452),
('Papel 360', 'Elena', 'Humades', 'Losada', 'Lopez Mateos',24 , 'San Cristobal Centro', 'Estado de México',97653 ),
('Solo Arte', 'Francisco', 'Del Rey', 'Hermosilla', 'Paseo del ruiseñor',111 , 'Balaustradas', 'Estado de México',54102 ),
('Trazos Dorados', 'Jorge', 'Tello', 'Regueiro', 'Toltecas',222 , 'Ajusco', 'Ciudad de Mexico',16833 ),
('Cromatica', 'Rafael', 'Castro', 'Enriquez', 'Costa Rica',60 , 'Lomas de Queretaro', 'Queretaro',76190);

insert into TELEFONO (razon_Social, telefono) values
('DISEÑOS PAPELERIA', 5518628607),
('DISEÑOS PAPELERIA', 5506175360),
('PAPELERIA Warolh', 5578605609),
('Mediterraneo', 5568808365),
('Mediterraneo', 5587861124),
('La Bonita',5598248167 ),
('Lawnscape', 5573540138),
('Entretejidos',5593752946 ),
('Cargo Papeleria',5538287666 ),
('Cargo Papeleria', 5592734754 ),
('Recreativa', 5502176534 ),
('Papeleria Edicion', 5597364264 ),
('Kashmere', 5592634561 ),
('Bereska', 5682940513 ),
('UV', 5619836554 );


INSERT INTO PRODUCTO (codigo_Barras, stock, precio_Venta, marca, descripcion, tipo_Producto) values
('7502247683709', 500, 89, 'STABILO', 'Marcatextos', 'PAPELERIA'),
('7507264583746', 300, 102, 'SCRIBE', 'Cuaderno Carta 100 hojas', 'PAPELERIA'),
('7508737488264', 300, 5, 'PAPER MATE', 'Pluma Negra', 'PAPELERIA'),
('7502763564895', 15, 120, 'MOLIN', 'Colores 24pzs', 'PAPELERIA'),
('7503249574186', 300, 5, 'PAPER MATE', 'Pluma roja', 'PAPELERIA'),
('7502775224680', 350, 7, 'MIRADO', 'Lapiz', 'PAPELERIA'),
('7501689053204', 50, 40, 'SCHOOL', ' Hojas blancas (100)', 'PAPELERIA'),
('7503898642902', 120, 12, 'ROYAL CAST', 'Folder', 'PAPELERIA'),
('7508766590325', 110,15 , 'AZOR', 'Lapicero', 'PAPELERIA'),
('7501247890453', 100 ,50 , 'MOVISTAR', 'Recarga MOVI 50', 'RECARGA'),
('7501726499585', 100 ,100 , 'MOVISTAR', 'Recarga MOVI 100', 'RECARGA'),
('7509374956274', 100 ,200 , 'MOVISTAR', 'Recarga MOVI 200', 'RECARGA'),
('7501826545123', 100, 50, 'TELCEL', 'Recarga TELCEL 50', 'RECARGA'),
('7505482949623', 100 ,100 , 'TELCEL', 'Recarga TELCEL 100', 'RECARGA'),
('7501937461341', 100, 200, 'TELCEL', 'Recarga TELCEL 200', 'RECARGA'),
('7506321589026', 1000,1 , 'COMETA', 'Impresion B/N', 'IMPRESION'),
('7502874591745', 750,5 , 'COMETA', 'Impresion C', 'IMPRESION'),
('7506248169953', 250, 22.50, 'GIVEIT', 'Bolsa de Regalo', 'REGALO'),
('7507547889535', 500 ,7, 'PARTY1', 'Moño', 'REGALO'),
('7501985653680', 250, 10, 'El Mono', 'Papel de envoltura', 'REGALO'),
('7504872790215', 70, 25, 'Artur', 'Tarjeta', 'REGALO'),
('7501055332175' ,150 ,20 , 'Omx', 'Sacapuntas metal 2pzs', 'PAPELERIA'),
('7506519773553' ,99 ,15 , 'Berol', 'Puntillas', 'PAPELERIA'),
('7501117634852' ,200 ,4 , 'Factis', 'Goma', 'PAPELERIA'),
('7509177639405' ,98 ,130 , 'Facial Bond', 'Hojas colores (100)', 'PAPELERIA'),
('7509988823341' ,70 ,26.50 , 'Bic', 'Corrector', 'PAPELERIA'),
('7508876173587' ,234 , 13, 'Pritt', 'Lapiz Adhesivo', 'PAPELERIA'),
('7503675839239' ,2 ,220 , 'Prismacolor', 'Colores 36pzs', 'PAPELERIA'),
('7501884758234' ,300 ,60 , 'Post- It', 'Post - It 4 pzs', 'PAPELERIA'),
('7501876561347' ,170 ,130 , 'Azor', 'Marcador de pizarron paq 8 pzs', 'PAPELERIA'),
('7500543341123' ,220 ,87 , 'Berol', 'Plumones 10 pzs', 'PAPELERIA');


INSERT INTO SUMINISTRA (razon_Social_Proveedor, codigo_Barras, precio_Compra, fecha_Compra) values
('DISEÑOS PAPELERIA', '7502763564895', 100, '2020-08-24'),
('La Bonita', '7502247683709', 73, '2020-04-17'),
('Mediterraneo', '7507264583746', 85, '2020-09-02'),
('PAPELERIA Warolh', '7508737488264',3, '2020-12-07'),
('Entretejidos','7502775224680',4.50, '2020-03-12'),
('Lawnscape','7508766590325',9.50, '2020-05-26'),
('Recreativa','7503898642902',8, '2020-11-06'),
('Kashmere','7501689053204',29, '2020-08-11'),
('UV','7503249574186',3, '2020-02-27'),
('Evoka','7507547889535' ,5 , '2020-04-19'),
('La dorada','7504872790215' ,20 , '2020-09-28'),
('La Tribu del Papel','7501985653680' ,7 , '2020-02-12'),
('Cargo Papeleria','7506248169953' ,18 , '2020-12-22'),
('Papel 360','7501117634852' ,2.50 , '2020-03-20'),
('Bereska','7501884758234' ,46 , '2020-04-21'),
('Evoka','7501876561347' , 115, '2020-07-29'),
('Papeleria Atlas','7501055332175' ,17.50 , '2020-01-30'),
('Cromatica','7503675839239' ,190 , '2020-03-12'),
('Solo Arte','7509988823341' ,18.50 , '2020-12-26'),
('Trazos Dorados','7506519773553' ,9, '2020-11-28'),
('Lawnscape','7508876173587' ,10, '2020-11-18'),
('Mediterraneo','7509177639405' ,110 , '2020-07-19'),
('UV','7500543341123' ,78 , '2020-08-12');


INSERT INTO CLIENTE (razon_Social, nombre, ap_Pat, ap_Mat, estado, codigo_Postal, colonia, calle, numero ) values
('Matchbox', 'Adriana', 'Juarez', 'Ortega', 'Sonora', 89000, 'Ciudad Sanibas', 'La Madrid Poniente', 324 ),
('SoundBack', 'Diana', 'Reynoso', '', 'Chihuahua', 32000, 'Melchor Ocampo', 'Brasil', 1540),
('Interconexiones', 'Ernesto', 'Alvarado', 'Roa', 'Monterey', 64600, 'Bustamante', 'Leones', 1839),
('Kabook', 'Julian', 'Tabares', 'Arranz', 'Baja California',22150 , 'Cacho', 'Colombia',9232 ),
('StraightUp', 'Domingo', 'Guillem', 'Atienza', 'Morelos',62440 , 'Acapantzingo', 'Ruiz Cortines', 58 ),
('ThinkTank', 'Alberto', 'Georgieva', 'Oliveira', 'Colima',28000 , 'Centro', '5 de Mayo',267 ),
('Internal Electronica', 'Maria', 'Gamboa', 'Vaquero', 'Ciudad de Mexico',06140 , 'Condesa', 'Michoacan',77 ),
('Prime', 'Milagros', 'Aguila', 'Nieves', 'Durango',34000 , 'Centro', 'Gomez Palacios',501 ),
('Sphinx', 'Maria Victoria', 'Ariño', 'Palomar', 'Yucatan',28364 , 'Maya Merida', 'Calle 17', 537 ),
('Carrier', 'Rosario', 'Doblas', 'Liñan', 'Guerrero',39880 , 'Playa Guitarron', 'Escencia', 16),
('Market Express', 'Miguel', 'Pan', 'Mellado', 'Ciudad de México',28764 , 'El Rosedal', 'Division del Norte',2943 ),
('Heartland', 'Alvaro', 'Portela', '', 'Ciudad de Mexico',03810 , 'Benito Juarez', 'Napoles',37 ),
('Honda', 'Jose Antonio', 'Exposito', 'Ballesta', 'Durango',34087 , 'Esperanza', 'Felipe Pescador',1700 ),
('GMC', 'Esteban', 'Pedraza', 'Colorado', 'Veracruz',96400 , 'Coatzacoalcos Centro', 'Revolucion',1014 ),
('Audi', 'Victor Manuel', 'Jeres', 'Parras', 'Ciudad de Mexioc',36508 , 'Iztapalapa', 'Francisco Villa',323 ),
('RealLife', 'Santiago', 'Paredes', 'Corbalan', 'Nuevo Leon',15202 , 'Moderno Apodaca', '5 de Mayo',64 ),
('Quick', 'Juan', 'Rueda', 'Ferrera', 'Tamaulipas',87000 , 'Centro', '14 Sur', 127),
('HalfPrice', 'Juan Jose', 'Jurado', 'Garay', 'Ciudad de Mexico',09040 , 'Del Valle Sur', 'Ejidos del Moral',78 ),
('Scion', 'Esteban', 'Requejo', 'Bustos', 'Puebla', 72550, 'Las Palmas', 'Compostela',4701 );


INSERT INTO EMAIL (email, razon_Social_Cliente) values
('dianrey@soundback.com', 'SoundBack'),
('adrey@matchbox.com', 'Matchbox'),
('julian.tabares@outlook.com', 'Kabook'),
('albert.geo@thinkthank.com', 'ThinkTank'),
('ernesto_san@inetrconexiones.com', 'Interconexiones'),
('aguilar_mil@gmail.com', 'Prime'),
('ariño2009@hotmail.com', 'Sphinx'),
('mar23gamboa@yahoo.com', 'Internal Electronica'),
('rodo_li@carrier.com', 'Carrier'),
('miguel_pame@hotmail.com', 'Market Express'),
('alvaro.portlea@gmail.com', 'Heartland'),
('jeres.parras@audi.com', 'Audi'),
('especo@gmc.com', 'GMC'),
('juan.rueda@quick.ocm', 'Quick'),
('santiago.paredes@yahoo.com', 'RealLife'),
('exposito.ballesta@gmail.com', 'Honda'),
('direccion@straightup.com', 'StraightUp'),
('maria.victoria@gmail.com', 'Sphinx'),
('compras@matchbox.com', 'Matchbox');


--La inserción se debe realizar de venta en venta y
--producto en producto
INSERT INTO VENTA (fecha_Venta,razon_Social) values
('2020-07-28', 'SoundBack');
CALL ingresa_Detalle ('7502763564895', 'VENT-01', 5);
CALL ingresa_Detalle('7501689053204', 'VENT-01', 10);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-12-24', 'Sphinx');
CALL ingresa_Detalle('7502247683709', 'VENT-02', 20);
CALL ingresa_Detalle('7508766590325', 'VENT-02', 11);

INSERT INTO VENTA (fecha_venta, razon_Social) values
('2020-08-02', 'Honda');
CALL ingresa_Detalle ('7501884758234', 'VENT-03', 13);

INSERT INTO VENTA (fecha_venta, razon_Social) values
('2020-09-01',  'Market Express');
CALL ingresa_Detalle('7509177639405', 'VENT-04', 8);
CALL ingresa_Detalle('7508737488264', 'VENT-04', 26);
CALL ingresa_Detalle('7501937461341', 'VENT-04', 1);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-04-16', 'Quick');
CALL ingresa_Detalle ('7501876561347', 'VENT-05', 10);
CALL ingresa_Detalle ('7506321589026', 'VENT-05', 17);
CALL ingresa_Detalle ('7502763564895', 'VENT-05', 3);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-07-18', 'Audi');
CALL ingresa_Detalle ('7502775224680', 'VENT-06', 50);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-12-16', 'Matchbox');
CALL ingresa_Detalle('7501055332175', 'VENT-07', 15);
CALL ingresa_Detalle('7509988823341', 'VENT-07', 25);
CALL ingresa_Detalle('7508766590325', 'VENT-07', 28);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-12-16', 'Interconexiones');
CALL ingresa_Detalle ('7503249574186', 'VENT-08', 9);
CALL ingresa_Detalle ('7508737488264', 'VENT-08', 7);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-08-09', 'ThinkTank');
CALL ingresa_Detalle ('7506248169953', 'VENT-09', 6);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-06-12', 'Carrier');
CALL ingresa_Detalle('7502874591745', 'VENT-010', 12 );

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-09-16', 'StraightUp');
CALL ingresa_Detalle ('7500543341123', 'VENT-011', 18);
CALL ingresa_Detalle ('7507264583746', 'VENT-011',11);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-08-11', 'RealLife');
CALL ingresa_Detalle ('7501884758234', 'VENT-012', 8);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-11-29', 'Kabook');
CALL ingresa_Detalle ('7502775224680', 'VENT-013', 38);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-12-22', 'Heartland');
CALL ingresa_Detalle('7504872790215', 'VENT-014', 23);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-06-05', 'GMC');
CALL ingresa_Detalle ('7503898642902', 'VENT-015',70);

INSERT INTO VENTA (fecha_Venta, razon_Social) values
('2020-04-14', 'Internal Electronica');
CALL ingresa_Detalle ('7501689053204', 'VENT-016', 14);
