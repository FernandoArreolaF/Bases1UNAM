-- Crear tabla de empleado con todas las columnas desde el inicio
CREATE TABLE empleado (
    rfc VARCHAR(13) PRIMARY KEY,
    num_empleado INT,
    nombre VARCHAR(100),
    apellido_paterno VARCHAR(50),
    apellido_materno VARCHAR(50),
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    edad INT,
    domicilio VARCHAR(255),
    sueldo DECIMAL(10, 2)
);

-- Crear tabla de cocineros
CREATE TABLE cocinero (
    rfc VARCHAR(13) PRIMARY KEY,
    especialidad VARCHAR(50)
);

-- Crear tabla de meseros
CREATE TABLE mesero (
    rfc VARCHAR(13) PRIMARY KEY,
    horario VARCHAR(50)
);

-- Crear tabla de administrativos
CREATE TABLE administrativo (
    rfc VARCHAR(13) PRIMARY KEY,
    rol VARCHAR(50)
);

-- Crear tabla de dependientes
CREATE TABLE dependiente (
    rfc_empleado VARCHAR(13),
    curp VARCHAR(18) PRIMARY KEY,
    nombre_dependiente VARCHAR(100),
    parentesco VARCHAR(50),
    FOREIGN KEY (rfc_empleado) REFERENCES empleado(rfc) ON DELETE CASCADE
);

-- Crear tabla de categorías
CREATE TABLE categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion TEXT
);

-- Crear tabla de platillos
CREATE TABLE platillo (
    id_platillo SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    receta TEXT,
    precio DECIMAL(10, 2),
    disponibilidad BOOLEAN,
    id_categoria INT REFERENCES categoria(id_categoria)
);

-- Crear tabla de bebidas
CREATE TABLE bebida (
    id_bebida SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10, 2),
    disponibilidad BOOLEAN,
    id_categoria INT REFERENCES categoria(id_categoria)
);

-- Crear tabla de órdenes
CREATE SEQUENCE folio_seq;
CREATE TABLE orden (
    folio VARCHAR(20) PRIMARY KEY DEFAULT 'ORD-' || LPAD(nextval('folio_seq')::TEXT, 3, '0'),
    fecha_hora TIMESTAMP,
    total_pagar DECIMAL(10, 2),
    rfc_mesero VARCHAR(13),
    FOREIGN KEY (rfc_mesero) REFERENCES mesero(rfc) ON DELETE SET NULL
);

-- Crear tabla de detalles de orden
CREATE TABLE detalle_orden (
    id_detalle SERIAL PRIMARY KEY,
    folio_orden VARCHAR(20),
    id_platillo INT,
    id_bebida INT,
    cantidad INT,
    precio_total DECIMAL(10, 2),
    FOREIGN KEY (folio_orden) REFERENCES orden(folio),
    FOREIGN KEY (id_platillo) REFERENCES platillo(id_platillo),
    FOREIGN KEY (id_bebida) REFERENCES bebida(id_bebida)
);

-- Crear tabla de clientes
CREATE TABLE cliente (
    rfc VARCHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    domicilio VARCHAR(255),
    razon_social VARCHAR(100),
    email VARCHAR(100),
    fecha_nacimiento DATE,
    estado VARCHAR(50),
    codigo_postal VARCHAR(10),
    colonia VARCHAR(100),
    calle VARCHAR(255),
    numero VARCHAR(10)
);

-- Agregar índices
CREATE INDEX idx_empleado_num ON empleado(num_empleado);
CREATE INDEX idx_disponibilidad ON platillo(disponibilidad);
CREATE INDEX idx_disponibilidad_bebida ON bebida(disponibilidad);
CREATE INDEX idx_fecha_hora_orden ON orden(fecha_hora);

-- Modificar la relación entre empleado y mesero
CREATE TABLE mesero_empleado (
    rfc_mesero VARCHAR(13) PRIMARY KEY,
    FOREIGN KEY (rfc_mesero) REFERENCES empleado(rfc) ON DELETE CASCADE
);

-- Vista para mostrar detalles del platillo más vendido
CREATE VIEW v_platillo_mas_vendido AS
SELECT p.id_platillo, p.nombre, p.descripcion, COUNT(d.id_detalle) AS total_ventas
FROM platillo p
JOIN detalle_orden d ON p.id_platillo = d.id_platillo
GROUP BY p.id_platillo
ORDER BY total_ventas DESC
LIMIT 1;

-- Vista para obtener el nombre de productos no disponibles
CREATE VIEW v_productos_no_disponibles AS
SELECT id_platillo AS id_producto, nombre, 'platillo' AS tipo_producto
FROM platillo
WHERE disponibilidad = FALSE
UNION
SELECT id_bebida AS id_producto, nombre, 'bebida' AS tipo_producto
FROM bebida
WHERE disponibilidad = FALSE;

-- Función almacenada para actualizar totales y validar disponibilidad
CREATE OR REPLACE FUNCTION agregar_producto_a_orden(
    in folio_orden VARCHAR(20),
    in id_platillo INT,
    in id_bebida INT,
    in cantidad INT
)
RETURNS VOID AS $$
DECLARE
    precio_platillo DECIMAL;
    precio_bebida DECIMAL;
BEGIN
    -- Obtener precios de platillo y bebida
    SELECT precio INTO precio_platillo FROM platillo WHERE id_platillo = id_platillo;
    SELECT precio INTO precio_bebida FROM bebida WHERE id_bebida = id_bebida;

    -- Validar disponibilidad
    IF id_platillo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM platillo WHERE id_platillo = id_platillo AND disponibilidad = TRUE) THEN
        RAISE EXCEPTION 'El platillo no está disponible';
    END IF;

    IF id_bebida IS NOT NULL AND NOT EXISTS (SELECT 1 FROM bebida WHERE id_bebida = id_bebida AND disponibilidad = TRUE) THEN
        RAISE EXCEPTION 'La bebida no está disponible';
    END IF;

    -- Actualizar totales
    UPDATE orden SET total_pagar = total_pagar + (cantidad * COALESCE(precio_platillo, 0) + cantidad * COALESCE(precio_bebida, 0)) WHERE folio = folio_orden;
    INSERT INTO detalle_orden(folio_orden, id_platillo, id_bebida, cantidad, precio_total)
    VALUES (folio_orden, id_platillo, id_bebida, cantidad, cantidad * COALESCE(precio_platillo, 0) + cantidad * COALESCE(precio_bebida, 0));
