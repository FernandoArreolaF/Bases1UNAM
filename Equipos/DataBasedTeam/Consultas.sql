--CONSULTAS PARA DASHBOARD

-- Ingresos mensuales por artículo
-- Agrupa las ventas por mes y por producto, sumando el importe total vendido.
CREATE OR REPLACE VIEW DASHBOARD_INGRESOS_MENSUALES_ARTICULO AS
SELECT 
    TO_CHAR(v.fechaVenta, 'YYYY-MM') AS "Mes",
    p.descripcion AS "Artículo",
    SUM(cp.importe) AS "Ingreso Total"
FROM VENTA v
JOIN CONTIENE_PRODUCTO cp ON v.numVenta = cp.numVenta
JOIN PRODUCTO p ON cp.codigoBarras = p.codigoBarras
GROUP BY TO_CHAR(v.fechaVenta, 'YYYY-MM'), p.descripcion
ORDER BY "Mes" DESC, "Ingreso Total" DESC;

-- EJEMPLO:
SELECT * FROM DASHBOARD_INGRESOS_MENSUALES_ARTICULO;


-- Gráfica útil sugerida: Margen Bruto por Categoría
-- Muestra qué categorías de productos dejan más ganancia real.
CREATE OR REPLACE VIEW DASHBOARD_MARGEN_POR_CATEGORIA AS
SELECT 
    p.categoria AS "Categoría",
    -- Calculamos cuánto se vendió en total 
    SUM(cp.importe) AS "Ventas Totales ($)",
    -- Calculamos el margen bruto:
    SUM((p.precioVenta - p.precioCompra) * cp.cantidad) AS "Margen Bruto (Ganancia)"
FROM CONTIENE_PRODUCTO cp
JOIN PRODUCTO p ON cp.codigoBarras = p.codigoBarras
JOIN VENTA v ON cp.numVenta = v.numVenta
GROUP BY p.categoria
ORDER BY "Margen Bruto (Ganancia)" DESC;

-- EJEMPLO:
SELECT * FROM DASHBOARD_MARGEN_POR_CATEGORIA;