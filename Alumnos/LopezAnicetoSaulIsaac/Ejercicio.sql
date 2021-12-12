--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      FI-UNAM
-- Project :      Prestamos.DM1
-- Author :       IsaacLopez117
--
-- Date Created : Tuesday, November 23, 2021 20:44:06
-- Target DBMS : IBM DB2 UDB 8.x
--

-- 
-- TABLE: Cliente 
--

CREATE TABLE Cliente(
    nombreCliente    CHAR(30)    NOT NULL,
    calle            CHAR(15)    NOT NULL,
    ciudad           CHAR(15)    NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY (nombreCliente)
);



-- 
-- TABLE: CtaCliente 
--

CREATE TABLE CtaCliente(
    numCta           INTEGER     NOT NULL,
    nombreCliente    CHAR(30)    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (numCta, nombreCliente)
);



-- 
-- TABLE: Cuenta 
--

CREATE TABLE Cuenta(
    numCta            INTEGER           NOT NULL,
    nombreSucursal    CHAR(15)          NOT NULL,
    saldo             DECIMAL(18, 0)    NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (numCta)
);



-- 
-- TABLE: Prestamo 
--

CREATE TABLE Prestamo(
    numPrestamo       INTEGER           NOT NULL,
    importe           DECIMAL(18, 0)    NOT NULL,
    nombreSucursal    CHAR(15)          NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (numPrestamo)
);



-- 
-- TABLE: Prestatario 
--

CREATE TABLE Prestatario(
    numPrestamo      INTEGER     NOT NULL,
    nombreCliente    CHAR(30)    NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY (numPrestamo, nombreCliente)
);



-- 
-- TABLE: Sucursal 
--

CREATE TABLE Sucursal(
    nombreSucursal    CHAR(15)          NOT NULL,
    ciudad            CHAR(15)          NOT NULL,
    activos           DECIMAL(18, 0)    NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY (nombreSucursal)
);



-- 
-- TABLE: CtaCliente 
--

ALTER TABLE CtaCliente ADD CONSTRAINT RefCuenta19 
    FOREIGN KEY (numCta)
    REFERENCES Cuenta(numCta);

ALTER TABLE CtaCliente ADD CONSTRAINT RefCliente20 
    FOREIGN KEY (nombreCliente)
    REFERENCES Cliente(nombreCliente);


-- 
-- TABLE: Cuenta 
--

ALTER TABLE Cuenta ADD CONSTRAINT RefSucursal31 
    FOREIGN KEY (nombreSucursal)
    REFERENCES Sucursal(nombreSucursal);


-- 
-- TABLE: Prestamo 
--

ALTER TABLE Prestamo ADD CONSTRAINT RefSucursal30 
    FOREIGN KEY (nombreSucursal)
    REFERENCES Sucursal(nombreSucursal);


-- 
-- TABLE: Prestatario 
--

ALTER TABLE Prestatario ADD CONSTRAINT RefPrestamo27 
    FOREIGN KEY (numPrestamo)
    REFERENCES Prestamo(numPrestamo);

ALTER TABLE Prestatario ADD CONSTRAINT RefCliente29 
    FOREIGN KEY (nombreCliente)
    REFERENCES Cliente(nombreCliente);


INSERT INTO Sucursal Values
('Copilco','CDMX',10000.00),
('Chivas','Guadalajara',8000.00),
('Momia','Guanajuato',10000.00),
('Mariposa','Morelia',2500.00),
('Regio','Monterrey',5000.00),
('Volador','Xalapa',6000.00);


INSERT INTO Cuenta Values
(123,'Chivas',1000.00),
(456,'Copilco',5000.00),
(789,'Mariposa',1000.00),
(147,'Momia',4050.00),
(258,'Regio',7800.00),
(369,'Copilco',4056.00),
(753,'Regio',1705.00),
(951,'Volador',3540.00),
(971,'Chivas',1040.00);


INSERT INTO Prestamo Values
(1234,5100,'Chivas'),
(5678,2000,'Copilco'),
(9123,8000,'Momia'),
(1397,2500,'Chivas'),
(4268,500,'Regio'),
(7539,6000,'Copilco'),
(9517,1000,'Mariposa'),
(5045,3000,'Regio'),
(7930,4000,'Volador');


INSERT INTO Cliente Values
('Isaac Lopez','Cancun','CDMX'),
('Josue Yamauchi','Gabriel Hz','CDMX'),
('Andy Leonhart','Gigantes','Guadalajara'),
('Francisco Regino','Zona','Monterrey'),
('Kevin Peña','Paricutin','Monterrey'),
('Armando Lopez','Aldama','Guadalajara'),
('Ricardo Ponce','Norte','Xalapa'),
('Samuel Lopez','Yobain','CDMX'),
('Hugo Rosas','del Cedro','Morelia'),
('Antonio Perez','las Palmas','Guanajuato');


INSERT INTO Prestatario Values
(1234,'Andy Leonhart'),
(5678,'Isaac Lopez'),
(9123,'Antonio Perez'),
(1397,'Armando Lopez'),
(4268,'Francisco Regino'),
(7539,'Josue Yamauchi'),
(9517,'Hugo Rosas'),
(5045,'Kevin Peña'),
(7930,'Ricardo Ponce');


INSERT INTO CtaCliente Values
(123,'Andy Leonhart'),
(456,'Isaac Lopez'),
(147,'Antonio Perez'),
(971,'Armando Lopez'),
(258,'Francisco Regino'),
(369,'Josue Yamauchi'),
(789,'Hugo Rosas'),
(753,'Kevin Peña'),
(951,'Ricardo Ponce');