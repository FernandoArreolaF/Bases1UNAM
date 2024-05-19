--Función para agregar toda la información de empleados

CREATE OR REPLACE FUNCTION agregar_empleado(
    IN p_nom_empleado VARCHAR(50),
    IN p_apPat_empleado VARCHAR(50),
    IN p_apMat_empleado VARCHAR(50),
    IN p_fotografia BYTEA,
    IN p_calle_empleado VARCHAR(100),
    IN p_numero_empleado SMALLINT,
    IN p_sueldo INT,
    IN p_esAdmin BOOLEAN,
    IN p_rol VARCHAR(50),
    IN p_esCocinero BOOLEAN,
	IN p_especialidad VARCHAR(100),
	IN p_esMesero BOOLEAN,
	IN p_horario VARCHAR(400),
	IN p_rfc_empleado VARCHAR(13),
	IN p_fecha_nacimiento DATE,
	IN p_cp_empleado VARCHAR(5),
	IN p_colonia_empleado VARCHAR(100),
	IN p_edo_empleado VARCHAR(35),
	IN p_edad INT,
	IN p_telefono_empleado VARCHAR(15),
    OUT p_num_empleado INT
)
AS $$
BEGIN
    -- Insertar en la tabla Empleado
    INSERT INTO Empleado (nom_empleado,apPat_empleado,apMat_empleado,fotografia,calle_empleado,
	numero_empleado,sueldo,esAdmin,rol,esCocinero,especialidad,esMesero,horario)
    VALUES (p_nom_empleado,p_apPat_empleado,p_apMat_empleado,p_fotografia,p_calle_empleado,
	p_numero_empleado,p_sueldo,p_esAdmin,p_rol,p_esCocinero,p_especialidad,p_esMesero,p_horario)
    RETURNING num_empleado INTO p_num_empleado;

    -- Insertar en la tabla rfc_empleado
    INSERT INTO rfc_empleado (rfc_empleado,fechaNac_empleado,num_empleado)
    VALUES (p_rfc_empleado,p_fecha_nacimiento,p_num_empleado);

    -- Insertar en la tabla direccion_empleado
    INSERT INTO direccion_empleado (cp_empleado,colonia_empleado,edo_empleado,num_empleado)
    VALUES (p_cp_empleado,p_colonia_empleado,p_edo_empleado,p_num_empleado);

    -- Insertar en la tabla fecha_nacimiento_empleado
    INSERT INTO fecha_nacimiento_empleado (fecha_nacimiento,edad,num_empleado)
    VALUES(p_fecha_nacimiento,p_edad,p_num_empleado);

    -- Insertar en la tabla telefono_empleado
    INSERT INTO Telefono_Empleado (num_empleado,telefono_empleado)
    VALUES(p_num_empleado,p_telefono_empleado);

END;
$$ LANGUAGE plpgsql;

-- Inserción de datos a Empleado, rfc_empleado,direccion_empleado,fecha_nacimiento_empleado,telefono_empleado

SELECT agregar_empleado(
    'Axel'::varchar,                       -- nom_empleado
    'Aguilar'::varchar,                    -- apPat_empleado
    'Goicochea'::varchar,                  -- apMat_empleado
    '01000000'::bytea,            	   -- fotografia
    'Cerro de Chapultepec'::varchar,       -- calle_empleado
    304::smallint,                         -- numero_empleado
    10000,                        	   -- sueldo
    FALSE,                        	   -- esAdmin
    NULL::varchar,                         -- rol
    TRUE,                         	   -- esCocinero
    'Mariscos'::varchar,                   -- especialidad
    FALSE,                        	   -- esMesero
    NULL::varchar,                         -- horario
    'AUGA010903D6A'::varchar,              -- rfc_empleado
    '2001-09-03'::date,                    -- fechaNac_empleado
    '14370'::varchar,                      -- cp_empleado
    'Residencial Chimali'::varchar,        -- colonia_empleado
    'Ciudad de México'::varchar,           -- edo_empleado
    23,                          	   -- edad
    '5512452809'::varchar                  -- telefono_empleado
);

