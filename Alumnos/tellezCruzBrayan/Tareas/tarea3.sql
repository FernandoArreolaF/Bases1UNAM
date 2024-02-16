--- Creamos la tabla con la que trabajaremos 
CREATE TABLE IF NOT EXISTS estudiante(
    numero_cuenta CHARACTER(10) PRIMARY KEY,
    nombre        VARCHAR(20),
    apellido_p    VARCHAR(20),
    apellido_m    VARCHAR(20),
    curp          CHARACTER(18),
    UNIQUE(numero_cuenta)
);
--- Insertamos un dato en la tabla para comprobar posteriormente
INSERT INTO estudiante VALUES('0422017255', 'Brayan', 'Téllez', 'Cruz', 'TECB030118HHGLXXXX');
--- Creamos el usuario
CREATE USER brayan_tellez WITH PASSWORD '12345678' CONNECTION LIMIT 5 VALID UNTIL '2024-02-14';
--- Creamos el rol correspondiente
CREATE ROLE db_editor;
--- Damos los privilegios al rol
GRANT SELECT, UPDATE, DELETE ON estudiante TO db_editor;
--- Asignamos el rol a nuestro usuario
GRANT db_editor TO brayan_tellez;
