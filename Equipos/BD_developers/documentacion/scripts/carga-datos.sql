----------------------------------------------------------------------------------------------------------------------------------
--@Autor: 	Carolina Rodriguez, Juan Pablo Sanchez, Jorge Luis Pastenes
--@Fecha:
--@Descripcion: Carga de datos
----------------------------------------------------------------------------------------------------------------------------------

insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Brightbean', 'Millard', 'Risborough', 'Eagleton', 'Texas', '78235', 'Saint Paul', 'Westerfield', '26926');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Meemm', 'Trumaine', 'Rowlands', 'Furniss', 'Alaska', '99507', 'Gerald', 'Caliangt', '6648');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Realbridge', 'Darsey', 'Bukowski', 'Colbourne', 'California', '94159', '2nd', 'Butternut', '4444');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Skibox', 'Kermie', 'Lynd', 'Winteringham', 'Indiana', '47712', 'Graceland', 'Meadow Ridge', '03');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Linkbridge', 'Dinnie', 'Veal', 'Bettinson', 'Missouri', '63143', 'Shoshone', 'Longview', '0');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Jetpulse', 'Jens', 'O''Ruane', 'Kiendl', 'Massachusetts', '02142', 'Esch', 'Eagle Crest', '48008');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Eabox', 'Tannie', 'Toward', 'Ralfe', 'Ohio', '43605', 'Donald', 'Oriole', '3');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Thoughtworks', 'Madelle', 'Axelbey', 'Presslie', 'New Jersey', '07195', 'Schlimgen', 'Burning Wood', '42');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Oyoba', 'Norri', 'Jachimczak', 'Stuchberry', 'District of Columbia', '20051', 'Hooker', 'Forest', '2');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Tambee', 'Malchy', 'Conradie', 'Iscowitz', 'Virginia', '24014', 'Eagan', 'Fordem', '60');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Cogilith', 'Ram', 'Signe', 'Caddie', 'Oregon', '97232', 'Village', 'Merry', '5845');
insert into proveedor (razon_social, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('Riffpedia', 'Missy', 'Tunnick', 'Drakeford', 'California', '90405', 'Surrey', 'Carey', '921');

SELECT setval('proveedor_id_proveedor_seq', 12, true);

insert into tel_proveedor (telefono, id_proveedor) values ('926 803 9195', 1);
insert into tel_proveedor (telefono, id_proveedor) values ('276 993 6289', 2);
insert into tel_proveedor (telefono, id_proveedor) values ('582 972 6799', 3);
insert into tel_proveedor (telefono, id_proveedor) values ('476 951 0007', 4);
insert into tel_proveedor (telefono, id_proveedor) values ('168 620 7289', 5);
insert into tel_proveedor (telefono, id_proveedor) values ('840 853 9795', 6);
insert into tel_proveedor (telefono, id_proveedor) values ('272 192 1439', 7);
insert into tel_proveedor (telefono, id_proveedor) values ('750 257 3793', 8);
insert into tel_proveedor (telefono, id_proveedor) values ('158 555 8991', 9);
insert into tel_proveedor (telefono, id_proveedor) values ('130 921 9488', 10);
insert into tel_proveedor (telefono, id_proveedor) values ('900 200 8600', 11);
insert into tel_proveedor (telefono, id_proveedor) values ('834 140 2099', 12);

SELECT setval('tel_proveedor_id_tel_proveedor_seq', 12, true);

insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('552-88-5195', 'Vicki', 'Dupoy', 'Kolyagin', 'Connecticut', '06160', 'Monument', 'American Ash', '83');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('168-88-0472', 'Ula', 'MacGillavery', 'MacKaig', 'Missouri', '63167', 'Swallow', 'Dwight', '09');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('532-83-5098', 'Caldwell', 'Mattiussi', 'O''Cuddie', 'District of Columbia', '20005', 'Vera', 'Longview', '36');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('391-05-5960', 'Ina', 'Kinnard', 'Infantino', 'New York', '11205', 'Mccormick', 'Talmadge', '60');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('546-41-2109', 'Chris', 'Rochell', 'Dudley', 'Florida', '33283', 'Northfield', 'Texas', '752');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('864-47-2537', 'Bambi', 'Stabbins', 'Fragino', 'Tennessee', '37939', 'Meadow Vale', 'Golf View', '197');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('517-54-1898', 'Evy', 'Roussell', 'Theurer', 'Texas', '77245', 'Shoshone', 'Dorton', '54');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('872-42-4957', 'Charlton', 'McGillivray', 'Mowen', 'Florida', '33233', 'Crowley', 'Grover', '8518');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('888-99-6700', 'Jelene', 'Pawfoot', 'Jepp', 'West Virginia', '25721', 'Stoughton', 'Basil', '0433');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('316-25-0561', 'Madeline', 'Donneely', 'Calderonello', 'California', '93111', 'Troy', 'Eagan', '28396');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('715-23-8072', 'Buck', 'Dikle', 'Asson', 'Arizona', '85743', 'Lighthouse Bay', 'Center', '11');
insert into cliente (rfc, nombre, ap_paterno, ap_materno, estado, cp, colonia, calle, numero) values ('890-14-1800', 'Adriaens', 'Buckel', 'Persey', 'Arizona', '85725', 'Gale', 'Havey', '4808');


insert into correo_cliente (correo, rfc) values ('ajezard0@edublogs.org', '223-19-8454');
insert into correo_cliente (correo, rfc) values ('lhesbrook1@xing.com', '621-09-3240');
insert into correo_cliente (correo, rfc) values ('dbradick2@creativecommons.org', '621-21-6622');
insert into correo_cliente (correo, rfc) values ('eiveson3@wisc.edu', '734-67-2908');
insert into correo_cliente (correo, rfc) values ('csenter4@liveinternet.ru', '782-75-6670');
insert into correo_cliente (correo, rfc) values ('ltocher5@ted.com', '672-98-0488');
insert into correo_cliente (correo, rfc) values ('dbert6@japanpost.jp', '546-56-7720');
insert into correo_cliente (correo, rfc) values ('rgeorgeson7@nhs.uk', '380-06-9485');
insert into correo_cliente (correo, rfc) values ('sdilger8@flickr.com', '838-38-8938');
insert into correo_cliente (correo, rfc) values ('hdevanny9@addtoany.com', '741-98-4673');
insert into correo_cliente (correo, rfc) values ('aworsfolda@pinterest.com', '721-05-1055');
insert into correo_cliente (correo, rfc) values ('rmaylingb@oracle.com', '551-07-7031');

SELECT setval('cliente_correo_id_cliente_correo_seq', 12, true);

INSERT INTO categoria(
	id_categoria, tipo)
	VALUES (1, 'Articulo papeleria');
INSERT INTO categoria(
	id_categoria, tipo)
	VALUES (2, 'Recarga');
INSERT INTO categoria(
	id_categoria, tipo)
	VALUES (3, 'Regalo');
INSERT INTO categoria(
	id_categoria, tipo)
	VALUES (4, 'impresiones');

SELECT setval('categoria_id_categoria_seq', 4, true);

insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('43742-0423', 'Energy', 'SD', '$636.41M', 'n/a', 'n/a', '6/23/2021', 1, 1);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('11410-117', 'Consumer Services', 'ANGI', '$730.37M', '$3.49M', '$1.8B', '3/23/2021', 2, 2);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('55289-214', 'Health Care', 'EPZM', '$796.59M', '$120.57B', '$387.13M', '2/11/2021', 3, 3);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('0093-9364', 'Consumer Services', 'PLCE', '$1.91B', '$412.44M', '$179.29M', '9/23/2021', 4, 4);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('11673-207', 'Technology', 'LTRPA', '$858.79M', 'n/a', '$24.6B', '3/7/2021', 5, 5);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('52125-170', 'n/a', 'FPF', '$1.48B', '$79.99M', '$3.56B', '4/16/2021', 6, 6);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('31722-421', 'Health Care', 'GPACW', 'n/a', '$42.5B', '$89.35M', '4/15/2021', 7, 7);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('47682-201', 'n/a', 'NCZ', '$463.93M', '$61.25B', '$17.83M', '9/16/2021', 8, 8);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('59779-964', 'Basic Industries', 'FLR', '$6.3B', '$2.28B', '$107.03M', '8/16/2021', 9, 9);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('0904-6089', 'n/a', 'ARI^C', 'n/a', '$8.92B', '$1.91B', '4/2/2021', 10, 10);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('0143-9683', 'n/a', 'NBB', '$555.7M', '$222.06M', '$117.97M', '9/30/2021', 11, 11);
insert into articulo (cod_barras, descripcion, marca, utilidad, costo_compra, precio_venta, fecha_compra, id_categoria, id_proveedor) values ('0430-3240', 'Health Care', 'IVC', '$399.95M', '$34.88M', '$207.39M', '2/27/2021', 12, 12);

SELECT setval('articulo_id_articulo_seq', 12, true);

insert into venta (fecha_venta, monto_total, rfc) values ('12/18/2020', '$50.64M', '385-18-8799');
insert into venta (fecha_venta, monto_total, rfc) values ('10/21/2021', '$6', '593-09-7214');
insert into venta (fecha_venta, monto_total, rfc) values ('8/1/2021', '$14.6B', '230-32-6383');
insert into venta (fecha_venta, monto_total, rfc) values ('12/22/2020', '$14.05M', '800-88-2292');
insert into venta (fecha_venta, monto_total, rfc) values ('8/13/2021', '$30.31M', '569-08-2528');
insert into venta (fecha_venta, monto_total, rfc) values ('2/26/2021', '$7', '204-38-4364');
insert into venta (fecha_venta, monto_total, rfc) values ('9/25/2021', '$72.51M', '601-70-1867');
insert into venta (fecha_venta, monto_total, rfc) values ('4/12/2021', '$15.84M', '540-05-2159');
insert into venta (fecha_venta, monto_total, rfc) values ('3/16/2021', '$8', '121-12-9890');
insert into venta (fecha_venta, monto_total, rfc) values ('10/29/2021', '$151.51M', '259-35-9703');
insert into venta (fecha_venta, monto_total, rfc) values ('11/24/2021', '$3.61B', '818-98-8326');
insert into venta (fecha_venta, monto_total, rfc) values ('4/23/2021', '$98', '106-16-1987');

SELECT setval('venta_id_venta_seq', 12, true);