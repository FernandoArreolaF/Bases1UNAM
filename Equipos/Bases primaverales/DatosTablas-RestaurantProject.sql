insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (1, 'gabriela','ramirez','ruiz','grrcdmx1584nr',('1980-01-01'),42,'bucareli',2888,'gustavo madero',09999,'cdmx','', 5000);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (2, 'ivan','zamorano','pedor','izpcdmx1258nr',('1990-01-01'),32,'chapultepec',452,'alvaro obregon',04020,'cdmx','', 4000);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (3, 'aura','perez','campos','apccdmx5145nr',('1995-03-13'),27,'roma',158,'coyoacan',04558,'cdmx','', 1000);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (4, 'raul','vazquez','gallo','rvgcdmx2685nr',('1995-02-03'),27,'insurgentes',158,'coyoacan',03265,'cdmx','', 2500);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (5, 'alexis','hernandez','romero','ahrcdmx8564nr',('1999-05-12'),23,'revolucion',44,'coyoacan',08954,'cdmx','', 3000);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (6, 'alan','becerra','castillo','abccdmx7845nr',('2001-09-15'),20,'misterios',1258,'gustavo madero',02584,'cdmx','', 2500);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (7, 'rodrigo','mendoza','cruz','rmccdmx5894nr',('1995-05-03'),27,'churubusco',589,'alvaro obregon',01881,'cdmx','', 1000);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (8, 'maria','lopez','sandoval','mlscdmx4587nr',('1991-02-13'),31,'chimalistac',4518,'benito juarez',02849,'cdmx','', 3000);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (9, 'jose','perez','montero','jpmcdmx5896nr',('1999-12-02'),21,'amsterdam',5894,'gustavo madero',04497,'cdmx','', 1500);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (10, 'fernando','cruz','marquez','fcmcdmx4589nr',('2002-10-08'),19,'milpa',254,'alvaro obregon',01881,'cdmx','', 1000);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (11, 'eder','avila','sanchez','eascdmx5849nr',('1950-12-05'),71,'juarez',32,'coyoacan',0188,'cdmx','', 1000);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (12, 'carlos','rivera','dias','crdcdmx6954nr',('1985-04-12'),37,'genova',587,'alvaro obregon',07815,'cdmx','', 1500);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (13, 'axel','mendez','pacheco','ampcdmx4587nr',('1984-02-13'),38,'regina',125,'benito juarez',0485,'cdmx','', 1800);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (14, 'ana','ramos','solis','arscdmx4587nr',('1962-12-03'),59,'valle',1145,'alvaro obregon',04180,'cdmx','', 1500);
insert into empleado (num_empleado, nombre, ap_paterno, ap_materno,rfc,fec_nacimiento,edad,calle,numero,colonia,cp,estado,foto,sueldo)
values (15, 'norma','quiroz','estrada','nqecdmx2457nr',('1991-09-02'),30,'boulevard',1246,'benito juarez',01808,'cdmx','', 4500);

--,pg_escape_bytea(file_get_contents('/home/sebastian/Desktop/imagen3.jpg')
-----------------------------
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,TRUE,FALSE,1); --administrativo
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,TRUE,FALSE,2); --administrativo
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,FALSE,TRUE,3); --mesero
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(TRUE,FALSE,FALSE,4); --cocinero postres y entradas
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(TRUE,FALSE,FALSE,5); --cocinero platos fuertes
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(TRUE,FALSE,FALSE,6); --cocinero sopas y ensaladas
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,FALSE,TRUE,7); --mesero
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(TRUE,FALSE,FALSE,8); --cocinero platos fuertes
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,FALSE,TRUE,9); --mesero
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,FALSE,TRUE,10); --administrativo
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,FALSE,TRUE,11); --mesero
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,FALSE,TRUE,12); --mesero
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(TRUE,FALSE,FALSE,13); --cocinero bebidas
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(TRUE,FALSE,FALSE,14); --cocinero aperitivos
insert into tipo_empleado (tipo_cocinero,tipo_administrativo,tipo_mesero,num_empleado)
values(FALSE,TRUE,FALSE,15); --administrativo