END;
$$ LANGUAGE plpgsql;

-- Función almacenada para obtener estadísticas de un mesero
CREATE OR REPLACE FUNCTION estadisticas_mesero(
    in num_empleado INT,
    out num_ordenes INT,
    out total_pagado DECIMAL
)
RETURNS RECORD AS $$
DECLARE
    rfc_mesero VARCHAR(13);
BEGIN
    -- Obtener RFC del empleado
    SELECT rfc INTO rfc_mesero FROM empleado WHERE num_empleado = num_empleado AND EXISTS (SELECT 1 FROM mesero_empleado WHERE rfc_mesero = empleado.rfc);

    -- Validar que sea un mesero
    IF rfc_mesero IS NULL THEN
        RAISE EXCEPTION 'El empleado no es un mesero';
    END IF;

    -- Obtener estadísticas
    SELECT COUNT(*), COALESCE(SUM(total_pagar), 0) INTO num_ordenes, total_pagado FROM orden WHERE rfc_mesero = rfc_mesero;
END;
$$ LANGUAGE plpgsql;

-- Modificar la tabla de órdenes
ALTER TABLE orden
ADD COLUMN rfc_cliente VARCHAR(13),
ADD CONSTRAINT fk_cliente_orden FOREIGN KEY (rfc_cliente) REFERENCES cliente(rfc) ON DELETE SET NULL;

-- Vista para asemejar a una factura de una orden
CREATE VIEW v_factura_orden AS
SELECT
    o.folio AS folio_orden,
    o.fecha_hora,
    o.total_pagar,
    c.nombre AS nombre_cliente,
    c.domicilio AS domicilio_cliente,
    c.razon_social,
    c.email,
    c.fecha_nacimiento AS fecha_nacimiento_cliente,
    c.estado,
    c.codigo_postal,
    c.colonia,
    c.calle,
    c.numero,
    m.rfc AS rfc_mesero,
    m.horario AS horario_mesero,
    d.id_detalle,
    COALESCE(p.nombre, b.nombre) AS nombre_producto,
    d.cantidad,
    d.precio_total
FROM orden o
JOIN cliente c ON o.rfc_cliente = c.rfc
LEFT JOIN mesero m ON o.rfc_mesero = m.rfc
JOIN detalle_orden d ON o.folio = d.folio_orden
LEFT JOIN platillo p ON d.id_platillo = p.id_platillo
LEFT JOIN bebida b ON d.id_bebida = b.id_bebida;



CREATE TABLE TELÉFONO (
    rfc VARCHAR,
    telefono INT,
    PRIMARY KEY (rfc, telefono),
    FOREIGN KEY (rfc) REFERENCES EMPLEADO(rfc VARCHAR)
);

