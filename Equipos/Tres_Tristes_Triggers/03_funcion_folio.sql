-- 04_funcion_folio.sql
-- Funcion para generar el folio de ORDEN
-- Formato: ORD-001, ORD-002, ... ORD-999, ORD-1000
-- Proyecto Final BD - Grupo 01
-- PostgreSQL
-- FUNCION: generar_folio()
-- Genera un folio unico usando la secuencia folio_seq
-- Ejemplo de retorno: 'ORD-001', 'ORD-002', ... 'ORD-1000'

CREATE OR REPLACE FUNCTION generar_folio()
RETURNS VARCHAR(10) AS $$
DECLARE
    v_numero    INTEGER;
    v_folio     VARCHAR(10);
BEGIN
    --Obteniene el siguiente valor de la secuencia
    v_numero := nextval('folio_seq');

    -- Formatear con ceros a la izquierda (minimo 3 digitos)
    -- Ejemplo: 1 -> 'ORD-001', 99 -> 'ORD-099', 1000 -> 'ORD-1000'
    v_folio := 'ORD-' || LPAD(v_numero::TEXT, 3, '0');

    RETURN v_folio;
END;
$$ LANGUAGE plpgsql;



