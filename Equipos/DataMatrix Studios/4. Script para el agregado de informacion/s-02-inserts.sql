--@Autor: DataMatrix Studios
--@Fecha creación:  2023
--@Descripción: Inserts para las tablas.

-- Inserts para empleado

insert into EMPLEADO (Numero_empleado, RFC, Nombre_empleado, Apellido_paterno, Apellido_materno, Fecha_nacimiento, Edad, Sueldo, Foto, Estado, Avenida_calle, Numero_exterior_vivienda, Colonia, Codigo_postal, Es_cocinero, Es_mesero, Es_administrativo) values
(1, 'RFC-GgzblMVs', 'Sig', 'Spiers', 'Smoughton', '15-03-2004', 22, 6881.4, 1, 'CDMX', 'Hayes', '3765', 'Guadalupe', '52107', 0, 0, 1),
(2, 'RFC-vg1YSimK', 'Aurelea', 'Lempke', 'Faust', '03-04-2001', 21, 10209.52, 1, 'CDMX', 'Florence', '8', 'Guadalupe', '52107', 0, 1, 0),
(3, 'RFC-9faGclx7', 'Theodoric', 'Dawkes', 'Henrichsen', '30-01-2003', 19, 17054.2, 1, 'CDMX', 'Grayhawk', '4739', 'Isidro Fabela', '54932', 1, 1, 0),
(4, 'RFC-UACH31xe', 'Harmon', 'Squelch', 'Oxburgh', '27-08-2003', 21, 10032.5, 1, 'CDMX', 'Leroy', '985', 'San Juan', '56030', 1, 1, 1),
(5, 'RFC-rNaTkKkP', 'Edgardo', 'Pack', 'Askin', '17-12-2002', 21, 24319.45, 1, 'CDMX', 'Ridgeview', '9', 'Santo Tomas', '54783', 0, 0, 1),
(6, 'RFC-2dkHoY8C', 'Adelheid', 'Crut', 'Tremouille', '26-02-2003', 20, 5495.59, 1, 'CDMX', 'Gateway', '4962', 'Emiliano Zapata', '55690', 0, 0, 0),
(7, 'RFC-PoXnZxyQ', 'Daffi', 'Knifton', 'Bucke', '04-06-2004', 19, 20414.6, 1, 'CDMX', 'Elka', '27271', 'San Juan', '56030', 1, 1, 1),
(8, 'RFC-c5ORrMqf', 'Gusty', 'Elderton', 'Emmanueli', '18-11-2001', 22, 14351.35, 1, 'CDMX', 'Sauthoff', '93709', 'Buenavista', '54414', 0, 1, 0),
(9, 'RFC-wbJNxZfN', 'Vikki', 'Pittam', 'D''Aubney', '23-04-2002', 19, 22887.12, 1, 'CDMX', 'Vidon', '469', 'La Palma', '52600', 1, 1, 0),
(10, 'RFC-ZufT7NDc', 'Kat', 'Bance', 'Vandenhoff', '21-04-2004', 20, 6235.16, 1, 'CDMX', 'Eastwood', '93520', 'El Carmen', '54927', 1, 0, 1),
(11, 'RFC-7u0VscEo', 'Mozes', 'Palmar', 'Raye', '10-07-2002', 19, 16632.51, 1, 'CDMX', 'Bunker Hill', '446', 'Santiago', '54784', 0, 1, 0),
(12, 'RFC-uQYOhUCm', 'Violetta', 'Daville', 'Gawler', '21-01-2001', 22, 20967.32, 1, 'CDMX', 'Steensland', '2823', 'El Carmen', '54927', 0, 1, 0),
(13, 'RFC-w73bp2fd', 'Burke', 'Snalham', 'McNulty', '30-03-2003', 22, 20056.19, 1, 'CDMX', 'Dexter', '84639', 'Buenavista', '55635', 0, 0, 1),
(14, 'RFC-NNDgdJBB', 'Madonna', 'Gracewood', 'Disman', '15-02-2001', 21, 23061.32, 1, 'CDMX', 'Dryden', '19868', 'San Martin', '56199', 0, 1, 0),
(15, 'RFC-IJqTX3eX', 'Germana', 'Olenikov', 'Sautter', '01-05-2003', 19, 24875.24, 1, 'CDMX', 'Mallory', '4', 'La Laguna', '51247', 0, 0, 1),
(16, 'RFC-RrlSW6dS', 'Jule', 'Lambrecht', 'Tweedlie', '08-01-2004', 19, 17851.41, 1, 'CDMX', 'Towne', '51223', 'San Pedro', '52140', 1, 0, 0),
(17, 'RFC-GdCf46nw', 'Mozes', 'Ogilvy', 'Girone', '14-10-2000', 21, 21158.15, 1, 'CDMX', 'Raven', '5', 'Emiliano Zapata', '55690', 0, 1, 0),
(18, 'RFC-osiirz8S', 'Emilio', 'Barck', 'Dentith', '01-08-2004', 23, 16099.93, 1, 'CDMX', 'Colorado', '74841', 'Santo Tomas', '54783', 0, 1, 0),
(19, 'RFC-RfVqHsf2', 'Maddalena', 'Lishmund', 'Fratczak', '11-01-2003', 23, 7012.03, 1, 'CDMX', 'Longview', '34', 'Adolfo Lopez Mateos', '56528', 0, 0, 1),
(20, 'RFC-C901d7W8', 'Ryun', 'Lorant', 'Brandolini', '01-02-2002', 20, 16919.26, 1, 'CDMX', 'Roth', '348', 'San Sebastian', '51950', 0, 1, 1);

-- Inserts para empleado telefono
insert into EMPLEADO_TELEFONO(Numero_empleado, Telefono_Id) values
(1, 12345678),
(1, 11223344),
(2, 12345678),
(3, 12345678),
(4, 12345678),
(5, 12345678),
(6, 12345678),
(7, 12345678),
(8, 12345678),
(9, 12345678);

-- Inserts para dependiente
insert into DEPENDIENTE(ID_dependiente, Numero_empleado, Curp, Nombre_dependiente, Apellido_paterno, Apellido_materno, Parentesco) values
(),
(),
(),
(),
(),
(),
(),
(),
();

-- Inserts para cliente
insert into CLIENTE(ID_cliente, RFC_cliente, Nombre_cliente, Apellido_paterno, Apellido_materno, Fecha_nacimiento, Razon_social, Email, Estado, Avenida_calle, Numero_exterior_vivienda, Colonia, Codigo_postal) values
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- Inserts para factura
insert into FACTURA(ID_factura, ID_cliente) values
();

-- Inserts para orden
insert into ORDEN(Folio_orden, Fecha_orden, Total_a_pagar, Mesero_atendio, ID_factura) values
(),
(),
();
-- Nota: Folio orden → ORD-%

-- Inserts para categoria
insert into CATEGORIA(ID_Categoria, Nombre_categoria, Descripcion_categoria) values
(),
(),
(),
(),
();

-- Inserts para alimentos
insert into ALIMENTOS(ID_ALIMENTO, Nombre_platillo, Receta_platillo, Descripcion_platillo, Disponibilidad_platillo, Precio_platillo, ID_Categoria) values
(),
(),
(),
(),
();

-- Inserts para orden_contiene_platillo
insert into ORDEN_CONTIENE_PLATILLO(ID_ALIMENTO, Folio_orden, Cantidad_platillo) values
(),
(),
(),
(),
(),
(),
(),
(),
(),
();