--Create intruction query set for data in Client table
INSERT INTO client VALUES
('MCAC860212','Marco','Castilleja','Antonio','Blvd. Manuel Ávila Camacho',138,'Lomas de Chapultepec',11650,'Ciudad de México'),
('WLES801306','Wilfrido','Espinoza','','Paseo de la Reforma',1000,'Peña Blanca Santa Fe',01210,'Ciudad de México'),
('JRAR820602','Jorge','Arias','','Av. San Antonio',461,'San Pedro de los Pinos',01180,'Ciudad de México');
('APEV970116','Adrian','Pérez','','Fuentes de aire',854,'Los Reyes la Paz',02145,'Estado de México');
--Inserting mails into emailc
    INSERT INTO emailc VALUES
('APEV970116','adiranp@gmail.com'),
('JRAR820602','jorgearias@gmail.com'),
('WLES801306','wilfre@hotmaail.com'),
('ZAMD980124','danielRT@outlook.com')
('MCAC860212','marcocas@gmail.com');
--Create instruction query set for data in product table
INSERT INTO product VALUES
('9 820145 658784',80.0,15,'HP Original','Paquete Papel Bond Carta Hp Original 500 Hojas',159.65,'stationery'),
('9 587632 502058',84.70,20,'HP Papers','Paquete Papel Bond Carta HP Multi 500 Hojas ',190.35,'stationery'),
('6 458712 562387',28.40,10,'BIC Crystal','Boligrafo Bic Med C/12 Pza Azul',45.62,'stationery'),
('7 452136 748510',575.90,5,'Mónaco','Mochila Mónaco 12prom Serig térmica',864.85,'gift'),
('4 051236 498771',50,10,'Telcél','Recarga de $50 C/paquete de datos vig. 3 día',50,'recharges'),
('4 051236 657841',50,10,'AT&T','Recarga de $50 C/paquete de datos vig. 3 día',50,'recharges'),
('4 051236 253610',50,10,'UNEFON','Recarga de $50 C/paquete de datos vig. 3 día',50,'recharges');
--Create instruction query for data in provider table
INSERT INTO provider VALUES
('H.P. México S.A. de C.V.','Raul','Ribeiro','Montes','Paseo de la Reforma',700,'Santa Fe',01210,'Ciudad de México'),
('BicWorld S.A. de C.V.','Diana','Montero','Franco','Vía Gustavo Baz',113,'Industrial Barrientos',54015,'Tlalnepantla'),
('Yamacue promoarticulos S.A. de C.V.','Fernanda','Peña Blanca','De Oca','Leandro Valle',604,'Miraval',62270,'Morelos'),
('TRANSBOX S.A. de C.V.','Joseline Valeria','Rámirez','Cortes','Shakespeare',39,'Anzures',11590,'Ciudad de México');
--insert into sale
INSERT INTO sale VALUES 
(default,'2020-05-16',490,'JRAR820602',2,'9 820145 658784'),
(default,'2020-05-16',580,'WLES801306',4,'9 587632 502058'),
(default,current_date,650,'JRAR820602',1,'6 458712 562387'),
(default,current_date,850,'APEV970116',2,'4 051236 498771'),
(default,'2020-05-16',120,'JRAR820602',1,'4 051236 498771'),
(default,'2020-05-14',320,'MCAC860212',1,'4 051236 657841'),
(default,'2020-05-10',620,'ZAMD980124',3,'4 051236 253610'),
(default,'2020-05-10',570,'JRAR820602',1,'9 820145 658784');
--insert into  phone_provider
INSERT INTO phone_provider VALUES
('H.P. México S.A. de C.V.',26153214),
('BicWorld S.A. de C.V.',26141232),
('Yamacue promoarticulos S.A. de C.V.',25147898),
('TRANSBOX S.A. de C.V.',23145889);
--insert into contain
INSERT INTO contain VALUES
('VENT-016','9 820145 658784'),
('VENT-017','9 587632 502058'),
('VENT-018','6 458712 562387'),
('VENT-019','4 051236 498771'),
('VENT-020','4 051236 498771'),
('VENT-001','4 051236 657841'),
('VENT-002','4 051236 253610'),
('VENT-003','9 820145 658784');

