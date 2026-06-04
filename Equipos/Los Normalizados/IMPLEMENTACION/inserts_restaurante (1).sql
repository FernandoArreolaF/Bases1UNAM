/* ============================================================
   INSERTS ADAPTADOS - RESTAURANTE CON MENÚ OLIVE GARDEN
   Base: DDL PostgreSQL Restaurante
   Ejecutar DESPUÉS de crear las tablas.
   ============================================================ */

BEGIN;

/* ============================================================
   1) EMPLEADOS
   Pilotos de F1 usados como empleados del restaurante.
   ============================================================ */

INSERT INTO empleado
(num_empleado, nombre, ap_pat, ap_mat, edad, rfc, calle, numero, colonia, cp, estado, sueldo, fecha_nac, foto)
VALUES
(1,  'Max',      'Verstappen', 'Racing', 28, 'VER970930MX1', 'Pista1', '1',  'Montecarlo',       '01001', 'CDMX', 52000.00, '1997-09-30', 'max_verstappen.jpg'),
(2,  'Lando',    'Norris',     'McLaren',26, 'NOR991113MX2', 'Pista2', '4',  'Del Valle',        '03100', 'CDMX', 48000.00, '1999-11-13', 'lando_norris.jpg'),
(3,  'Oscar',    'Piastri',    'McLaren',25, 'PIA010406MX3', 'Pista3', '81', 'Narvarte',         '03020', 'CDMX', 47000.00, '2001-04-06', 'oscar_piastri.jpg'),
(4,  'Charles',  'Leclerc',    'Ferrari',28, 'LEC971016MX4', 'Pista4', '16', 'Roma Norte',       '06700', 'CDMX', 50000.00, '1997-10-16', 'charles_leclerc.jpg'),
(5,  'Lewis',    'Hamilton',   'Ferrari',41, 'HAM850107MX5', 'Pista5', '44', 'Polanco',          '11550', 'CDMX', 61000.00, '1985-01-07', 'lewis_hamilton.jpg'),
(6,  'George',   'Russell',    'Mercedes',28,'RUS980215MX6', 'Pista6', '63', 'Condesa',          '06140', 'CDMX', 49000.00, '1998-02-15', 'george_russell.jpg'),
(7,  'Kimi',     'Antonelli',  'Mercedes',19,'ANT060825MX7', 'Pista7', '12', 'Coyoacan',         '04030', 'CDMX', 39000.00, '2006-08-25', 'kimi_antonelli.jpg'),
(8,  'Fernando', 'Alonso',     'Aston',  44, 'ALO810729MX8', 'Pista8', '14', 'SanAngel',         '01000', 'CDMX', 56000.00, '1981-07-29', 'fernando_alonso.jpg'),
(9,  'Lance',    'Stroll',     'Aston',  27, 'STR981029MX9', 'Pista9', '18', 'Nápoles',          '03810', 'CDMX', 38000.00, '1998-10-29', 'lance_stroll.jpg'),
(10, 'Carlos',   'Sainz',      'Williams',31,'SAI940901MX0', 'Recta1', '55', 'Mixcoac',          '03930', 'CDMX', 46000.00, '1994-09-01', 'carlos_sainz.jpg'),
(11, 'Alexander','Albon',      'Williams',30,'ALB960323MX1', 'Recta2', '23', 'Tacuba',           '11410', 'CDMX', 43000.00, '1996-03-23', 'alex_albon.jpg'),
(12, 'Pierre',   'Gasly',      'Alpine', 30, 'GAS960207MX2', 'Recta3', '10', 'Coapa',            '04980', 'CDMX', 44000.00, '1996-02-07', 'pierre_gasly.jpg'),
(13, 'Franco',   'Colapinto',  'Alpine', 23, 'COL030527MX3', 'Recta4', '43', 'Juárez',           '06600', 'CDMX', 37000.00, '2003-05-27', 'franco_colapinto.jpg'),
(14, 'Esteban',  'Ocon',       'Haas',   29, 'OCO960917MX4', 'Recta5', '31', 'Portales',         '03300', 'CDMX', 42000.00, '1996-09-17', 'esteban_ocon.jpg'),
(15, 'Oliver',   'Bearman',    'Haas',   21, 'BEA050508MX5', 'Recta6', '87', 'Doctores',         '06720', 'CDMX', 36000.00, '2005-05-08', 'oliver_bearman.jpg'),
(16, 'Nico',     'Hulkenberg', 'Audi',   38, 'HUL870819MX6', 'Recta7', '27', 'Anzures',          '11590', 'CDMX', 45000.00, '1987-08-19', 'nico_hulkenberg.jpg'),
(17, 'Gabriel',  'Bortoleto',  'Audi',   21, 'BOR041014MX7', 'Recta8', '5',  'Guerrero',         '06300', 'CDMX', 36000.00, '2004-10-14', 'gabriel_bortoleto.jpg'),
(18, 'Liam',     'Lawson',     'Bulls',  24, 'LAW020211MX8', 'Curva1', '30', 'Escandón',         '11800', 'CDMX', 37000.00, '2002-02-11', 'liam_lawson.jpg'),
(19, 'Arvid',    'Lindblad',   'Bulls',  18, 'LIN070808MX9', 'Curva2', '41', 'Industrial',       '07800', 'CDMX', 34000.00, '2007-08-08', 'arvid_lindblad.jpg'),
(20, 'Isack',    'Hadjar',     'RedBull',21, 'HAD040928MX0', 'Curva3', '6',  'Centro',           '06000', 'CDMX', 38000.00, '2004-09-28', 'isack_hadjar.jpg'),
(21, 'Sergio',   'Perez',      'Cadillac',36,'PER900126MX1', 'Curva4', '11', 'SantaFe',          '01210', 'CDMX', 47000.00, '1990-01-26', 'sergio_perez.jpg'),
(22, 'Valtteri', 'Bottas',     'Cadillac',36,'BOT890828MX2', 'Curva5', '77', 'Lindavista',       '07300', 'CDMX', 45000.00, '1989-08-28', 'valtteri_bottas.jpg');

