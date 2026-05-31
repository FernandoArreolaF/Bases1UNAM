-- 02_secuencias.sql
-- Secuencias para el sistema de restaurante
-- Proyecto Final BD - Grupo 01
-- Secuencia para el folio de ORDEN
-- Formato: ORD-001, ORD-002, ... ORD-999, ORD-1000 sucesivamente 

DROP SEQUENCE IF EXISTS folio_seq;

CREATE SEQUENCE folio_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    NO CYCLE;


-- Secuencia para DEPENDIENTE_ID
-- Llave artificial de la tabla DEPENDIENTE

DROP SEQUENCE IF EXISTS dependiente_id_seq;

CREATE SEQUENCE dependiente_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    NO CYCLE;


-- Secuencia para CATEGORIA_ID
-- Llave artificial de la tabla CATEGORIA

DROP SEQUENCE IF EXISTS categoria_id_seq;

CREATE SEQUENCE categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    NO CYCLE;


-- Secuencia para PRODUCTO_ID
-- Llave artificial de la tabla PRODUCTO

DROP SEQUENCE IF EXISTS producto_id_seq;

CREATE SEQUENCE producto_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    NO CYCLE;


-- Verificacion: mostrar secuencias creadas

SELECT sequencename, start_value, increment_by, min_value
FROM pg_sequences
WHERE schemaname = 'public'
ORDER BY sequencename;

