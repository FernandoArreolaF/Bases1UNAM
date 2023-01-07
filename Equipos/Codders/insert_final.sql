insert into EMPLEADO_ESTADO values(57840,'ESTADO DE MÉXICO');
insert into EMPLEADO_ESTADO values(04000,'CDMX');
insert into EMPLEADO_ESTADO values(11310,'CDMX');
insert into EMPLEADO_ESTADO values(11410,'CDMX');
insert into EMPLEADO_ESTADO values(12345,'PUEBLA');
insert into EMPLEADO_ESTADO values(23410,'ESTADO DE MÉXICO');
insert into EMPLEADO_ESTADO values(09395,'CDMX');
insert into EMPLEADO_ESTADO values(13524,'GUANAJUATO');
insert into EMPLEADO_ESTADO values(14589,'COLIMA');
insert into EMPLEADO_ESTADO values(16220,'GUANAJUATO');

insert into SUCURSAL_ESTADO values(10092,'CDMX');
insert into SUCURSAL_ESTADO values(13225,'PUEBLA');
insert into SUCURSAL_ESTADO values(14289,'ESTADO DE MEXICO');

insert into PROVEEDOR_ESTADO values(76745,'CHIHUAHUA');
insert into PROVEEDOR_ESTADO values(57950,'VERACRUZ');
insert into PROVEEDOR_ESTADO values(16900,'JALISCO');
insert into PROVEEDOR_ESTADO values(10300,'YUCATAN');
insert into PROVEEDOR_ESTADO values(16540,'OAXACA');

insert into CLIENTE_ESTADO values(52135,'GUERERRO');
insert into CLIENTE_ESTADO values(14789,'CDMX');
insert into CLIENTE_ESTADO values(10080,'CDMX');
insert into CLIENTE_ESTADO values(42710,'ESTADO DE MEXICO');
insert into CLIENTE_ESTADO values(62784,'BAJA CALIFORNIA');
insert into CLIENTE_ESTADO values(31234,'SINALOA');
insert into CLIENTE_ESTADO values(12789,'CDMX');
insert into CLIENTE_ESTADO values(57840,'ESTADO DE MEXICO');

insert into sucursal values(713333,'2000-01-03',5554483071,456,34,10092,'BELGICA');
insert into sucursal values(258996,' 1990-12-15',5584783001,228,2,13225,'REPUBLICA DEL SALVADOR');
insert into sucursal values(7941523,'2016-11-23',5554963210,4310,4,14289,'RAMOS');

insert into proveedor values('CAGM640618NNJ',5514364335,'SAPI',1131851441,6630,3,76745,'CERRADA DE ABASOLO');
insert into proveedor values('BAFJ701213SB1',5553994545,'International WOOD',1131115802,6630,3,16900,'UXMAL');
insert into proveedor values('OIPF790205P26',5598739124,'Maderas SA',1570865715,13,9,10300,'LANDEROS');
insert into proveedor values('MAMHM670102NJ',5589235798,'Todo Casa CO.',1452843952,723,12,57950,'CAMINO AL LAUREL');
insert into proveedor values('SAD7808121G8U',5509324802,'Hogar y + C.V',1570869123,412,11,16540,'POMUCH');

INSERT INTO categoria VALUES ( 1, 'madera', 'muebles de madera');
INSERT INTO categoria VALUES ( 2, 'metal', 'muebles de metal');
INSERT INTO categoria VALUES ( 3, 'cristal', 'muebles de cristal');
INSERT INTO categoria VALUES ( 4, 'vidrio', 'muebles de vidrio');
INSERT INTO categoria VALUES ( 5, 'plástico', 'muebles de plastico');
INSERT INTO categoria VALUES ( 6, 'ratán', 'muebles de ratan');
INSERT INTO categoria VALUES ( 7, 'bambú', 'muebles de bambu');
INSERT INTO categoria VALUES ( 8, 'cuero', 'muebles de cuero');
INSERT INTO categoria VALUES ( 9, 'tela', 'muebles de tela');
INSERT INTO categoria VALUES ( 10, 'laminado', 'muebles de laminado');
INSERT INTO categoria VALUES ( 11, 'marmol', 'muebles de marmol');
INSERT INTO categoria VALUES ( 12, 'granito', 'muebles de granito');
INSERT INTO categoria VALUES ( 145, 'INFANTILES', 'Muebles para uso infantil');
INSERT INTO categoria VALUES ( 155, 'COCINA', 'Muebles para espacios de cocina y comedor');
INSERT INTO categoria VALUES ( 899, 'JARDÍN', 'Muebles para jardin y exteriores');
INSERT INTO categoria VALUES ( 784, 'DORMITORIO', 'Muebles para espacio de dormitorio');
INSERT INTO categoria VALUES ( 256, 'SALA', 'Muebles para sala de estar y pasillos');
INSERT INTO categoria VALUES ( 778, 'BAÑO', 'Muebles para baño');
INSERT INTO categoria VALUES ( 1234, 'Muebles Bases de Datos', 'Muebles demostracion bases');
INSERT INTO categoria VALUES ( 123466, 'Refrigeradores', 'Refrigeradores Perrones');
INSERT INTO categoria VALUES ( 125463, 'Comedor industriaL', 'Comedor industrial para empresas');