--------------------------------
insert into telefono (telefono,num_empleado)
values(5544667799,1);
insert into telefono (telefono,num_empleado)
values(5566442366,2);
insert into telefono (telefono,num_empleado)
values(5598756487,3);
insert into telefono (telefono,num_empleado)
values(5589563124,4);
insert into telefono (telefono,num_empleado)
values(5558795621,5);
insert into telefono (telefono,num_empleado)
values(5531254789,6);
insert into telefono (telefono,num_empleado)
values(5589563214,7);
insert into telefono (telefono,num_empleado)
values(5578945602,8);
insert into telefono (telefono,num_empleado)
values(5503210258,9);
insert into telefono (telefono,num_empleado)
values(5506320124,10);
insert into telefono (telefono,num_empleado)
values(5547895421,11);
insert into telefono (telefono,num_empleado)
values(5569998741,12);
insert into telefono (telefono,num_empleado)
values(5574856854,13);
insert into telefono (telefono,num_empleado)
values(5568489587,14);
insert into telefono (telefono,num_empleado)
values(5578989210,15);

-------------------------------------------
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('ieieiejdhfebrsba3','maria','gutierrez','ruiz','sobrina',1);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('ters88374hdfretb4','rodolfo','zamorano','leon','hijo',2);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('resr010273hntrej9','jorge','campos','reyes','abuelo',3);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('hngbfsdsvrgg71v8e', 'sofia','perez','campos','hermana',3);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('t4rng48t1g8rtg1vv', 'valeria','gallo','nuñez','hija',4);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('hytgr87t1g8v1e1e8','carolina','flores','romero','hija',5);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('verGtynr7yoiio4i8','mauricio','becerra','ramirez', 'padre',6);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('hv2s4ftyvy9h89j98', 'alberto','mendoza','gonzalez','padre',7);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('wxctrv54676vf6787', 'jorge','lopez','sandoval','hermano',8);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('mimjuih7ybbh76thj','oscar','campos','montero', 'tio',9);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('358jfi03m4t04w677','carlos','gutierrez','montero','sobrino',9);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('uvebsg5n548u9jh4t','felipe','cruz','ruiz','primo',10);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('lvdfingu45ht89544', 'miriam', 'leon', 'avila', 'hijo',11);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('vbearuhf8439045wn','pedro','garcia','martinez', 'primo',12);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('23vrtc678ij88iju8','gabriela','rivera','juarez','sobrina',13);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('gbnyug5rg789889yh','laura','mendez','pacheco','hermana',13);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('vrtdezw3er67y8h90','rocio','pacheco','leon','hijo',13);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('rexe434609i9inu00', 'esther','solis','gomez', 'madre',14);
insert into dependiente (curp,nombre_dep,ap_paterno_dep,ap_materno,parentesco_dep,num_empleado)
values('q124frr5uuui889km','jaime','estrada','perales', 'abuelo',15);

---------------------------------
insert into administrativo(rol, num_empleado)
values ('jefe', 1);
insert into administrativo(rol, num_empleado)
values ('contador', 2);
insert into mesero(hr_inicio, hr_fin, num_empleado)
values('09:01:01','15:00:00', 3);
insert into cocinero(especializacion, num_empleado)
values ('postres', 4);
insert into cocinero(especializacion, num_empleado)
values ('platos fuertes', 5);
insert into cocinero(especializacion, num_empleado)
values ('sopas y ensaldas', 6);
insert into mesero(hr_inicio, hr_fin, num_empleado)
values('09:01:01','15:00:00', 7);
insert into cocinero(especializacion, num_empleado)
values ('proteinas', 8);
insert into mesero(hr_inicio, hr_fin, num_empleado)
values('12:01:01','18:00:00', 9);
insert into administrativo(rol, num_empleado)
values ('supervisor', 10);
insert into mesero(hr_inicio, hr_fin, num_empleado)
values('15:01:01','21:00:00', 11);
insert into mesero(hr_inicio, hr_fin, num_empleado)
values('15:01:01','21:00:00', 12);
insert into cocinero(especializacion, num_empleado)
values ('bebidas', 13);
insert into cocinero(especializacion, num_empleado)
values ('aperitivos', 14);
insert into administrativo(rol, num_empleado)
values ('coordinador', 15);


-- CATEGORIAS --
INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (1,'bebidas calientes','100% mexicanos');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (2,'bebidas frias','refrescantes sabores');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (3,'jugos y frutas','ingredientes naturales');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (4,'snacks','para iniciar la mañana');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (5,'huevos y omelettes','preparados con un toque especial');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (6,'almuezos','comidas ligeras');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (7,'chilaquiles','tradicion y sazon mexicanos');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (8,'entradas','alimentos para empezar');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (9,'tacos','plato para compartir');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (10,'sopas y caldos','con excelente sazon');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (11,'ensaladas','con el perfecto balance de ingredientes');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (12,'hamburguesas y sandwiches','autenticas combinaciones en nuestro pan casero');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (13,'carnes','cortes de alta calidad');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (14,'aves','una proteina de calidad');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (15,'pescados','proteinas del mar');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (16,'enchiladas','recetas tradicionales');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (17,'postres','dulce antojo');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (18,'bebidas refrescantes','frescas opciones para hidratarse');