/* ============================================================
   2) TELÉFONOS DE EMPLEADOS
   ============================================================ */

INSERT INTO telefono_empleado (num_empleado, telefono) VALUES
(1,'5551000001'), (2,'5551000002'), (3,'5551000003'), (4,'5551000004'),
(5,'5551000005'), (6,'5551000006'), (7,'5551000007'), (8,'5551000008'),
(9,'5551000009'), (10,'5551000010'), (11,'5551000011'), (12,'5551000012'),
(13,'5551000013'), (14,'5551000014'), (15,'5551000015'), (16,'5551000016'),
(17,'5551000017'), (18,'5551000018'), (19,'5551000019'), (20,'5551000020'),
(21,'5551000021'), (22,'5551000022');

/* ============================================================
   3) SUBTIPOS DE EMPLEADO
   Especialización parcial y traslapada.
   Se dividen los pilotos entre meseros, cocineros y administrativos y 
   algunos se repiten para mostrar traslape.
   ============================================================ */

-------1. Registro de los meseros
INSERT INTO mesero (num_empleado) VALUES
(1),(2),(3),(4),(5),(6),(7),(21);

-- 2. Asignación de horarios estructurados
INSERT INTO horario_mesero (num_empleado, dia_semana, hora_inicio, hora_fin) VALUES
-- Mesero 1: Lunes a viernes 09:00-17:00
(1, 'Lunes',     '09:00:00', '17:00:00'),
(1, 'Martes',    '09:00:00', '17:00:00'),
(1, 'Miércoles', '09:00:00', '17:00:00'),
(1, 'Jueves',    '09:00:00', '17:00:00'),
(1, 'Viernes',   '09:00:00', '17:00:00'),

-- Mesero 2: Lunes a viernes 12:00-20:00
(2, 'Lunes',     '12:00:00', '20:00:00'),
(2, 'Martes',    '12:00:00', '20:00:00'),
(2, 'Miércoles', '12:00:00', '20:00:00'),
(2, 'Jueves',    '12:00:00', '20:00:00'),
(2, 'Viernes',   '12:00:00', '20:00:00'),

-- Mesero 3: Martes a sábado 13:00-21:00
(3, 'Martes',    '13:00:00', '21:00:00'),
(3, 'Miércoles', '13:00:00', '21:00:00'),
(3, 'Jueves',    '13:00:00', '21:00:00'),
(3, 'Viernes',   '13:00:00', '21:00:00'),
(3, 'Sábado',    '13:00:00', '21:00:00'),

