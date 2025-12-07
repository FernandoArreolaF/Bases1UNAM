
CREATE OR REPLACE VIEW vista_factura AS
SELECT 
    v.folio_venta AS "Folio",
    v.fecha_venta AS "Fecha Venta",
    c.rfc AS "RFC Cliente",
    c.nombre AS "Nombre Cliente",
    -- Agregamos la dirección del domicilio completo
    CONCAT(c.calle, ' #', c.numero, ', ', c.colonia, ', ', c.codigo_postal, ', ', c.estado) AS "Dirección Fiscal",
    p.descripcion AS "Producto",
    d.cantidad AS "Cantidad",
    d.precio_unitario_aplicado AS "Precio Unit.",
    d.subtotal_articulo AS "Importe",
    v.monto_total AS "Total Venta"
FROM venta v
JOIN cliente c ON v.rfc_cliente = c.rfc
JOIN detalle_venta d ON v.folio_venta = d.folio_venta
JOIN producto p ON d.codigo_barras = p.codigo_barras
ORDER BY v.folio_venta ASC, p.descripcion ASC;