-- 65 Registros Empleado
INSERT INTO EMPLEADO (Num_empleado, RFC, estado, CP, colonia, calle, número, nombre, Ap_paterno, Ap_materno, Fecha_nac, Edad, Foto)
VALUES
(1, 'RFC1', 'Activo', 12345, 'Colonia1', 'Calle1', 1, 'Juan', 'Pérez', 'Gómez', '1990-01-15', 32, NULL),
(2, 'RFC2', 'Inactivo', 54321, 'Colonia2', 'Calle2', 2, 'María', 'González', 'López', '1995-05-20', 28, NULL),
(3, 'RFC3', 'Activo', 67890, 'Colonia3', 'Calle3', 3, 'Carlos', 'Rodríguez', 'Vega', '1985-03-10', 37, NULL),
(4, 'RFC4', 'Activo', 98765, 'Colonia4', 'Calle4', 4, 'Laura', 'Díaz', 'Sánchez', '1992-08-02', 30, NULL),
(5, 'RFC5', 'Inactivo', 11111, 'Colonia5', 'Calle5', 5, 'Pedro', 'Hernández', 'Luna', '1988-12-25', 34, NULL),
(6, 'RFC6', 'Activo', 22222, 'Colonia6', 'Calle6', 6, 'Ana', 'Martínez', 'Ortega', '1993-07-18', 29, NULL),
(7, 'RFC7', 'Inactivo', 33333, 'Colonia7', 'Calle7', 7, 'Javier', 'Soto', 'Ramírez', '1998-02-05', 25, NULL),
(8, 'RFC8', 'Inactivo', 45689, 'Colonia8', 'Calle8', 8, 'Jorge', 'Mendez', 'Maldonado', '1998-02-05', 25, NULL),
(9, 'RFC9', 'Inactivo', 12485, 'Colonia9', 'Calle9', 9, 'Renata', 'Mendez', 'Maldonado', '1998-02-05', 25, NULL),
(10, 'RFC10', 'Inactivo', 68547, 'Colonia10', 'Calle10', 10, 'Carlos', 'Maldonado', 'Gonzalez', '1998-02-05', 25, NULL),
(11, 'RFC11', 'Activo', 55555, 'Colonia11', 'Calle11', 11, 'Elena', 'Vargas', 'Gutiérrez', '1991-09-08', 30, NULL),
(12, 'RFC12', 'Activo', 77777, 'Colonia12', 'Calle12', 12, 'Roberto', 'Fernández', 'Mendoza', '1994-11-12', 28, NULL),
(13, 'RFC13', 'Inactivo', 99999, 'Colonia13', 'Calle13', 13, 'Patricia', 'Rojas', 'Santos', '1986-06-25', 35, NULL),
(14, 'RFC14', 'Activo', 88888, 'Colonia14', 'Calle14', 14, 'Hugo', 'López', 'Cabrera', '1993-03-30', 29, NULL),
(15, 'RFC15', 'Activo', 66666, 'Colonia15', 'Calle15', 15, 'Isabel', 'García', 'Moreno', '1989-12-10', 32, NULL),
(16, 'RFC16', 'Inactivo', 44444, 'Colonia16', 'Calle16', 16, 'Fernando', 'Jiménez', 'Aguilar', '1996-04-05', 26, NULL),
(17, 'RFC17', 'Activo', 33333, 'Colonia17', 'Calle17', 17, 'Mónica', 'Pérez', 'Navarro', '1990-07-18', 31, NULL),
(18, 'RFC18', 'Inactivo', 22222, 'Colonia18', 'Calle18', 18, 'Alejandro', 'Gómez', 'Herrera', '1997-02-01', 25, NULL),
(19, 'RFC19', 'Activo', 11111, 'Colonia19', 'Calle19', 19, 'Carmen', 'Sánchez', 'Ruiz', '1987-10-15', 34, NULL),
(20, 'RFC20', 'Activo', 99999, 'Colonia20', 'Calle20', 20, 'Ricardo', 'Luna', 'Valdez', '1992-05-20', 30, NULL),
(21, 'RFC21', 'Inactivo', 88888, 'Colonia21', 'Calle21', 21, 'Gabriela', 'Torres', 'Pérez', '1995-08-12', 26, NULL),
(22, 'RFC22', 'Activo', 66666, 'Colonia22', 'Calle22', 22, 'Arturo', 'Núñez', 'Salgado', '1998-04-25', 23, NULL),
(23, 'RFC23', 'Activo', 44444, 'Colonia23', 'Calle23', 23, 'Daniela', 'Guerrero', 'Vega', '1990-11-05', 31, NULL),
(24, 'RFC24', 'Inactivo', 22222, 'Colonia24', 'Calle24', 24, 'Manuel', 'Villanueva', 'Ortiz', '1985-02-18', 36, NULL),
(25, 'RFC25', 'Activo', 11111, 'Colonia25', 'Calle25', 25, 'Luis', 'Aguilar', 'Hernández', '1987-07-20', 34, NULL),
(26, 'RFC26', 'Inactivo', 99999, 'Colonia26', 'Calle26', 26, 'Eva', 'Romero', 'Molina', '1996-09-15', 25, NULL),
(27, 'RFC27', 'Activo', 77777, 'Colonia27', 'Calle27', 27, 'Rodrigo', 'Suárez', 'Castro', '1993-12-30', 28, NULL),
(28, 'RFC28', 'Inactivo', 55555, 'Colonia28', 'Calle28', 28, 'Renata', 'López', 'Guzmán', '1992-03-05', 30, NULL),
(29, 'RFC29', 'Activo', 33333, 'Colonia29', 'Calle29', 29, 'Jorge', 'Flores', 'Cabrera', '1989-06-10', 32, NULL),
(30, 'RFC30', 'Activo', 22222, 'Colonia30', 'Calle30', 30, 'Ana', 'Cruz', 'Santillán', '1994-01-22', 28, NULL),
(31, 'RFC31', 'Inactivo', 88888, 'Colonia31', 'Calle31', 31, 'Fernanda', 'Santos', 'Ríos', '1995-05-15', 26, NULL),
(32, 'RFC32', 'Activo', 66666, 'Colonia32', 'Calle32', 32, 'Héctor', 'Gómez', 'Cervantes', '1998-02-20', 23, NULL),
(33, 'RFC33', 'Activo', 44444, 'Colonia33', 'Calle33', 33, 'Carolina', 'Vega', 'Torres', '1990-11-10', 31, NULL),
(34, 'RFC34', 'Inactivo', 22222, 'Colonia34', 'Calle34', 34, 'Roberto', 'Ortiz', 'Mendoza', '1985-04-18', 36, NULL),
(35, 'RFC35', 'Activo', 11111, 'Colonia35', 'Calle35', 35, 'Laura', 'Hernández', 'García', '1987-08-20', 34, NULL),
(36, 'RFC36', 'Inactivo', 99999, 'Colonia36', 'Calle36', 36, 'Martín', 'Molina', 'Guzmán', '1996-09-22', 25, NULL),
(37, 'RFC37', 'Activo', 77777, 'Colonia37', 'Calle37', 37, 'Gabriela', 'Castro', 'Ramírez', '1993-12-25', 28, NULL),
(38, 'RFC38', 'Inactivo', 55555, 'Colonia38', 'Calle38', 38, 'Alejandro', 'Guzmán', 'Villanueva', '1992-03-10', 30, NULL),
(39, 'RFC39', 'Activo', 33333, 'Colonia39', 'Calle39', 39, 'Sofía', 'Cabrera', 'Vargas', '1989-06-15', 32, NULL),
(40, 'RFC40', 'Activo', 22222, 'Colonia40', 'Calle40', 40, 'Mario', 'Santillán', 'López', '1994-01-28', 28, NULL),
(41, 'RFC41', 'Inactivo', 88888, 'Colonia41', 'Calle41', 41, 'Victoria', 'Torres', 'Sánchez', '1995-07-10', 26, NULL),
(42, 'RFC42', 'Activo', 66666, 'Colonia42', 'Calle42', 42, 'Andrés', 'Núñez', 'Mendoza', '1998-05-15', 23, NULL),
(43, 'RFC43', 'Activo', 44444, 'Colonia43', 'Calle43', 43, 'Valentina', 'Guerrero', 'Vega', '1990-12-20', 31, NULL),
(44, 'RFC44', 'Inactivo',22222, 'Colonia44', 'Calle44', 44, 'Daniel', 'Villanueva', 'Ortiz', '1985-06-18', 36, NULL),
(45, 'RFC45', 'Activo',11111, 'Colonia45', 'Calle45', 45, 'Lucía', 'Aguilar', 'Hernández', '1987-09-15', 34, NULL),
(46, 'RFC46', 'Inactivo',99999, 'Colonia46', 'Calle46', 46, 'Joaquín', 'Romero', 'Molina', '1996-10-22', 25, NULL),
(47, 'RFC47', 'Activo',77777, 'Colonia47', 'Calle47', 47, 'Bianca', 'Suárez', 'Castro', '1994-01-25', 28, NULL),
(48, 'RFC48', 'Inactivo',55555, 'Colonia48', 'Calle48', 48, 'Martín', 'López', 'Guzmán', '1992-04-10', 30, NULL),
(49, 'RFC49', 'Activo',33333, 'Colonia49', 'Calle49', 49, 'Camila', 'Flores', 'Cabrera', '1989-07-15', 32, NULL),
(50, 'RFC50', 'Activo',22222, 'Colonia50', 'Calle50', 50, 'Francisco', 'Cruz', 'Santillán', '1994-02-28', 28, NULL),
(51, 'RFC51', 'Inactivo',22222, 'Colonia51', 'Calle51', 56, 'Juan', 'Martínez', 'Mendoza', '2000-04-18', 23, NULL),
(52, 'RFC52', 'Activo',77777, 'Colonia52', 'Calle52', 12, 'Paula', 'Molina', 'Lechuga', '2000-04-18', 23, NULL),
(53, 'RFC53', 'Activo',11111, 'Colonia53', 'Calle53', 31, 'Thais', 'Martínez', 'Tello', '2000-08-5', 23, NULL),
(54, 'RFC54', 'Activo',88888, 'Colonia54', 'Calle54', 67, 'Belen', 'Pérez', 'Rodríguez', '1999-08-23', 24, NULL),
(55, 'RFC55', 'Inactivo',22222,'Colonia55', 'Calle55', 15, 'Isacc', 'Pérez', 'Fonseca', '1999-07-1', 24, NULL),
(56, 'RFC56', 'Inactivo',66666,'Colonia56', 'Calle56', 15, 'Dario', 'Caballero', 'Cornejo', '1980-02-17', 43 , NULL),
(57, 'RFC57', 'Inactivo',99999,'Colonia57', 'Calle57', 76, 'Xochitl', 'Torres', 'Sánchez', '1970-05-20', 53, NULL),
(58, 'RFC58', 'Activo', 12345, 'Colonia58', 'Calle58', 9, 'Rodrigo', 'Valencia', 'Múngica', '2006-09-6', 17, NULL),
(59, 'RFC59', 'Activo', 12345, 'Colonia59', 'Calle59', 45, 'Dimitri', 'Coronel', 'Peñasco', '2003-01-14', 20, NULL),
(60, 'RFC60', 'Activo', 12789, 'Colonia60', 'Calle60', 23, 'Broke', 'Ortiz', 'Villanueva', '1999-03-10', 24, NULL),
(61, 'RFC61', 'Activo', 11111, 'Colonia61', 'Calle61', 1, 'Saskia', 'Morales', 'Castillo', '1985-10-23', 38, NULL),
(62, 'RFC62', 'Inactivo',99999, 'Colonia62', 'Calle62', 69, 'Camilo', 'Trejo', 'Contreras', '1990-12-14', 32, NULL),
(63, 'RFC63', 'Inactivo',44444, 'Colonia63', 'Calle63', 24, 'Rosa', 'Vargas', 'Paredes', '1991-11-26', 32, NULL),
(64, 'RFC64', 'Inactivo',66666, 'Colonia64', 'Calle64', 73, 'Marta', 'Herrera', 'Ortega', '1961-05-18', 62, NULL),
(65, 'RFC65', 'Activo',12345, 'Colonia65', 'Calle65', 73, 'Julian', 'Velázquez', 'Morales', '1999-08-27', 24, NULL);





