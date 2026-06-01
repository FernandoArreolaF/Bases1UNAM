-- ============================================================
-- 06_vistas.sql
-- Vista platillo mas vendido
-- Vista tipo de factura
-- Vista productos no disponibles
-- ============================================================


-- ============================================================
-- 1. Vista del platillo más vendido
-- ============================================================
DROP VIEW IF EXISTS vista_platillo_mas_vendido; -- Eliminar la vista

CREATE VIEW vista_platillo_mas_vendido AS -- Creamos la vista con su respectivo nombre
SELECT
    PRODUCTO.producto_id, -- Se escoge el de producto ya que es la tabla con la que se asocia la tabla relación 'DETALLE_ORDEN'
    PRODUCTO.nombre,
    PRODUCTO.descripcion,
    PRODUCTO.precio,
    SUM(DETALLE_ORDEN.cantidad) AS cant_total -- Suma para calcular la cantidad total de los platillos vendidos
FROM PRODUCTO
JOIN DETALLE_ORDEN ON PRODUCTO.producto_id = DETALLE_ORDEN.producto_id -- Usamos un JOIN para complementar la información y que asi la base de datos tenga en una misma tabla la cantidad que se vendio, que platillo es y su nombre
WHERE PRODUCTO.tipo = 'platillo' -- Se especifica que se quiere solamente el platillo y no bebida
GROUP BY PRODUCTO.producto_id -- Queremos que las suma se agrupe segun el producto
ORDER BY cant_total DESC -- Ordenamos de manera descendente para tener al platillo mas vendido hasta arriba de la tabla
LIMIT 1; -- Con esto solo se mostrara la primera dila de nuestra vista, que en este caso sera el platillo mayor vendido 

-- SELECT * FROM vista_platillo_mas_vendido;


-- ============================================================
-- 2. Vista de la factura
-- ============================================================
DROP VIEW IF EXISTS vista_factura;

CREATE VIEW vista_factura AS
SELECT
-- ENCABEZADO, esta parte sera lo del encabezado de la factura iran datos relacionados con la compra y el cliente
    ORDEN.folio,
    ORDEN.fecha,
    ORDEN.hora,
    ORDEN.total,
    CLIENTE_FACT.rfc,
    CLIENTE_FACT.nombre_cliente,
    CLIENTE_FACT.email,
    CLIENTE_FACT.estado,
    CLIENTE_FACT.codigo_postal,
    CLIENTE_FACT.colonia,
    CLIENTE_FACT.numero,
    CLIENTE_FACT.calle,
    CLIENTE_FACT.razon_social,
    -- DETALLE, en esta parte estara incluido la segunda parte de la factura que incluye los detalles de la orden asi como datos importantes del producto
    PRODUCTO.producto_id,
    PRODUCTO.nombre,
    PRODUCTO.precio,
    DETALLE_ORDEN.cantidad,
    (DETALLE_ORDEN.cantidad * PRODUCTO.precio) AS subtotal -- Esto hace la funcion de saber cuanto es lo que se debe pagar por la cantidad de los platillos o bebidas consumidos
FROM ORDEN
JOIN CLIENTE_FACT  ON ORDEN.rfc = CLIENTE_FACT.rfc
JOIN DETALLE_ORDEN ON ORDEN.folio = DETALLE_ORDEN.folio 
JOIN PRODUCTO      ON DETALLE_ORDEN.producto_id = PRODUCTO.producto_id  -- Triple join para que a la hora de consultar la vista se visualize la información establecida anteriormente de las tablas ORDEN, PRODUCTO, CLIENTE_FACT y DETALLE_ORDEN, en una sola tabla
WHERE ORDEN.rfc IS NOT NULL; -- Con esto aseguramos filtrar solo la factura de aquellas que su 'rfc' no sean 'NULL'

-- SELECT * FROM vista_factura;


-- ============================================================
-- 3. Vista productos no disponibles
-- ============================================================
DROP VIEW IF EXISTS vista_p_no_disponibles;

CREATE VIEW vista_p_no_disponibles AS
SELECT
    PRODUCTO.nombre -- Solo devuelve el nombre
FROM PRODUCTO
WHERE PRODUCTO.disponibilidad = FALSE; -- Y ya con esto devolvera solo el nombre de los prductos que su disponibilidad sea igual a FALSE

-- SELECT * FROM vista_p_no_disponibles;
