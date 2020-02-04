1) login
psql es una terminal interactivapsq
psql postgres -U ferarreolaf
Por defecto postgres usa el 5432
Diferenciar entre superusarios y usarios normales
Parametros: -h y -p

2)Listar bases de datos
\l

3) Crear usuario --> Diferenciar de un rol
create user bases;

4) Listar usuarios
\l

5) Asignar contraseña
alter user bases with password 'grupo5';

6) Crear usuario directamente
CREATE USER basesdatos2 WITH ENCRYPTED PASSWORD 'grupo5';

7) Listar usuarios
\l

8) Borrar al usuario (directo)
drop user basesdatos2;

9) Crear rol
CREATE ROLE creador;

10) Listar roles
SELECT
   rolname
FROM
   pg_roles;

11) Permisos al usuario
alter user bases createdb;

12) Asignar usuario al rol
grant creador to bases;

13) Listar
\du

14) Damos priviegios
grant SELECT on vuelos to creador;

15) Ahora bases puede ver lo que hay en la tabla vuelos

16) Intentamos borrar el rol
drop role creador;

17) Removemos Permisos
revoke SELECT on vuelos from creador;