-- Mesero 4: Miércoles a domingo 14:00-22:00
(4, 'Miércoles', '14:00:00', '22:00:00'),
(4, 'Jueves',    '14:00:00', '22:00:00'),
(4, 'Viernes',   '14:00:00', '22:00:00'),
(4, 'Sábado',    '14:00:00', '22:00:00'),
(4, 'Domingo',   '14:00:00', '22:00:00'),

-- Mesero 5: Fines de semana 10:00-18:00
(5, 'Sábado',    '10:00:00', '18:00:00'),
(5, 'Domingo',   '10:00:00', '18:00:00'),

-- Mesero 6: Lunes a sábado 11:00-19:00
(6, 'Lunes',     '11:00:00', '19:00:00'),
(6, 'Martes',    '11:00:00', '19:00:00'),
(6, 'Miércoles', '11:00:00', '19:00:00'),
(6, 'Jueves',    '11:00:00', '19:00:00'),
(6, 'Viernes',   '11:00:00', '19:00:00'),
(6, 'Sábado',    '11:00:00', '19:00:00'),

-- Mesero 7: Medio tiempo 16:00-22:00 (Asumido L-V)
(7, 'Lunes',     '16:00:00', '22:00:00'),
(7, 'Martes',    '16:00:00', '22:00:00'),
(7, 'Miércoles', '16:00:00', '22:00:00'),
(7, 'Jueves',    '16:00:00', '22:00:00'),
(7, 'Viernes',   '16:00:00', '22:00:00'),

-- Mesero 21: Turno especial 18:00-23:00 (Asumido fines de semana)
(21, 'Viernes',  '18:00:00', '23:00:00'),
(21, 'Sábado',   '18:00:00', '23:00:00'),
(21, 'Domingo',  '18:00:00', '23:00:00');

INSERT INTO cocinero (num_empleado, especialidad) VALUES
(8,  'Pastas Alfredo'),
(9,  'Antipasti'),
(10, 'Pizzas'),
(11, 'Postres'),
(12, 'Sopas e insalatas'),
(13, 'Bebidas y café'),
(14, 'Carnes y pollo'),
(15, 'Mariscos'),
(5,  'Platillos premium');

INSERT INTO administrativo (num_empleado, rol) VALUES
(16, 'Gerente general'),
(17, 'Control de caja'),
(18, 'Inventario'),
(19, 'Recursos humanos'),
(20, 'Compras'),
(21, 'Relación con clientes'),
(22, 'Facturación'),
(8,  'Supervisor de cocina');

/* ============================================================
   4) DEPENDIENTES
   ============================================================ */


INSERT INTO dependiente (num_empleado, id_dependiente, nombre, ap_pat, parentesco, curp) VALUES
(1,  1, 'Victoria', 'Verstappen', 'Hermana', 'VEVI010101MDFRRR01'),
(2,  1, 'Adam',     'Norris',     'Padre',   'NOAD010101HDFRRR02'),
(5,  1, 'Roscoe',   'Hamilton',   'Mascota', 'HARA010101HDFRRR03'),
(8,  1, 'Lorena',   'Alonso',     'Hermana', 'ALLO010101MDFRRR04'),
(21, 1, 'Antonio',  'Pérez',      'Padre',   'PEAT010101HDFRRR05');


/* ============================================================
   5) CLIENTES
   ============================================================ */

