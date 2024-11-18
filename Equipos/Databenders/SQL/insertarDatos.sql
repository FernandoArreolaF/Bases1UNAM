-- Insertar datos en la tabla Paises
INSERT INTO Paises (Nombre) VALUES
('México'),
('Estados Unidos'),
('Canadá');

-- Insertar datos en la tabla Estados
INSERT INTO Estados (Nombre, PaisID) VALUES
('Ciudad de México', 1),
('Jalisco', 1),
('Nuevo León', 1),
('California', 2),
('Ontario', 3);

-- Insertar datos en la tabla Proveedores
INSERT INTO Proveedores (RazonSocial, Domicilio_Calle, Domicilio_Numero, Domicilio_Colonia, Domicilio_CodigoPostal, Domicilio_EstadoID, Nombre, RFC) VALUES
('Papeles Finos S.A. de C.V.', 'Av. Insurgentes', '1234', 'Col. Centro', '06000', 1, 'Papeles Finos', 'PAP123456789'),
('Suministros Escolares S.A.', 'Calle Juárez', '567', 'Col. Americana', '44160', 2, 'Suministros Escolares', 'SUM987654321'),
('Tecnología en Papel', 'Av. Universidad', '890', 'Col. Tecnológico', '64849', 3, 'Tecno Papel', 'TEC112233445');

-- Insertar datos en la tabla ProveedorTelefonos
INSERT INTO ProveedorTelefonos (ProveedorID, NumeroTelefono, TipoTelefono) VALUES
(1, '5551234567', 'Oficina'),
(1, '5557654321', 'Móvil'),
(2, '3312345678', 'Oficina'),
(3, '8187654321', 'Oficina');

-- Insertar datos en la tabla Empleados
INSERT INTO Empleados (Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, FechaIngreso) VALUES
('Juan', 'Pérez', 'López', '1990-05-15', '2020-01-10'),
('María', 'García', 'Hernández', '1985-08-22', '2018-03-05'),
('Carlos', 'Sánchez', 'Martínez', '1992-11-30', '2019-07-18');

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (Nombre, ApellidoPaterno, ApellidoMaterno, Domicilio_Calle, Domicilio_Numero, Domicilio_Colonia, Domicilio_CodigoPostal, Domicilio_EstadoID, Email, RFC) VALUES
('Ana', 'Ramírez', 'Torres', 'Calle Independencia', '456', 'Col. Revolución', '06400', 1, 'ana.ramirez@example.com', 'RAM123456789'),
('Luis', 'Fernández', 'Gómez', 'Av. Patria', '789', 'Col. Vallarta', '45010', 2, 'luis.fernandez@example.com', 'FER987654321'),
('Sofía', 'López', 'Díaz', 'Calle Hidalgo', '321', 'Col. Obispado', '64060', 3, 'sofia.lopez@example.com', 'LOP112233445');

-- Insertar datos en la tabla ClienteEmails
INSERT INTO ClienteEmails (ClienteID, Email) VALUES
(1, 'ana.ramirez@example.com'),
(1, 'aramirez@gmail.com'),
(2, 'luis.fernandez@example.com'),
(3, 'sofia.lopez@example.com');

-- Insertar datos en la tabla Categorias
INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Papelería', 'Artículos de oficina y escolares'),
('Regalos', 'Artículos para obsequiar en ocasiones especiales'),
('Impresiones', 'Servicios de impresión en diversos formatos'),
('Recargas', 'Venta de tiempo aire y servicios electrónicos');

-- Insertar datos en la tabla Productos
INSERT INTO Productos (CodigoBarras, Nombre, PrecioCompra, PrecioVenta, Foto, Stock, CantidadStock, CategoriaID, ProveedorID) VALUES
('7501001234567', 'Cuaderno Profesional', 20.00, 35.00, NULL, 100, 100, 1, 1),
('7502002345678', 'Pluma Bolígrafo Azul', 5.00, 10.00, NULL, 200, 200, 1, 2),
('7503003456789', 'Taza de Cerámica', 30.00, 60.00, NULL, 50, 50, 2, 3),
('7504004567890', 'Impresión a Color', 1.00, 2.50, NULL, 500, 500, 3, NULL),
('7505005678901', 'Recarga Telcel $100', 95.00, 100.00, NULL, 100, 100, 4, NULL);

-- Insertar datos en la tabla Ventas
INSERT INTO Ventas (Folio, FechaVenta, CantidadTotalPagar, EmpleadoID) VALUES
('VENT-001', '2023-10-01', 150.00, 1),
('VENT-002', '2023-10-02', 260.00, 2),
('VENT-003', '2023-10-03', 75.00, 3);

-- Insertar datos en la tabla DetalleVenta
INSERT INTO DetalleVenta (VentaID, ProductoID, CantidadProducto, PrecioTotalArticulo, ClienteID) VALUES
(1, 1, 2, 70.00, 1),
(1, 2, 5, 50.00, 1),
(1, 3, 1, 30.00, 1),
(2, 4, 100, 250.00, 2),
(2, 5, 1, 100.00, 2),
(3, 2, 5, 50.00, 3),
(3, 5, 1, 100.00, 3);


