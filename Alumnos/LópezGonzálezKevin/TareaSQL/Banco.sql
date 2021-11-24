--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      FI-UNAM
-- Project :      TareaConsultas.DM1
-- Author :       KevinL
--
-- Date Created : Tuesday, November 23, 2021 20:42:21
-- Target DBMS : PostgreSQL 8.0
--

-- 
-- TABLE: CLIENTE 
--

CREATE TABLE CLIENTE(
    nombreCliente  varchar(20)    NOT NULL,
    calle            varchar(15)    NOT NULL,
    ciudad           varchar(20)    NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY (nombreCliente)
)
;



-- 
-- TABLE: CTACLIENTE 
--

CREATE TABLE CTACLIENTE(
    numCta         int8           NOT NULL,
    nombreCliente  varchar(20)    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (numCta, nombreCliente)
)
;



-- 
-- TABLE: CUENTA 
--

CREATE TABLE CUENTA(
    numCta          int8              NOT NULL,
    nombreSucursal  varchar(40)       NOT NULL,
    saldo             numeric(10, 0)    NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (numCta)
)
;



-- 
-- TABLE: PRESTAMO 
--

CREATE TABLE PRESTAMO(
    numPrestamo     int8              NOT NULL,
    nombreSucursal  varchar(40)       NOT NULL,
    importe           numeric(10, 0)    NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (numPrestamo)
)
;



-- 
-- TABLE: PRESTATARIO 
--

CREATE TABLE PRESTATARIO(
    numPrestamo    int8           NOT NULL,
    nombreCliente  varchar(20)    NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY (numPrestamo, nombreCliente)
)
;



-- 
-- TABLE: SUCURSAL 
--

CREATE TABLE SUCURSAL(
    nombreSucursal  varchar(40)       NOT NULL,
    activos           numeric(18, 0)    NOT NULL,
    ciudad            varchar(40)       NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY (nombreSucursal)
)
;



-- 
-- TABLE: CTACLIENTE 
--

ALTER TABLE CTACLIENTE ADD CONSTRAINT RefCUENTA61 
    FOREIGN KEY (numCta)
    REFERENCES CUENTA(numCta) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE CTACLIENTE ADD CONSTRAINT RefCLIENTE71 
    FOREIGN KEY (nombreCliente)
    REFERENCES CLIENTE(nombreCliente) ON DELETE RESTRICT ON UPDATE RESTRICT
;


-- 
-- TABLE: CUENTA 
--

ALTER TABLE CUENTA ADD CONSTRAINT RefSUCURSAL111 
    FOREIGN KEY (nombreSucursal)
    REFERENCES SUCURSAL(nombreSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT
;


-- 
-- TABLE: PRESTAMO 
--

ALTER TABLE PRESTAMO ADD CONSTRAINT RefSUCURSAL171 
    FOREIGN KEY (nombreSucursal)
    REFERENCES SUCURSAL(nombreSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT
;


-- 
-- TABLE: PRESTATARIO 
--

ALTER TABLE PRESTATARIO ADD CONSTRAINT RefPRESTAMO81 
    FOREIGN KEY (numPrestamo)
    REFERENCES PRESTAMO(numPrestamo) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE PRESTATARIO ADD CONSTRAINT RefCLIENTE91 
    FOREIGN KEY (nombreCliente)
    REFERENCES CLIENTE(nombreCliente) ON DELETE RESTRICT ON UPDATE RESTRICT
;


