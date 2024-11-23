
SELECT DISTINCT 
    producto.codbarras, 
    producto.precio, 
    contiene_producto_venta.precioarticulo,
    (contiene_producto_venta.precioarticulo - producto.precio) AS ganancia
FROM producto
INNER JOIN contiene_producto_venta ON producto.codbarras = contiene_producto_venta.codbarras;

-- creamos la funcion

CREATE OR REPLACE FUNCTION calcular_utilidad()
RETURNS TABLE(codbarras VARCHAR, precio NUMERIC, precioarticulo NUMERIC, ganancia NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT 
        producto.codbarras, 
        producto.precio, 
        contiene_producto_venta.precioarticulo,
        (contiene_producto_venta.precioarticulo - producto.precio) AS ganancia
    FROM producto
    INNER JOIN contiene_producto_venta ON producto.codbarras = contiene_producto_venta.codbarras;
END;
$$;

SELECT * FROM calcular_utilidad();