-- Tabla TELÉFONO
INSERT INTO TELÉFONO (Num_empleado, telefono)
VALUES
(1, 5551234),
(2, 5555678),
(3, 5559999),
(4, 5558888),
(5, 5557777),
(6, 5556666),
(7, 5555555),
(8, 5554444),
(9, 5553333),
(10, 5552222),
(11, 5551111),
(12, 5550000),
(13, 5559999),
(14, 5558888),
(15, 5557777),
(16, 5556666),
(17, 5555555),
(18, 5554444),
(19, 5553333),
(20, 5552222),
(21, 5551111),
(22, 5550000),
(23, 5559999),
(24, 5558888),
(25, 5557777),
(26, 5556666),
(27, 5555555),
(28, 5554444),
(29, 5553333),
(30, 5552222),
(31, 5551111),
(32, 5550000),
(33, 5559999),
(34, 5558888),
(35, 5557777),
(36, 5556666),
(37, 5555555),
(38, 5554444),
(39, 5553333),
(40, 5552222),
(41, 5551111),
(42, 5550000),
(43, 5559999),
(44, 5558888),
(45, 5557777),
(46, 5556666),
(47, 5555555),
(48, 5554444),
(49, 5553333),
(50, 5552222),
(51, 5936573),
(52, 5522859),
(53, 5534567),
(54, 5528901),
(55, 5552245),
(56, 5516232),
(57, 5545671),
(58, 5500145),
(59, 5542189),
(60, 5534789),
(61, 5566621),
(62, 5578131),
(63, 5561213),
(64, 5523457),
(65, 5537831),

-- Inserciones en la tabla COCINERO
INSERT INTO COCINERO (Num_empleado, Especialidad)
VALUES
(35, 'Italiana'),
(20, 'Francesa'),
(45, 'Mexicana'),
(12, 'Asiática'),
(50, 'Mediterránea'),
(48, 'Vegetariana'),
(40, 'Parrilla'),
(25, 'Postres'),
(15, 'Vegana'),
(30, 'Sushi'),
(10, 'Internacional'),
(42, 'Mariscos'),
(22, 'Thai'),
(5, 'Gourmet'),
(18, 'Comida rápida'),
(2, 'Vegetariana'),
(8, 'Asiática'),
(16, 'Mexicana'),
(23, 'Parrilla'),
(49, 'Postres');

-- Inserciones en la tabla MESERO
INSERT INTO MESERO (Num_empleado, Horario)
VALUES
(1, '2023-01-01 08:00:00'),
(7, '2023-01-02 10:30:00'),
(13, '2023-01-03 12:00:00'),
(19, '2023-01-04 14:45:00'),
(25, '2023-01-05 16:30:00'),
(31, '2023-01-06 18:15:00'),
(37, '2023-01-07 20:00:00'),
(43, '2023-01-08 22:30:00'),
(49, '2023-01-09 10:00:00'),
(2, '2023-01-10 12:45:00'),
(11, '2023-01-11 14:30:00'),
(21, '2023-01-12 16:15:00'),
(30, '2023-01-13 18:00:00'),
(40, '2023-01-14 20:45:00'),
(50, '2023-01-15 22:30:00'),
(6, '2023-01-16 09:15:00'),
(16, '2023-01-17 11:00:00'),
(26, '2023-01-18 13:30:00'),
(36, '2023-01-19 15:45:00'),
(46, '2023-01-20 17:30:00');

-- Inserciones en la tabla ADMINISTRATIVO
INSERT INTO ADMINISTRATIVO (Num_empleado, Rol)
VALUES
(8, 'Gerente'),
(3, 'Contador'),
(18, 'Secretario'),
(28, 'Recursos Humanos'),
(38, 'Analista de Datos'),
(48, 'Asistente Administrativo'),
(13, 'Coordinador de Proyectos'),
(23, 'Analista de Recursos Humanos'),
(33, 'Asistente de Dirección'),
(43, 'Especialista en Finanzas');

