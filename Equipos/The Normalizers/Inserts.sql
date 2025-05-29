 --1. Categorías

INSERT INTO categoria (categoria_id, nombre) VALUES
(1, 'Sillas'),
(2, 'Mesas'),
(3, 'Camas');

--2. Teléfonos

INSERT INTO telefono (telefono_id, telefono) VALUES
(1, '5512345678'),
(2, '5598765432'),
(3, '557393726');

--3. Sucursales

INSERT INTO sucursal (sucursal_id, ubicacion, telefono, año_fundacion) VALUES
(1, 'CDMX - Centro', '5555123456', '2001'),
(2, 'Guadalajara - Norte', '3333123456', '2005');

--4. Empleados

INSERT INTO empleado (
    empleado_id, supervisor_id, sucursal_id, telefono_id, num_empleado,
    rfc, curp, nombre, ap_paterno, ap_materno,
    calle, numero, cp, colonia, estado, email,
    fecha_ingreso, tipo_empleado
) VALUES
(101, 104, 1, 1, 'E001', 'RFC101', 'CURP101', 'Luis', 'Ramírez', 'Gómez',
 'Av. Reforma', '100', '06000', 'Centro', 'CDMX', 'luis.ramirez@example.com',
 '2020-01-10', 'vendedor'),

(102, 101, 1, 2, 'E002', 'RFC102', 'CURP102', 'Ana', 'López', 'Hernández',
 'Av. Juárez', '200', '06010', 'Centro', 'CDMX', 'ana.lopez@example.com',
 '2021-05-01', 'cajero'),

 (104, 104, 1, 2, 'E004', 'RFC104', 'CURP104', 'Antonio', 'López', 'Gutierrez',
 'Av. Juárez', '200', '06010', 'Centro', 'CDMX', 'antonio.lopez@example.com',
 '2021-05-01', 'cajero'),

(103, 101, 2, 3, 'E003', 'RFC103', 'CURP103', 'Angel', 'Pérez', 'López',
'Av. Reforma', '100', '06000', 'Centro', 'CDMX', 'Angel.Perz@example.com',
'2020-01-10', 'vendedor');
 
--5. Clientes

INSERT INTO cliente (
    cliente_id, rfc, nombre, ap_paterno, ap_materno, razon_social,
    calle, numero, cp, colonia, estado, email, telefono
) VALUES
(201, 'CLIRFC01', 'Carlos', 'Pérez', 'Hernández', 'Carlos Pérez',
 'Av. Insurgentes', '300', '03100', 'Del Valle', 'CDMX', 'carlos.perez@example.com', '5588997766');

--Ejemplo razón social por defecto;
INSERT INTO cliente (
    cliente_id, rfc, nombre, ap_paterno, ap_materno,
    calle, numero, cp, colonia, estado, email, telefono
) VALUES (
    900, 'RFC900', 'Ana', 'García', 'López',
    'Calle 8', '500', '66000', 'Norte', 'Chiapas', 'ana.garcia@example.com', '9610000000'
);

--6. Proveedores

INSERT INTO proveedor (
    proveedor_id, rfc, razon_social, calle, numero, cp, colonia, estado, telefono, num_cuenta
) VALUES
(301, 'PRRFC01', 'Muebles S.A. de C.V.', 'Calle Mueble', '123', '12345', 'Industrial', 'CDMX', '5511223344', '123456789012');

--7. Artículos

INSERT INTO articulo (
    articulo_id, categoria_id, cod_barras, nombre, precio_venta, precio_compra, stock, fotografia
) VALUES
(401, 1, 'BARRAS001', 'Silla Ejecutiva', 1500.00, 1000.00, 5, decode('00', 'hex')),
(402, 2, 'BARRAS002', 'Mesa Redonda', 2500.00, 1700.00, 2, decode('00', 'hex'));

--8. Artículos por proveedor

INSERT INTO articulo_proveedor (articulo_proveedor_id, articulo_id, proveedor_id) VALUES
(1, 401, 301),
(2, 402, 301);

--9. Ventas iniciales
--Prueba stock, montos y articulos totales
INSERT INTO venta (
    venta_id, empleado_vendedor_id, empleado_cobrador_id, cliente_id,
    fecha_venta
) VALUES
(1, 101, 102, 201, CURRENT_DATE);

--Prueba empleados diferenets sucursales.
INSERT INTO venta (
    venta_id, empleado_vendedor_id, empleado_cobrador_id, cliente_id,
    fecha_venta
) VALUES
(2, 101, 103, 201, CURRENT_DATE);


--Prueba cliente no registrado
INSERT INTO venta (
    venta_id, empleado_vendedor_id, empleado_cobrador_id, cliente_id,
    fecha_venta
) VALUES
(3, 101, 102, NULL, CURRENT_DATE);

--10.- Añadir articulos a una venta (registros de articulo_venta)
INSERT INTO articulo_venta (
    articulo_venta_id, articulo_id, venta_id, cantidad
) VALUES (
    1, 401, 1, 2);

--Prueba, articulos insuficientes
INSERT INTO articulo_venta (
    articulo_venta_id, articulo_id, venta_id, cantidad
) VALUES (
    2, 402, 1, 3
);
