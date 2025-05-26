-- Tabla SUCURSAL
CREATE TABLE SUCURSAL (
    idSucursal SERIAL PRIMARY KEY,
    calleS VARCHAR(100) NOT NULL,
    cpS CHAR(5) NOT NULL,
    numS VARCHAR(10) NOT NULL,
    cdS VARCHAR(100) NOT NULL,
    coloniaS VARCHAR(100) NOT NULL,
    telefonoSuc VARCHAR(20) NOT NULL,
    anioFundacionS INTEGER NOT NULL,
    CONSTRAINT chk_anio_fundacion CHECK (anioFundacionS > 0)
);

--Tabla Supervisor
CREATE TABLE SUPERVISOR (
    idSupervisor INTEGER PRIMARY KEY,
    nombreS VARCHAR(100) NOT NULL,
    apPaS VARCHAR(100) NOT NULL,
    apMaS VARCHAR(100),
    emailS VARCHAR(100) NOT NULL UNIQUE,
    telefonosS VARCHAR(20) NOT NULL,
    rfcS CHAR(13) NOT NULL UNIQUE,
    curpS CHAR(18) NOT NULL UNIQUE,
    fechaAsignacion DATE NOT NULL,
    observaciones TEXT,
    idSucursal INTEGER NOT NULL REFERENCES SUCURSAL(idSucursal)
);

-- Tabla EMPLEADO
CREATE TABLE EMPLEADO (
    numEmpleado SERIAL PRIMARY KEY,
    nombreE VARCHAR(100) NOT NULL,
    apPaE VARCHAR(100) NOT NULL,
    apMaE VARCHAR(100),
    emailE VARCHAR(100) NOT NULL UNIQUE,
    telefonosE VARCHAR(20) NOT NULL,	
    rfcE CHAR(13) NOT NULL UNIQUE,
    curpE CHAR(18) NOT NULL UNIQUE,
    tipoEmp VARCHAR(30) NOT NULL CHECK (tipoEmp IN ('cajero', 'vendedor', 'administrador', 'seguridad', 'limpieza')),
    fechIng DATE NOT NULL,
    calleE VARCHAR(100) NOT NULL,
    cpE CHAR(5) NOT NULL,
    numE VARCHAR(10) NOT NULL,
    cdE VARCHAR(100) NOT NULL,
    coloniaE VARCHAR(100) NOT NULL,
    idSucursal INTEGER NOT NULL REFERENCES SUCURSAL(idSucursal),
	idSupervisor INTEGER REFERENCES SUPERVISOR(idSupervisor)
);


-- Tabla CLIENTE
CREATE TABLE CLIENTE (
    rfcCliente CHAR(13) PRIMARY KEY,
    nomCli VARCHAR(100) NOT NULL,
    apPaCli VARCHAR(100) NOT NULL,
    apMaCli VARCHAR(100),
    razonSocialCli VARCHAR(100) DEFAULT 'nombre completo',
    telefonoCli VARCHAR(20) NOT NULL,
    emailCli VARCHAR(100) NOT NULL UNIQUE,
    cpC CHAR(5) NOT NULL,
    calleC VARCHAR(100) NOT NULL,
    cdC VARCHAR(100) NOT NULL,
    coloniaC VARCHAR(100) NOT NULL,
	numC SERIAL UNIQUE
    );

-- Tabla CATEGORIA
CREATE TABLE CATEGORIA (
    idCategoria SERIAL PRIMARY KEY,
    nombreCatego VARCHAR(50) NOT NULL CHECK (char_length(nombreCatego) > 0)
);

