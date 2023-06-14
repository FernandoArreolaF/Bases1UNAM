-- Inserción de información.

BEGIN;

--PROVEDOR

INSERT INTO PROVEDOR (rfcpro, nombre, razonsocial, estado, colonia, cp, num, calle)
        VALUES ('OFM93251485G','Oficimundo','Oficimundo S.A DE C.V','Ciudad de México','Polanco III sección',11540,204,'Av. Ejercito Nacional'),
            ('PAE031205391','Papelerías Escorpión','Comercializadora Scorpion S.A de C.V','Puebla','Centro Histórico de Puebla',72000,218,'Av. 8 Oriente'),
            ('CPO170620V23','La Universal papelerías','Consorcio Papelero OM S de RL de C V','Puebla','Centro',75520,9,'Av. Revolución'),
            ('DUE9568748JI','Distribuidora Universo Escolar','DISTRIBUIDORA ESCOLAR, S.A','Ciudad de México','Centro de la Ciudad de México',06090,44,'José María Pino Suárez'),
            ('PAE031305391','Papelerías Escorpión','Comercializadora Scorpion S.A de C.V','Puebla','Centro Histórico de Puebla',72000,218,'Av. 8 Oriente'),
            ('UPM020503A88','Unión Papelera','Union Papelera de México, S.A de C.V.','Ciudad de México','Escandón 1 Sección',11800,108,'Benjamín Franklin'),
            ('DPO9911038H5','DPO','Distribuidora de Papelería, S.A de C.V','Ciudad de México','Insurgentes Mixoac',03920,160,'Av. Extremadura Loc. C.'),
            ('MPM050321P9O','Mega Papelería','Mega Oficinas de México S.A de C.v','Ciudad de México','Hipódromo',06170,527,'Av. Insurgentes Sur'),
            ('RGM9705127G8','Regalarama','Regalarama S.A de C.V','Nuevo León','Centro',64000,1962,'Washington'),
            ('MTC0112308F9','MTCenter','MTCenter S.A de C.V','Morelos','Lomas de Cortés',62240,1304,'Av. Vicente Guerrero');


--CLIENTES

INSERT INTO CLIENTE (rfcClien, nombre, aPaterno, aMaterno, cp, estado, colonia, calle, num)
        VALUES ('NGJM020831I84','José Manuel','Nava','González',09828,'Ciudad de México','Ricardo Flores Magón','Los Reyes',16),
                ('SRAK011225IR9','Ana Karen','Saldaña','Ramírez',07890,'Ciudad de México','Nueva Tenochtitlán','Nte 80-A',4719),
                ('OGIJ97062256Y','Itzel Jazmín','Ortiz','Guzmán',55270,'Estado de México','Granjas Valle de Guadalupe','C. Pascual Morales',100),
                ('TFDM020426O9I','Dulce María','Tolentino','Francisco',56346,'Estado de México','Xaltipac','Mariano Maya Muñoz',15),
                ('JRA010515P0I','Abdiel','Jarquín','Reyes',72130,'Puebla','Libertad','3 Sur',3),
                ('MPO960202O0Y','Omar','Maldonado','Palacios',72488,'Puebla','16 de Septiembre Nte','Av 78 Pte.',523),
                ('AGK981231TU3','Kenya','Alarcón','García',11830,'Ciudad de México','Daniel Garza al Poniente','General Pedro Hinojosa',44),
                ('GSLM881201I8F','Luis Manuel','García','Sánchez',03300,'Ciudad de México','Portales','Canarias',317),
                ('PRE901115H7H','Esteban','Pardavé','Ramírez',16035,'Ciudad de México','Paseos del Sur','Ponciano Arriaga',8),
                ('NGCE000607O9U','Christian Eduardo','Navarrete','González',57500,'Estado de México','Agua Azul','Lago Mayor',23),
                ('POD750308PE4','Daniela','Padilla','Ortega',02240,'Ciudad de México','San Andrés','Campo Moloacan',117),
                ('AAA920308MN8','Andrés','Alfaro','Andrade',66610,'Nuevo León','Prados de Santa Rosa','Fresno',315),
                ('ESJ940127M65','Javier','Espinoza','Sánchez',39000,'Guerrero','San Antonio','Ignacio Zaragoza',59),
                ('RPEO430822U77','Edgar Osvaldo','Rodríguez','Pérez',37320,'Guanajuato','Obregón','Constancia',228),
                ('RJMA800920L0J','Marco Antonio','Robles','Jiménez',04870,'Ciudad de México','Espartaco','5',108),
                ('FGG020302LK4','Guillermo','Félix','García',04310,'Ciudad de México','Romero de Terreros','Cerro del Hombre',192);