-- Inserciones en la tabla DEPENDIENTES
INSERT INTO DEPENDIENTES (CURP, Num_empleado, Nombre_dependiente, Parentesco)
VALUES
('CURP101', 35, 'Laura', 'Hija'),
('CURP102', 20, 'Diego', 'Hijo'),
('CURP103', 45, 'Sofía', 'Hija'),
('CURP104', 12, 'Carlos', 'Hijo'),
('CURP105', 50, 'Isabella', 'Hija'),
('CURP106', 48, 'Lucas', 'Hijo'),
('CURP107', 40, 'Emma', 'Hija'),
('CURP108', 25, 'Mateo', 'Hijo'),
('CURP109', 15, 'Valentina', 'Hija'),
('CURP110', 30, 'Sebastián', 'Hijo'),
('CURP111', 10, 'Ximena', 'Hija'),
('CURP112', 42, 'Daniel', 'Hijo'),
('CURP113', 22, 'Mariana', 'Hija'),
('CURP114', 5, 'Alexander', 'Hijo'),
('CURP115', 18, 'Camila', 'Hija'),
('CURP116', 2, 'Adrián', 'Hijo'),
('CURP117', 8, 'Fernanda', 'Hija'),
('CURP118', 16, 'Nicolas', 'Hijo'),
('CURP119', 23, 'Ana', 'Hija'),
('CURP120', 49, 'Eduardo', 'Hijo'),
('CURP121', 1, 'Luna', 'Hija'),
('CURP122', 7, 'Pablo', 'Hijo'),
('CURP123', 17, 'Ariana', 'Hija'),
('CURP124', 27, 'Martín', 'Hijo'),
('CURP125', 37, 'Elena', 'Hija'),
('CURP126', 47, 'Oliver', 'Hijo'),
('CURP127', 6, 'Aurora', 'Hija'),
('CURP128', 16, 'Javier', 'Hijo'),
('CURP129', 26, 'Sara', 'Hija'),
('CURP130', 65, 'Morticia', 'Hija'),
('CURP131', 55, 'Homero', 'Hijo'),
('CURP132', 33, 'Merlina', 'Hija'),
('CURP133', 20, 'Pericles', 'Hijo'),
('CURP134', 13, 'Casimiro', 'Hijo'),
('CURP135', 9, 'Evano', 'Hijo'),
('CURP136', 1, 'bumblebee', 'Hija'),
('CURP137', 31, 'Luna', 'Hija'),
('CURP138', 8, 'Perla', 'Hija'),
('CURP139', 12, 'Alicia', 'Hija'),
('CURP140', 46, 'Sofia', 'Hija'),
('CURP141', 51, 'Tomas', 'Hijo'),
('CURP142', 60, 'Manuel', 'Hijo'),
('CURP143', 61, 'Cesar', 'Hijo'),
('CURP144', 62, 'Thais', 'Hija'),
('CURP145', 63, 'Belen', 'Hija');