-- Primero: Registramos los datos generales en la tabla CLIENTE
INSERT INTO cliente
(id_cliente, rfc, email, calle, numero, colonia, cp, estado, tipo_cliente)
VALUES
(1,  'AULE010101MX1', 'ericka.aguilar@example.com',        'Av Universidad', '100', 'Copilco',      '04360', 'CDMX', 'FISICA'),
(2,  'BARE010101MX2', 'sofia.bautista@example.com',        'Insurgentes',    '200', 'Del Valle',    '03100', 'CDMX', 'FISICA'),
(3,  'BEFL010101MX3', 'jose.bermejo@example.com',          'Reforma',        '300', 'Juárez',       '06600', 'CDMX', 'FISICA'),
(4,  'CRBA010101MX4', 'ximena.cruz@example.com',           'Pilares',        '400', 'Narvarte',     '03020', 'CDMX', 'FISICA'),
(5,  'JAMA010101MX5', 'rodrigo.jardon@example.com',        'Chiapas',        '500', 'Roma Norte',   '06700', 'CDMX', 'FISICA'),
(6,  'PAFE010101MX6', 'hector.parra@example.com',          'Puebla',         '600', 'Condesa',      '06140', 'CDMX', 'FISICA'),
(7,  'VIOT010101MX7', 'teodora.villavicencio@example.com', 'Palmas',         '700', 'Polanco',      '11550', 'CDMX', 'FISICA'),
(8,  'GOLO010101MX8', 'maria.gomez@example.com',           'Madero',         '80',  'Centro',       '06000', 'CDMX', 'FISICA'),
(9,  'MASA010101MX9', 'diego.martinez@example.com',        'Bolívar',        '90',  'Obrera',       '06800', 'CDMX', 'FISICA'),
(10, 'HERI010101MX0', 'valeria.hernandez@example.com',     'Sonora',         '10',  'Roma Sur',     '06760', 'CDMX', 'FISICA'),
(11, 'TONA010101MX1', 'camila.torres@example.com',         'Morelos',        '11',  'Coyoacán',     '04030', 'CDMX', 'FISICA'),
(12, 'RUCA010101MX2', 'emiliano.ruiz@example.com',         'Acoxpa',         '12',  'Coapa',        '04980', 'CDMX', 'FISICA'),
(13, 'ORVE010101MX3', 'natalia.ortega@example.com',        'Homero',         '13',  'Polanco',      '11550', 'CDMX', 'FISICA'),
(14, 'LUPE010101MX4', 'andres.luna@example.com',           'Yucatán',        '14',  'Roma Norte',   '06700', 'CDMX', 'FISICA'),
(15, 'SAMO010101MX5', 'regina.salazar@example.com',        'Amsterdam',      '15',  'Hipódromo',    '06100', 'CDMX', 'FISICA'),
(16, 'RBR100101RB1', 'facturacion@redbullracing.com', 'Circuito Gral', '1',    'Polanco',  '11550', 'CDMX', 'MORAL'),
(17, 'SFE200202SF2', 'pagos@ferrari.com',             'Maranello',     '27',   'Lomas',    '11000', 'CDMX', 'MORAL'),
(18, 'MCL300303MC3', 'contacto@mclaren.com',          'Woking',        '4',    'Santa Fe', '01210', 'CDMX', 'MORAL'),
(19, 'NEO400404ND4', 'finanzas@neon.tech',            'Cloud Server',  '54',   'Condesa',  '06140', 'CDMX', 'MORAL'),
(20, 'UNA500505UN5', 'rectoria@unam.mx',              'Av Universidad','3000', 'Copilco',  '04510', 'CDMX', 'MORAL');

-- Segundo: Registramos los datos específicos en PERSONA_FISICA
INSERT INTO persona_fisica 
(id_cliente, nombre, ap_pat, ap_mat, fecha_nac)
VALUES
(1,  'Ericka',          'Aguilar',       'Lara',       '2001-01-01'),
(2,  'Sofía',           'Bautista',      'Reyes',      '2001-02-02'),
(3,  'José Tristán',    'Bermejo',       'Flores',     '2001-03-03'),
(4,  'Ximena Carolina', 'Cruz',          'Basilio',    '2001-04-04'),
(5,  'Rodrigo',         'Jardón',        'Marín',      '2001-05-05'),
(6,  'Héctor Emilio',   'Parra',         'Fernández',  '2001-06-06'),
(7,  'Teodora Vicenta', 'Villavicencio', 'Oraverás',   '1988-07-07'),
(8,  'María Fernanda',  'Gómez',         'López',      '1999-08-08'),
(9,  'Diego',           'Martínez',      'Santos',     '1998-09-09'),
(10, 'Valeria',         'Hernández',     'Ríos',       '2000-10-10'),
(11, 'Camila',          'Torres',        'Nava',       '1997-11-11'),
(12, 'Emiliano',        'Ruiz',          'Castro',     '1996-12-12'),
(13, 'Natalia',         'Ortega',        'Vega',       '2002-01-13'),
(14, 'Andrés',          'Luna',          'Paredes',    '1995-02-14'),
(15, 'Regina',          'Salazar',       'Mora',       '1994-03-15');