-- Tabla ARTICULO
CREATE TABLE ARTICULO (
    codigoBarras VARCHAR(50) PRIMARY KEY,
    precioCompra NUMERIC(10,2) NOT NULL CHECK (precioCompra >= 0),
    nombreArt VARCHAR(100) NOT NULL,
    fotografiaArt BYTEA,
    precioVenta NUMERIC(10,2) NOT NULL CHECK (precioVenta >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    idCategoria INTEGER NOT NULL REFERENCES CATEGORIA(idCategoria)
);

-- Tabla PROVEEDOR
CREATE TABLE PROVEEDOR (
    rfc CHAR(13) PRIMARY KEY,
    razonSocial VARCHAR(100) NOT NULL,
    telefonoProv VARCHAR(20) NOT NULL,
    nombreProv VARCHAR(100) NOT NULL,
    cuentaPagoProv VARCHAR(50) NOT NULL,
    cp CHAR(5) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    cd VARCHAR(100) NOT NULL,
    num VARCHAR(10) NOT NULL,
    colonia VARCHAR(100) NOT NULL
);

-- Tabla PROVEEDOR_ARTICULO
CREATE TABLE PROVEEDOR_ARTICULO (
    historialProv DATE NOT NULL,
    rfc CHAR(13) NOT NULL REFERENCES PROVEEDOR(rfc) ON DELETE CASCADE,
    codigoBarras VARCHAR(50) NOT NULL REFERENCES ARTICULO(codigoBarras) ON DELETE CASCADE,
    PRIMARY KEY (rfc, codigoBarras)
);

CREATE TABLE VENTA (
    folio SERIAL PRIMARY KEY,
    fechaVent DATE NOT NULL,
    cantidadTotalArt INTEGER NOT NULL CHECK (cantidadTotalArt >= 0),
    montoTotal NUMERIC(10,2) NOT NULL CHECK (montoTotal >= 0),
    numEmpleadoVendedor INTEGER NOT NULL REFERENCES EMPLEADO(numEmpleado),
    numEmpleadoCajero INTEGER NOT NULL REFERENCES EMPLEADO(numEmpleado),
    CONSTRAINT chk_dos_empleados CHECK (numEmpleadoVendedor <> numEmpleadoCajero)
);


-- Tabla VENTA_DETALLE (VENTA_ARTICULO)
CREATE TABLE VENTA_DETALLE (
    montoPorArt NUMERIC(10,2) NOT NULL CHECK (montoPorArt >= 0),
    cantidadPorArt INTEGER NOT NULL CHECK (cantidadPorArt > 0),
    folio INTEGER NOT NULL REFERENCES VENTA(folio),
    codigoBarras VARCHAR(50) NOT NULL REFERENCES ARTICULO(codigoBarras),
    PRIMARY KEY (folio, codigoBarras)
);


-- Tabla FACTURA
CREATE TABLE FACTURA (
    folioFac INTEGER PRIMARY KEY,
    fechFac DATE NOT NULL,
    montoFac NUMERIC(10,2) NOT NULL,
    formaPago VARCHAR(30) NOT NULL,
    folio INTEGER NOT NULL REFERENCES VENTA(folio),
    rfcCliente CHAR(13) REFERENCES CLIENTE(rfcCliente)
);


-- Tabla PROGRAMALEALTAD
CREATE TABLE PROGRAMALEALTAD (
    idProgramaL SERIAL PRIMARY KEY,
    nomPrograma VARCHAR(50) NOT NULL,
    beneficios TEXT,
    descuento NUMERIC(5,2) CHECK (descuento >= 0 AND descuento <= 100),
    puntos INTEGER CHECK (puntos >= 0)
);



-------CONSULSTAS----------
-------CONSULSTAS----------
-------CONSULSTAS----------
-------CONSULSTAS----------
-------CONSULSTAS----------


----CLIENTE

SELECT * FROM cliente;
TRUNCATE TABLE cliente RESTART IDENTITY CASCADE;

----supervisores

SELECT * FROM supervisor;
TRUNCATE TABLE supervisor RESTART IDENTITY CASCADE;

----EMPLEADO

SELECT * FROM empleado;
TRUNCATE TABLE empleado RESTART IDENTITY CASCADE;

----sucursal

SELECT * FROM sucursal;
TRUNCATE TABLE sucursal RESTART IDENTITY CASCADE;


--VENTAS
SELECT * FROM venta;
TRUNCATE TABLE venta RESTART IDENTITY CASCADE;

--facturas

SELECT * FROM factura;
TRUNCATE TABLE factura RESTART IDENTITY CASCADE;

--categoria

SELECT * FROM categoria;
TRUNCATE TABLE categoria RESTART IDENTITY CASCADE;

---ARTICULO

SELECT * FROM articulo;
TRUNCATE TABLE articulo RESTART IDENTITY CASCADE;

--venta detalle
SELECT * FROM venta_detalle;
TRUNCATE TABLE venta_detalle RESTART IDENTITY CASCADE;

--PROVEEDOR

SELECT * FROM proveedor;
TRUNCATE TABLE proveedor RESTART IDENTITY CASCADE;

--PROVEEDOR articulo

SELECT * FROM proveedor_articulo;
TRUNCATE TABLE proveedor_articulo RESTART IDENTITY CASCADE;













--PASO 1:--
--Se meterán los datos del cliente, --
--si ya existe se sobrescribe si no existe se crea un nuevo cliente.--


INSERT INTO CLIENTE (
    rfcCliente, nomCli, apPaCli, apMaCli, razonSocialCli,
    telefonoCli, emailCli, cpC, calleC, cdC, coloniaC
) VALUES (
    'MOOA940615HXX',
    'Amelia',
    'Montanez',
    'Orellana',
    'Amelia Montanez Orellana',
    '7089597717',
    'patriciavarela@gmail.com',
    '49789',
    'Calzada Norte Figueroa',
    'San Asuncion de la Montana',
    'los altos'
)
ON CONFLICT (rfcCliente) DO UPDATE
SET nomCli = EXCLUDED.nomCli,
    apPaCli = EXCLUDED.apPaCli,
    apMaCli = EXCLUDED.apMaCli,
    razonSocialCli = EXCLUDED.razonSocialCli,
    telefonoCli = EXCLUDED.telefonoCli,
    emailCli = EXCLUDED.emailCli,
    cpC = EXCLUDED.cpC,
    calleC = EXCLUDED.calleC,
    cdC = EXCLUDED.cdC,
    coloniaC = EXCLUDED.coloniaC,
    numC = EXCLUDED.numC;


--PASO 2:--
--Se agrega los datos de la venta como fecha, cantidad total de artículos, monto total--
--y el numero de empleado tanto del vendedor como del cajero validando que no sean el mismo.--


INSERT INTO VENTA (
    fechaVent,
    cantidadTotalArt,
    montoTotal,
    numEmpleadoVendedor,
    numEmpleadoCajero
) VALUES (
    '2026-08-11',  -- Formato ISO para la fecha
    13,
    26702,
    13,
    12
);


--PASO 3:--
--Se meten los datos para el detalle de la venta, en esta sección encontraremos --
--monto por artículo, cantidad por articulo folio y el código de barras.--

INSERT INTO VENTA_DETALLE (
    montoPorArt, cantidadPorArt, folio, codigoBarras
) VALUES
    (4157.98, 2, 1, '6650300000000'),
    (1652.00, 1, 1, '1428510000000'),
	(5565.00, 3, 1, '9344220000000'),
	(3539.97, 3, 1, '2076980000000'),
	(9881.97, 3, 1, '7751590000000'),
	(1611.99, 1, 1, '9894720000000');



--PASO 4:
--La generación de la factura se agregará la fecha, monto de la factura, la ---
--forma de pago, el folio de la venta y el RFC del cliente. ---


INSERT INTO FACTURA (
    folioFac, fechFac, montoFac, formaPago, folio, rfcCliente
) VALUES (
    1, 
	'2023-08-11', 
	26702.00, 
	'efectivo', 
	1, 
	'MOOA940615HXX'
);












---OBJETIVO 1---
--Cada que se agregue un artículo a una venta, debe actualizarse los totales 
----(por artículo, venta y cantidad de artículos), así como validar que el articulo esté disponible.

-- Función
CREATE OR REPLACE FUNCTION actualizar_art()
RETURNS TRIGGER AS $$
DECLARE
    stock_actual INT;
    nuevo_stock INT;
    precio_unitario NUMERIC(10,2);
BEGIN
    -- Obtener el stock actual
    SELECT stock, precioVenta INTO stock_actual, precio_unitario
    FROM ARTICULO
    WHERE codigoBarras = NEW.codigoBarras;

    -- Validar existencia del artículo
    IF stock_actual IS NULL THEN
        RAISE EXCEPTION 'No se encontró el artículo con código de barras %.', NEW.codigoBarras;
    END IF;

    -- Calcular nuevo stock
    nuevo_stock := stock_actual - NEW.cantidadPorArt;

    -- Validar stock suficiente
    IF nuevo_stock < 0 THEN
        RAISE EXCEPTION 'Stock insuficiente para el artículo con código de barras %.', NEW.codigoBarras;
    END IF;

    -- Actualizar el stock
    UPDATE ARTICULO
    SET stock = nuevo_stock
    WHERE codigoBarras = NEW.codigoBarras;

    -- Alerta si el nuevo stock es bajo
    IF nuevo_stock < 3 THEN
        RAISE NOTICE 'Alerta: El stock del artículo % es menor que 3 (stock actual: %).', NEW.codigoBarras, nuevo_stock;
    END IF;

    -- Calcular el monto por artículo
    NEW.montoPorArt := NEW.cantidadPorArt * precio_unitario;

    -- Actualizar el monto total de la venta
    UPDATE VENTA
    SET montoTotal = COALESCE(montoTotal, 0) + NEW.montoPorArt,
        cantidadTotalArt = COALESCE(cantidadTotalArt, 0) + NEW.cantidadPorArt
    WHERE folio = NEW.folio;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_procesar_venta
BEFORE INSERT ON VENTA_DETALLE
FOR EACH ROW
EXECUTE FUNCTION actualizar_art();

---OBJETIVO 1---
--Cada que se agregue un artículo a una venta, debe actualizarse los totales 
----(por artículo, venta y cantidad de artículos), así como validar que el articulo esté disponible.















---OBEJITVO 2:  INDICE-------
---INDICE-------
---INDICE-------
CREATE INDEX idx_venta_fecha ON VENTA (fechaVent);

SELECT * FROM VENTA WHERE fechaVent BETWEEN '2024-01-01' AND '2024-03-31';

SELECT * FROM VENTA ORDER BY fechaVent DESC;

SELECT * FROM VENTA WHERE fechaVent = '2024-04-12';
---INDICE-------
---INDICE-------
---INDICE-------








-----------OBJETIVO 3:  VISTA<3 -----------
-----------VISTA<3 -----------
-----------VISTA<3 -----------
-----------VISTA<3 -----------

CREATE VIEW articulos_no_disponibles AS
SELECT
    codigoBarras,
    nombreArt,
    stock,
    CASE
        WHEN stock = 0 THEN 'No disponible'
        WHEN stock < 3 THEN 'Stock bajo'
        ELSE 'Disponible'
    END AS estado
FROM ARTICULO
WHERE stock < 3;

SELECT * FROM public.articulos_no_disponibles

-----------VISTA<3 -----------
-----------VISTA<3 -----------
UPDATE articulo
SET stock = 0
WHERE codigoBarras = '1510900000000';
-----------VISTA<3 -----------
-----------VISTA<3 -----------











--------vista ticket------------
--------vista ticket----
--------vista ticket------------
CREATE OR REPLACE VIEW ticket AS
SELECT
    'MBL-' || LPAD(CAST(v.folio AS TEXT), 3, '0') AS folio_ticket,
    v.fechaVent,
    e1.nombreE || ' ' || e1.apPaE AS vendedor,
    e2.nombreE || ' ' || e2.apPaE AS cajero,
    v.montoTotal,
    COALESCE(f.formaPago, 'NO FACTURADO') AS forma_pago,
    COALESCE(c.nomCli || ' ' || c.apPaCli, 'PUBLICO GENERAL') AS cliente
FROM VENTA v
JOIN EMPLEADO e1 ON v.numEmpleadoVendedor = e1.numEmpleado
JOIN EMPLEADO e2 ON v.numEmpleadoCajero = e2.numEmpleado
LEFT JOIN FACTURA f ON v.folio = f.folio
LEFT JOIN CLIENTE c ON f.rfcCliente = c.rfcCliente;

SELECT * FROM ticket;

SELECT * 
FROM ticket
WHERE folio_ticket = 'MBL-001';
--------vista ticket------------
--------vista ticket------------
--------vista ticket------------
SELECT *
FROM FACTURA f
LEFT JOIN CLIENTE c ON f.rfcCliente = c.rfcCliente
WHERE f.folio = 1;  -- Usa un folio real de los que estás consultando







DELETE FROM VENTA
WHERE folio = 101;


-----TRIGGER VALIDAR EMPLEADO------
-----TRIGGER VALIDAR EMPLEADO------
-----TRIGGER VALIDAR EMPLEADO------

CREATE OR REPLACE FUNCTION validar_empleados_misma_sucursal()
RETURNS TRIGGER AS $$
DECLARE
    sucursal_vendedor INTEGER;
    sucursal_cajero INTEGER;
BEGIN
    -- Validar que el vendedor y el cajero no sean la misma persona
    IF NEW.numEmpleadoVendedor = NEW.numEmpleadoCajero THEN
        RAISE EXCEPTION 'El vendedor y el cajero no pueden ser la misma persona.';
    END IF;

    -- Obtener la sucursal del vendedor
    SELECT idSucursal INTO sucursal_vendedor
    FROM EMPLEADO
    WHERE numEmpleado = NEW.numEmpleadoVendedor;

    -- Obtener la sucursal del cajero
    SELECT idSucursal INTO sucursal_cajero
    FROM EMPLEADO
    WHERE numEmpleado = NEW.numEmpleadoCajero;

    -- Verificar existencia de empleados
    IF sucursal_vendedor IS NULL OR sucursal_cajero IS NULL THEN
        RAISE EXCEPTION 'Uno o ambos empleados no existen.';
    END IF;

    -- Verificar que ambos estén en la misma sucursal
    IF sucursal_vendedor <> sucursal_cajero THEN
        RAISE EXCEPTION 'El vendedor y el cajero deben pertenecer a la misma sucursal.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_validar_empleados_sucursal ON VENTA;

CREATE TRIGGER trg_validar_empleados_sucursal
BEFORE INSERT ON VENTA
FOR EACH ROW
EXECUTE FUNCTION validar_empleados_misma_sucursal();




-----TRIGGER VALIDAR EMPLEADO------
-----TRIGGER VALIDAR EMPLEADO------
-----TRIGGER VALIDAR EMPLEADO------












------JERARQUIA--------
------JERARQUIA--------
------JERARQUIA--------
CREATE OR REPLACE FUNCTION obtener_jerarquia(p_nombre_empleado VARCHAR)
RETURNS TABLE (
    nombre_empleado VARCHAR,
    puesto_empleado VARCHAR,
    nombre_supervisor VARCHAR,
    puesto_supervisor VARCHAR,
    sucursal_id VARCHAR,
    direccion_sucursal VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        (e.nombreE || ' ' || e.apPaE || COALESCE(' ' || e.apMaE, ''))::VARCHAR AS nombre_empleado,
        e.tipoEmp::VARCHAR AS puesto_empleado,
        (s.nombreS || ' ' || s.apPaS || COALESCE(' ' || s.apMaS, ''))::VARCHAR AS nombre_supervisor,
        'supervisor'::VARCHAR AS puesto_supervisor,
        su.cdS::VARCHAR AS sucursal_id,
        (su.calleS || ', ' || su.coloniaS || ', ' || su.cdS)::VARCHAR AS direccion_sucursal
    FROM EMPLEADO e
    LEFT JOIN SUPERVISOR s ON e.idSupervisor = s.idSupervisor
    INNER JOIN SUCURSAL su ON e.idSucursal = su.idSucursal
    WHERE e.nombreE = p_nombre_empleado;
END;
$$ LANGUAGE plpgsql;

------JERARQUIA--------
------JERARQUIA--------
------JERARQUIA--------

SELECT * FROM obtener_jerarquia('Camila');

------JERARQUIA--------
------JERARQUIA--------
------JERARQUIA--------