-- Inserciones en la tabla FACTURA
INSERT INTO FACTURA (RFC, Nombre_cliente, Fecha_nac, Email, Razon_social, Colonia, CP, Número, Calle, Estado)
VALUES
('RFC1', 'Juan Pérez', '1990-05-15', 'juan.perez@example.com', 'Restaurante El Sabor', 'Centro', 12345, 101, 'Calle Principal', 'Ciudad de México'),
('RFC2', 'Ana López', '1985-08-22', 'ana.lopez@example.com', 'Comidas Ricas', 'San Antonio', 54321, 202, 'Avenida Secundaria', 'Guadalajara'),
('RFC3', 'Carlos García', '1992-03-10', 'carlos.garcia@example.com', 'Cocina del Valle', 'La Esperanza', 67890, 303, 'Calle de la Paz', 'Monterrey'),
('RFC4', 'María Torres', '1988-11-05', 'maria.torres@example.com', 'Sabores Exquisitos', 'Los Pinos', 98765, 404, 'Boulevard de la Aurora', 'Puebla'),
('RFC5', 'Roberto Ramírez', '1995-06-30', 'roberto.ramirez@example.com', 'Gastronomía del Sur', 'Las Flores', 43210, 505, 'Avenida de la Luna', 'Querétaro'),
('RFC6', 'Laura González', '1987-09-18', 'laura.gonzalez@example.com', 'Delicias del Mar', 'San Pedro', 13579, 606, 'Callejón del Sol', 'Cancún'),
('RFC7', 'Daniel Mendoza', '1993-04-25', 'daniel.mendoza@example.com', 'Especialidades Gastronómicas', 'La Victoria', 24680, 707, 'Paseo de la Montaña', 'Tijuana'),
('RFC8', 'Alejandra Silva', '1989-12-12', 'alejandra.silva@example.com', 'Aromas del Chef', 'La Reforma', 97531, 808, 'Calle de los Sabores', 'Mérida'),
('RFC9', 'Javier Vargas', '1996-07-08', 'javier.vargas@example.com', 'Sabores Caseros', 'Los Alamos', 11223, 909, 'Avenida de la Tradición', 'Toluca'),
('RFC10', 'Silvia Jiménez', '1986-02-14', 'silvia.jimenez@example.com', 'Culinaria del Norte', 'San Francisco', 33445, 1010, 'Boulevard de la Historia', 'Acapulco'),
('RFC11', 'Pedro Sánchez', '1991-10-20', 'pedro.sanchez@example.com', 'Sazón Auténtico', 'El Paraíso', 55667, 1111, 'Calle Principal', 'Playa del Carmen'),
('RFC12', 'Mariana Ortiz', '1984-07-02', 'mariana.ortiz@example.com', 'Delicias Orientales', 'El Dorado', 77889, 1212, 'Avenida del Sol', 'Puerto Vallarta'),
('RFC13', 'Rodrigo Castro', '1997-04-15', 'rodrigo.castro@example.com', 'Experiencia Gourmet', 'Las Palmas', 99000, 1313, 'Calle de las Delicias', 'Hermosillo'),
('RFC14', 'Adriana Moreno', '1983-11-28', 'adriana.moreno@example.com', 'Sabor a Hogar', 'San Miguel', 11223, 1414, 'Boulevard de la Alegria', 'Cabo San Lucas'),
('RFC15', 'Héctor Guzmán', '1990-06-05', 'hector.guzman@example.com', 'Gastronomía Moderna', 'La Colina', 33445, 1515, 'Avenida de la Creatividad', 'Puerto Escondido'),
('RFC16', 'Karla Rivera', '1985-09-23', 'karla.rivera@example.com', 'Sabores del Campo', 'El Bosque', 55667, 1616, 'Callejón del Arte', 'Chihuahua'),
('RFC17', 'Francisco Nava', '1992-04-10', 'francisco.nava@example.com', 'Placeres Culinarios', 'Las Rosas', 77889, 1717, 'Paseo de la Elegancia', 'Ciudad Juárez'),
('RFC18', 'Natalia Díaz', '1988-12-13', 'natalia.diaz@example.com', 'Delicias de la Tierra', 'La Sierra', 99000, 1818, 'Boulevard del Gusto', 'Saltillo'),
('RFC19', 'Gabriel Torres', '1995-07-01', 'gabriel.torres@example.com', 'Cocina Vanguardista', 'Los Olivos', 11223, 1919, 'Calle de la Innovación', 'Campeche'),
('RFC20', 'Patricia Soto', '1987-02-15', 'patricia.soto@example.com', 'Sabor y Tradición', 'El Vergel', 33445, 2020, 'Avenida de la Historia', 'Durango'),
('RFC21', 'Eduardo Ríos', '1993-10-21', 'eduardo.rios@example.com', 'Especias y Sabores', 'La Fuente', 55667, 2121, 'Boulevard del Arte', 'Culiacán'),
('RFC22', 'Ana Beltrán', '1986-07-03', 'ana.beltran@example.com', 'Delicias Mediterráneas', 'La Estrella', 77889, 2222, 'Paseo de la Armonía', 'Veracruz'),
('RFC23', 'Andrés Mendoza', '1991-04-16', 'andres.mendoza@example.com', 'Culinaria Internacional', 'El Milagro', 99000, 2323, 'Calle de las Maravillas', 'Aguascalientes'),
('RFC24', 'Lucía Cervantes', '1984-12-29', 'lucia.cervantes@example.com', 'Sazón y Estilo', 'Los Cerezos', 11223, 2424, 'Boulevard de la Fantasía', 'Morelia'),
('RFC25', 'Raúl Gómez', '1997-07-16', 'raul.gomez@example.com', 'Fusión Gastronómica', 'Las Cruces', 55667, 2525, 'Avenida de los Sueños', 'San Luis Potosí'),
('RFC26', 'Carmen Vargas', '1983-02-01', 'carmen.vargas@example.com', 'Delicias Exóticas', 'La Luna', 77889, 2626, 'Paseo de la Serenidad', 'Zacatecas'),
('RFC27', 'Ricardo Rueda', '1990-09-24', 'ricardo.rueda@example.com', 'Cocina Creativa', 'Los Pinos', 99000, 2727, 'Calle de la Inspiración', 'Colima'),
('RFC28', 'Liliana Navarro', '1985-04-11', 'liliana.navarro@example.com', 'Sabores del Mar', 'El Bosquecito', 11223, 2828, 'Boulevard del Mar', 'Tepic'),
('RFC29', 'José Rodríguez', '1992-01-28', 'jose.rodriguez@example.com', 'Aromas del Mundo', 'Las Margaritas', 55667, 2929, 'Avenida de la Abundancia', 'Tuxtla Gutiérrez'),
('RFC30', 'Isabel Maldonado', '1987-08-14', 'isabel.maldonado@example.com', 'Gastronomía Contemporánea', 'La Cima', 77889, 3030, 'Paseo de la Innovación', 'Ciudad Obregón');

-- Inserciones en la tabla DETALLE_DE_ORDEN
INSERT INTO DETALLE_DE_ORDEN (ID_detalle, Cantidad, Precio_total)
VALUES
(1, 2.5, 15.75),
(2, 1.0, 32.50),
(3, 3.0, 45.60),
(4, 2.5, 42.90),
(5, 1.0, 28.75),
(6, 4.0, 90.40),
(7, 2.0, 31.05),
(8, 1.5, 45.80),
(9, 3.0, 30.25),
(10, 1.0, 85.60),
(11, 2.5, 54.30),
(12, 1.0, 37.95),
(13, 4.0, 20.50),
(14, 2.5, 95.85),
(15, 1.0, 72.40),
(16, 3.0, 48.15),
(17, 2.5, 35.70),
(18, 1.0, 18.35),
(19, 4.0, 80.70),
(20, 2.0, 60.25),
(21, 1.5, 42.90),
(22, 3.0, 28.55),
(23, 2.5, 75.90),
(24, 1.0, 55.45),
(25, 4.0, 38.10),
(26, 2.5, 20.75),
(27, 1.0, 90.10),
(28, 3.0, 68.65),
(29, 2.5, 45.20),
(30, 1.0, 30.85);