-- Tercero: Insertar los datos específicos en PERSONA_MORAL
-- Usamos exactamente los mismos IDs que acabamos de registrar arriba
INSERT INTO persona_moral 
(id_cliente, razon_social) 
VALUES
(16, 'Red Bull Racing S.A. de C.V.'),
(17, 'Scuderia Ferrari S.A.B. de C.V.'),
(18, 'McLaren Racing Limited S.A.'),
(19, 'Neon Databases México S. de R.L.'),
(20, 'Universidad Nacional Autónoma de México');
/* ============================================================
   6) CATEGORÍAS DEL MENÚ
   ============================================================ */

INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES
(1,  'Antipasti',        'Entradas para compartir'),
(2,  'Soups & Insalatta','Sopas recién hechas y ensaladas'),
(3,  'Cucina Classica',  'Pastas, pollo, carne y platillos clásicos'),
(4,  'OG Favorites',     'Favoritos de la casa'),
(5,  'Amazing Alfredos', 'Platillos con salsa Alfredo'),
(6,  'Postres',          'Postres italianos y pasteles'),
(7,  'Bebidas sin alcohol','Jugos, refrescos, limonadas y aguas'),
(8,  'Café',             'Café frío y caliente'),
(9,  'Coctelería',       'Cocteles con y sin alcohol'),
(10, 'Cervezas',         'Cervezas nacionales, premium y sin alcohol'),
(11, 'Vinos',            'Vinos por copa o botella');

/* ============================================================
   7) PRODUCTOS DEL MENÚ
   tipo_producto: PLATILLO o BEBIDA
   ============================================================ */

