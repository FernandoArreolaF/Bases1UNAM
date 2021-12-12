CREATE TABLE SUCURSAL
(
    nombre_sucursal VARCHAR(30)  NOT NULL,
    ciudad VARCHAR(15) NOT NULL,
    activos NUMERIC NOT NULL,
    CONSTRAINT SUCURSAL_PK PRIMARY KEY (nombre_sucursal)
);

INSERT INTO SUCURSAL VALUES('copilco','cdmx',5876);
INSERT INTO SUCURSAL VALUES('universidad','cdmx',58324);
INSERT INTO SUCURSAL VALUES('hidalgo','guanajuato',23324);
INSERT INTO SUCURSAL VALUES('cuichapa','veracruz',15324);
INSERT INTO SUCURSAL VALUES('vicente','puebla',90324);
--_________________________________________________________

CREATE TABLE CLIENTE
(
    nombre_cliente VARCHAR(40)  NOT NULL,
    calle VARCHAR(15) NOT NULL,
    ciudad VARCHAR(10) NOT NULL,
    CONSTRAINT CLIENTE_PK PRIMARY KEY (nombre_cliente)
);

INSERT INTO CLIENTE VALUES('Andrea Lopez','calle 1','cdmx');
INSERT INTO CLIENTE VALUES('Emilio Gomez','calle 2','guanajuato');
INSERT INTO CLIENTE VALUES('Juan Fernandez','calle 4','guanajuato');
INSERT INTO CLIENTE VALUES('Fernanda Nunez','calle 6','guanajuato');
INSERT INTO CLIENTE VALUES('Javier Lopez','calle 9','veracruz');
INSERT INTO CLIENTE VALUES('Horacio Castrejon','calle 20','veracruz');
INSERT INTO CLIENTE VALUES('Andres Ramirez','calle 32','puebla');
INSERT INTO CLIENTE VALUES('Karen Flores','calle 0','puebla');
INSERT INTO CLIENTE VALUES('Miriam Flores','calle 43','cdmx');
--_________________________________________________________

CREATE TABLE CUENTA
(
    num_cuenta int  NOT NULL,
    nombre_sucursal VARCHAR(30) NOT NULL,
    saldo NUMERIC NOT NULL,
    CONSTRAINT CUENTA_PK PRIMARY KEY (num_cuenta),
    CONSTRAINT SUCURSALCUENTA_FK FOREIGN KEY (nombre_sucursal) REFERENCES SUCURSAL (nombre_sucursal)
);

INSERT INTO CUENTA VALUES(345678,'cuichapa',12999);
INSERT INTO CUENTA VALUES(345278,'cuichapa',999);
INSERT INTO CUENTA VALUES(235278,'hidalgo',991899);
INSERT INTO CUENTA VALUES(748432,'universidad',12978999);
INSERT INTO CUENTA VALUES(456708,'vicente',99349);
INSERT INTO CUENTA VALUES(108765,'hidalgo',98762);
INSERT INTO CUENTA VALUES(987652,'universidad',567);
INSERT INTO CUENTA VALUES(198768,'vicente',123);
INSERT INTO CUENTA VALUES(987656,'hidalgo',987);
--_________________________________________________________

CREATE TABLE CTACLIENTE
(
    nombre_cliente VARCHAR(40)  NOT NULL,
    num_cuenta int NOT NULL,
    CONSTRAINT CTACLIENTE_PK PRIMARY KEY (nombre_cliente, num_cuenta),
    CONSTRAINT CLIENTE_FK FOREIGN KEY (nombre_cliente) REFERENCES CLIENTE(nombre_cliente),
    CONSTRAINT CUENTA_FK FOREIGN KEY (num_cuenta) REFERENCES CUENTA (num_cuenta)
);


INSERT INTO CTACLIENTE VALUES('Andrea Lopez',345678);
INSERT INTO CTACLIENTE VALUES('Emilio Gomez',345278);
INSERT INTO CTACLIENTE VALUES('Juan Fernandez',235278);
INSERT INTO CTACLIENTE VALUES('Fernanda Nunez',748432);
INSERT INTO CTACLIENTE VALUES('Javier Lopez',456708);
INSERT INTO CTACLIENTE VALUES('Horacio Castrejon',108765);
INSERT INTO CTACLIENTE VALUES('Andres Ramirez',987652);
INSERT INTO CTACLIENTE VALUES('Karen Flores',198768);
INSERT INTO CTACLIENTE VALUES('Miriam Flores',987656);
--_________________________________________________________



CREATE TABLE PRESTAMO
(
    num_prestamo INT NOT NULL,
    nombre_sucursal VARCHAR(30) NOT NULL,
    importe NUMERIC NOT NULL,
    CONSTRAINT PRESTAMO_PK PRIMARY KEY (num_prestamo),
    CONSTRAINT SUCURSALPRESTAMO_FK FOREIGN KEY (nombre_sucursal) REFERENCES SUCURSAL (nombre_sucursal)
);

INSERT INTO PRESTAMO VALUES(1,'copilco',9876);
INSERT INTO PRESTAMO VALUES(2,'universidad',98765);
INSERT INTO PRESTAMO VALUES(3,'hidalgo',65);
INSERT INTO PRESTAMO VALUES(4,'cuichapa',4567);
INSERT INTO PRESTAMO VALUES(5,'copilco',5678);


--_________________________________________________________

CREATE TABLE PRESTATARIO
(
    nombre_cliente VARCHAR(40)  NOT NULL,
    num_prestamo int  NOT NULL,
    CONSTRAINT PRESTATARIO_PK PRIMARY KEY (nombre_cliente,num_prestamo),
    CONSTRAINT CLIENTEPRESTATARIO_FK FOREIGN KEY (nombre_cliente) REFERENCES CLIENTE (nombre_cliente),
    CONSTRAINT PRESTAMOPRESTATARIO_FK FOREIGN KEY (num_prestamo) REFERENCES PRESTAMO (num_prestamo)
);

INSERT INTO PRESTATARIO VALUES('Andrea Lopez',1);
INSERT INTO PRESTATARIO VALUES('Javier Lopez',2);
INSERT INTO PRESTATARIO VALUES('Horacio Castrejon',3);
INSERT INTO PRESTATARIO VALUES('Andres Ramirez',4);
INSERT INTO PRESTATARIO VALUES('Karen Flores',5);
--_________________________________________________________

--Encontrar la información de todos los préstamos realizados en la sucursal “copilco”.
SELECT * FROM PRESTAMO WHERE nombre_sucursal='copilco';

--Determinar el nombre de los clientes que viven en Guanajuato
SELECT nombre_cliente FROM CLIENTE WHERE ciudad='guanajuato';

--Nombre de los clientes del banco que tienen una cuenta, un préstamo o ambas cosas
(SELECT nombre_cliente FROM PRESTATARIO) UNION (SELECT nombre_cliente FROM CTACLIENTE);

--Relación de clientes que tienen abierta una cuenta pero no tienen ninguna de préstamo.
(SELECT nombre_cliente FROM CTACLIENTE) EXCEPT (SELECT nombre_cliente FROM PRESTATARIO);

--Nombre de los clientes con préstamo mayor a 5000 pesos
SELECT nombre_cliente 
FROM PRESTAMO, PRESTATARIO 
WHERE importe>5000 AND PRESTATARIO.num_prestamo=PRESTAMO.num_prestamo;


--_________________________________________________________
DROP TABLE CLIENTE;
DROP TABLE CUENTA;
DROP TABLE PRESTAMO;
DROP TABLE SUCURSAL;
DROP TABLE PRESTATARIO;
DROP TABLE CTACLIENTE;