-- Inserciones en la tabla ORDEN
INSERT INTO ORDEN (Folio, Fecha_hora, Total_pagar, ID_detalle, RFC)
VALUES
('Folio101', '2023-01-01 08:30:00', 50.75, 1, 'RFC1'),
('Folio102', '2023-01-02 09:45:00', 32.50, 2, 'RFC2'),
('Folio103', '2023-01-03 11:15:00', 75.20, 3, 'RFC3'),
('Folio104', '2023-01-04 13:00:00', 42.90, 4, 'RFC4'),
('Folio105', '2023-01-05 14:30:00', 28.75, 5, 'RFC5'),
('Folio106', '2023-01-06 16:00:00', 90.40, 6, 'RFC6'),
('Folio107', '2023-01-07 17:45:00', 62.10, 7, 'RFC7'),
('Folio108', '2023-01-08 19:30:00', 45.80, 8, 'RFC8'),
('Folio109', '2023-01-09 10:00:00', 30.25, 9, 'RFC9'),
('Folio110', '2023-01-10 12:15:00', 85.60, 10, 'RFC10'),
('Folio111', '2023-01-11 14:00:00', 54.30, 11, 'RFC11'),
('Folio112', '2023-01-12 15:45:00', 37.95, 12, 'RFC12'),
('Folio113', '2023-01-13 17:30:00', 20.50, 13, 'RFC13'),
('Folio114', '2023-01-14 19:00:00', 95.85, 14, 'RFC14'),
('Folio115', '2023-01-15 20:45:00', 72.40, 15, 'RFC15'),
('Folio116', '2023-01-16 09:30:00', 48.15, 16, 'RFC16'),
('Folio117', '2023-01-17 11:15:00', 35.70, 17, 'RFC17'),
('Folio118', '2023-01-18 13:00:00', 18.35, 18, 'RFC18'),
('Folio119', '2023-01-19 14:45:00', 80.70, 19, 'RFC19'),
('Folio120', '2023-01-20 16:30:00', 60.25, 20, 'RFC20'),
('Folio121', '2023-01-21 18:00:00', 42.90, 21, 'RFC21'),
('Folio122', '2023-01-22 19:45:00', 28.55, 22, 'RFC22'),
('Folio123', '2023-01-23 10:30:00', 75.90, 23, 'RFC23'),
('Folio124', '2023-01-24 12:15:00', 55.45, 24, 'RFC24'),
('Folio125', '2023-01-25 14:00:00', 38.10, 25, 'RFC25'),
('Folio126', '2023-01-26 15:45:00', 20.75, 26, 'RFC26'),
('Folio127', '2023-01-27 17:30:00', 90.10, 27, 'RFC27'),
('Folio128', '2023-01-28 19:15:00', 68.65, 28, 'RFC28'),
('Folio129', '2023-01-29 09:00:00', 45.20, 29, 'RFC29'),
('Folio130', '2023-01-30 10:45:00', 30.85, 30, 'RFC30');

-- Inserciones en la tabla CATEGORIA
INSERT INTO CATEGORIA (Id_categoria, Nombre, Descripcion)
VALUES
(1, 'Entrante', 'Platos para empezar la comida'),
(2, 'Plato principal', 'Platos fuertes y sustanciosos'),
(3, 'Postre', 'Deliciosos dulces y postres'),
(4, 'Bebida', 'Refrescos, jugos y otras bebidas'),
(5, 'Ensalada', 'Ensaladas frescas y saludables'),
(6, 'Aperitivo', 'Pequeños bocados para abrir el apetito'),
(7, 'Desayuno', 'Platos ideales para empezar el día'),
(8, 'Vegetariano', 'Platos sin carne'),
(9, 'Vegano', 'Platos sin ingredientes de origen animal'),
(10, 'Internacional', 'Platos de diversas cocinas del mundo');

