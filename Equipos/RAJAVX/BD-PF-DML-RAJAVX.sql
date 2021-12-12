--insertando clientes
insert into CLIENTE(RFC , NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ESTADO, CP, COLONIA, CALLE, NUMERO)
values ('AMMA123456789','Alejandro Martin','Avalos','Medina','Monterrey','04150',
 'Torito','Concepcion',256);
insert into CLIENTE(RFC , NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ESTADO, CP, COLONIA, CALLE, NUMERO)
values ('RDRC123456789','Rodrigo Daniel','Resendiz','Cruz', 'CDMX','03100',
 'Del valle','San Borja',605);
 insert into CLIENTE(RFC , NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ESTADO, CP, COLONIA, CALLE, NUMERO)
values ('MCFA123456789','Alexis Fernando','Castro','Mora','CDMX','03400',
 'Del valle sur','Omega',1202);
 insert into CLIENTE(RFC , NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ESTADO, CP, COLONIA, CALLE, NUMERO)
values ('RLJ0123456789','Joshua','Roldan','Landa', 'Veracruz','52501',
 'poza rica','Mara Caibo',707);
 insert into CLIENTE(RFC , NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ESTADO, CP, COLONIA, CALLE, NUMERO)
values ('VTV0123456789','Valeria','Valdemar','Tamez','Guerrero','03100',
 'coyula','arras',919);
 
 --insertando emails
insert into CLIENTE_EMAIL(RFC,EMAIL)
values ('AMMA123456789','uwu@yahoo.com');
insert into CLIENTE_EMAIL(RFC,EMAIL)
values ('RDRC123456789','owo@gmail.com');
insert into CLIENTE_EMAIL(RFC,EMAIL)
values ('MCFA123456789','uwur@myspace.com');
insert into CLIENTE_EMAIL(RFC,EMAIL)
values ('RLJ0123456789','7u7@hotmail.com');
insert into CLIENTE_EMAIL(RFC,EMAIL)
values ('VTV0123456789','awa@outlook.com');

--insertando proveedores

insert into PROVEEDOR values(1,'Rosa','S.A','Guanajuato','13100','Cuajimalpa',
					  'san benito',123,'1234165371','635173567');
insert into PROVEEDOR values(2,'Mike','S.A','CDMX','45110','universidad',
					  'london',272,'098765432','918291');
insert into PROVEEDOR values(3,'Zeuz','S.A','Zacatecas','09120','Cuajimalpa',
					  'san benito',444,'9327456',null);					  

--insertando articulos
										  
insert into ARTICULO values(1,'Recarga telefonica $20','Telcel',15,20,999);
insert into ARTICULO values(2,'Paketaxo queso 255 gr.','Sabritas',40,45.50,100);
insert into ARTICULO values(3,'Lapiz de grafito punta gruesa','Pelikan',5,10,45);
insert into ARTICULO values(4,'Paquete de papel 500 hojas tamaño A40','Office Depot',65,89.99,70);
insert into ARTICULO values(5,'coca cola light de lata 255 ml.','Coca-Cola',15,20,10);
insert into ARTICULO values(6,'caja de chocolates','De la Rosa',78,100,41);
insert into ARTICULO values(7,'impresion a color papel A40','Generico',1,2.50,999);					 
					 
--insertando categorias
insert into CATALOGO values(1,'Recarga',1);
insert into CATALOGO values(2,'Regalo',2);
insert into CATALOGO values(3,'Articulo de Papeleria',3);
insert into CATALOGO values(4,'Articulo de Papeleria',4);					 
insert into CATALOGO values(5,'Regalo',5);
insert into CATALOGO values(6,'Regalo',6);
					 
--insertando proveedores_almacen
insert into PROVEEDOR_ALMACEN values(1,1,'25-10-2021');
insert into PROVEEDOR_ALMACEN values(2,2,'25-10-2021');
insert into PROVEEDOR_ALMACEN values(2,5,'25-10-2021');
insert into PROVEEDOR_ALMACEN values(2,6,'25-10-2021');
insert into PROVEEDOR_ALMACEN values(3,3,'25-10-2021');
insert into PROVEEDOR_ALMACEN values(3,4,'25-10-2021');
insert into PROVEEDOR_ALMACEN values(3,7,'25-10-2021');
					 
--insertando en venta
insert into VENTA values('VENT-'||cast(nextval('seq_venta') as varchar),
					 '25-10-2021',65.50,2,'AMMA123456789');				 
--insertando en venta_almacen
insert into VENTA_ALMACEN values('VENT-1',1,20,1,(20*1));
insert into VENTA_ALMACEN values('VENT-1',2,45.50,1,(45.50*1));
					 
select * from ticket;