SELECT agregar_empleado(
    'Laura',                            -- nom_empleado
    'Gonzalez',                         -- apPat_empleado
    'Rodríguez',                        -- apMat_empleado
    '02000000'::bytea,                  -- fotografia
    'Avenida Universidad',              -- calle_empleado
    110::smallint,                      -- numero_empleado
    12000,                              -- sueldo
    FALSE,                              -- esAdmin
    NULL::varchar,                      -- rol
    FALSE,                              -- esCocinero
    NULL::varchar,                      -- especialidad
    TRUE,                               -- esMesero
    NULL::varchar,                      -- horario
    'LGZR010203D6A'::varchar,           -- rfc_empleado
    '1990-02-03'::date,                 -- fechaNac_empleado
    '03020'::varchar,                   -- cp_empleado
    'Narvarte'::varchar,                -- colonia_empleado
    'Ciudad de México'::varchar,        -- edo_empleado
    33,                                 -- edad
    '5523456789'::varchar               -- telefono_empleado
);


SELECT agregar_empleado(
    'Pedro',                              -- nom_empleado
    'Méndez',                             -- apPat_empleado
    'López',                              -- apMat_empleado
    '03000000'::bytea,                    -- fotografia
    'Eje Central',                        -- calle_empleado
    408::smallint,                        -- numero_empleado
    13000,                                -- sueldo
    TRUE,                                 -- esAdmin
    'Gerente'::varchar,                   -- rol
    FALSE,                                -- esCocinero
    NULL::varchar,                        -- especialidad
    FALSE,                                -- esMesero
    'Turno completo'::varchar,            -- horario
    'PMLZ050607HDF'::varchar,        -- rfc_empleado
    '1976-06-07'::date,                   -- fechaNac_empleado
    '03200'::varchar,                     -- cp_empleado
    'Centro'::varchar,                    -- colonia_empleado
    'Ciudad de México'::varchar,          -- edo_empleado
    47,                                   -- edad
    '5543219876'::varchar                 -- telefono_empleado
);

SELECT agregar_empleado(
    'Isabel',                             -- nom_empleado
    'Cortez',                             -- apPat_empleado
    'Navarro',                            -- apMat_empleado
    '04000000'::bytea,                    -- fotografia
    'Reforma',                            -- calle_empleado
    912::smallint,                        -- numero_empleado
    15000,                                -- sueldo
    FALSE,                                -- esAdmin
    'Chef'::varchar,                      -- rol
    TRUE,                                 -- esCocinero
    'Cocina internacional'::varchar,      -- especialidad
    FALSE,                                -- esMesero
    'Lunes a Viernes 9-17'::varchar,      -- horario
    '81200HDFNVR05'::varchar,        -- rfc_empleado
    '1980-12-08'::date,                   -- fechaNac_empleado
    '06500'::varchar,                     -- cp_empleado
    'Cuauhtémoc'::varchar,                -- colonia_empleado
    'Ciudad de México'::varchar,          -- edo_empleado
    43,                                   -- edad
    '5567890123'::varchar                 -- telefono_empleado
);

SELECT agregar_empleado(
    'Miguel',                             -- nom_empleado
    'Rivera',                             -- apPat_empleado
    'Santos',                             -- apMat_empleado
    '05000000'::bytea,                    -- fotografia
    'Paseo de la Reforma',                -- calle_empleado
    121::smallint,                        -- numero_empleado
    14000,                                -- sueldo
    FALSE,                                -- esAdmin
    NULL::varchar,                        -- rol
    FALSE,                                -- esCocinero
    NULL::varchar,                        -- especialidad
    TRUE,                                 -- esMesero
    'Fines de semana 12-24'::varchar,     -- horario
    'MRSZ930310HDF'::varchar,        -- rfc_empleado
    '1993-03-10'::date,                   -- fechaNac_empleado
    '06600'::varchar,                     -- cp_empleado
    'Juárez'::varchar,                    -- colonia_empleado
    'Ciudad de México'::varchar,          -- edo_empleado
    30,                                   -- edad
    '5587654321'::varchar                 -- telefono_empleado
);

