\c papeleria_PF;
-------- INSERCION A TABLAS --------

insert into proveedor (prov_razon_Social, prov_nombre, prov_estado, prov_CP, prov_colonia, prov_calle, prov_numero)
values ('cartones para todo', 'CARTONES Y ALGO MAS', 'Tamaulipas', '07329', 'alguna', 'vicente guerrero', 263),
('cartones 2', 'CARTONES Y ALGO MA', 'Guerrero', '08267', 'alguna_1', 'vicente ', 267),
('cartones 3', 'CARTONES Y ALGO M', 'Chiapas', '18273', 'alguna_2', 'vicente av', 264),
('cartones 4', 'CARTONES Y ALGO', 'Sonora', '13652', 'alguna_3', 'vicente avenida', 269),
('cartones 5', 'CARTONES', 'Michoacan', '27201', 'alguna_4', 'avenida vicente guerrero', 213);
select * from proveedor p 

insert into inventario (inv_codigo_barras, inv_precio_compra, inv_foto_url, inv_fecha_compra, inv_stock)
values (394789821972, 45.00, 'https://s3.amazonaws.com/productos.papeleria/AT%26T.png','2023-06-01', 100),
(394789821973, 90.00, 'https://s3.amazonaws.com/productos.papeleria/AT%26T.png','2023-04-01', 100),
(600724784868, 275.00, 'https://s3.amazonaws.com/productos.papeleria/Mochila-Hombre.png','2023-02-10', 7),
(293191272802, 40.00, 'https://s3.amazonaws.com/productos.papeleria/Movistar.png','2023-05-01', 100),
(293191272803, 80.00, 'https://s3.amazonaws.com/productos.papeleria/Movistar.png','2023-05-01', 100),
(447860646475, 350.00, 'https://s3.amazonaws.com/productos.papeleria/Oso-Gigante-Beige.jpg','2023-03-15', 2),
(741231014278, 45.00, 'https://s3.amazonaws.com/productos.papeleria/PilloFon.png','2023-06-01', 100),
(741231014279, 90.00, 'https://s3.amazonaws.com/productos.papeleria/PilloFon.png','2023-06-01', 100),
(457917919598, 60.00, 'https://s3.amazonaws.com/productos.papeleria/Taza.jpg','2023-05-20', 10),
(114056211990, 45.00, 'https://s3.amazonaws.com/productos.papeleria/Telcel.png','2023-06-05', 100),
(114056211991, 90.00, 'https://s3.amazonaws.com/productos.papeleria/Telcel.png','2023-06-05', 100),
(399590618155, 50.00, 'https://s3.amazonaws.com/productos.papeleria/Cauderno-Jeans.png','2023-01-25', 15),
(219016431214, 30.00, 'https://s3.amazonaws.com/productos.papeleria/Cuaderno-Cuadro-Chico.png','2023-01-25', 13),
(226380482565, 30.00, 'https://s3.amazonaws.com/productos.papeleria/Cuaderno-Raya.png','2023-01-25', 20),
(687499736256, 15.00, 'https://s3.amazonaws.com/productos.papeleria/Goma.png','2023-02-15', 37),
(502798828568, 1.50, 'https://s3.amazonaws.com/productos.papeleria/Lapiz.png','2023-04-01', 47),
(484139753236, 17.00, 'https://s3.amazonaws.com/productos.papeleria/Pritt.png','2023-05-27', 24),
(715150864290, 10.00, 'https://s3.amazonaws.com/productos.papeleria/Pluma.png','2023-04-01', 15);
select * from inventario 

insert into producto (prod_codigo_Barras, prod_descripcion, prod_precio_Venta)
values (394789821972, 'Recarga Telefonica AT&T 50', 50),
(394789821973, 'Recarga Telefonica AT&T 100', 100),
(600724784868, 'Mochila Hombre Color Negro', 350),
(293191272802, 'Recarga Telefonica Movistar 50', 50),
(293191272803, 'Recarga Telefonica Movistar 100', 100),
(447860646475, 'Peluche Oso Gigante', 500),
(741231014278, 'Recarga Telefonica PilloFon 50', 50),
(741231014279, 'Recarga Telefonica PilloFon 100', 100),
(457917919598, 'Taza Decorada Mario Bros', 80),
(114056211990, 'Recarga Telefonica Telcel 50', 50),
(114056211991, 'Recarga Telefonica Telcel 100', 100),
(399590618155, 'Cuaderno Jean Book Cuadro', 65),
(219016431214, 'Cuaderno Cuadro Chico', 35),
(226380482565, 'Cuaderno Raya', 35),
(687499736256, 'Goma', 18),
(502798828568, 'Lapiz', 2),
(484139753236, 'Pritt', 25),
(715150864290, 'Pluma', 15);
select * from producto 