------------------------------------
-- PLATILLOS Y BEBIDAS --
INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida, id_categoria)
VALUES (1, 'capuchinno','240 ml,incluye refil',40,'cafe espumoso con leche entera',TRUE,0,FALSE,TRUE,1);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (2,'chocolate caliente','240 ml',50,'chocolate oaxaqueño espumoso',TRUE,0,FALSE,TRUE,1);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (3,'smoothie de mango','420 ml',40,'acompañado de chile en polvo y chamoy',TRUE,0,FALSE,TRUE,2);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (4,'malteada de vainilla','473 ml',50,'acompañada con galleta de barquillo',TRUE,0,FALSE,TRUE,2);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida, id_categoria)
VALUES (5,'jugo de naranja','355 ml',30,'exprimido al momento',TRUE,0,FALSE,TRUE,3);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida, id_categoria)
VALUES (6,'jugo de piña','355 ml',30,'preparado al momento',TRUE,0,FALSE,TRUE,3);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida, id_categoria)
VALUES (7,'hot cakes','3 pzas',60,'con mantequilla y miel de abeja o jarabe de maple',TRUE,0,TRUE,FALSE,4);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida, id_categoria)
VALUES (8,'molletes','4 pzas',70,'dorados con jamon, tocino al gratin',TRUE,0,TRUE,FALSE,4);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida, id_categoria)
VALUES (9,'huevos con arrachera','3 pzas',100,'salsa verde al cilantro, acompañados con frijoles',TRUE,0,TRUE,FALSE,5);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida, id_categoria)
VALUES (10,'tarascos','2 pzas',60,'huevos fritos sobre tortilla con jamon, salsa y queso',FALSE,0,TRUE,FALSE,5);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida, id_categoria)
VALUES (11,'norteño','250 g',70,'machaca a la mexicana y tortillas de harina',FALSE,0,TRUE,FALSE,6);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (12,'mañanera','120 g',150,'arrachera con chilaquiles rojos',TRUE,0,TRUE,FALSE,6);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (13,'enfrijoladas','3 pzas',70,'al gratin con pechuga de pollo',TRUE,0,TRUE,FALSE,7);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (14,'chilaquiles verdes','487 kcal',60,'acompañados con tiras de pollo',TRUE,0,TRUE,FALSE,7);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (15,'queso fundido','150 g',40,'con salsa verda al cilantro y tortillas de harina',TRUE,0,TRUE,FALSE,8);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (16,'doradas de chicharrron','5 pzas',50,'con salsa habanero y guacamole',TRUE,0,TRUE,FALSE,8);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (17,'taco de pastor','5 pzas',80,'acompañados con gaucamole y frijoles refritos',TRUE,0,TRUE,FALSE,9);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (18,'tacos dorados','150 g',80,'con crema, queso y salsa',TRUE,0,TRUE,FALSE,9);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (19,'consome de pollo','250 ml',40,'con arroz blanco y pechuga de pollo',TRUE,0,TRUE,FALSE,10);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (20,'caldo tlalpeño','250 ml',40,'con pechuga de pollo, queso manchego, aguacate y arroz',TRUE,0,TRUE,FALSE,10);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (21,'mediterranea','aderezo al gusto',30,'con pechuga de pollo, lechega, espinaca y jitomate',TRUE,0,TRUE,FALSE,11);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (22,'san francisco','aderezo al gusto',30,'combinacion de lechugas con pechuga de pollo a la hierbas finas',TRUE,0,TRUE,FALSE,11);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (23,'club sandwich','4 pzas',50,'con pechuga de pollo, tocino, jampon y queso americano',TRUE,0,TRUE,FALSE,12);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (24,'hamburguesa de pavo','120 g',70,'en pan de ajonjoli con aguacate, cebolla, acompañada de papas fritas',TRUE,0,TRUE,FALSE,12);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (25,'arrachera','200 g',120,'jugosa y suave, cocinada a la parrilla, con papas fritas',TRUE,0,TRUE,FALSE,13);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (26,'asado mixto','180 g',150,'carne de res, pechuga de pollo, pierna de cerdo, queso y nopales',TRUE,0,TRUE,FALSE,13);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (27,'pechuga spicy','150 g',100,'de pollo con ejotes al limon y papas fritas',TRUE,0,TRUE,FALSE,14);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (28,'sabana','150 g',90,'pechuga de pollo con salsa verde al cilantro y esquites',TRUE,0,TRUE,FALSE,14);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (29,'filete almendrado','160 g',80,'sobre cebolla francesa, pure de papa y ensalada de lechugas',TRUE,0,TRUE,FALSE,15);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (30,'filete teriyaki','160 g',80,'sobre arroz con verduras y laminas de chile habanero',TRUE,0,TRUE,FALSE,15);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (31,'enchiladas originales','3 pzas',60,'de pechuga de pollo con salsa al gratin',TRUE,0,TRUE,FALSE,16);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (32,'enchiladas de mole','3 pzas',60,'de pechuga de pollo y mole artesanal',TRUE,0,TRUE,FALSE,16);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (33,'pastel de chocolate','3 capas',80,'pan y cobertura de chocolate',TRUE,0,TRUE,FALSE,17);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (34,'crepas de cajeta','3 pzas',50,'con helado de vainilla, caramelizadas con nuez',TRUE,0,TRUE,FALSE,17);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (35,'naranjada','355 ml',20,'bebida mineral con fruta natural',TRUE,0,FALSE,TRUE,18);