--TELEFONO

INSERT INTO TELEFONO (telefono, rfcPro)
        VALUES ('5562782479','OFM93251485G'),
                ('5562782723','OFM93251485G'),
                ('2212721307','CPO170620V23'),
                ('5519459015','DUE9568748JI'),
                ('2222426140','PAE031205391'),
                ('2222420042','PAE031205391'),
                ('5555362060','UPM020503A88'),
                ('5555434465','UPM020503A88'),
                ('55980056','DPO9911038H5'),
                ('55980167','DPO9911038H5'),
                ('5543980278','MPM050321P9O'),
                ('4771521966','MPM050321P9O');


--EMAIL

INSERT INTO EMAIL (emails, rfcClien)
        VALUES ('navito@gmail.com','NGJM020831I84'),
                ('anaKarenista@gmail.com','SRAK011225IR9'),
                ('laNinhaBonita@gmail.com','OGIJ97062256Y'),
                ('dulce.tolentino@gmail.com','TFDM020426O9I'),
                ('elArqui.abdiel@gmail.com','JRA010515P0I'),
                ('ironman_supremo@hotmail.com','MPO960202O0Y'),
                ('theMinim_89@hotmail.com','AGK981231TU3'),
                ('luis.luis.garcia@gmail.com','GSLM881201I8F'),
                ('rob_boyPar@gmail.com','PRE901115H7H'),
                ('poli_Navarr@gmail.com','NGCE000607O9U'),
                ('danyPreciosa@hotmail.com','POD750308PE4'),
                ('nuevoAndresig@hotmail.com','AAA920308MN8'),
                ('javi_espinoza59@gmail.com','AAA920308MN8'),
                ('guana_rodriEdga@gmail.com','ESJ940127M65'),
                ('marjinado108@gmail.com','RPEO430822U77'),
                ('jim_0980@gmail.com','RPEO430822U77'),
                ('marjinado108@hotmail.com','RPEO430822U77'),
                ('komo_80.a@gmail.com','RJMA800920L0J'),
                ('komo_70.b@hotmail.com','RJMA800920L0J'),
                ('phoenix_grant10@gmail.com','FGG020302LK4'),
                ('phoenix_grant10@hotmail.com','FGG020302LK4');


