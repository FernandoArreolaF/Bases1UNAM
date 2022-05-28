INSERT INTO empleado (num_empleado, ap_paterno, ap_mateno, nombre, edad, rfc, fecha_nac, sueldo, foto, estado, colonia, calle, numero, cp, admin_rol, cocin_especialidad)
VALUES (1,'Gomez','Gomez','Pedro',30,'MELM8305281H0','1980-01-10',10000,'empleado1.jpg','CDMX','Olivar','Calle 1',23,01436,'Gerente','Cortes Finos');

INSERT INTO empleado (num_empleado, ap_paterno, ap_mateno, nombre, edad, rfc, fecha_nac, sueldo, foto, estado, colonia, calle, numero, cp, cocin_especialidad, mesero_hora_inicio, mesero_hora_fin)
VALUES (2,'Perez','Perez','Alejandra',32,'MELM8305281H2','1982-01-10',8000,'empleado2.jpg','CDMX','Olivar','Calle 2',10,01436,'Reposteria', '08:00:00', '16:00:00');

INSERT INTO empleado (num_empleado, ap_paterno, ap_mateno, nombre, edad, rfc, fecha_nac, sueldo, foto, estado, colonia, calle, numero, cp)
VALUES (3,'Ramirez','Ramirez','Carlos',34,'MELM8305281H3','1983-01-10',8000,'empleado3.jpg','CDMX','Olivar','Calle 3',13,01436);

INSERT INTO categoria (nombre, descripcion) VALUES ('Desayunos','Disponibles de 7 am a 1 pm');

INSERT INTO categoria (nombre, descripcion) VALUES ('Almuerzos','Disponibles de 1 pm a 8 pm');

INSERT INTO categoria (nombre, descripcion) VALUES ('Bebidas Calientes','Productos 100% Mexicanos');

INSERT INTO producto (nombre, descripcion, precio, disponibilidad, receta, tipo, num_empleado, nombre_categoria) VALUES ('Hot Cakes','Naturales con mantequilla y miel de abeja o jarabe de maple o con cajeta', 85, true, 'Receta para los Hotcakes', 'p',2,'Desayunos');

INSERT INTO producto (nombre, descripcion, precio, disponibilidad, receta, tipo, num_empleado, nombre_categoria) VALUES ('Arrachera','A la parrilla con chilaquiles rojos', 175, true, 'Receta para los Arrachera', 'p', 1, 'Almuerzos');

INSERT INTO producto (nombre, descripcion, precio, disponibilidad, receta, tipo, num_empleado, nombre_categoria) VALUES ('Cafe Americano','Organico 100% mexicano', 30, true, 'Receta para el cafe americano', 'b', 3, 'Desayunos');

INSERT INTO cliente (rfc, ap_paterno, ap_mateno, nombre, estado, colonia, calle, numero, cp, fecha_nac, razon_social, email) VALUES ('MELM8305281H4','Mena','Rodriguez','Alex','CDMX','Olivar','Calle 4',14,01437, '1984-01-10', 'P.Fisica', 'mena.rodriguez@mail.com');

INSERT INTO orden (fecha, num_empleado, rfc_cliente) values (now(), 3, 'MELM8305281H4');




