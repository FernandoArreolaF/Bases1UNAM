-- ========================================
-- Función: Dar formato similar a VENT-###
-- Descripción:
-- El trigger genera automaticamente el folio  cuando se 
-- inserta un nuevo registro a la tabla de ventas
-- ========================================

--Funcion que genera el folio y lo coloca antes del valor
CREATE OR REPLACE FUNCTION generar_folio_venta()
RETURNS TRIGGER AS $$
BEGIN
    NEW.Folio := 'VENT-' || LPAD(nextval('secuencia_ventas')::text, 3, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Asignando el triger a la tabla ventas
--Se activa antes de una insercion de ventas
CREATE TRIGGER trigger_folio_ventas
BEFORE INSERT ON Ventas
FOR EACH ROW
EXECUTE FUNCTION generar_folio_venta();
