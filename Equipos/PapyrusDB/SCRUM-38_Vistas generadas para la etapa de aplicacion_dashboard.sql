/* ============================================================
    PapyrusDB Solutions - Sistema de Gestión para Papelería

    Archivo: [SCRUM-38_ Vistas geenradas para la etapa de aplicación_dashboard.sql]
    Descripción: En este scrip se muestran las vistas generadas para posteriormente crear gráficas
	con la informacion que deseamos mostrar en los dashboard.


    Fecha: [6 de diciembre del 2025]
   ============================================================*/


-- Vistas para dashboard 1: Ingresos totales mensuales por articulo en el periodo 2025
--------------------------------------------------------------------------------------


-- ingresos mensuales por articulo en un año
/*Permite analizar el comportamiento de ventas por artículo a lo largo del año
e identificar tendencias, estacionalidad y productos con mayor demanda mensual.*/
CREATE OR REPLACE VIEW vista_ingresos_mensuales_articulo AS
SELECT 
    p.idProducto,
    p.descripcion AS producto,
    EXTRACT(YEAR FROM v.fechaVenta) AS anio,
    EXTRACT(MONTH FROM v.fechaVenta) AS mes,
    SUM(d.cantidadProducto * d.precioUnitarioPorProd) AS ingresos_mensuales
FROM detalleVenta d
JOIN venta v ON d.idVenta = v.idVenta
JOIN producto p ON d.idProducto = p.idProducto
GROUP BY p.idProducto, p.descripcion, anio, mes
ORDER BY p.descripcion, mes;


-- producto mas rentable del año
/*Facilita identificar cuáles artículos son los más rentables para el negocio.*/
CREATE OR REPLACE VIEW vista_ingresos_totales_producto AS
SELECT 
    p.idProducto,
    p.descripcion AS producto,
    EXTRACT(YEAR FROM v.fechaVenta) AS anio,
    SUM(d.cantidadProducto * d.precioUnitarioPorProd) AS ingresos_totales
FROM detalleVenta d
JOIN venta v ON d.idVenta = v.idVenta
JOIN producto p ON d.idProducto = p.idProducto
GROUP BY p.idProducto, p.descripcion, anio
ORDER BY ingresos_totales DESC;


-- categoria mas rentable 
/*Ayuda a determinar qué categoria de productos genera mayor utilidad en el periodo.*/
CREATE OR REPLACE VIEW vista_ingresos_categoria AS
SELECT 
    p.categoria,
    EXTRACT(YEAR FROM v.fechaVenta) AS anio,
    SUM(d.cantidadProducto * d.precioUnitarioPorProd) AS ingresos_categoria
FROM detalleVenta d
JOIN venta v ON d.idVenta = v.idVenta
JOIN producto p ON d.idProducto = p.idProducto
GROUP BY p.categoria, anio
ORDER BY ingresos_categoria DESC;


-- Ventas con totales
/*permitiendo visualizar totales y fechas para análisis general de ventas.*/
CREATE OR REPLACE VIEW vista_ventas_con_totales AS
SELECT 
    idVenta,
    idCliente,
    fechaVenta,
    pagoTotal
FROM venta;


-- Productos más vendidos
/*Vista que calcula cuántas unidades se han vendido por cada producto,
útil para identificar los productos de mayor rotación y planear compras.*/
CREATE OR REPLACE VIEW vista_productos_mas_vendidos AS
SELECT 
    idProducto,
    SUM(cantidadProducto) AS total_vendido
FROM detalleVenta
GROUP BY idProducto;


-- Ingresos por categoría
/*Se usa para graficar qué tipo de productos aportan más beneficios.*/
CREATE OR REPLACE VIEW vista_ingresos_por_categoria AS
SELECT 
    p.categoria,
    SUM(d.precioTotalPorProd) AS ingresos
FROM detalleVenta d
JOIN producto p ON p.idProducto = d.idProducto
GROUP BY p.categoria;

select * from producto;
select * from inventario;


-- Vistas para dashboard 2: Rendimiento de los vendedores
-----------------------------------------------------------------------------------------------------

-- Número de ventas por vendedor
/*Permite evaluar el desempeño de los vendedores según su volumen de ventas.*/
CREATE OR REPLACE VIEW vista_num_ventas_por_vendedor AS
SELECT
    e.idEmpleado,
    (e.nombre || ' ' || e.apPat || ' ' || COALESCE(e.apMat, '')) AS nombreCompleto,
    COUNT(v.idVenta) AS total_ventas
