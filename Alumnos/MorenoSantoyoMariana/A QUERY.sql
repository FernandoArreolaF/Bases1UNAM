BEGIN;

UPDATE alumno
SET apellido_alumno = 'Suarez'
WHERE id_alumno = 7;

COMMIT;