SELECT agregar_empleado(
    'Andrea',                             -- nom_empleado
    'García',                             -- apPat_empleado
    'Luna',                               -- apMat_empleado
    '06000000'::bytea,                    -- fotografia
    'Av. Insurgentes',                    -- calle_empleado
    200::smallint,                        -- numero_empleado
    16000,                                -- sueldo
    FALSE,                                -- esAdmin
    NULL::varchar,                        -- rol
    TRUE,                                 -- esCocinero
    'Postres'::varchar,                   -- especialidad
    FALSE,                                -- esMesero
    NULL::varchar,                        -- horario
    'AGLL860526'::varchar,                -- rfc_empleado
    '1986-05-26'::date,                   -- fechaNac_empleado
    '03100'::varchar,                     -- cp_empleado
    'Condesa'::varchar,                   -- colonia_empleado
    'Ciudad de México'::varchar,          -- edo_empleado
    37,                                   -- edad
    '5512345678'::varchar                 -- telefono_empleado
);

SELECT agregar_empleado(
    'Ricardo',                            -- nom_empleado
    'Ramírez',                            -- apPat_empleado
    'Ortiz',                              -- apMat_empleado
    '07000000'::bytea,                    -- fotografia
    'Calle de la Amargura',               -- calle_empleado
    99::smallint,                         -- numero_empleado
    17000,                                -- sueldo
    FALSE,                                -- esAdmin
    NULL::varchar,                        -- rol
    FALSE,                                -- esCocinero
    NULL::varchar,                        -- especialidad
    TRUE,                                 -- esMesero
    'Noches 18-02'::varchar,              -- horario
    'RROZ920817'::varchar,                -- rfc_empleado
    '1992-08-17'::date,                   -- fechaNac_empleado
    '04000'::varchar,                     -- cp_empleado
    'Coyoacán'::varchar,                  -- colonia_empleado
    'Ciudad de México'::varchar,          -- edo_empleado
    31,                                   -- edad
    '5519876543'::varchar                 -- telefono_empleado
);

SELECT agregar_empleado(
    'Daniela',                            -- nom_empleado
    'Fernández',                          -- apPat_empleado
    'Hernández',                          -- apMat_empleado
    '08000000'::bytea,                    -- fotografia
    'Av. Patriotismo',                    -- calle_empleado
    450::smallint,                        -- numero_empleado
    18000,                                -- sueldo
    TRUE,                                 -- esAdmin
    'Subgerente'::varchar,                -- rol
    FALSE,                                -- esCocinero
    NULL::varchar,                        -- especialidad
    FALSE,                                -- esMesero
    'Lunes a Viernes 9-18'::varchar,      -- horario
    'DFHZ900101'::varchar,                -- rfc_empleado
    '1990-01-01'::date,                   -- fechaNac_empleado
    '05000'::varchar,                     -- cp_empleado
    'Mixcoac'::varchar,                   -- colonia_empleado
    'Ciudad de México'::varchar,          -- edo_empleado
    34,                                   -- edad
    '5598765432'::varchar                 -- telefono_empleado
);

SELECT agregar_empleado(
    'Luis',                               -- nom_empleado
    'Martínez',                           -- apPat_empleado
    'Gómez',                              -- apMat_empleado
    '09000000'::bytea,                    -- fotografia
    'Calzada de Tlalpan',                 -- calle_empleado
    800::smallint,                        -- numero_empleado
    14500,                                -- sueldo
    FALSE,                                -- esAdmin
    NULL::varchar,                        -- rol
    TRUE,                                 -- esCocinero
    'Mariscos'::varchar,                  -- especialidad
    FALSE,                                -- esMesero
    NULL::varchar,                        -- horario
    'LMGZ850101'::varchar,                -- rfc_empleado
    '1985-01-01'::date,                   -- fechaNac_empleado
    '04360'::varchar,                     -- cp_empleado
    'Villa Coapa'::varchar,               -- colonia_empleado
    'Ciudad de México'::varchar,          -- edo_empleado
    39,                                   -- edad
    '5534567890'::varchar                 -- telefono_empleado
);

SELECT agregar_empleado(
    'Sofía',                              -- nom_empleado
    'Díaz',                               -- apPat_empleado
    'Romero',                             -- apMat_empleado
    '10000000'::bytea,                    -- fotografia
    'Av. Revolución',                     -- calle_empleado
    300::smallint,                        -- numero_empleado
    15000,                                -- sueldo
    FALSE,                                -- esAdmin
    NULL::varchar,                        -- rol
    FALSE,                                -- esCocinero
    NULL::varchar,                        -- especialidad
    TRUE,                                 -- esMesero
    'Turno nocturno'::varchar,            -- horario
    'SDRZ900204'::varchar,                -- rfc_empleado
    '1990-02-04'::date,                   -- fechaNac_empleado
    '04470'::varchar,                     -- cp_empleado
    'San Ángel'::varchar,                 -- colonia_empleado
    'Ciudad de México'::varchar,          -- edo_empleado
    34,                                   -- edad
    '5541235678'::varchar                 -- telefono_empleado
);
select * from empleado;
---------------------------------------------------------------------------------------------------------
-- Inserción de datos a Cliente
INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES(
	'Alonso',
	'Hernández',
	'Morales',
	'Hexagon'
);
INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Carlos',
    'Domínguez',
    'Juárez',
    'CarDom SA de CV'
);

INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Ana',
    'Mendez',
    'Pérez',
    'AnaMP Company'
);

INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Beatriz',
    'Ramos',
    'García',
    'Ramos y Asociados'
);

INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Diego',
    'Martínez',
    'Sánchez',
    'Martínez Consulting'
);

INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Elena',
    'Gómez',
    'Hernández',
    'ElenaGH'
);

INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Fernando',
    'López',
    'Ortega',
    'López & Ortega'
);

INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Gabriela',
    'Vargas',
    'Nuñez',
    'Vargas Nuñez Corp'
);

INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Hugo',
    'Santos',
    'Reyes',
    'Santos Reyes Ltd'
);

INSERT INTO Cliente (
    nombre_clie,
    apPat_clie,
    apMat_clie,
    razonSocial
) VALUES (
    'Isabel',
    'Navarro',
    'Lara',
    'NavarroLara Inc'
);

select *from cliente;
-----------------------------------------------------------------------------------------------
-- Inserción de datos a Categoria
INSERT INTO Categoria (
    nombre_cat, 
    descripcion 
) VALUES(
	'Desayunos',
	'Platillos servidos entre las 7:00 y las 12:00'
);
INSERT INTO Categoria (
    nombre_cat, 
    descripcion 
) VALUES (
    'Comidas',
    'Platillos servidos entre las 13:00 y las 16:00'
);

INSERT INTO Categoria (
    nombre_cat, 
    descripcion 
) VALUES (
    'Cenas',
    'Platillos servidos entre las 19:00 y las 23:00'
);

INSERT INTO Categoria (
    nombre_cat, 
    descripcion 
) VALUES (
    'Bebidas',
    'Bebidas alcohólicas y no alcohólicas servidas durante todo el día'
);

SELECT* FROM CATEGORIA;
---------------------------------------------------------------------------------
-- Inserción de datos a Platillo
INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
	'Molletes',
	'1 bolillo con frijoles, queso manchego, cebolla, jitomate y chile picado',
	40.0,
	'1 bolillo con frijoles, queso manchego, cebolla, jitomate y chile picado',
	TRUE,
	'Platillo',
	1
);

INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
    'Huevos Rancheros',
    'Huevos fritos servidos sobre una tortilla de maíz y bañados en salsa roja',
    50.0,
    'Huevos fritos sobre una tortilla de maíz con salsa roja',
    TRUE,
    'Desayuno',
    1
);

INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
    'Chilaquiles',
    'Totopos bañados en salsa verde o roja, acompañados de pollo desmenuzado y crema',
    60.0,
    'Totopos en salsa verde o roja con pollo y crema',
    TRUE,
    'Desayuno',
    1
);

INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
    'Enchiladas Verdes',
    'Tortillas rellenas de pollo bañadas en salsa verde, acompañadas de crema y queso',
    80.0,
    'Tortillas rellenas de pollo con salsa verde, crema y queso',
    TRUE,
    'Comida',
    2
);

INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
    'Tacos al Pastor',
    'Tacos de carne al pastor con cebolla, cilantro y piña',
    50.0,
    'Tacos de carne al pastor con cebolla, cilantro y piña',
    TRUE,
    'Comida',
    2
);

INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
    'Pozole',
    'Caldo de maíz con carne de cerdo, lechuga, rábanos y orégano',
    70.0,
    'Caldo de maíz con carne de cerdo y verduras',
    TRUE,
    'Comida',
    2
);

INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
    'Sopes',
    'Tortilla gruesa de maíz con frijoles, carne, lechuga, crema y queso',
    45.0,
    'Tortilla gruesa con frijoles, carne, lechuga, crema y queso',
    TRUE,
    'Cena',
    3
);

INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
    'Tostadas',
    'Tortilla crujiente con frijoles, pollo, lechuga, crema y salsa',
    50.0,
    'Tortilla crujiente con frijoles, pollo, lechuga, crema y salsa',
    TRUE,
    'Cena',
    3
);



INSERT INTO Platillo (
    nombre_plat, 
    receta,
    precio, 
    descripcion, 
    disponibilidad, 
    tipo, 
    id_categoria 
) VALUES(
    'Agua de Horchata',
    'Bebida de arroz con canela y azúcar',
    20.0,
    'Bebida de arroz con canela y azúcar',
    TRUE,
    'Bebida',
    4
);
 select *from platillo;

---------------------------------------------------------------------------

-- Inserción de datos a Orden
CREATE OR REPLACE FUNCTION agregar_orden(
    IN p_folio VARCHAR(255),
    IN p_num_empleado INT,
	IN p_id_platillo INT,
    IN p_cantidadPorProducto SMALLINT
)
RETURNS VOID
AS $$
BEGIN
    -- Insertar en la tabla Orden
    INSERT INTO Orden (folio, fecha_orden, num_empleado)
    VALUES (p_folio, DATE_TRUNC('day', CURRENT_TIMESTAMP), p_num_empleado);
	
    -- Insertar en la tabla Orden_Platillo
    INSERT INTO Orden_Platillo (folio, id_platillo, cantidadPorProducto)
    VALUES (p_folio, p_id_platillo, p_cantidadPorProducto);

	UPDATE Orden SET total =0;
END;
$$ LANGUAGE plpgsql;

-- Inserción de datos a Orden, Orden_Platillo
-- Inserción de órdenes usando la función agregar_orden
SELECT agregar_orden(
    'ORD-001'::varchar,  -- folio
    1,                   -- num_empleado
    1,                   -- id_platillo
    2::smallint          -- cantidadPorProducto
);

SELECT agregar_orden(
    'ORD-002'::varchar,  -- folio
    2,                   -- num_empleado
    2,                   -- id_platillo
    3::smallint          -- cantidadPorProducto
);

SELECT agregar_orden(
    'ORD-003'::varchar,  -- folio
    3,                   -- num_empleado
    3,                   -- id_platillo
    1::smallint          -- cantidadPorProducto
);

SELECT agregar_orden(
    'ORD-004'::varchar,  -- folio
    4,                   -- num_empleado
    4,                   -- id_platillo
    4::smallint          -- cantidadPorProducto
);

SELECT agregar_orden(
    'ORD-005'::varchar,  -- folio
    5,                   -- num_empleado
    5,                   -- id_platillo
    2::smallint          -- cantidadPorProducto
);

SELECT * FROM ORDEN;
-----------------------------------------------------------------------------------------------------
--Función para agregar toda la información de facturas

CREATE OR REPLACE FUNCTION agregar_factura(
    IN p_id_cliente INT,
    IN p_numero_factura INT,
    IN p_email VARCHAR(30),
    IN p_folioOrden VARCHAR(255),
    IN p_rfc VARCHAR(13),
    IN p_cp_factura VARCHAR(10),
    IN p_colonia_factura VARCHAR(50),
    IN p_edo_factura VARCHAR(50),
    IN p_calle_factura VARCHAR(100),
    IN p_fecha_nacimiento DATE,
    OUT p_id_factura INT
)
AS $$
BEGIN
    -- Insertar en la tabla Factura
    INSERT INTO Factura (id_cliente, numero_factura, email, folioorden, rfc)
    VALUES (p_id_cliente, p_numero_factura, p_email, p_folioOrden, p_rfc)
    RETURNING id_factura INTO p_id_factura;

    -- Insertar en la tabla Direccion_Factura
    INSERT INTO Direccion_Factura (cp_factura, colonia_factura, edo_factura, calle_factura, id_factura, id_cliente)
    VALUES (p_cp_factura, p_colonia_factura, p_edo_factura, p_calle_factura, p_id_factura, p_id_cliente);

    -- Insertar en la tabla Fecha_Nac_Factura
    INSERT INTO Fecha_Nac_Factura (fecha_nacimiento, id_factura, id_cliente)
    VALUES (p_fecha_nacimiento, p_id_factura, p_id_cliente);
END;
$$ LANGUAGE plpgsql;