\lo_import 'D:/ImgMuebleria/cama_ks.jpg'
insert into articulo values(1236547,'CAMA KS',12900.00,16125.00,5,encode(lo_get(:LASTOID),'base64'),4);
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/mesa_c.jpg'
insert into articulo values(78965412,'MESA DE CENTRO',6500.00,8125.00,4,encode(lo_get(:LASTOID),'base64'),4);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/bar.jpg'
insert into articulo values(36541207,'BAR',9700.00,12125.00,3,encode(lo_get(:LASTOID),'base64'),3);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/mueble_m.jpg'
insert into articulo values(12344,'Mueble_madera',222.00,300.00,100,encode(lo_get(:LASTOID),'base64'),1);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/cajonera_c.jpg'
insert into articulo values(96548787,'CAJONERA COCINA',14780.00,18475.00,8,encode(lo_get(:LASTOID),'base64'),7);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/sofa_c.jpg'
insert into articulo values(78455210,'SOFA CAMA',12000.00,15000.00,3,encode(lo_get(:LASTOID),'base64'),6);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/buro.jpg'
insert into articulo values(96547852,'BURO',14700.00,15000.00,5,encode(lo_get(:LASTOID),'base64'),4);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/mesa_n.jpg'
insert into articulo values(23658971,'MESA NIÑOS',5700.00,7125.00,15,encode(lo_get(:LASTOID),'base64'),11);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/conunto_d.jpg'
insert into articulo values(10236547,'CONJUNTO DE DORMITORIO',33680.00,42100.00,10,encode(lo_get(:LASTOID),'base64'),3);
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/sala_lg.jpg'
insert into articulo values(12045789,'SALA LOUNGE',23200.00,29000.00,1,encode(lo_get(:LASTOID),'base64'),2);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/centro_j.jpg'
insert into articulo values(13236547,'CENTRO DE JUEGO',12400.00,15000.00,1,encode(lo_get(:LASTOID),'base64'),2);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/escritorio.jpg'
insert into articulo values(12365478,'ESCRITORIO',8500.00,10000.00,1,encode(lo_get(:LASTOID),'base64'),8);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/tocador_b.jpg'
insert into articulo values(47820365,'TOCADOR BAÑO',19300.00,24125.00,0,encode(lo_get(:LASTOID),'base64'),3);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/librero.jpg'
insert into articulo values(20365478,'LIBRERO 2BLE COLUMNA',10000.00,12500.00,0,encode(lo_get(:LASTOID),'base64'),9);	
\lo_list 
\lo_unlink id_objeto
\lo_import 'D:/ImgMuebleria/comedor.jpg'
insert into articulo values(89645201,'COMEDOR RUSTICO',17500.00,21000.00,2,encode(lo_get(:LASTOID),'base64'),1);		
\lo_list 
\lo_unlink id_objeto

insert into venta values(nextval('seque_folio_venta'),'2001-01-11 00:00:00',NULL,NULL,'JUMM420313PA5',315289014,217318574);
insert into venta values(nextval('seque_folio_venta'),'1990-01-11 00:00:00',NULL,NULL,NULL,317884964,418759684);
--insert into venta values(nextval('seque_folio_venta'),'2021-11-11 00:00:00',NULL,NULL,'ANA950214NSL2',217318574,315289014);
--insert into venta values(nextval('seque_folio_venta'),'2001-01-11 00:00:00',NULL,NULL,'REV970410UM34',315289014,216257810);
--insert into venta values(nextval('seque_folio_venta'),'2000-10-20 00:00:00',NULL,NULL,NULL,419412987,903719429);
--insert into venta values(nextval('seque_folio_venta'),'1999-07-11 00:00:00',NULL,NULL,'PSL780425NU12',216257810,315289014);

insert into es_vendido values('MBL-001',12344,NULL,4,FALSE);
insert into es_vendido values('MBL-001',12344,NULL,5,TRUE);
insert into es_vendido values('MBL-002',96548787,NULL,3,FALSE);
insert into es_vendido values('MBL-002',78965412,NULL,2,TRUE);

insert into provee values('OIPF790205P26',10236547,'2010-10-10');

INSERT INTO cliente VALUES ( 'JUMM420313PA5', 'jm4203@gmail.com', 'MANUEL', 'JUAREZ', 'MORELOS', 52135, 'PORFIRIO DIAZ', 2, 51, DEFAULT);
INSERT INTO cliente VALUES ( 'ANA950214NSL2', 'ana95@gmail.com', 'ANA', 'NOGAL', 'ARENDIZ', 14789 , 'PACIFICO', 3, 145, DEFAULT);
INSERT INTO cliente VALUES ( 'PSL780425NU12', 'psl78@gmail.com', 'LUIS', 'PASCAL', 'SOLER', 10080, 'MANI', 4, 478, 'werwe434');
INSERT INTO cliente VALUES ( 'OSS890327LI02', 'oss89@gmail.com', 'SANDRA', 'OSMAR', 'SARILLANA', 42710, 'MAGUEY', 5, 1745, 'hdfghd56');
INSERT INTO cliente VALUES ( 'REV970410UM34', 'rev97@gmail.com', 'VALERIA', 'RUIZ', 'ESCAMILLA', 62784, 'MANGO', 3, 123, 'sdfgsdf98f');
INSERT INTO cliente VALUES ( 'CACL010325MN1', 'cac@gmal.com', 'MANUEL', 'PEREZ', 'ESCOBEDO', 31234 , 'LIMA', 4, 32, 'MANUEL PEREZ ESCOBEDO');
INSERT INTO cliente VALUES ( 'ANRA930214NL6', 'ana93@gmail.com', 'ANA', 'ROBLE', 'ARENAS', 14789, 'MIRADOR', 3, 57, 'ANA ROBLE ARENAS');
INSERT INTO cliente VALUES ( 'COML720818AN4', 'lucila84@gmail.com', 'LUCIA', 'CORONA', 'MUÑOZ',57840 , 'TRISTE', 12, 321, 'LUCIA CORONA MUÑOZ');
