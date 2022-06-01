----------------TABLA EMPLEADO-------
DROP TABLE EMPLEADO CASCADE;
SELECT * FROM EMPLEADO;
CREATE TABLE EMPLEADO(
rfc_Emp varchar(13), -- LLAVE PRIMARIA
num_Empleado smallint ,  -- CLAVE UNICA 
nombre varchar(50) NOT NULL,  
ap_Paterno varchar(50) NOT NULL,  
ap_Materno varchar(50),
cp int NOT NULL, 
colonia varchar(40) NOT NULL, 
calle varchar(50) NOT NULL, 
numero int NOT NULL, 
id_Estado smallint,
sueldo money NOT NULL, 
foto text NOT NULL,
CONSTRAINT PK_EMP PRIMARY KEY(rfc_Emp),
CONSTRAINT UNIQ_num_Emp UNIQUE(num_Empleado),
CONSTRAINT FK_EMP_CAT FOREIGN KEY(id_Estado) REFERENCES CATALOGO_ESTADOS(id_Estado) ON DELETE CASCADE on update cascade
);

-----CSV CON LOS DATOS INICIALES (SIN INCLUIR FECHA DE NACIMIENTO Y EDAD, ESTOS SE CALCULAN CON LOS UPDATE)-----------------
COPY EMPLEADO FROM 'C:\Users\Public\Datos de tablas\Empleados.txt' USING DELIMITERS ',';

--Para cuando ingresamos registros desde csv, es necesario lo siguiente
ALTER TABLE EMPLEADO ADD fecha_Nac date;--CAMPO CALCULADO
ALTER TABLE EMPLEADO ADD edad smallint;--CAMPO CALCULADO
UPDATE EMPLEADO SET fecha_Nac = CAST(substring (rfc_Emp, 5,6) AS date) WHERE fecha_Nac is NULL;
UPDATE EMPLEADO SET edad = EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM fecha_Nac) WHERE edad is NULL;
SELECT * FROM EMPLEADO;

---------------------------SECUENCIA PARA EL NUMERO DE EMPLEADO------
DROP SEQUENCE cuenta_num_emp;
CREATE SEQUENCE cuenta_num_emp
START WITH 11
INCREMENT BY 1;

---------FUNCION Y TRIGGER QUE CALCULAN LA FECHA DE NACIMIENTO Y LA EDAD------------------------ 
DROP FUNCTION calc_Fecha_Edad CASCADE;
CREATE FUNCTION calc_Fecha_Edad() RETURNS trigger AS $fecha_edad$
BEGIN
 UPDATE EMPLEADO SET fecha_Nac = CAST(substring (rfc_Emp, 5,6) AS date) WHERE fecha_Nac is NULL;
 UPDATE EMPLEADO SET edad = EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM fecha_Nac) WHERE edad is NULL;
  RETURN new;
END;
$fecha_edad$ LANGUAGE plpgsql;

DROP TRIGGER insert_fecha_edad ON EMPLEADO;
CREATE TRIGGER insert_fecha_edad AFTER INSERT ON EMPLEADO
 FOR EACH ROW EXECUTE PROCEDURE calc_Fecha_Edad();

---------------------------INSERCION DE NUEVOS EMPLEADOS--------------
INSERT INTO EMPLEADO VALUES('SOGA031128',NEXTVAL('cuenta_num_emp'),'Andrea','Sosa','Gómez',03650,'Letran Valle','Matías Romero',2016,9,4500,'C:/Users/Miguel Galán/Desktop/FI_UNAM/Semestre_6.2022-2/Bases de Datos/Tareas/Proyecto/Empleados/AndreaSG.bmp',NULL,NULL);
INSERT INTO EMPLEADO VALUES('AIRD940610',NEXTVAL('cuenta_num_emp'),'Daniel','Avila','Rivera',03241,'Roma','Londres',2456,9,8000,'C:/Users/Miguel Galán/Desktop/FI_UNAM/Semestre_6.2022-2/Bases de Datos/Tareas/Proyecto/Empleados/DanielAR.bmp',NULL,NULL);
INSERT INTO EMPLEADO VALUES('ROMJ940404',NEXTVAL('cuenta_num_emp'),'Julian','Rosas','Monroy',01381,'Juárez','León Calvallo',4590,9,8000,'C:/Users/Miguel Galán/Desktop/FI_UNAM/Semestre_6.2022-2/Bases de Datos/Tareas/Proyecto/Empleados/JulianRM.bmp',NULL,NULL);

------------------------------------CATALOGO DE ESTADOS------------------------------
DROP TABLE CATALOGO_ESTADOS CASCADE;
CREATE TABLE CATALOGO_ESTADOS(
id_Estado smallint,
nombre_Estado varchar(30) NOT NULL,
CONSTRAINT PK_CAT_EST PRIMARY KEY(id_Estado)
);
SELECT * FROM CATALOGO_ESTADOS;
COPY CATALOGO_ESTADOS FROM 'C:\Users\Public\Datos de tablas\catalogoEstados.txt' USING DELIMITERS ',';