-- Inserción de datos a Factura,Direccion_Factura,Fecha_Nac_Factura
-- Inserción de facturas usando la función agregar_factura

SELECT agregar_factura(
    1,                 -- id_cliente
    1001,              -- numero_factura
    'cliente1@email.com', -- email
    'ORD-001',         -- folioOrden
    '1234567891A',     -- rfc
    '12345',           -- cp_factura
    'Centro',          -- colonia_factura
    'Estado',          -- edo_factura
    'Calle Principal', -- calle_factura
    '1990-05-17'::date -- fecha_nacimiento
);

SELECT agregar_factura(
    2,                 -- id_cliente
    1002,              -- numero_factura
    'cliente2@email.com', -- email
    'ORD-002',         -- folioOrden
    '2345678901B',     -- rfc
    '23456',           -- cp_factura
    'Norte',           -- colonia_factura
    'Estado',          -- edo_factura
    'Avenida Secundaria', -- calle_factura
    '1985-04-12'::date -- fecha_nacimiento
);

SELECT agregar_factura(
    3,                 -- id_cliente
    1003,              -- numero_factura
    'cliente3@email.com', -- email
    'ORD-003',         -- folioOrden
    '3456789012C',     -- rfc
    '34567',           -- cp_factura
    'Sur',             -- colonia_factura
    'Estado',          -- edo_factura
    'Calle Terciaria', -- calle_factura
    '1980-08-23'::date -- fecha_nacimiento
);

SELECT agregar_factura(
    4,                 -- id_cliente
    1004,              -- numero_factura
    'cliente4@email.com', -- email
    'ORD-004',         -- folioOrden
    '4567890123D',     -- rfc
    '45678',           -- cp_factura
    'Este',            -- colonia_factura
    'Estado',          -- edo_factura
    'Calle Cuarta',    -- calle_factura
    '1995-11-05'::date -- fecha_nacimiento
);

SELECT agregar_factura(
    5,                 -- id_cliente
    1005,              -- numero_factura
    'cliente5@email.com', -- email
    'ORD-005',         -- folioOrden
    '5678901234E',     -- rfc
    '56789',           -- cp_factura
    'Oeste',           -- colonia_factura
    'Estado',          -- edo_factura
    'Avenida Quinta',  -- calle_factura
    '1975-01-30'::date -- fecha_nacimiento
);

SELECT * FROM FACTURA;
---------------------------------------------------------------


-- Inserción de datos a Dependiente
INSERT INTO Dependiente (
    curp_D,
    num_empleado,
    nombre_dep,
    apPat_dep,
    apMat_dep,
    parentesco
) VALUES (
    'SASO221109HDFNNSA0',
    4,
    'Oscar',
    'Sánchez',
    'Santos',
    'Hijo'
);

INSERT INTO Dependiente (
    curp_D,
    num_empleado,
    nombre_dep,
    apPat_dep,
    apMat_dep,
    parentesco
) VALUES (
    'JMGR150923HDFLRS01',
    1,
    'Jorge',
    'Martínez',
    'Gómez',
    'Hijo'
);

INSERT INTO Dependiente (
    curp_D,
    num_empleado,
    nombre_dep,
    apPat_dep,
    apMat_dep,
    parentesco
) VALUES (
    'LMTR110506HDFRZA02',
    2,
    'Luisa',
    'Morales',
    'Torres',
    'Hija'
);

INSERT INTO Dependiente (
    curp_D,
    num_empleado,
    nombre_dep,
    apPat_dep,
    apMat_dep,
    parentesco
) VALUES (
    'AGRZ080701HDFRRT03',
    3,
    'Ana',
    'García',
    'Ramírez',
    'Hija'
);

INSERT INTO Dependiente (
    curp_D,
    num_empleado,
    nombre_dep,
    apPat_dep,
    apMat_dep,
    parentesco
) VALUES (
    'BZLT050815HDFLRS04',
    5,
    'Beatriz',
    'Zamora',
    'López',
    'Esposa'
);

INSERT INTO Dependiente (
    curp_D,
    num_empleado,
    nombre_dep,
    apPat_dep,
    apMat_dep,
    parentesco
) VALUES (
    'MNRZ140201HDFLRS05',
    6,
    'Manuel',
    'Nuñez',
    'Ramírez',
    'Hijo'
);