INSERT INTO producto
(id_producto, id_categoria, nombre, descripcion, receta, precio, disponibilidad, tipo_producto)
VALUES
(1,  1, 'Lasagna Fritta con Carne', 'Láminas de lasagna empanizadas con parmesano, salsa Alfredo y bolognese.', 'Freír lasagna, montar con Alfredo y bolognese.', 295.00, TRUE, 'PLATILLO'),
(2,  1, 'Fonduta di Mozzarella Ahumada de Espinaca', 'Queso mozzarella ahumado horneado con quesos italianos y espinaca.', 'Hornear mezcla de quesos y servir con pan toscano.', 299.00, TRUE, 'PLATILLO'),
(3,  1, 'Bocados di Risotto', 'Bocados de arroz con queso empanizados y salsa marinara.', 'Empanizar risotto y freír.', 230.00, TRUE, 'PLATILLO'),
(4,  1, 'Ravioles Frittos', 'Ravioles de queso y espinaca fritos con salsa marinara.', 'Freír ravioles y acompañar con marinara.', 199.00, TRUE, 'PLATILLO'),
(5,  1, 'Calamares Frittos', 'Calamares fritos con salsa marinara y aderezo ranch.', 'Empanizar calamares y freír.', 299.00, TRUE, 'PLATILLO'),
(6,  1, 'Pizza Pepperoni', 'Pizza tradicional con pepperoni y quesos italianos.', 'Hornear masa con salsa, queso y pepperoni.', 215.00, TRUE, 'PLATILLO'),
(7,  1, 'Shrimp Fritto Misto', 'Camarones con pimientos y cebolla empanizados.', 'Empanizar y freír camarones con verduras.', 305.00, TRUE, 'PLATILLO'),
(8,  2, 'Insalata della Casa', 'Ensalada con lechugas mixtas, aceitunas, jitomate, cebolla y crutones.', 'Mezclar vegetales y aderezo italiano.', 195.00, TRUE, 'PLATILLO'),
(9,  2, 'Zuppa Minestrone', 'Sopa vegetariana con vegetales, frijoles y pasta.', 'Cocer vegetales y pasta en caldo de jitomate.', 159.00, TRUE, 'PLATILLO'),
(10, 2, 'Pollo & Gnocchi', 'Sopa cremosa con pollo, pasta gnocchi y espinaca.', 'Preparar caldo cremoso con pollo y gnocchi.', 159.00, TRUE, 'PLATILLO'),
(11, 3, 'Pasta Five Cheese', 'Pasta penne con salsa de cinco quesos y jitomate.', 'Cocer pasta y bañar en salsa five cheese.', 225.00, TRUE, 'PLATILLO'),
(12, 3, 'Pasta Carbonara', 'Spaghetti con salsa cremosa de parmesano, pancetta y pimientos.', 'Cocer pasta y mezclar con carbonara.', 259.00, TRUE, 'PLATILLO'),
(13, 3, 'Spaghetti Bolognesa con Albóndigas', 'Spaghetti con salsa de carne y albóndigas.', 'Servir spaghetti con bolognesa y albóndigas.', 265.00, TRUE, 'PLATILLO'),
(14, 3, 'Ravioli di Formaggio', 'Ravioles rellenos de queso con salsa marinara o carne.', 'Cocer ravioles y gratinar con quesos.', 295.00, TRUE, 'PLATILLO'),
(15, 3, 'Lasagna Classica Grande', 'Capas de pasta con salsa de carne y quesos italianos.', 'Hornear capas de pasta, carne y quesos.', 365.00, TRUE, 'PLATILLO'),
(16, 4, 'Giro d Italia', 'Lasagna, pollo parmigiana y fettuccine Alfredo.', 'Montar los tres clásicos de Italia.', 425.00, TRUE, 'PLATILLO'),
(17, 4, 'Chicken & Shrimp Carbonara', 'Carbonara con pollo y camarón servida con spaghetti.', 'Preparar carbonara con proteínas.', 445.00, TRUE, 'PLATILLO'),
(18, 4, 'Frutti di Mare', 'Camarones, almejas y mejillones en salsa di mare con spaghetti.', 'Preparar mariscos con salsa di mare.', 385.00, TRUE, 'PLATILLO'),
(19, 5, 'Fettuccine Alfredo Piccante', 'Fettuccine con salsa Alfredo picante.', 'Cocer fettuccine y mezclar con Alfredo piccante.', 230.00, TRUE, 'PLATILLO'),
(20, 5, 'Fettuccine Alfredo con Brócoli', 'Fettuccine Alfredo acompañado con brócoli sazonado.', 'Cocer pasta y brócoli, agregar Alfredo.', 254.00, TRUE, 'PLATILLO'),
(21, 5, 'Seafood Alfredo', 'Salsa Alfredo con camarones y almejas sobre fettuccine.', 'Preparar mariscos y pasta con Alfredo.', 415.00, TRUE, 'PLATILLO'),
(22, 6, 'Panna Cotta', 'Postre de crema cocida sabor vainilla con salsa de fresa.', 'Refrigerar crema cocida y servir con salsa.', 169.00, TRUE, 'PLATILLO'),
(23, 6, 'Chocolate Lasagna', 'Postre en capas con queso crema y chocolate.', 'Montar capas dulces y refrigerar.', 209.00, TRUE, 'PLATILLO'),
(24, 6, 'Tiramisú', 'Postre de mascarpone con soletas humedecidas en café.', 'Montar capas de mascarpone, café y cocoa.', 199.00, TRUE, 'PLATILLO'),
(25, 7, 'Jugo de Fruta', 'Jugo de manzana, naranja, piña, arándano o uva.', NULL, 58.00, TRUE, 'BEBIDA'),
(26, 7, 'Té Helado Refill', 'Té negro frío con refill personal.', NULL, 65.00, TRUE, 'BEBIDA'),
(27, 7, 'Agua Embotellada Ciel Natural', 'Agua natural embotellada de 600 ml.', NULL, 48.00, TRUE, 'BEBIDA'),
(28, 7, 'Limonada de Frambuesa', 'Limonada con concentrado de frambuesa.', NULL, 97.00, TRUE, 'BEBIDA'),
(29, 8, 'Café Latte Frío Caramel', 'Café latte frío sabor caramelo.', NULL, 82.00, TRUE, 'BEBIDA'),
(30, 8, 'Cappuccino Olive Garden', 'Cappuccino caliente estilo Olive Garden.', NULL, 69.00, TRUE, 'BEBIDA'),
(31, 9, 'Italian Margarita', 'Margarita frappé con tequila Don Julio Blanco y fruta fresca.', NULL, 175.00, TRUE, 'BEBIDA'),
(32, 9, 'Cucumber Mint', 'Coctelería sin alcohol de pepino y menta.', NULL, 105.00, TRUE, 'BEBIDA'),
(33, 10,'Heineken', 'Cerveza premium 325 ml.', NULL, 79.00, TRUE, 'BEBIDA'),
(34, 10,'Indio', 'Cerveza nacional 325 ml.', NULL, 67.00, TRUE, 'BEBIDA'),
(35, 11,'Bacco L.A. Cetto Copa', 'Vino Lambrusco por copa.', NULL, 125.00, TRUE, 'BEBIDA'),
(36, 11,'Protos Verdejo Copa', 'Vino blanco Verdejo por copa.', NULL, 209.00, TRUE, 'BEBIDA');