FROM venta v
JOIN empleado e ON e.idEmpleado = v.idEmpleado
GROUP BY e.idEmpleado, nombreCompleto
ORDER BY total_ventas DESC;


-- Ingresos generados por vendedor
/*Vista que suma los ingresos generados por cada vendedor.
Útil para medir el impacto económico de cada empleado en el negocio.*/
CREATE OR REPLACE VIEW vista_ingresos_por_vendedor AS
SELECT
    e.idEmpleado,
    (e.nombre || ' ' || e.apPat || ' ' || COALESCE(e.apMat, '')) AS nombreCompleto,
    SUM(d.precioTotalPorProd) AS ingresos_generados
FROM venta v
JOIN detalleVenta d ON d.idVenta = v.idVenta
JOIN empleado e ON e.idEmpleado = v.idEmpleado
GROUP BY e.idEmpleado, nombreCompleto
ORDER BY ingresos_generados DESC;


-- Mejor vendedor del periodo completo
/*Sirve para identificar al mejor vendedor general del negocio.*/
CREATE OR REPLACE VIEW vista_mejor_vendedor AS
SELECT 
    idEmpleado,
    nombreCompleto,
    ingresos_generados
FROM vista_ingresos_por_vendedor
ORDER BY ingresos_generados DESC
LIMIT 1;


-- Ventas mensuales por vendedor (cantidad)
/*Vista que cuenta el número de ventas realizadas por cada vendedor en cada mes.
Permite ver patrones mensuales de actividad y detectar periodos de mayor o menor desempeño.*/
CREATE OR REPLACE VIEW vista_ventas_mensuales_por_vendedor AS
SELECT 
    v.idEmpleado,
    (e.nombre || ' ' || e.apPat || ' ' || COALESCE(e.apMat, '')) AS nombreCompleto,
    EXTRACT(YEAR FROM v.fechaVenta)  AS anio,
    EXTRACT(MONTH FROM v.fechaVenta) AS mes,
    COUNT(v.idVenta) AS total_ventas
FROM venta v
JOIN empleado e ON e.idEmpleado = v.idEmpleado
GROUP BY 
    v.idEmpleado, nombreCompleto, anio, mes
ORDER BY anio, mes, v.idEmpleado;



-- Ingresos mensuales por vendedor
/* Vista que suma los ingresos obtenidos por cada vendedor en cada mes.
Se utiliza para evaluar el rendimiento económico mensual del personal de ventas.*/
CREATE OR REPLACE VIEW vista_ingresos_mensuales_por_vendedor AS
SELECT 
    e.idEmpleado,
    (e.nombre || ' ' || e.apPat || ' ' || COALESCE(e.apMat, '')) AS nombreCompleto,
    EXTRACT(YEAR FROM v.fechaVenta)  AS anio,
    EXTRACT(MONTH FROM v.fechaVenta) AS mes,
    SUM(d.precioTotalPorProd) AS ingresos_mensuales
FROM venta v
JOIN detalleVenta d ON d.idVenta = v.idVenta
JOIN empleado e ON e.idEmpleado = v.idEmpleado
GROUP BY e.idEmpleado, nombreCompleto, anio, mes
ORDER BY anio, mes, ingresos_mensuales DESC;


-- Mejor vendedor por mes
/*Vista que identifica al mejor vendedor de cada mes basado en ingresos generados.
Facilita reconocer variaciones mensuales en desempeño y premiar a los mejores resultados.*/
CREATE OR REPLACE VIEW vista_mejor_vendedor_mensual AS
SELECT 
    sub.idEmpleado,
    sub.nombreCompleto,
    sub.anio,
    sub.mes,
    sub.ingresos_mensuales
FROM (
    SELECT
        e.idEmpleado,
        (e.nombre || ' ' || e.apPat || ' ' || COALESCE(e.apMat, '')) AS nombreCompleto,
        EXTRACT(YEAR FROM v.fechaVenta) AS anio,
        EXTRACT(MONTH FROM v.fechaVenta) AS mes,
        SUM(d.precioTotalPorProd) AS ingresos_mensuales,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM v.fechaVenta), EXTRACT(MONTH FROM v.fechaVenta)
            ORDER BY SUM(d.precioTotalPorProd) DESC
        ) AS ranking
    FROM venta v
    JOIN detalleVenta d ON d.idVenta = v.idVenta
    JOIN empleado e ON e.idEmpleado = v.idEmpleado
    GROUP BY e.idEmpleado, nombreCompleto, anio, mes
) sub
WHERE sub.ranking = 1
ORDER BY sub.anio, sub.mes;