-----------------------------------TABLA TELEFONO--------------------------
DROP TABLE TELEFONO CASCADE;
CREATE TABLE TELEFONO(
telefono bigint,
rfc_Emp varchar(13), 
CONSTRAINT PK_TEL PRIMARY KEY(telefono),
CONSTRAINT FK_TEL_EMP FOREIGN KEY(rfc_Emp) REFERENCES EMPLEADO(rfc_Emp) ON DELETE CASCADE on update cascade
);
COPY TELEFONO FROM 'C:\Users\Public\Datos de tablas\telefonosEmpleados.txt' USING DELIMITERS ',';
INSERT INTO TELEFONO VALUES(5517699856,'SOGA031128');
INSERT INTO TELEFONO VALUES(5531050789,'AIRD940610');
INSERT INTO TELEFONO VALUES(5544332211,'ROMJ940404');
SELECT * FROM TELEFONO;

------TABLA MESERO----------
DROP TABLE MESERO CASCADE;
CREATE TABLE MESERO(
rfc_Emp varchar(13),
horario_Dia varchar (5) NOT NULL,                    
horario_Hora varchar (5) NOT NULL,                    
CONSTRAINT PK_MES PRIMARY KEY(rfc_Emp),
CONSTRAINT FK_MES_EMP FOREIGN KEY(rfc_Emp) REFERENCES EMPLEADO(rfc_Emp) ON DELETE CASCADE on update cascade
);
COPY MESERO FROM 'C:\Users\Public\Datos de tablas\meseros.txt' USING DELIMITERS ',';
SELECT * FROM MESERO;

--Estructura para crear con INSERT
INSERT INTO MESERO('rfc','DIAS','HORAS');--INDICA QUE HAY QUE PONER EN EL INSERT

-------TABLA COCINERO  Y CATALOGO DE ESPECIALIDAD---------
DROP TABLE ESPECIALIDAD_COCINERO CASCADE;
CREATE TABLE ESPECIALIDAD_COCINERO(
id_Especialidad smallint,
Especialidad varchar(50),
CONSTRAINT PK_ESP_COC PRIMARY KEY(id_Especialidad)
);
COPY ESPECIALIDAD_COCINERO FROM 'C:\Users\Public\Datos de tablas\catalogoCocineros.txt' USING DELIMITERS ',';
SELECT * FROM ESPECIALIDAD_COCINERO;

DROP TABLE COCINERO CASCADE;
CREATE TABLE COCINERO(
rfc_Emp varchar(13),
id_Especialidad smallint, 
CONSTRAINT PK_COC PRIMARY KEY(rfc_Emp,id_Especialidad),
CONSTRAINT FK_COC_EMP FOREIGN KEY(rfc_Emp) REFERENCES EMPLEADO(rfc_Emp) ON DELETE CASCADE on update cascade,
CONSTRAINT FK_COC_ESP FOREIGN KEY(id_Especialidad) REFERENCES ESPECIALIDAD_COCINERO(id_Especialidad) ON DELETE CASCADE on update cascade
);
COPY COCINERO FROM 'C:\Users\Public\Datos de tablas\Cocineros.txt' USING DELIMITERS ',';
SELECT*FROM COCINERO;

------TABLA ADMINISTRATIVO Y CATALOGO DE ROLES---------
DROP TABLE ROL_ADMIN CASCADE;
CREATE TABLE ROL_ADMIN(
id_Rol smallint,
rol varchar(50),
CONSTRAINT PK_ROL_ADMIN PRIMARY KEY(id_Rol)
);
COPY ROL_ADMIN FROM 'C:\Users\Public\Datos de tablas\RolAdmin.txt' USING DELIMITERS ',';
SELECT*FROM ROL_ADMIN;

DROP TABLE ADMINISTRATIVO CASCADE;
CREATE TABLE ADMINISTRATIVO(
rfc_Emp varchar(13), 
id_Rol smallint,
CONSTRAINT PK_ADM PRIMARY KEY(rfc_Emp,id_Rol),
CONSTRAINT FK_ADM_EMP FOREIGN KEY(rfc_Emp) REFERENCES EMPLEADO(rfc_Emp) ON DELETE CASCADE on update cascade,
CONSTRAINT FK_ADM_ROL FOREIGN KEY(id_Rol) REFERENCES ROL_ADMIN(id_Rol) ON DELETE CASCADE on update cascade
);
COPY ADMINISTRATIVO FROM 'C:\Users\Public\Datos de tablas\Administradores.txt' USING DELIMITERS ',';
SELECT*FROM ADMINISTRATIVO;

---------TABLA DEPENDIENTE--------
DROP TABLE DEPENDIENTE CASCADE;
CREATE TABLE DEPENDIENTE(
curp varchar(18),
rfc_Emp varchar(13), 
nombre varchar(50) NOT NULL, 
ap_Paterno varchar(50) NOT NULL, 
ap_Materno varchar(50), 
parentesco varchar(30) NOT NULL,
CONSTRAINT FK_DEP_EMP FOREIGN KEY(rfc_Emp) REFERENCES EMPLEADO(rfc_Emp) ON DELETE CASCADE on update cascade,
CONSTRAINT PK_DEP PRIMARY KEY(curp) 
);
COPY DEPENDIENTE FROM 'C:\Users\Public\Datos de tablas\Dependientes.txt' USING DELIMITERS ',';
SELECT*FROM DEPENDIENTE;

