--Proyecto Final BD Grupo 01
--Equipo CapitosDreamTeam
-- Autores:
--Alvarez Salgado Eduardo Antonio
--Lara Hernández Emmanuel
--Merida Serralde Francisco Jared
--Ponce de León Reyes Bruno
--Zepeda Aparicio Diego Arturo

--Código DML para la carga de registros iniciales

--- CATEGORIA
insert into CATEGORIA(nombreCategoria,descripcion) 
    values ('ENTRADA','Platillo para empezar'),
           ('PLATO_FUERTE','Platillo principal'),
           ('POSTRE','Platillo para el final'),
           ('BEBIDA_FRIA','Bebidas frescas'),
           ('BEBIDA_CALIENTE','Bebidas preparadas (cafés, chocolates,etc.)');

--- PRODUCTO
insert into PRODUCTO(nombreProducto, descripcion, receta, precio, cantidadDisponible, tipoProducto, nombreCategoria) 
    values ('Bruschetta Clásica', 'Pan tostado con tomate fresco, ajo, albahaca y aceite de oliva', 'Pan ciabatta, tomates, ajo, albahaca, aceite de oliva', 95.00, 12, 'PLATILLO', 'ENTRADA'),
           ('Carpaccio de Res', 'Láminas de filete de res con alcaparras, parmesano y arúgula', 'Filete de res, alcaparras, queso parmesano, aceite', 165.00, 10, 'PLATILLO', 'ENTRADA'),
           ('Lasaña Boloñesa', 'Capas de pasta con carne, salsa bechamel y queso gratinado', 'Láminas de pasta, carne molida, jitomate, bechamel, mozzarella', 195.00, 7, 'PLATILLO', 'PLATO_FUERTE'),
           ('Spaghetti alla Carbonara', 'Pasta tradicional con huevo, queso y pimienta', 'Spaghetti, huevo, queso pecorino romano, guanciale, pimienta', 170.00, 8, 'PLATILLO', 'PLATO_FUERTE'),
           ('Pizza Margherita', 'Salsa de tomate, mozzarella fresca y albahaca', 'Masa de pizza, salsa de tomate San Marzano, mozzarella, albahaca', 155.00, 9, 'PLATILLO', 'PLATO_FUERTE'),
           ('Tiramisú', 'Postre en capas de soletas, café y crema Mascarpone', 'Soletas, café, queso mascarpone, huevo, cacao', 90.00, 6, 'PLATILLO', 'POSTRE'),
           ('Panna Cotta de Frutos Rojos', 'Postre frío con dulce de fresas y frambuesas', 'Crema para batir, azúcar, grenetina, coulis de frutos rojos', 75.00, 11, 'PLATILLO', 'POSTRE'),
           ('Capuccino', 'Café espresso con leche y canela', 'Espresso, leche entera, canela', 55.00, 16, 'BEBIDA', 'BEBIDA_CALIENTE');

--- CLIENTE
insert into CLIENTE(rfc, nomPila, apPaterno, apMaterno, domEstado, domCodigoPostal, domColonia, domCalle, domNumero, fechaNacimiento, razonSocial, email) 
    values ('SAPA900115A10', 'Alejandro', 'Sánchez', 'Palacios', 'CDMX', '03100', 'Del Valle', 'Av. Coyoacán', '1024', '1990-01-15', 'Alejandro Sánchez Palacios', 'alejandro.san@mail.com'),
           ('GOMM851122B20', 'Mónica', 'Gómez', 'Mendoza', 'EdoMex', '53100', 'Satélite', 'Circuitos Actores', '45', '1985-11-22', 'Gómez y Asociados S.A.', 'monica.gomez@mail.com'),
           ('LORE930504C30', 'Eduardo', 'López', 'Ramírez', 'CDMX', '06700', 'Roma Norte', 'Alvaro Obregón', '88', '1993-05-04', 'Eduardo López Ramírez', 'eduardo.lop@mail.com'),
           ('FERF970812D40', 'Fernanda', 'Fernández', 'Flores', 'Jalisco', '44100', 'Americana', 'Av. Libertad', '310', '1997-08-12', 'Fernanda Fernández Flores', 'fer.flores@mail.com'),
           ('BIN051020TL4', 'Bienes', 'Raíces', 'Inmobiliarios', 'CDMX', '06600', 'Juárez', 'Paseo de la Reforma', '222', '2005-10-20', 'Bienes Inmobiliarios del Norte S.A. de C.V.', 'contacto@binorte.com');

