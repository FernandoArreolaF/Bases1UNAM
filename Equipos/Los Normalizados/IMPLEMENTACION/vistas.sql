/* ============================================================
   VISTA: PLATILLO MÁS VENDIDO
   Muestra los detalles del platillo con mayor cantidad vendida.
   ============================================================ */
DROP VIEW IF EXISTS vista_sim_fac;
DROP VIEW IF EXISTS platillo_mas_vendido;

CREATE VIEW platillo_mas_vendido AS 
SELECT 
    p.id_producto, 
    p.nombre, 
    p.descripcion, 
    p.precio, 
    p.disponibilidad, 
    p.receta, 
    SUM(d.cant_prod) AS total_vendido
FROM producto p
JOIN detalle_orden d 
    ON p.id_producto = d.id_producto
WHERE p.tipo_producto = 'PLATILLO'
GROUP BY 
    p.id_producto, 
    p.nombre, 
    p.descripcion, 
    p.precio, 
    p.disponibilidad, 
    p.receta
ORDER BY total_vendido DESC
LIMIT 1;


/* ============================================================
   VISTA: SIMULACIÓN DE FACTURA
   Muestra una fila por factura, integrando datos del cliente,
   orden, pago y productos consumidos.
   ============================================================ */
CREATE VIEW vista_sim_fac AS 
SELECT 
    f.id_factura, 
    f.fecha_emision,
    o.folio,
    o.fecha AS fecha_orden,

    c.id_cliente,
    c.rfc, 
    pm.razon_social,

    COALESCE(
        pm.razon_social, 
        pf.nombre || ' ' || pf.ap_pat || COALESCE(' ' || pf.ap_mat, '') 
    ) AS nombre_cliente_completo,

    c.calle || ' ' || c.numero || ', ' || c.colonia || ', ' || c.cp || ', ' || c.estado 
        AS domicilio_cliente,

    c.email,

    STRING_AGG(
        pr.nombre || ' x' || d.cant_prod || ' = $' || d.subtotal_prod,
        ' | '
        ORDER BY pr.nombre
    ) AS productos_consumidos,

    pa.monto_pago,
    o.total_pagar
FROM factura f
    JOIN cliente c ON f.id_cliente = c.id_cliente
    LEFT JOIN persona_moral pm ON c.id_cliente = pm.id_cliente
    LEFT JOIN persona_fisica pf ON c.id_cliente = pf.id_cliente
    JOIN orden o ON f.folio = o.folio
    JOIN pago pa ON f.folio = pa.folio AND f.id_cliente = pa.id_cliente
    JOIN detalle_orden d ON o.folio = d.folio
    JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY 
    f.id_factura,
    f.fecha_emision,
    o.folio,
    o.fecha,
    c.id_cliente,
    c.rfc,
    pm.razon_social,
    pf.nombre,
    pf.ap_pat,
    pf.ap_mat,
    c.calle,
    c.numero,
    c.colonia,
    c.cp,
    c.estado,
    c.email,
    pa.monto_pago,
    o.total_pagar;