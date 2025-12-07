
-------------------------

-- Datos para Gráfica de Ingresos
SELECT 
    p.descripcion AS "Producto",
    TO_CHAR(v.fecha_venta, 'Month') AS "Mes",
    SUM(d.subtotal_articulo) AS "Total Vendido ($)"
FROM detalle_venta d
JOIN venta v ON d.folio_venta = v.folio_venta
JOIN producto p ON d.codigo_barras = p.codigo_barras
GROUP BY p.descripcion, TO_CHAR(v.fecha_venta, 'Month'), EXTRACT(MONTH FROM v.fecha_venta)
ORDER BY EXTRACT(MONTH FROM v.fecha_venta);

-- Datos para Gráfica de Stock Crítico
SELECT 
    descripcion AS "Producto",
    stock AS "Unidades Disponibles"
FROM producto
ORDER BY stock ASC
LIMIT 5; -- Solo los 5 con menos stock