-- PRODUCTO

    --SELECT insertar Proveedor y producto(rfcproveedor, fecha, cantidad, precioC, categoria, marca, descripcion).
    --Artículos de papelería.

    SELECT insertarP('OFM93251485G','05-06-2023',12,35,'Papelería','Blanca Nieves','Lapices de colores Blanca Nieves (24 piezas).');
    SELECT insertarP('OFM93251485G','05-06-2023',20,5,'Papelería','Janel','Cinta adhesiva Diurex chico.');
    SELECT insertarP('CPO170620V23','05-06-2023',500,0.3,'Papelería','Janel','Hoja blanca tamaño carta.');
    SELECT insertarP('DUE9568748JI','07-06-2023',15,28,'Papelería','Scribe','Cuaderno forma profesional cuadro chico de 100 hojas.');
    SELECT insertarP('DUE9568748JI','07-06-2023',20,8.5,'Papelería','BIC','Pluma negra kilométrico 100.');
    SELECT insertarP('PAE031205391','04-06-2023',20,12,'Papelería','Scribe','Cuaderno forma francesa cuadro grande de 100 hojas.');
    SELECT insertarP('UPM020503A88','03-06-2023',12,15,'Papelería','Pilot','Regla de plástico de 30cm.');
    SELECT insertarP('DPO9911038H5','06-06-2023',15,15.5,'Papelería','Maped','Sacapuntas doble de plástico.');

    --Regalos

    SELECT insertarP('RGM9705127G8','09-06-2023',2,70,'Regalos','Peluches Ranizzima Corp','Oso de peluche blanco chico.');
    SELECT insertarP('RGM9705127G8','09-06-2023',10,15,'Regalos','ElCorte','Caja de regalo de cartón chica.');
    SELECT insertarP('RGM9705127G8','09-06-2023',2,120,'Regalos','Turin','Chocolate Turín Baileys Tubo de 200g.');
    SELECT insertarP('RGM9705127G8','09-06-2023',3,240,'Regalos','Ferrero Rocher','Chocolates Ferrero Rocher (12 piezas).');
    SELECT insertarP('RGM9705127G8','09-06-2023',3,160,'Regalos','Coffee me','Taza llena de chocolates Kisses, Turin, Golden.');

    --Impresiones

    SELECT insertarP('MPM050321P9O','10-06-2023',700,0.5,'Impresiones','B/N','Carta');
    SELECT insertarP('MPM050321P9O','10-06-2023',400,1,'Impresiones','B/N','Opalina');
    SELECT insertarP('MPM050321P9O','10-06-2023',500,2,'Impresiones','Color','Carta');
    SELECT insertarP('MPM050321P9O','10-06-2023',200,4,'Impresiones','Color','Opalina');

    --Recargas

    SELECT insertarP('MTC0112308F9','10-06-2023',200,20,'Recargas','20.0','Telcel');
    SELECT insertarP('MTC0112308F9','10-06-2023',300,50,'Recargas','50.0','Telcel');
    SELECT insertarP('MTC0112308F9','10-06-2023',500,100,'Recargas','100','Telcel');
    SELECT insertarP('MTC0112308F9','10-06-2023',500,150,'Recargas','150','Telcel');
    SELECT insertarP('MTC0112308F9','10-06-2023',800,200,'Recargas','200','Telcel');
    SELECT insertarP('MTC0112308F9','10-06-2023',1000,500,'Recargas','500','Telcel');
    
    SELECT insertarP('MTC0112308F9','10-06-2023',300,20,'Recargas','20.0','Movistar');
    SELECT insertarP('MTC0112308F9','10-06-2023',300,20,'Recargas','50.0','Movistar');
    SELECT insertarP('MTC0112308F9','10-06-2023',300,20,'Recargas','100','Movistar');
    SELECT insertarP('MTC0112308F9','10-06-2023',450,20,'Recargas','150','Movistar');
    SELECT insertarP('MTC0112308F9','10-06-2023',400,20,'Recargas','200','Movistar');
    SELECT insertarP('MTC0112308F9','10-06-2023',1000,20,'Recargas','500','Movistar');

    SELECT insertarP('MTC0112308F9','10-06-2023',100,10,'Recargas','10.0','Unefon');
    SELECT insertarP('MTC0112308F9','10-06-2023',120,20,'Recargas','20.0','Unefon');
    SELECT insertarP('MTC0112308F9','10-06-2023',200,50,'Recargas','50.0','Unefon');
    SELECT insertarP('MTC0112308F9','10-06-2023',300,100,'Recargas','100','Unefon');
    SELECT insertarP('MTC0112308F9','10-06-2023',450,150,'Recargas','150','Unefon');

COMMIT;