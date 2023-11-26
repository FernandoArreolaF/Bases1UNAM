CREATE
OR REPLACE VIEW vista_platillo_mas_vendido AS
SELECT
    ad.alimento_id,
    ad.nombre AS nombre_alimento,
    ad.descripcion AS descripcion_alimento,
    ad.precio AS precio_alimento,
    ca.nombre AS nombre_categoria,
    COUNT(od.alimento_id) AS cantidad_vendida
FROM alimento ad
    JOIN categoria_alimento ca ON ad.categoria_alimento_id = ca.categoria_alimento_id
    JOIN orden_detalle od ON ad.alimento_id = od.alimento_id
GROUP BY
    ad.alimento_id,
    ad.nombre,
    ad.descripcion,
    ad.precio,
    ca.nombre
ORDER BY
    COUNT(od.alimento_id) DESC
LIMIT 1;

CREATE OR REPLACE VIEW vista_factura_orden AS
SELECT
    (c.nombre || ' ' || c.ap_pat || ' ' || c.ap_mat) as nombre_completo,
    og.fecha,
    og.folio,
    og.total as importe,
    (og.total * 1.16) as importe_iva,
    to_char((og.fecha + interval '3 days'),'YYYY-MM-DD') as fecha_vencimiento
FROM orden_general og
JOIN cliente c ON og.cliente_id = c.cliente_id
WHERE og.genero_factura = true;



CREATE
OR REPLACE VIEW vista_productos_no_disponibles AS
SELECT
    alimento_id,
    nombre,
    descripcion,
    precio,
    disponible
FROM alimento
WHERE disponible = false;
