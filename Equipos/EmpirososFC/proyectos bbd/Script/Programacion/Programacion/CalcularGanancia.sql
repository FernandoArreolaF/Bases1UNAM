select * from producto 
select * from contiene_producto_venta
select * from venta
order by fecha



-- desglozado
SELECT 
    producto.codbarras,
    SUM(producto.precio * contiene_producto_venta.cantarticulo) AS total_compra
FROM venta
INNER JOIN contiene_producto_venta ON contiene_producto_venta.numero = venta.numero
INNER JOIN producto ON contiene_producto_venta.codbarras = producto.codbarras
WHERE venta.fecha BETWEEN '2024-01-01' AND '2024-01-05'
GROUP BY producto.codbarras;


-- como funcion

CREATE OR REPLACE FUNCTION CalcularTotales(
    FechaInicio DATE,
    FechaFin DATE
)
RETURNS TABLE (
    total_compra NUMERIC,
    total_venta NUMERIC,
    diferencia NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        SUM(producto.precio * contiene_producto_venta.cantarticulo) AS total_compra,
        SUM(DISTINCT venta.total) AS total_venta,
        (SUM(DISTINCT venta.total) - SUM(producto.precio * contiene_producto_venta.cantarticulo)) AS diferencia
    FROM venta
    INNER JOIN contiene_producto_venta ON contiene_producto_venta.numero = venta.numero
    INNER JOIN producto ON contiene_producto_venta.codbarras = producto.codbarras
    WHERE venta.fecha BETWEEN FechaInicio AND FechaFin;
END;
$$;


SELECT * FROM CalcularTotales('2024-01-01', '2024-01-09');