----------------------------------TABLA CLIENTE------------------------
DROP TABLE CLIENTE CASCADE;
CREATE TABLE CLIENTE(
rfc_Cliente varchar(13), 
nombre varchar(50) NOT NULL, 
ap_Paterno varchar(50) NOT NULL, 
ap_Materno varchar(50), 
fecha_Nac date, -- TIPO CALCULADO
razon_Social varchar(60) NOT NULL,  
email varchar(100) NOT NULL, 
cp int NOT NULL, 
colonia varchar(40) NOT NULL, 
calle varchar(50) NOT NULL, 
numero int NOT NULL, 
id_Estado smallint, -- YA ES UN CATÁLOGO 
CONSTRAINT PK_CLIENTE PRIMARY KEY(rfc_Cliente),
CONSTRAINT FK_CLI_CAT FOREIGN KEY(id_Estado) REFERENCES CATALOGO_ESTADOS(id_Estado) ON DELETE CASCADE on update cascade
);
SELECT*FROM CLIENTE;

---------FUNCION Y TRIGGER QUE CALCULAN LA FECHA DE NACIMIENTO DEL CLIENTE------------------------
DROP FUNCTION calc_Fecha_cliente;
CREATE FUNCTION calc_Fecha_cliente() RETURNS trigger AS $fecha$
BEGIN
 UPDATE CLIENTE SET fecha_Nac = CAST(substring (rfc_Cliente, 5,6) AS date) WHERE fecha_Nac is NULL;
  RETURN new;
END;
$fecha$ LANGUAGE plpgsql;

DROP TRIGGER insert_fecha_cliente ON CLIENTE;
CREATE TRIGGER insert_fecha_cliente AFTER INSERT ON CLIENTE
 FOR EACH ROW EXECUTE PROCEDURE calc_Fecha_cliente();

--A PARTIR DE AQUI YA SE HACE EN LA INTERAZ
------------------------------------INSERTS DE CLIENTES---------------------------
INSERT INTO CLIENTE VALUES('OIGC700830','Carlos Ernesto','Ortíz','García',NULL,'Carlos Ernesto Ortíz García','carlos_6508@yahoo.com',01280,'Arvide','Minas',146,9);
INSERT INTO CLIENTE VALUES('BOCD031020','Daniel','Borboa','Castillo',NULL,'Daniel´s Borboas S.A de C.V','danielito_123@hotmail.com',01670,'Alamos','Xola',144,9);
INSERT INTO CLIENTE VALUES('GAOM010812','Miguel Angel','Galán','Olivares',NULL,'Galane´s S.A de C.V','galan_123@hotmail.com',09840,'Los reyes','Ahuizotl',08,9);

SELECT*FROM CLIENTE;
SELECT*FROM ORDEN;

--ESTO YA VIENE PRECARGADO, NO EN LA INTERFAZ
--------------------TABLA PRODUCTO  Y CATALOGO DE PRODUCTOS-------------------------
DROP TABLE CATEGORIA_PRODUC CASCADE;
CREATE TABLE CATEGORIA_PRODUC(
id_Categoria smallint,
nom_Categoria varchar(50) NOT NULL,
desc_Categoria varchar(150) NOT NULL, 
CONSTRAINT PK_CAT_PRODUC PRIMARY KEY(id_Categoria)
);
INSERT INTO CATEGORIA_PRODUC VALUES(1,'Entradas','Exquisitas entradas para compartir entre amigos y familiares');
INSERT INTO CATEGORIA_PRODUC VALUES(2,'Al pastor','Tacos y gringas');
INSERT INTO CATEGORIA_PRODUC VALUES(3,'Alambres','Carne de cerdo o res sazonada y servida con una porción de queso derretido');
INSERT INTO CATEGORIA_PRODUC VALUES(4,'A la parrilla','Tacos de bistec, rajas, costilla, arrachera y chorizo a la parrilla');
INSERT INTO CATEGORIA_PRODUC VALUES(5,'Sopas','Frijoles charros y sopa de tortilla');
INSERT INTO CATEGORIA_PRODUC VALUES(6,'Bebidas','Refrescos, aguas y jugos');
INSERT INTO CATEGORIA_PRODUC VALUES(7,'Bar','Bebidas alcohólicas');
INSERT INTO CATEGORIA_PRODUC VALUES(8,'Postres','Deliciosos platillos dulces para cerrar con broche de oro');
INSERT INTO CATEGORIA_PRODUC VALUES(9,'Extras','Guarniciones extra de salsa verde o roja, guacamole, chicharrón, etc');
SELECT*FROM CATEGORIA_PRODUC;

--TAMPOCO SE HACE EN LA INTERFAZ, YA VIENE PRECARGADO
DROP TABLE PRODUCTO CASCADE;
CREATE TABLE PRODUCTO(
id_PB int, 
nombre_PB varchar(50) NOT NULL, 
precio money NOT NULL,  -- precio es “el precio unitario del producto”
disponibilidad bool NOT NULL, 
descripcion varchar (150) NOT NULL, 
receta varchar(200) NOT NULL, 
id_Categoria smallint,
es_Platillo bool NOT NULL, 
es_Bebida bool NOT NULL,
CONSTRAINT PK_PROD PRIMARY KEY(id_PB),
CONSTRAINT UNIQ_nom_PB UNIQUE(nombre_PB),
CONSTRAINT FK_PRO_CAT FOREIGN KEY(id_Categoria) REFERENCES CATEGORIA_PRODUC(id_Categoria) ON DELETE CASCADE on update cascade,
CONSTRAINT CK_PLATILLO_BEBIDA CHECK(es_Platillo != es_Bebida)--Verifica que un alimento no pertenezca a ambas categorias
);
SELECT*FROM PRODUCTO;

