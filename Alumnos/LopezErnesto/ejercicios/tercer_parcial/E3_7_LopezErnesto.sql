--  Se desea conocer aquellos alumnos que ya cuentan con asesor. Interesa el nombre del asesor y del alumno.
CREATE OR REPLACE VIEW alumnos_asesor AS SELECT alumno.nombre_alumno, asesor.nombre_asesor FROM alumno INNER JOIN asesor ON alumno.id_asesor = asesor.id_asesor;
-- Se desea conocer aquellos alumnos que ya cuentan con asesor y aquellos que no. Interesa el nombre del asesor y del alumno.
CREATE OR REPLACE VIEW alumnos_asesor_2 AS SELECT alumno.nombre_alumno, asesor.nombre_asesor FROM alumno LEFT JOIN asesor ON alumno.id_asesor = asesor.id_asesor;
-- Se desea conocer aquellos asesores que ya cuentan con tesista y aquellos que no. Interesa el nombre del asesor y del alumno.
CREATE OR REPLACE VIEW asesor_alumno AS SELECT asesor.nombre_asesor,alumno.nombre_alumno FROM alumno RIGHT JOIN asesor ON alumno.id_asesor = asesor.id_asesor;
-- Se desea conocer aquellos alumnos que ya cuentan con asesor, así como los alumnos sin asesor y los asesores sin alumnos. Interesa el nombre del asesor y del alumno.
CREATE OR REPLACE VIEW asesor_alumno_2 AS SELECT alumno.nombre_alumno,asesor.nombre_asesor FROM alumno FULL OUTER JOIN asesor ON alumno.id_asesor = asesor.id_asesor;
-- Se desea conocer aquellos alumnos sin asesor y los asesores sin alumnos. Interesa el nombre del asesor y del alumno.
CREATE OR REPLACE VIEW asesor_alumno_3 AS SELECT alumno.nombre_alumno,asesor.nombre_asesor FROM (alumno FULL OUTER JOIN asesor ON alumno.id_asesor = asesor.id_asesor)
WHERE alumno.nombre_alumno IS NULL OR asesor.nombre_asesor IS NULL;
-- Se desea conocer aquellos alumnos sin asesor. Interesa el nombre del alumno. Emplear joins.
CREATE OR REPLACE VIEW alumnos_sin_asesor AS SELECT alumno.nombre_alumno FROM (alumno FULL OUTER JOIN asesor ON alumno.id_asesor = asesor.id_asesor)
WHERE asesor.nombre_asesor IS NULL;
-- Se desea conocer aquellos asesores sin alumnos. Interesa el nombre del asesor. Emplear joins.
CREATE OR REPLACE VIEW asesor_sin_alumno AS SELECT asesor.nombre_asesor FROM (alumno FULL OUTER JOIN asesor ON alumno.id_asesor = asesor.id_asesor)
WHERE alumno.nombre_alumno IS NULL;