DROP DATABASE IF EXISTS proyecto_restaurante;
CREATE DATABASE proyecto_restaurante;

CREATE TABLE EMPLEADO(
id_empleado SERIAL NOT NULL,
edad smallint NOT NULL,
sueldo float NOT NULL,
fecha_nacimiento date NOT NULL,
RFC_EMPLEADO varchar(13) NOT NULL,
nombre varchar(60) NOT NULL,
ap_Paterno varchar(60) NOT NULL,
ap_Materno varchar(60) NOT NULL,
calle  varchar(60) NOT NULL,
numero smallint NOT NULL,
colonia varchar(60) NOT NULL,
codigo_Postal int NOT NULL,
estado varchar(60) NOT NULL,
CONSTRAINT empleado_PK PRIMARY KEY(id_empleado));
 
CREATE TABLE COCINERO(
id_empleado SERIAL NOT NULL,
especialidad varchar(60) NOT NULL,
CONSTRAINT cocinero_PK PRIMARY KEY(id_empleado),
CONSTRAINT cocinero_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES empleado(id_empleado));
 
CREATE TABLE ADMINISTRATIVO(
id_empleado SERIAL NOT NULL,
rol varchar(25) NOT NULL,
CONSTRAINT administrativo_PK PRIMARY KEY(id_empleado),
CONSTRAINT administrativo_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES empleado(id_empleado));
 
CREATE TABLE MESERO(
id_empleado SERIAL NOT NULL,
horario date NOT NULL,
CONSTRAINT mesero_PK PRIMARY KEY(id_empleado),
CONSTRAINT mesero_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES empleado(id_empleado));
 
CREATE TABLE CLIENTE(
RFC_CLIENTE varchar(13) NOT NULL,
nombre varchar(60) NOT NULL,
ap_Paterno varchar(60) NOT NULL,
ap_Materno varchar(60) NOT NULL,
razon_social varchar(100) NOT NULL,
email varchar(100) NOT NULL,
fecha_nacimiento date NOT NULL,
calle  varchar(60) ,
numero smallint,
colonia  varchar(60),
codigo_Postal int,
estado varchar(60),
CONSTRAINT cliente_PK PRIMARY KEY(RFC_CLIENTE));
 
CREATE TABLE ORDEN(
folio SERIAL NOT NULL,
fecha date DEFAULT now() NOT NULL, --now()
total_Pago float NOT NULL,
cantidad_Alimentos int NOT NULL,
precio_unitario_Alimento float NOT NULL,
RFC_CLIENTE varchar(13) ,
id_empleado SERIAL NOT NULL,
CONSTRAINT orden_PK PRIMARY KEY(folio),
CONSTRAINT orden_cliente_FK FOREIGN KEY(RFC_CLIENTE)
REFERENCES CLIENTE(RFC_CLIENTE));
 
CREATE TABLE DEPENDIENTE(
CURP varchar(18) NOT NULL,
nombre varchar(60) NOT NULL,
ap_Paterno varchar(60) NOT NULL,
ap_Materno varchar(60) NOT NULL,
parentesco varchar(25),
id_empleado SERIAL NOT NULL,
CONSTRAINT dependiente_PK PRIMARY KEY(CURP),
CONSTRAINT dependiente_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES EMPLEADO(id_empleado));
 
CREATE TABLE MENU_CATEGORIA(
id_identificador SERIAL NOT NULL,
precio float NOT NULL,
receta varchar(100) NOT NULL,
nombre_alimento varchar(60) NOT NULL,
disponibilidad boolean NOT NULL,
nombre_categoria varchar(60) NOT NULL,
descripcion  varchar(60) NOT NULL,
desc_Categoria varchar(60) NOT NULL,
tipo_categoria varchar(20) null,
nivel_de_dificultad smallint null,
sin_alcohol boolean null,
con_alcohol boolean null,
CONSTRAINT menu_PK PRIMARY KEY(id_identificador));
 
CREATE TABLE telefono(
No_telefono int,
id_empleado SERIAL,
CONSTRAINT telefono_PK PRIMARY KEY(No_telefono),
CONSTRAINT telefono_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES EMPLEADO(id_empleado));
 
CREATE TABLE contiene(
folio int NOT NULL,
id_identificador smallint NOT NULL,
CONSTRAINT contiene_menu_orden_PK PRIMARY KEY(folio,id_identificador),
CONSTRAINT contiene_menu_FK FOREIGN KEY(id_identificador)
REFERENCES MENU_CATEGORIA(id_identificador),
CONSTRAINT contiene_orden_FK FOREIGN KEY(folio)
REFERENCES ORDEN(folio));

ALTER TABLE DEPENDIENTE DROP CONSTRAINT dependiente_empleado_FK;
ALTER TABLE DEPENDIENTE ADD CONSTRAINT
dependiente_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES EMPLEADO(id_empleado) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ORDEN ADD CONSTRAINT
EMPLEADO_ORDEN_FK FOREIGN KEY(id_empleado)
REFERENCES EMPLEADO(id_empleado) ON DELETE RESTRICT ON UPDATE CASCADE;



ALTER TABLE ORDEN DROP CONSTRAINT orden_cliente_FK;

ALTER TABLE ORDEN ADD CONSTRAINT
 orden_cliente_FK FOREIGN KEY(RFC_CLIENTE)
REFERENCES CLIENTE(RFC_CLIENTE) ON DELETE RESTRICT ON UPDATE CASCADE;


ALTER TABLE COCINERO DROP CONSTRAINT cocinero_empleado_FK;
 
ALTER TABLE COCINERO ADD CONSTRAINT cocinero_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES empleado(id_empleado) ON DELETE SET NULL ON UPDATE CASCADE;
 
ALTER TABLE ADMINISTRATIVO DROP CONSTRAINT administrativo_empleado_FK;


ALTER TABLE ADMINISTRATIVO ADD CONSTRAINT
administrativo_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES empleado(id_empleado) ON DELETE SET NULL ON UPDATE CASCADE;


ALTER TABLE MESERO DROP CONSTRAINT mesero_empleado_FK;
ALTER TABLE MESERO ADD CONSTRAINT
mesero_empleado_FK FOREIGN KEY(id_empleado)
REFERENCES empleado(id_empleado) ON DELETE SET NULL ON UPDATE CASCADE;


CREATE INDEX I_RECETA_MENU_CATEGORIA ON MENU_CATEGORIA(RECETA);