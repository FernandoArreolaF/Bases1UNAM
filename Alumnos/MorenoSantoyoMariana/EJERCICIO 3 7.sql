-- Creación de la tabla asesor
CREATE TABLE asesor (
    id_asesor VARCHAR(4),
    nombre_asesor VARCHAR(100),
    CONSTRAINT asesorPK PRIMARY KEY (id_asesor)
);

-- Creación de la tabla alumno
CREATE TABLE alumno (
    id_alumno SERIAL,
    nombre_alumno VARCHAR(100),
    id_asesor VARCHAR(4) NULL,
    CONSTRAINT alumnoPk PRIMARY KEY (id_alumno),
    CONSTRAINT alumnoFk FOREIGN KEY (id_asesor) REFERENCES asesor(id_asesor) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Inserción de datos en la tabla asesor
INSERT INTO asesor (id_asesor, nombre_asesor)
VALUES 
    ('as-1', 'Jorge Campos'),
    ('as-2', 'Laura Sandoval'),
    ('as-3', 'Adolfo Millan'),
    ('as-4', 'Fernando Arreola');

-- Inserción de datos en la tabla alumno
INSERT INTO alumno (nombre_alumno, id_asesor)
VALUES 
    ('Mauricio Barrientos', 'as-1'),
    ('Mario Tabura', 'as-2'),
    ('Luz Rueda', 'as-1'),
    ('Jorge Santillan', NULL),
    ('Gabriela Gaitan', 'as-3');

-- Consulta para seleccionar todos los datos de los asesores
SELECT * FROM asesor;

-- Consulta para seleccionar todos los datos de los alumnos
SELECT * FROM alumno;

-- 1) Separar el nombre del alumno y nombre del asesor (si aplica)
ALTER TABLE asesor ADD COLUMN primer_nombre_asesor VARCHAR(100);
ALTER TABLE asesor ADD COLUMN apellido_asesor VARCHAR(100);

UPDATE asesor SET
    primer_nombre_asesor = SPLIT_PART(nombre_asesor, ' ', 1),
    apellido_asesor = SPLIT_PART(nombre_asesor, ' ', 2);

ALTER TABLE alumno ADD COLUMN primer_nombre_alumno VARCHAR(100);
ALTER TABLE alumno ADD COLUMN apellido_alumno VARCHAR(100);

UPDATE alumno SET
    primer_nombre_alumno = SPLIT_PART(nombre_alumno, ' ', 1),
    apellido_alumno = SPLIT_PART(nombre_alumno, ' ', 2);

-- 2) Alumno U Asesor (sólo en el atributo nombre)
SELECT nombre_alumno AS nombre FROM alumno
UNION
SELECT nombre_asesor AS nombre FROM asesor;

-- 3) Alumno INTERSECT Asesor (sólo en el atributo nombre)
SELECT nombre_alumno AS nombre FROM alumno
INTERSECT
SELECT nombre_asesor AS nombre FROM asesor;

-- 4) Alumno - Asesor y Asesor - Alumno
SELECT primer_nombre_alumno AS nombre FROM alumno
EXCEPT
SELECT primer_nombre_asesor AS nombre FROM asesor;

SELECT primer_nombre_asesor AS nombre FROM asesor
EXCEPT
SELECT primer_nombre_alumno AS nombre FROM alumno;

-- 5) Alumno natural join Asesor y Alumno cross join asesor
SELECT * FROM alumno NATURAL JOIN asesor;

SELECT * FROM alumno CROSS JOIN asesor;

-- 6) Modificar la tabla Alumno, agregue los siguientes atributos: carrera varchar(40) y edad smallint
ALTER TABLE alumno ADD COLUMN carrera VARCHAR(40);
ALTER TABLE alumno ADD COLUMN edad SMALLINT;

-- 7) Insertar los siguientes 5 registros:
INSERT INTO alumno (id_alumno, nombre_alumno, id_asesor, primer_nombre_alumno, apellido_alumno, carrera, edad)
VALUES
    (6, 'Isaac Lemus', 'as-1', 'Isaac', 'Lemus', 'Petrolera', 30),
    (7, 'Gabriela Suarez', 'as-3', 'Gabriela', 'Suarez', 'Industrial', 24),
    (8, 'Pablo Gonzalez', 'as-2', 'Pablo', 'Gonzalez', 'Computacion', 23),
    (9, 'David Rivera', 'as-1', 'David', 'Rivera', 'Industrial', 25),
    (10, 'Dayana Plata', 'as-4', 'Dayana', 'Plata', 'Computacion', 24);

-- 8) Actualizar los 5 registros iniciales para asignar valores en los atributos agregados
UPDATE alumno SET carrera = 'Petrolera', edad = 27 WHERE id_alumno = 6;
UPDATE alumno SET carrera = 'Industrial', edad = 24 WHERE id_alumno = 7;
UPDATE alumno SET carrera = 'Computacion', edad = 23 WHERE id_alumno = 8;
UPDATE alumno SET carrera = 'Industrial', edad = 25 WHERE id_alumno = 9;
UPDATE alumno SET carrera = 'Computacion', edad = 24 WHERE id_alumno = 10;

-- 9) Validar que los datos coincidan con los esperados
SELECT * FROM alumno;

-- 10) Nombre completo del alumno de mayor edad
SELECT nombre_alumno AS "Nombre Completo", edad
FROM alumno
ORDER BY edad DESC
LIMIT 1;

-- 11) Nombre completo del alumno de menor edad
SELECT nombre_alumno AS "Nombre Completo", edad
FROM alumno
ORDER BY edad ASC
LIMIT 1;

-- 12) cantidad de alumnos por carrera
SELECT carrera, COUNT(*) AS "Cantidad de Alumnos"
FROM alumno
GROUP BY carrera
ORDER BY "Cantidad de Alumnos" DESC;

-- 13) Nombre de la carrera que tiene a la persona más joven. Agrupar los datos.
SELECT carrera, MIN(edad) AS edad_minima
FROM alumno
GROUP BY carrera
HAVING MIN(edad) = (SELECT MIN(edad) FROM alumno);

-- 14) Nombre de la carrera que tiene a la persona más grande. Agrupar los datos.
SELECT carrera, MAX(edad) AS edad_maxima
FROM alumno
GROUP BY carrera
HAVING MAX(edad) = (SELECT MAX(edad) FROM alumno);

-- 15) Nombre de la carrera que tiene a la persona más joven. Usar subconsultas.
SELECT carrera, MIN(edad) AS edad_minima
FROM alumno
WHERE edad = (
    SELECT MIN(edad) FROM alumno
)
GROUP BY carrera;

-- 16) Nombre de la carrera que tiene a la persona más grande. Usar subconsultas
SELECT carrera, MAX(edad) AS edad_maxima
FROM alumno
WHERE edad = (
    SELECT MAX(edad) FROM alumno
)
GROUP BY carrera;

-- 17) Promedio de edad por carrera
SELECT carrera, AVG(edad) AS promedio_edad
FROM alumno
GROUP BY carrera
ORDER BY promedio_edad DESC;

-- 18) borrar al asesor Adolfo Millan
DELETE FROM asesor
WHERE nombre_asesor = 'Adolfo Millan';

-- 19) Actualizar el id del asesor Fernando Arreola, asignar "as-5"
UPDATE asesor
SET id_asesor = 'as-5'
WHERE nombre_asesor = 'Fernando Arreola';