INSERT INTO platilloybebida (id_platilloybebida, nombre_platilloybebida, descripcion, precio_platilloybebida, receta, disponibilidad, cantidad_vendido, es_platillo, es_bebida,id_categoria)
VALUES (36,'refresco','600 ml',30,'bebida endulzada',TRUE,0,FALSE,TRUE,18);

----------------------------
insert into prepara(num_empleado,id_platilloybebida)
values(13,1);
insert into prepara(num_empleado,id_platilloybebida)
values(13,2);
insert into prepara(num_empleado,id_platilloybebida)
values(13,3);
insert into prepara(num_empleado,id_platilloybebida)
values(13,4);
insert into prepara(num_empleado,id_platilloybebida)
values(13,5);
insert into prepara(num_empleado,id_platilloybebida)
values(13,6);
insert into prepara(num_empleado,id_platilloybebida)
values(14,7);
insert into prepara(num_empleado,id_platilloybebida)
values(14,8);
insert into prepara(num_empleado,id_platilloybebida)
values(14,9);
insert into prepara(num_empleado,id_platilloybebida)
values(14,10);
insert into prepara(num_empleado,id_platilloybebida)
values(14,11);
insert into prepara(num_empleado,id_platilloybebida)
values(14,12);
insert into prepara(num_empleado,id_platilloybebida)
values(5,13);
insert into prepara(num_empleado,id_platilloybebida)
values(5,14);
insert into prepara(num_empleado,id_platilloybebida)
values(14,15);
insert into prepara(num_empleado,id_platilloybebida)
values(14,16);
insert into prepara(num_empleado,id_platilloybebida)
values(5,17);
insert into prepara(num_empleado,id_platilloybebida)
values(5,18);
insert into prepara(num_empleado,id_platilloybebida)
values(6,19);
insert into prepara(num_empleado,id_platilloybebida)
values(6,20);
insert into prepara(num_empleado,id_platilloybebida)
values(8,21);
insert into prepara(num_empleado,id_platilloybebida)
values(8,22);
insert into prepara(num_empleado,id_platilloybebida)
values(8,23);
insert into prepara(num_empleado,id_platilloybebida)
values(8,24);
insert into prepara(num_empleado,id_platilloybebida)
values(8,25);
insert into prepara(num_empleado,id_platilloybebida)
values(8,26);
insert into prepara(num_empleado,id_platilloybebida)
values(8,27);
insert into prepara(num_empleado,id_platilloybebida)
values(8,28);
insert into prepara(num_empleado,id_platilloybebida)
values(8,29);
insert into prepara(num_empleado,id_platilloybebida)
values(8,30);
insert into prepara(num_empleado,id_platilloybebida)
values(5,31);
insert into prepara(num_empleado,id_platilloybebida)
values(5,32);
insert into prepara(num_empleado,id_platilloybebida)
values(4,33);
insert into prepara(num_empleado,id_platilloybebida)
values(4,34);
insert into prepara(num_empleado,id_platilloybebida)
values(13,35);
insert into prepara(num_empleado,id_platilloybebida)
values(13,36);