insert into cliente values 
('lesm8806304FA', 'Matías', 'Leyva', 'Suarez', 'Estado de Mexico', '04050', 'Tlalnepantla De Baz', 'Convento De Santa Ines', '38'),
('EATA920901JA4', 'Alejandra', 'Torres', 'Estrada', 'CDMX', '03100', 'Benito Juarez', 'Parroquia', '705'),
('MOLV970411Q17', 'valeria', 'lopez', 'moreno', 'Estado de Mexico', '07900', 'Nezahualcoyotl', 'calle 17', '168'),
('RUSF901215bg2', 'Francisco', 'Ruiz', 'Sanchez', 'CDMX', '03020', 'alvaro obregon', 'Doctor Jose Maria Vertiz', '800'),
('FETL7805208P9', 'Luis', 'Fernandez', 'Torres', 'CDMX', '03100', 'coyoacan', 'Av Insurgentes Sur', '1384'),
('GAA900227RU9', 'jose', 'Garcia', 'Arreola', 'CDMX', '02834', 'roma', 'Rio Panuco', '16');
select * from cliente 

insert into venta (ven_fecha_venta, ven_rfc_cliente) 
values ('2023-05-20','MOLV970411Q17'),
('2023-05-20','lesm8806304FA'),
('2023-05-25','EATA920901JA4'),
('2023-05-25','RUSF901215bg2'),
('2023-05-25','FETL7805208P9'),
('2023-05-30','GAA900227RU9'),
('2023-05-30','MOLV970411Q17');
select * from venta 


insert into proveer 
values ('cartones para todo', 600724784868, 2), 
('cartones 4',457917919598, 3),
('cartones 4',399590618155, 2),
('cartones 4',219016431214, 6),
('cartones 4',226380482565, 4),
('cartones 4',687499736256, 10),
('cartones 4',502798828568, 16);
select * from proveer 


insert into contener 
values ('VENT-0009', 1, 3),
('VENT-0009', 3, 1),
('VENT-0010', 13, 2),
('VENT-0010', 14, 2),
('VENT-0010', 18, 3),
('VENT-0011', 14, 1),
('VENT-0011', 15, 2),
('VENT-0011', 16, 2),
('VENT-0012', 9, 1),
('VENT-0012', 11, 1),
('VENT-0013', 10, 1),
('VENT-0014', 7, 1),
('VENT-0015', 4, 1);
select * from contener

insert into telefono 
values (5544332211, 'cartones para todo'),
(5528273612, 'cartones para todo'),
(7339283818, 'cartones 2'),
(4448927237, 'cartones 3'),
(5529383920, 'cartones 2'),
(2227834749, 'cartones 4'),
(5593474882, 'cartones 5'),
(5567838920, 'cartones 5');
select * from telefono t  

insert into email 
values ('matias_s@gmail.com', 'LESM8806304FA'),
('ale_torres12@outlook.com', 'EATA920901JA4'),
('ale_torres@gmail.com', 'EATA920901JA4'),
('vale_lopez_23@gmail.com', 'MOLV970411Q17'),
('vale_moreno@hotmail.com', 'MOLV970411Q17'),
('fran_suarez@gmail.com', 'RUSF901215BG2'),
('ltorres@gmail.com', 'FETL7805208P9'),
('jose_arreola@gmail.com', 'GAA900227RU9 ');
select * from email e




--INSERTRS
INSERT INTO  venta VALUES (DEFAULT, now(), DEFAULT, '$clirf');
INSERT INTO  venta VALUES (DEFAULT,now(),DEFAULT, 'LESM8806304FA');