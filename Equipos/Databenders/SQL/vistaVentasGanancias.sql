-- ========================================
-- Creación de la vista 'VistaVentasGanancias'
-- Esta vista consolida la información de ventas y ganancias,
-- permitiendo obtener la cantidad total vendida y la ganancia correspondiente
-- en una fecha específica o en un período de fechas.
-- ========================================

CREATE VIEW VistaVentasGanancias AS
SELECT
    -- Fecha de la venta
    v.FechaVenta,

    -- Cantidad total vendida en la fecha
    SUM(dv.PrecioTotalArticulo) AS CantidadTotalVendida,

    -- Ganancia total en la fecha (Ventas - Costo de los productos)
    SUM(dv.PrecioTotalArticulo - (dv.CantidadProducto * p.PrecioCompra)) AS GananciaTotal
FROM
    Ventas v
    INNER JOIN DetalleVenta dv ON v.VentaID = dv.VentaID    -- Relaciona las ventas con sus detalles
    INNER JOIN Productos p ON dv.ProductoID = p.ProductoID  -- Relaciona los detalles con los productos
GROUP BY
    v.FechaVenta;

-- ========================================
-- Ejemplos de consultas utilizando la vista 'VistaVentasGanancias'
-- 1. Obtener la cantidad total vendida y ganancia en una fecha específica:
SELECT * FROM VistaVentasGanancias WHERE FechaVenta = '2023-10-01';
--
-- 2. Obtener la cantidad total vendida y ganancia en un período de fechas:
SELECT * FROM VistaVentasGanancias
WHERE FechaVenta BETWEEN '2023-10-01' AND '2023-10-31';
-- ========================================
