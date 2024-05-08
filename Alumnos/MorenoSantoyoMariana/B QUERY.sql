BEGIN;
-- Sesión B
-- Después de que la transacción en la sesión A ha confirmado los cambios
-- Ahora vemos el cambio en la sesión B

SELECT *
FROM alumno
WHERE id_alumno = 7;
-- Sesión B
-- Rollback para deshacer cualquier cambio realizado en esta transacción en la sesión B
ROLLBACK;

-- Ahora, después del rollback en la sesión B, los cambios realizados en la sesión A también se deshacen en la sesión B
-- Por lo tanto, volvemos a ver el apellido original del alumno con id = 7 en la sesión B
SELECT *
FROM alumno
WHERE id_alumno = 7;