--- EMPLEADO
insert into EMPLEADO(fechaNacimiento, rfc, nomPila, apPaterno, apMaterno, domEstado, domCodigoPostal, domColonia, domCalle, domNumero, sueldo, foto)
    values ('1992-03-10', 'HELR920310AA1', 'Roberto', 'Hernández', 'Luna', 'CDMX', '03100', 'Del Valle', 'Amores', '412', 16000.00, '\x00'),
           ('1995-07-22', 'GARM950722BB2', 'María', 'García', 'Moreno', 'CDMX', '06700', 'Roma Norte', 'Orizaba', '93', 11000.00, '\x00'),
           ('1988-11-05', 'PEAL881105CC3', 'Luis', 'Pérez', 'Alba', 'EdoMex', '53100', 'Satélite', 'Circuito Juristas', '14', 18500.00, '\x00'),
           ('1994-05-14', 'MORE940514DD4', 'Elena', 'Morales', 'Ríos', 'CDMX', '04000', 'Coyoacán', 'Malintzin', '205', 11000.00, '\x00'),
           ('1991-01-29', 'SARA910129EE5', 'Arturo', 'Sánchez', 'Rojas', 'CDMX', '01000', 'San Ángel', 'Juárez', '19', 14000.00, '\x00'),
           ('1996-08-18', 'CAST960818FF6', 'Tatiana', 'Castro', 'Solís', 'CDMX', '07000', 'Lindavista', 'Peten', '855', 12500.00, '\x00'),
           ('1993-12-01', 'NAVJ931201GG7', 'Juan', 'Navarro', 'Vargas', 'EdoMex', '54000', 'Tlalnepantla', 'Toltecas', '33', 11500.00, '\x00'),
           ('1995-02-15', 'LOMF950215KY2', 'Fernando', 'López', 'Martínez', 'CDMX', '09000', 'Iztapalapa', 'Ermita', '1105', 13500.00, '\x00');

--- TELEFONO_EMPLEADO
insert into TELEFONO_EMPLEADO(telefono,numeroEmpleado)
    values ('5512345678', 1),
           ('5523456789', 2),
           ('5534567890', 3),
           ('5545678901', 4),
           ('5556789012', 5),
           ('5567890123', 6),
           ('5578901234', 7),
           ('5511223344', 8);

--- DEPENDIENTE_EMPLEADO
insert into DEPENDIENTE_EMPLEADO(idDependiente,numeroEmpleado,curp,nomPila,apPaterno,apMaterno,parentesco)
    values (1, 1, 'HERR150420HDFLNR05', 'Raúl', 'Hernández', 'Gómez', 'HERMANO'),
           (1, 3, 'PERA120805MDFLNS01', 'Alicia', 'Pérez', 'Soto', 'HIJA'),
           (1, 5, 'SANF181123HDFRRN09', 'Francisco', 'Sánchez', 'Luna', 'HIJO'),
           (1, 2, 'GARM401201MDFRRN02', 'María', 'Moreno', 'Cruz', 'MADRE'),
           (1, 6, 'CASS210707HDFLSS03', 'Santiago', 'Castro', 'Díaz', 'HIJO'),
           (1, 4, 'MORL200228MDFRRS06', 'Lucía', 'Morales', 'Vega', 'HIJA'),
           (1, 8, 'LOPD190902HDFRNT08', 'Diego', 'López', 'Ruiz', 'HIJO'),
           (2, 8, 'LOPM220614MDFRNT01', 'Mía', 'López', 'Ruiz', 'HIJA');

--- TIPO_EMPLEADO
insert into TIPO_EMPLEADO(tipoEmpleado,numeroEmpleado)
    values ('COCINERO', 1),
           ('MESERO', 2),
           ('ADMINISTRATIVO', 3),
           ('MESERO', 4),
           ('COCINERO', 5),
           ('COCINERO', 6),
           ('MESERO', 7),
           ('COCINERO', 8),
           ('MESERO', 8);

--- COCINERO
insert into COCINERO(numeroEmpleado,especialidadCocinero)
    values (1, 'Cortes de carne'),
           (5, 'Salsas y guarniciones'),
           (6, 'Bollería'),
           (8, 'Entradas y Platos fuertes');

--- MESERO
insert into MESERO(numeroEmpleado,horaEntrada,horaSalida)
    values (2, '07:00:00', '15:00:00'),
           (4, '07:00:00', '15:00:00'),
           (7, '15:00:00', '23:00:00'),
           (8, '15:00:00', '23:00:00');

--- ADMINISTRATIVO
insert into ADMINISTRATIVO(numeroEmpleado,rolAdministrativo)
    values (3, 'Gerente_Compras');

--- ORDEN
insert into ORDEN(fechaOrden,numeroEmpleado)
    values ('2026-05-01 11:20:11', 2),
           ('2026-05-15 19:30:09', 4),
           ('2026-05-28 13:05:50', 7),
           ('2026-05-30 21:45:03', 2),
           ('2026-05-31 23:59:01', 8);

--- FACTURA
insert into FACTURA(fechaFactura,folio,idCliente)
    values ('2026-05-01 12:10:00', 'ORD-0001', 1),
           ('2026-05-15 20:45:00', 'ORD-0002', 2),
           ('2026-05-28 14:20:00', 'ORD-0003', 3),
           ('2026-05-30 22:30:00', 'ORD-0004', 4),
           ('2026-06-01 00:15:00', 'ORD-0005', 5);

--- DETALLE_ORDEN
insert into DETALLE_ORDEN(folio,idProducto,cantidad)
    values ('ORD-0001', 1, 2), -- 2 Bruschettas
           ('ORD-0001', 3, 1), -- 1 Lasaña Boloñesa
           ('ORD-0001', 8, 2), -- 2 Capuccinos
           ('ORD-0002', 2, 1), -- 1 Carpaccio de Res
           ('ORD-0002', 4, 2), -- 2 Spaghetti Carbonara
           ('ORD-0003', 5, 1), -- 1 Pizza Margherita
           ('ORD-0003', 6, 2), -- 2 Tiramisús
           ('ORD-0004', 3, 1), -- 1 Lasaña Boloñesa
           ('ORD-0004', 8, 1), -- 1 Capuccino
           ('ORD-0005', 4, 1), -- 1 Spaghetti Carbonara
           ('ORD-0005', 7, 2); -- 2 Panna Cottas