----------------INSERCIONES DE PRODUCTOS---------------------
--------------Entradas--------------------
INSERT INTO PRODUCTO VALUES(1001,'Chicharrón de queso',76,TRUE,'Chicarrón de queso gouda. Salsa a elegi','80 g de queso gouda tostado al comal',1,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(1002,'Guacamole',63,TRUE,'Guacamole al centro con totopos alrededor','120 g de pulpa de aguacate con cilantro y cebolla',1,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(1003,'Cebollitas normales',63,TRUE,'Cebollitas asadas a la plancha','300 g de cebolla cambray',1,TRUE,FALSE);
------------Al pastor-----------------------
INSERT INTO PRODUCTO VALUES(2001,'Gringa de pastor',111,TRUE,'3 Gringas de carne al pastor en tortillas de harina queso, piña, cebolla y cilantro','2 tortillas de harina, 300 g de pastor, 20 g de queso mezclado con cebolla y cilantro',2,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(2002,'Taco al pastor',15,TRUE,'1 Taco de carne al pastor con piña cebolla y cilantro','22 g de carne al pastor cocinada al trompo, 2 tortillas de maíz de 10 g, piña, cilantro y cebolla, salsa opcional',2,TRUE,FALSE);
------------Alambres-----------------------
INSERT INTO PRODUCTO VALUES(3001,'Alambre de pastor',100,TRUE,'Pastor, cebolla, tocino, chile poblano, picado y gratinado con queso manchego','211 g de pastor, 1/4 cebolla, 20 g tocino, 20 g chile poblano, picar y gratinar con queso manchego',3,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(3002,'Alambre de costilla',120,TRUE,'Costilla, cebolla, tocino, chile poblano, picado y gratinado con queso manchego','211 g de costilla, 1/4 cebolla, 20 g tocino, 20 g chile poblano, picar y gratinar con queso manchego',3,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(3003,'Alambre de bistec',100,TRUE,'Bistec, cebolla, tocino, chile poblano, picado y gratinado con queso manchego','211 g de bistec, 1/4 cebolla, 20 g tocino, 20 g chile poblano, picar y gratinar con queso manchego',3,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(3004,'Alambre vegetariano',90,TRUE,'Alambre de nopales o champiñones a elegir, cebolla, chile poblano, picado y gratinado con queso manchego','211 g de nopales o champiñones, 1/4 cebolla, 20 g chile poblano, picar y gratinar con queso manchego',3,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(3005,'Trinity',130,TRUE,'3 Tacos arabes con alambre de pastor y queso','250 g de pastor, 3 tortillas árabes, 1/4 cebolla, 20 g tocino, 20 g chile poblano, picar, preparar cada taco y gratinar con queso manchego',3,TRUE,FALSE);
------------A la parrilla--------------
INSERT INTO PRODUCTO VALUES(4001,'Taco de bistec',15,TRUE,'1 Taco de bistec','22 g de bistec de res cocinado a la parrilla, 2 tortillas de maíz de 10 g, salsa opcional',4,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(4002,'Taco de rajas con crema',12,TRUE,'1 Taco de rajas con crema','30 g de rajas preparadas con crema, 2 tortillas de maíz de 10 g, salsa opcional',4,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(4003,'Taco de costilla',20,TRUE,'1 Taco de costilla','30 g de costilla de res cocinada a la parrilla, 2 tortillas de maíz de 10 g, salsa opcional',4,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(4004,'Taco de arrachera',30,TRUE,'1 Taco de arrachera','30 g de arrachera cocinada a la parrilla, 2 tortillas de maíz de 10 g, salsa opcional',4,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(4005,'Taco de chorizo',15,TRUE,'1 Taco de chorizo','25 g de chorizo cocinado a la parrilla, 2 tortillas de maíz de 10 g, salsa opcional',4,TRUE,FALSE);
------------Sopas----------------------
INSERT INTO PRODUCTO VALUES(5005,'Frijoles charros',60,TRUE,'Plato de frijoles charros','200 g de frijoles cocinados al estilo de la casa en su jugo, 30 g de chorizo picado, 10 g de salchicha picada, 10 g de chicharrón',5,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(5006,'Sopa de tortilla',60,TRUE,'Plato de sopa de tortilla o azteca','150 g de tortilla dorada en tiras servidas en el caldo de la casa,10 g de aguacate, 5 ml de crema, 5 g de cebolla y 5 g de chicharrón',5,TRUE,FALSE);
-----------Bebidas---------------------
INSERT INTO PRODUCTO VALUES(6006,'Refresco',25,TRUE,'Refrescos: coca-cola, sprite, manzanita, fanta','1 Refresco de envase de vidrio',6,FALSE,TRUE);
INSERT INTO PRODUCTO VALUES(6007,'Aguas de sabor',25,TRUE,'Aguas de sabor: sandía, limon, jamaica, horchata, tamarindo','1 Agua de sabor servida en copa de 1 litro o en envase de unicel',6,FALSE,TRUE);
INSERT INTO PRODUCTO VALUES(6008,'Jugos de fruta natural',25,TRUE,'Jugo de fruta natural: naranja, mandarina, verde, zanahoria','1 Jugo de fruta natural servido en copa de 1 litro o en envase de unicel',6,FALSE,TRUE);
-----------Bar-------------------------
INSERT INTO PRODUCTO VALUES(7001,'Cerveza',40,TRUE,'Cerveza: Corona, Modelo, Indio, Sol, Heineken. Oscuras y claras','Cervezas de 355 ml aprox',7,FALSE,TRUE);
INSERT INTO PRODUCTO VALUES(7002,'Michelada',50,TRUE,'Michelada: Corona, Modelo, Indio, Sol, Heineken. Oscura y clara','Michelada de 400 ml aprox con limón y sal, opcionalmente chile piquín',7,FALSE,TRUE);
-----------Postres---------------------
INSERT INTO PRODUCTO VALUES(8001,'Flan napolitano',30,TRUE,'1 Flan napolitano','Flan preparado a base de huevo, mantequilla y azucar caramelizada',8,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(8002,'Arroz con leche',30,TRUE,'1 Arroz con leche en vaso de plastico','250 ml de arroz preparado con leche, azúcar y canela',8,TRUE,FALSE);

-----------Extras----------------------
INSERT INTO PRODUCTO VALUES(9001,'Extra salsa verde o roja',10,TRUE,'Salsa verde o roja','200 ml de salsa verde o roja',9,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(9002,'Extra de guacamole',20,TRUE,'Guacamole','150 ml de guacamole',9,TRUE,FALSE);
INSERT INTO PRODUCTO VALUES(9003,'Extra de chicharrón',15,TRUE,'Chicharrón','150 g chicharrón',9,TRUE,FALSE);
SELECT * FROM PRODUCTO;

-------------------------------------------TABLA ORDEN-----------------
DROP TABLE ORDEN CASCADE;
CREATE TABLE ORDEN(
folio text, --ORD-001 DONDE 001 es un numero secuencial
fecha date  default now(),
total_Orden money, --TIPO CALCULADO SUMA DE LOS TOTALES POR PRODUCTO es decir suma n total_X_Produc
rfc_Emp varchar(13), 
rfc_Cliente varchar(13),
status BOOLEAN,																								--cambio
CONSTRAINT PK_ORD PRIMARY KEY(folio),
CONSTRAINT FK_ORD_EMP FOREIGN KEY(rfc_Emp) REFERENCES EMPLEADO(rfc_Emp) ON DELETE CASCADE on update cascade,
CONSTRAINT FK_ORD_CLI FOREIGN KEY(rfc_Cliente) REFERENCES CLIENTE(rfc_Cliente) ON DELETE CASCADE on update cascade
);
SELECT*FROM ORDEN;

----SECUENCIA PARA GENERAR EL FOLIO-----
DROP SEQUENCE genera_Folio;--borrar la secuencia si se desea un nuevo comienzo
CREATE SEQUENCE genera_Folio
START WITH 001
INCREMENT BY 1;

------FUNCION QUE GENERA LA ORDEN DE UN CLIENTE-------
DROP FUNCTION cliente_genera_orden;
CREATE FUNCTION cliente_genera_orden(fecha text,rfc_Ingresado text) RETURNS void AS $generaOrden$ -- Cambio fecha
DECLARE
 mesero_Aleatorio varchar(13);
 folio text;
BEGIN
  IF EXISTS (SELECT rfc_Cliente FROM CLIENTE WHERE rfc_Cliente = rfc_Ingresado ) THEN
     mesero_Aleatorio := (SELECT rfc_Emp FROM MESERO order by random()limit 1);
     folio:= (SELECT CONCAT('ORD','-',NEXTVAL('genera_Folio')));
     INSERT INTO ORDEN VALUES(folio,cast(fecha as date),0,mesero_Aleatorio,rfc_Ingresado,True);
     RAISE NOTICE 'Se genero la orden: %', folio;
   ELSE
     RAISE NOTICE 'No se encontro el rfc: %', rfc_Ingresado;
  END IF;
END;
$generaOrden$ LANGUAGE plpgsql;

--ESTO SÍ SE HACE EN LA INTERFAZ
------------------GENERAMOS LA ORDEN DE UN CLIENTE-------
SELECT * FROM CLIENTE;
SELECT * FROM ORDEN;
SELECT * FROM CONTENIDO_ORDEN;

SELECT cliente_genera_orden(CURRENT_DATE,'OIGC700830');
SELECT cliente_genera_orden(CURRENT_DATE,'BOCD031020');
SELECT cliente_genera_orden('2022-05-25','GAOM010812');
SELECT * FROM ORDEN;

-------------------------TABLA CONTENIDO_ORDEN-------------------------
DROP TABLE CONTENIDO_ORDEN CASCADE;
CREATE TABLE CONTENIDO_ORDEN(
folio text, --ORD-1 DONDE 1 es un numero secuencial
id_PB int, 
cantidad_PB smallint NOT NULL, --cantidad por producto
total_X_Produc money, --TIPO CALCULADO (precio del producto unitario (precio) * cantidad que pide (cantidad_PB) )
CONSTRAINT FK_CONTENIDO_ORD FOREIGN KEY(folio) REFERENCES ORDEN(folio) ON DELETE CASCADE on update cascade,
CONSTRAINT FK_CONT_PRODUC FOREIGN KEY(id_PB) REFERENCES PRODUCTO(id_PB) ON DELETE CASCADE on update cascade,
CONSTRAINT PK_CONT_ORD PRIMARY KEY(folio, id_PB)
);
SELECT*FROM CONTENIDO_ORDEN;
SELECT*FROM ORDEN;
---Cada que se agregue un producto a la orden, debe actualizarse los totales (por producto y venta),
---así como validar que el producto este disponible:
DROP FUNCTION agrega_productos;
CREATE FUNCTION agrega_productos(folio_ingresado text, id_producto integer, cantidad integer) RETURNS void AS $agrega$
DECLARE
v_precio_producto money;
v_precio_X_cantidad money;
BEGIN
  IF EXISTS(SELECT folio FROM ORDEN WHERE folio = folio_ingresado) THEN
    RAISE NOTICE 'Sí existe el folio: %', folio_ingresado;
    IF EXISTS(SELECT id_PB FROM PRODUCTO WHERE id_PB = id_producto) THEN
	   RAISE NOTICE 'Sí existe el id de producto: %', id_producto;
	   IF EXISTS(SELECT disponibilidad FROM PRODUCTO WHERE id_PB = id_producto AND disponibilidad = TRUE) THEN
	     RAISE NOTICE 'Sí hay disponibilidad del producto: %', id_producto;
		 IF EXISTS(SELECT id_pb FROM CONTENIDO_ORDEN WHERE id_pb = id_producto AND folio = folio_ingresado)THEN
		 	UPDATE CONTENIDO_ORDEN SET cantidad_pb = cantidad_pb + cantidad WHERE id_pb = id_producto AND folio = folio_ingresado;
			v_precio_producto:=(SELECT precio FROM PRODUCTO WHERE id_PB = id_producto);
		    v_precio_X_cantidad:= v_precio_producto * cantidad;
			UPDATE CONTENIDO_ORDEN SET total_X_produc = total_X_produc + v_precio_X_cantidad WHERE id_pb = id_producto AND folio = folio_ingresado;
			UPDATE ORDEN SET total_orden = v_precio_X_cantidad + total_orden WHERE folio = folio_ingresado;
		   ELSE
		     v_precio_producto:=(SELECT precio FROM PRODUCTO WHERE id_PB = id_producto);
		     v_precio_X_cantidad:= v_precio_producto * cantidad;
		     UPDATE ORDEN SET total_orden = v_precio_X_cantidad + total_orden WHERE folio = folio_ingresado;
		     INSERT INTO CONTENIDO_ORDEN VALUES(folio_ingresado,id_producto,cantidad,v_precio_X_cantidad);
		     RAISE NOTICE 'El total a pagar por el producto es: %', v_precio_X_cantidad;
		 END IF;
	   ELSE
	     RAISE NOTICE 'No hay disponibilidad del producto: %', id_producto;
	   END IF;
	ELSE
	 RAISE NOTICE 'No existe el id de producto: %', id_producto;
	END IF;
  ELSE
   RAISE NOTICE 'No existe el folio: %', folio_ingresado;
  END IF;
END;
$agrega$ LANGUAGE plpgsql;

SELECT * FROM CATALOGO_ESTADOS;
SELECT*FROM EMPLEADO;
SELECT*FROM ORDEN;
SELECT*FROM PRODUCTO where es_bebida = true;
SELECT*FROM CONTENIDO_ORDEN;
SELECT * FROM CLIENTE;

--YO LA CREE
DROP VIEW cliente_orden;
CREATE VIEW cliente_orden AS(
	SELECT ORDEN.folio, CLIENTE.nombre||' '||CLIENTE.ap_paterno||' '||CLIENTE.ap_materno AS cliente, rfc_cliente
	FROM ORDEN INNER JOIN CLIENTE
	USING (rfc_cliente)
	WHERE ORDEN.status = true
);
SELECT * FROM CLIENTE;
SELECT * FROM ORDEN;
SELECT * FROM CONTENIDO_ORDEN;
SELECT * FROM cliente_orden;

--ESTO SE HACE DESDE LA INTERFAZ
--No funciona cuando la orden no existe, cuando el id_pb no existe, no puedes meter un 0
SELECT agrega_productos('ORD-1',3005,1);
SELECT agrega_productos('ORD-1',3004,1);
SELECT agrega_productos('ORD-2',3004,3);
SELECT agrega_productos('ORD-2',3004,1);
SELECT agrega_productos('ORD-3',7002,7);
SELECT agrega_productos('ORD-3',7002,3);
SELECT agrega_productos('ORD-3',7002,3);

---Crear al menos, un índice, del tipo que se prefiera y donde se prefiera.
--Justificar el porqué de la elección en ambos aspectos.
SELECT nombre_pb, precio FROM PRODUCTO;
DROP INDEX ind_tab_produc;
CREATE INDEX ind_tab_produc ON PRODUCTO (id_pb, nombre_pb, precio);

---Dado un número de empleado, mostrar la cantidad de órdenes que ha
--registrado en el día así como el total que se ha pagado por dichas órdenes.
--Si no se trata de un mesero, mostrar un mensaje de error.
DROP FUNCTION cantidad_ordenes_mesero;
CREATE FUNCTION cantidad_ordenes_mesero(numero_emp integer) RETURNS varchar AS $body$
DECLARE
busca_rfc VARCHAR(13);
BEGIN
	IF EXISTS(SELECT num_empleado FROM EMPLEADO WHERE num_empleado = numero_emp) THEN
	  RAISE NOTICE 'Sí existe el numero de empleado: %',numero_emp;
	  busca_rfc :=(SELECT rfc_emp FROM EMPLEADO WHERE num_empleado = numero_emp);
	  IF EXISTS(SELECT rfc_emp FROM MESERO WHERE rfc_emp = busca_rfc) THEN
	     RAISE NOTICE 'El empleado ingresado sí es mesero';
		 RETURN busca_rfc;
	  ELSE
	  	RAISE NOTICE 'El empleado ingresado NO es mesero';
	  END IF;
	ELSE
		RAISE NOTICE 'No existe el numero de empleado: %',numero_emp;
	END IF;
END;
$body$ LANGUAGE plpgsql;

--SE HACE DESDE LA INTERFAZ
SELECT COUNT(folio) AS cantidad_de_ordenes_generadas, SUM(total_orden) FROM ORDEN 
WHERE rfc_emp = cantidad_ordenes_mesero(12) AND fecha = CURRENT_DATE; --EL 07 ES VARIABLE CONFORME AL num_empleado
SELECT * FROM ORDEN ;
select * FROM EMPLEADO;
select * from mesero;

--YA NO SE USA
---vista que muestre los detalles del platillo más vendido
--DROP FUNCTION PRODUCTO_MAS_VENDIDO();
/*CREATE FUNCTION PRODUCTO_MAS_VENDIDO() RETURNS integer AS $body$
DECLARE
i integer:= 1;
j integer:= 1;
iteraciones integer;
id_iteracion integer :=1000;
id_mayor integer:=0;
cantidad integer:=0; --cantidad del producto más vendido, solo se cambia si el id existe y si la suma de la cantidad es mayor a la cantidad previa guardada
limite_inf integer:=1000;
limite_sup integer:=2000;
BEGIN
	FOR j IN 1..9 LOOP
		IF j > 1 THEN
		 limite_inf:=limite_inf + 1000;
		 limite_sup:=limite_sup + 1000;
		END IF;
		iteraciones:=(SELECT COUNT(id_pb) FROM PRODUCTO WHERE id_pb > limite_inf AND id_pb < limite_sup);
		id_iteracion := limite_inf;
		FOR i IN 1..iteraciones LOOP
	     id_iteracion:= id_iteracion + 1;
			IF EXISTS (SELECT id_pb FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion) THEN
				IF ((SELECT SUM(cantidad_pb) FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion) > cantidad) THEN
					cantidad:=(SELECT SUM(cantidad_pb) FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion);
					id_mayor := id_iteracion;
					RAISE NOTICE ' cantidad = %', cantidad;
					RAISE NOTICE ' id_mayor = %', id_mayor;
				END IF;
			END IF;
	    END LOOP;	
	END LOOP;	
	RETURN id_mayor;
END;
$body$ LANGUAGE plpgsql;*/




--yo hice esta
SELECT * FROM PRODUCTO;
DROP FUNCTION platillo_mas_vendido;
CREATE FUNCTION platillo_mas_vendido() RETURNS integer AS $body$
DECLARE
i integer:= 1;
j integer:= 1;
iteraciones integer;
id_iteracion integer :=1000;
id_mayor integer:=0;
cantidad integer:=0; --cantidad del producto más vendido, solo se cambia si el id existe y si la suma de la cantidad es mayor a la cantidad previa guardada
limite_inf integer:=1000;
limite_sup integer:=2000;
BEGIN
	FOR j IN 1..9 LOOP
		IF j > 1 THEN
		 limite_inf:=limite_inf + 1000;
		 limite_sup:=limite_sup + 1000;
		END IF;
		iteraciones:=(SELECT COUNT(id_pb) FROM PRODUCTO WHERE id_pb > limite_inf AND id_pb < limite_sup AND es_platillo = true);
		id_iteracion := limite_inf;
		FOR i IN 1..iteraciones LOOP
	     id_iteracion:= id_iteracion + 1;
			IF EXISTS (SELECT id_pb FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion) THEN
				IF ((SELECT SUM(cantidad_pb) FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion) > cantidad) THEN
					cantidad:=(SELECT SUM(cantidad_pb) FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion);
					id_mayor := id_iteracion;
					RAISE NOTICE ' cantidad = %', cantidad;
					RAISE NOTICE ' id_mayor = %', id_mayor;
				END IF;
			END IF;
	    END LOOP;	
	END LOOP;	
	RETURN id_mayor;
END;
$body$ LANGUAGE plpgsql;

DROP FUNCTION bebida_mas_vendido;
CREATE FUNCTION bebida_mas_vendido() RETURNS integer AS $body$
DECLARE
i integer:= 1;
j integer:= 1;
iteraciones integer;
id_iteracion integer :=1000;
id_mayor integer:=0;
cantidad integer:=0; --cantidad del producto más vendido, solo se cambia si el id existe y si la suma de la cantidad es mayor a la cantidad previa guardada
limite_inf integer:=6006;
limite_sup integer:=6009;
BEGIN
	FOR j IN 1..2 LOOP
		IF j > 1 THEN
		 limite_inf:=limite_inf + 995;
		 limite_sup:=limite_sup + 994;
		END IF;
		iteraciones:=(SELECT COUNT(id_pb) FROM PRODUCTO WHERE id_pb > limite_inf AND id_pb < limite_sup AND es_bebida = true);
		id_iteracion := limite_inf;
		FOR i IN 1..iteraciones LOOP
	     id_iteracion:= id_iteracion + 1;
		 	RAISE NOTICE 'Entra %',id_iteracion;
			IF EXISTS (SELECT id_pb FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion) THEN
			RAISE NOTICE 'Entra %',i;
				IF ((SELECT SUM(cantidad_pb) FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion) > cantidad) THEN
					cantidad:=(SELECT SUM(cantidad_pb) FROM CONTENIDO_ORDEN WHERE id_pb = id_iteracion);
					id_mayor := id_iteracion;
					RAISE NOTICE ' cantidad = %', cantidad;
					RAISE NOTICE ' id_mayor = %', id_mayor;
				END IF;
			END IF;
	    END LOOP;	
	END LOOP;	
	RETURN id_mayor;
END;
$body$ LANGUAGE plpgsql;

DROP VIEW PLATILLO_MAS_VENDIDO;
CREATE VIEW PLATILLO_MAS_VENDIDO AS(
	SELECT id_pb, nombre_pb, precio, descripcion
	FROM PRODUCTO WHERE id_pb = PLATILLO_MAS_VENDIDO() 
);
SELECT * FROM PLATILLO_MAS_VENDIDO;
DROP VIEW BEBIDA_MAS_VENDIDA;
CREATE VIEW BEBIDA_MAS_VENDIDA AS(
	SELECT id_pb, nombre_pb, precio, descripcion
	FROM PRODUCTO WHERE id_pb = BEBIDA_MAS_VENDIDO() 
);
SELECT * FROM BEBIDA_MAS_VENDIDA;
SELECT * FROM PRODUCTO WHERE es_bebida=true;
SELECT * FROM PRODUCTO;
SELECT * FROM CONTENIDO_ORDEN;
---GENERAMOS LA VISTA DEL PRODUCTO MÁS VENDIDO-----------
--tampoco se usa
--DROP VIEW PRODUCTO_MAS_VENDIDO 
--CREATE VIEW PRODUCTO_MAS_VENDIDO AS(
--	SELECT id_pb, nombre_pb, precio, descripcion
--	FROM PRODUCTO WHERE id_pb = PRODUCTO_MAS_VENDIDO() 
--);

--ESTO SE HACE DESDE LA INTERFAZ, YA NO SE USA PRODUCTO_MAS_VENDIDO
SELECT * FROM PRODUCTO_MAS_VENDIDO;
SELECT * FROM PLATILLO_MAS_VENDIDO;
SELECT * FROM BEBIDA_MAS_VENDIDA;
SELECT * FROM CONTENIDO_ORDEN;


--ESTO SE HACE DESDE LA INTERFAZ
--Permitir obtener el nombre de aquellos productos que no estén disponibles----------
SELECT id_pb, nombre_pb FROM PRODUCTO WHERE disponibilidad IS FALSE;


------De manera automática se genere una vista que contenga información necesaria para asemejarse a una factura de una orden-----
DROP VIEW FACTURA;
CREATE VIEW FACTURA AS(
 SELECT 'Taqueria Los Inges' AS local,'Ciudad universitaria, FI-UNAM, CP:04360' AS domicilio_local,'RFC:FING080312AFD' AS RFC, 'CDMX, '||now() AS lug_fecha_emision, rfc_cliente,nombre||' '||ap_paterno||' '||ap_materno AS nombre, razon_social,cp,email AS envio_factura,'Por definir' AS uso_de_cfdi,
 1 AS cantidad,'Consumo de alimentos y bebidas. Orden:'||ORDEN.folio||'. Fecha orden: '||ORDEN.fecha AS descripcion, total_orden AS importe,'01-Efectivo' AS forma_de_pago, 'PUE-pago en una sola exhibición' AS metodo_de_pago, '0 días' AS condicion_de_pago
 FROM CLIENTE INNER JOIN  ORDEN using(rfc_cliente)
);

--ESTO SE HACE DESDE LA INTERFAZ
SELECT * FROM ORDEN;
SELECT * FROM FACTURA WHERE rfc_cliente = 'GAOM010812' AND descripcion LIKE '%ORD-3%';
SELECT * FROM FACTURA WHERE descripcion LIKE '%ORD-3%'
SELECT * FROM FACTURA;
Update ORDEN SET status = true;
------Dada una fecha, o una fecha de inicio y fecha de fin, regresar el total del
------número de ventas y el monto total por las ventas en ese periodo de tiempo.
------Nota: Con producto se hace referencia a los alimentos y bebidas.
---PARA UNA FECHA-----
--select id_pb AS id,PRODUCTO.nombre_pb AS PRODUCTO, sum(total_X_produc) AS TOTAL FROM CONTENIDO_ORDEN INNER JOIN ORDEN using(folio) INNER JOIN PRODUCTO using (id_pb) WHERE ORDEN.fecha = '2022-05-23' GROUP BY id_pb, PRODUCTO.nombre_pb;

--ESTO SE HACE DESDE LA INTERFAZ
---PARA UNA FECHA, LOS PARAMETROS SON IGUALES Y PARA UN INTERVALO DE FECHAS, PUS SON DISTINTOS-----------
select id_pb AS id,PRODUCTO.nombre_pb AS PRODUCTO, sum(total_X_produc) AS TOTAL FROM CONTENIDO_ORDEN INNER JOIN ORDEN using(folio) INNER JOIN PRODUCTO using (id_pb) WHERE ORDEN.fecha BETWEEN '2022-05-23' AND '2022-05-23' GROUP BY id_pb, PRODUCTO.nombre_pb;

select * from cliente;
SELECT*FROM ORDEN;
SELECT*FROM CONTENIDO_ORDEN;
SELECT * FROM EMPLEADO;
SELECT * FROM CATALOGO_ESTADOS;