INSERT INTO COMIDA (Id_comida, Id_categoria, Nombre, Receta, Precio, Disponibilidad, Descripcion)
VALUES
(1, 2, 'Lomo Saltado', 'Salteado de carne, cebolla, tomate y papas fritas', 15.99, TRUE, 'Plato peruano tradicional'),
(2, 3, 'Tiramisú', 'Capas de bizcocho empapado en café con crema de mascarpone', 8.99, TRUE, 'Postre italiano clásico'),
(3, 1, 'Guacamole', 'Aguacate, tomate, cebolla, cilantro y limón', 7.50, TRUE, 'Entrada mexicana fresca'),
(4, 4, 'Margarita', 'Tequila, triple sec y jugo de limón', 9.99, TRUE, 'Cóctel clásico mexicano'),
(5, 2, 'Sushi de salmón', 'Arroz, alga nori, salmón fresco', 18.50, TRUE, 'Plato japonés tradicional'),
(6, 5, 'Ensalada César', 'Lechuga romana, aderezo César, crutones y parmesano', 12.75, TRUE, 'Ensalada clásica'),
(7, 3, 'Cheesecake de fresa', 'Tarta de queso con cobertura de fresas', 10.50, TRUE, 'Postre dulce y cremoso'),
(8, 6, 'Bruschetta', 'Pan tostado con tomate, ajo y albahaca', 6.99, TRUE, 'Aperitivo italiano'),
(9, 1, 'Caldo de pollo', 'Sopa de pollo con verduras y fideos', 9.25, TRUE, 'Sopa reconfortante'),
(10, 7, 'Omelette de champiñones', 'Huevos batidos con champiñones y queso', 11.99, TRUE, 'Desayuno nutritivo'),
(11, 8, 'Enchiladas de frijoles', 'Tortillas rellenas de frijoles y salsa', 10.99, TRUE, 'Plato vegetariano mexicano'),
(12, 9, 'Bowl vegano', 'Quinoa, aguacate, garbanzos y verduras', 13.50, TRUE, 'Comida vegana saludable'),
(13, 2, 'Filete de salmón', 'Salmón a la parrilla con limón y hierbas', 22.75, TRUE, 'Plato principal de pescado'),
(14, 5, 'Ensalada de quinoa', 'Quinoa, espinacas, aguacate y aderezo de limón', 15.25, TRUE, 'Ensalada nutritiva'),
(15, 6, 'Tapenade de aceitunas', 'Pasta de aceitunas, alcaparras y ajo', 7.25, TRUE, 'Aperitivo mediterráneo'),
(16, 3, 'Tarta de manzana', 'Masa hojaldrada con relleno de manzana y canela', 11.50, TRUE, 'Postre clásico'),
(17, 10, 'Curry de pollo', 'Pollo al curry con arroz basmati', 16.99, TRUE, 'Plato internacional hindú'),
(18, 2, 'Risotto de champiñones', 'Arroz cremoso con champiñones y parmesano', 14.75, TRUE, 'Plato italiano reconfortante'),
(19, 4, 'Limóncello', 'Licor italiano de limón', 8.50, TRUE, 'Bebida italiana refrescante'),
(20, 1, 'Empanadas de carne', 'Masa rellena de carne sazonada', 9.99, TRUE, 'Entrada latinoamericana'),
(21, 3, 'Helado de vainilla', 'Helado suave de vainilla con toppings', 5.99, TRUE, 'Postre helado clásico'),
(22, 9, 'Bowl de tofu', 'Tofu marinado con verduras y arroz integral', 12.25, TRUE, 'Comida vegana proteica'),
(23, 2, 'Pasta Alfredo', 'Pasta con salsa Alfredo cremosa', 13.50, TRUE, 'Plato italiano de pasta'),
(24, 5, 'Ensalada de aguacate', 'Aguacate, tomate, lechuga y aderezo de cilantro', 14.75, TRUE, 'Ensalada fresca y deliciosa'),
(25, 6, 'Pinchos de aceitunas', 'Aceitunas marinadas en aceite de oliva y hierbas', 6.50, TRUE, 'Aperitivo mediterráneo'),
(26, 3, 'Tarta de chocolate', 'Tarta de chocolate con ganache y frutas', 16.99, TRUE, 'Postre indulgente'),
(27, 10, 'Sushi fusion', 'Combinación de sabores internacionales en sushi', 20.50, TRUE, 'Plato de fusión culinaria'),
(28, 2, 'Gnocchi con pesto', 'Gnocchi con salsa pesto y piñones', 18.25, TRUE, 'Plato italiano reconfortante'),
(29, 4, 'Mojito de fresa', 'Cóctel refrescante con fresas, menta y ron', 9.25, TRUE, 'Bebida de verano'),
(30, 1, 'Ceviche de camarones', 'Camarones marinados con limón y especias', 15.99, TRUE, 'Entrada latinoamericana'),
(31, 4, 'Sangrita', 'Sangria señorial con tequila, limón y sal', 30.75, TRUE, 'Bebida tradicional Mexicana'),
(32, 3, 'Flan', 'Mezcla de huevos, leche condensada,leche evaporada con un poco de  caramelo', 35.05, TRUE, 'Postre clásico'),
(33, 3, 'Pastel de Zanahoria', 'Compuesto por zanahorias frescas ralladas,mezcla de especias aromáticas, harina, huevos y glaseado de Queso Crema', 80.00, TRUE, 'Postre clásico'),
(34, 7, 'Hotcakes', 'Mezcla de arina de trigo,azucar, polvo de hornear, sal , leche y huevo con un toque de extracto de vainilla ', 78.05, TRUE, 'Postre clásico'),
(35, 10, 'Kebabs', 'Trozos de carne marinada con una variedad de verduras, todo ensartado en palitos y asado a la parrilla', 250.99, TRUE, 'Plato del Oriente Medio'),
(36, 10, 'Pizza', 'Base de masa de pan, generalmente fina y redonda, cubierta con salsa de tomate y queso, y a menudo se le añaden ingredientes adicionales como pepperoni, champiñones, jamón, aceitunas, pimientos y otros', 345.99, TRUE, 'Plato de origen Italiano'),
(37, 10, 'Pasta Carbonara', 'Pasta cocida con una salsa hecha de huevo batido, queso rallado, panceta y pimienta negra.', 180.00, TRUE, 'Plato de origen Italiano'),
(37, 10, 'Couscous', 'Pequeñas bolitas de sémola de trigo cocidas al vapor, a menudo acompañadas de carne, verduras y garbanzos', 161.99, TRUE, 'Plato marroquí'),
(38, 10, 'Kefta Tagine', 'Albóndigas de carne de cordero o vaca sazonadas con hierbas y especias, cocidas en una salsa de tomate', 223.75, TRUE, 'Plato marroquí'),
(39, 4, 'Tejuino', 'Bebida a base de maíz, limón y sal', 25.00, TRUE, 'Bebida tradicional Mexicana'),
(40, 4, 'Té helado', 'Bebida refrescante elevaorada aprtir de té, endulzante y limón', 17.00, TRUE, 'Bebida refrescante'),
(41, 4, 'Smoothies', 'Mezcla de frutas, yogur o leche', 55.00, TRUE, 'Bebida refrescante'),
(42, 8, 'Lentejas al Curry', 'Lentejas cocidas en una salsa de curry con tomate, cebolla, ajo, y especias', 93.99, TRUE, 'Plato vegetariano'),
(43, 8, 'Hummus con Vegetales', 'Puré de garbanzos, tahini, ajo y limón, acompañado de zanahorias, apio y pepino', 60.00, TRUE, 'Plato vegetariano'),
(44, 8, 'Risotto de Champiñones', 'Arroz Arborio cocido con caldo, vino blanco, champiñones y queso parmesano', 100.00, TRUE, 'Plato vegetariano'),
(45, 8, 'Tacos de Tofu', 'Tofu marinado y cocido en tortillas con aderezos como aguacate, repollo rallado y salsa', 35.00, TRUE, 'Plato vegetariano');


-- Inserciones en la tabla INCLUYE
INSERT INTO INCLUYE (Id_comida, Id_detalle)
VALUES
(1, 2),
(1, 3),
(1, 1),
(2, 4),
(2, 2),
(3, 5),
(4, 3),
(5, 6),
(6, 1),
(6, 7),
(7, 8),
(8, 9),
(8, 2),
(9, 5),
(9, 3),
(10, 10),
(11, 2),
(12, 6),
(12, 4),
(12, 1),
(12, 7),
(13, 8),
(14, 2),
(15, 9),
(15, 4),
(16, 5),
(17, 3),
(18, 10),
(18, 1),
(18, 7),
(18, 12),
(19, 15),
(19, 11),
(20, 14),
(20, 12),
(21, 17),
(21, 13),
(21, 16),
(22, 11),
(23, 18),
(24, 19),
(24, 20),
(25, 14),
(26, 17),
(26, 15),
(26, 30),
(27, 12),
(28, 16),
(29, 19),
(30, 11);

-- Inserciones en la tabla ATIENDE
INSERT INTO ATIENDE (num_empleado, Folio, num_mesa)
VALUES
(1, 'Folio101', 5),
(7, 'Folio102', 10),
(13, 'Folio103', 3),
(19, 'Folio104', 8),
(25, 'Folio105', 12),
(31, 'Folio106', 15),
(37, 'Folio107', 7),
(43, 'Folio108', 14),
(49, 'Folio109', 2),
(2, 'Folio110', 6),
(11, 'Folio111', 9),
(21, 'Folio112', 13),
(30, 'Folio113', 4),
(40, 'Folio114', 11),
(50, 'Folio115', 1),
(6, 'Folio116', 5),
(16, 'Folio117', 10),
(26, 'Folio118', 3),
(36, 'Folio119', 8),
(46, 'Folio120', 12),
(1, 'Folio121', 15),
(7, 'Folio122', 7),
(13, 'Folio123', 14),
(19, 'Folio124', 2),
(25, 'Folio125', 6),
(31, 'Folio126', 9),
(37, 'Folio127', 13),
(43, 'Folio128', 4),
(49, 'Folio129', 11),
(2, 'Folio130', 1);