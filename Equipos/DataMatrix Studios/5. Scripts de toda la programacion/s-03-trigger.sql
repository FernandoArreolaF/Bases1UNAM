--@Autor: DataMatrix Studios
--@Fecha creación:  2023
--@Descripción: Se busca suplir lo siguiente: Cada que se agregue un producto a la orden, debe actualizarse 
-- 				los totales (por producto y venta), así como validar que el producto esté disponible


CREATE OR REPLACE FUNCTION actualizar_totales_y_validar_producto() 
RETURNS TRIGGER AS $$
DECLARE
    total_por_producto NUMERIC(12, 2);
    total_venta NUMERIC(12, 2);
BEGIN
    -- Validar si el producto está disponible
    IF NOT EXISTS (
        SELECT 1
        FROM ALIMENTOS
        WHERE ID_ALIMENTO = NEW.ID_ALIMENTO AND Disponibilidad_platillo = 'Disponible'
    ) THEN
        RAISE EXCEPTION 'El producto no se encuentra disponible';
    END IF;

    -- Calcular el total por producto (cantidad * precio)
    total_por_producto := NEW.Cantidad_platillo * (
        SELECT Precio_platillo FROM ALIMENTOS WHERE ID_ALIMENTO = NEW.ID_ALIMENTO
    );

    -- Actualizar el total por producto en ORDEN_CONTIENE_PLATILLO
    UPDATE ORDEN_CONTIENE_PLATILLO 
    SET total_por_producto = total_por_producto 
    WHERE ID_ALIMENTO = NEW.ID_ALIMENTO AND Folio_orden = NEW.Folio_orden;

    -- Calcular el total de la venta (sumar los totales por producto para la orden)
    total_venta := (
        SELECT SUM(total_por_producto) FROM ORDEN_CONTIENE_PLATILLO WHERE Folio_orden = NEW.Folio_orden
    );

    -- Actualizar el total de la venta en la tabla ORDEN
    UPDATE ORDEN SET Total_a_pagar = total_venta WHERE Folio_orden = NEW.Folio_orden;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizacion_totales_orden
AFTER INSERT ON ORDEN_CONTIENE_PLATILLO
FOR EACH ROW
EXECUTE FUNCTION actualizar_totales_y_validar_producto();