/* ============================================================
   8) ÓRDENES
   Solo pueden atenderlas empleados que estén en MESERO.
   ============================================================ */

INSERT INTO orden (folio, num_mesero, fecha, total_pagar) VALUES
('ORD-001', 1,  '2025-01-15 14:20:00', 0),
('ORD-002', 2,  '2025-02-10 15:40:00', 0),
('ORD-003', 3,  '2025-03-08 18:10:00', 0),
('ORD-004', 4,  '2025-04-22 19:30:00', 0),
('ORD-005', 5,  '2025-05-12 13:15:00', 0),
('ORD-006', 6,  '2025-06-18 20:05:00', 0),
('ORD-007', 7,  '2025-07-07 16:50:00', 0),
('ORD-008', 21, '2025-08-21 21:10:00', 0),
('ORD-009', 1,  '2025-09-14 14:05:00', 0),
('ORD-010', 2,  '2025-10-25 17:45:00', 0),
('ORD-011', 3,  '2025-11-03 18:25:00', 0),
('ORD-012', 4,  '2025-12-01 20:30:00', 0),
('ORD-013', 5,  '2025-12-06 15:55:00', 0),
('ORD-014', 6,  '2025-12-12 19:10:00', 0),
('ORD-015', 21, '2025-12-20 21:45:00', 0);

-- Ajusta la secuencia para que la siguiente orden automática sea ORD-016
SELECT setval('seq_folio_orden', 15);

/* ============================================================
   9) DETALLE_ORDEN
   El subtotal_prod NO se inserta manualmente, 
   lo calcula automáticamente el trigger fn_calcular_subtotal().
   Después de cada INSERT, el trigger fn_actualizar_totalOrden()
   actualiza automáticamente orden.total_pagar.
   ============================================================ */

INSERT INTO detalle_orden (folio, id_producto, cant_prod) VALUES
('ORD-001', 1, 1), ('ORD-001', 8, 2), ('ORD-001', 25, 2),
('ORD-002', 6, 1), ('ORD-002', 4, 1), ('ORD-002', 30, 2),
('ORD-003', 16, 1), ('ORD-003', 23, 1), ('ORD-003', 31, 2),
('ORD-004', 17, 1), ('ORD-004', 18, 1), ('ORD-004', 35, 2),
('ORD-005', 12, 2), ('ORD-005', 9, 1), ('ORD-005', 28, 2),
('ORD-006', 21, 1), ('ORD-006', 5, 1), ('ORD-006', 33, 3),
('ORD-007', 19, 2), ('ORD-007', 22, 2), ('ORD-007', 26, 2),
('ORD-008', 15, 1), ('ORD-008', 11, 1), ('ORD-008', 36, 2),
('ORD-009', 7, 1), ('ORD-009', 3, 1), ('ORD-009', 32, 3),
('ORD-010', 20, 1), ('ORD-010', 14, 1), ('ORD-010', 24, 1), ('ORD-010', 27, 2),
('ORD-011', 13, 2), ('ORD-011', 2, 1), ('ORD-011', 34, 4),
('ORD-012', 18, 2), ('ORD-012', 31, 2), ('ORD-012', 23, 2),
('ORD-013', 10, 3), ('ORD-013', 29, 2), ('ORD-013', 22, 1),
('ORD-014', 16, 2), ('ORD-014', 21, 1), ('ORD-014', 35, 3),
('ORD-015', 17, 1), ('ORD-015', 15, 1), ('ORD-015', 24, 2), ('ORD-015', 33, 2);

