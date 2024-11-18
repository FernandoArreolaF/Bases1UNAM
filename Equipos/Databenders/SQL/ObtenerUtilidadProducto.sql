-- ========================================
-- Función: obtener_utilidad_producto
-- Descripción:
-- Esta función recibe el código de barras de un producto y regresa la utilidad,
-- calculada como la diferencia entre el precio de venta y el precio de compra.
-- ========================================

CREATE OR REPLACE FUNCTION obtener_utilidad_producto(p_codigo_barras VARCHAR)
RETURNS TABLE (
    productoid INT,
    nombre_producto VARCHAR(100),
    codigobarras VARCHAR(50),
    preciocompra DECIMAL(10,2),
    precioventa DECIMAL(10,2),
    utilidad DECIMAL(10,2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.productoid,
        p.nombre AS nombre_producto,
        p.codigobarras,
        p.preciocompra,
        p.precioventa,
        (p.precioventa - p.preciocompra) AS utilidad
    FROM
        productos p
    WHERE
        p.codigobarras = p_codigo_barras;
END;
$$ LANGUAGE plpgsql;



-- ========================================
-- Ejemplo de uso de la función obtener_utilidad_producto
-- Esta consulta obtiene la utilidad del producto con el código de barras especificado.
-- Reemplazar '7501001234567' con el código de barras del producto deseado.
-- ========================================

SELECT * FROM obtener_utilidad_producto('7501001234567');