/* ============================================================
   10) PRODUCTOS NO DISPONIBLES
   Se actualiza la disponibilidad DESPUÉS de insertar detalle_orden.
   Así el trigger puede calcular correctamente subtotal_prod y total_pagar
   durante la carga inicial de las órdenes.

   Productos marcados como no disponibles:
   1, 5, 7, 9 y 11.
   ============================================================ */

UPDATE producto
SET disponibilidad = FALSE
WHERE id_producto IN (1, 5, 7, 9, 11);


/* ============================================================
   11) PAGOS
   Puede pagar una sola persona o dividirse la cuenta entre clientes.
   ============================================================ */

INSERT INTO pago (folio, id_cliente, porcentaje_pago, monto_pago) VALUES
('ORD-001', 1, 100.00, 801.00),
('ORD-002', 2, 100.00, 552.00),
('ORD-003', 3,  50.00, 492.00), ('ORD-003', 4, 50.00, 492.00),
('ORD-004', 7, 100.00, 1080.00),
('ORD-005', 5,  60.00, 522.60), ('ORD-005', 6, 40.00, 348.40),
('ORD-006', 8, 100.00, 951.00),
('ORD-007', 9, 100.00, 928.00),
('ORD-008', 10, 50.00, 504.00), ('ORD-008', 11, 50.00, 504.00),
('ORD-009', 12, 100.00, 850.00),
('ORD-010', 13, 100.00, 844.00),
('ORD-011', 14, 100.00, 1097.00),
('ORD-012', 15, 100.00, 1538.00),
('ORD-013', 4, 100.00, 810.00),
('ORD-014', 7,  70.00, 1148.00), ('ORD-014', 1, 30.00, 492.00),
('ORD-015', 2,  50.00, 683.00), ('ORD-015', 3, 50.00, 683.00);

/* ============================================================
   12) FACTURAS
   Cada factura referencia un pago existente: (folio, id_cliente).
   ============================================================ */

INSERT INTO factura (id_factura, folio, id_cliente, fecha_emision) VALUES
(1, 'ORD-001', 1,  '2025-01-15 15:00:00'),
(2, 'ORD-002', 2,  '2025-02-10 16:20:00'),
(3, 'ORD-003', 3,  '2025-03-08 19:00:00'),
(4, 'ORD-003', 4,  '2025-03-08 19:05:00'),
(5, 'ORD-004', 7,  '2025-04-22 20:15:00'),
(6, 'ORD-005', 5,  '2025-05-12 14:00:00'),
(7, 'ORD-005', 6,  '2025-05-12 14:05:00'),
(8, 'ORD-008', 10, '2025-08-21 22:00:00'),
(9, 'ORD-012', 15, '2025-12-01 21:15:00'),
(10,'ORD-014', 7,  '2025-12-12 20:05:00'),
(11,'ORD-015', 2,  '2025-12-20 22:10:00');

/* ============================================================
   13) VERIFICACIÓN RÁPIDA
   ============================================================ */

SELECT 'empleado' AS tabla, COUNT(*) AS total FROM empleado
UNION ALL SELECT 'telefono_empleado', COUNT(*) FROM telefono_empleado
UNION ALL SELECT 'mesero', COUNT(*) FROM mesero
UNION ALL SELECT 'horario_mesero', COUNT(*) FROM horario_mesero
UNION ALL SELECT 'cocinero', COUNT(*) FROM cocinero
UNION ALL SELECT 'administrativo', COUNT(*) FROM administrativo
UNION ALL SELECT 'dependiente', COUNT(*) FROM dependiente
UNION ALL SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL SELECT 'persona_fisica', COUNT(*) FROM persona_fisica
UNION ALL SELECT 'persona_moral', COUNT(*) FROM persona_moral
UNION ALL SELECT 'categoria', COUNT(*) FROM categoria
UNION ALL SELECT 'producto', COUNT(*) FROM producto
UNION ALL SELECT 'orden', COUNT(*) FROM orden
UNION ALL SELECT 'detalle_orden', COUNT(*) FROM detalle_orden
UNION ALL SELECT 'pago', COUNT(*) FROM pago
UNION ALL SELECT 'factura', COUNT(*) FROM factura;

COMMIT;
