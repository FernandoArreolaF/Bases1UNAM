


--Vista que muestre todos los detalles del platillo más vendido.
--Primero, necesitamos una consulta para encontrar el platillo más vendido:

SELECT *
FROM menu
WHERE id_prod = (
    SELECT id_prod
    FROM contiene
    GROUP BY id_prod
    ORDER BY SUM(cantidad_prod) DESC
    LIMIT 1
);

--De manera autom ́atica se genere una vista que contenga informaci ́on ne- cesaria --para asemejarse a una factura de una orden.

CREATE VIEW factura_orden AS
SELECT
    o.folio_orden,
    f.rfc_cli,
    f.nombre_pila_cli || ' ' || f.ap_pat_cli || ' ' || f.ap_mat_cli AS nombre_cliente,
    f.estado_cli,
    f.codigo_postal_cli,
    f.colonia_cli,
    f.calle_cli,
    f.num_dom_cli,
    f.razon_social_cli,
    f.email_cli,
    f.fecha_nac_cli,
    o.fecha_orden AS fecha_orden,
    m.nombre_prod,
    ctd.cantidad_prod,
    m.precio_unitario_prod,
    ctd.precio_total_prod AS subtotal_producto,
    o.total_orden AS total_factura
FROM
    orden o
JOIN
    factura f ON o.folio_orden = f.folio_orden
JOIN
    contiene ctd ON o.folio_orden = ctd.folio_orden
JOIN
    menu m ON ctd.id_prod = m.id_prod;

--Con esa consulta, ahora podemos crear una vista:

CREATE VIEW platillo_mas_vendido AS
SELECT *
FROM menu
WHERE id_prod = (
    SELECT id_prod
    FROM contiene
    GROUP BY id_prod
    ORDER BY SUM(cantidad_prod) DESC
    LIMIT 1
);

-- consultas
--Dado un número de empleado, mostrar la cantidad de  ́ordenes que ha registrado en --el d ́ıa as ́ı como el total que se ha pagado por dichas  ́ordenes. Si no se trata de un --mesero, mostrar un mensaje de error.

SELECT COUNT(folio_orden) AS cantidad_ordenes, COALESCE(SUM(total_orden), 0) AS total_pagado
FROM orden
WHERE fecha_orden::DATE = CURRENT_DATE
AND num_emp_mesero = 1;




--Permitir obtener el nombre de aquellos productos que no est ́en disponibles.

SELECT nombre_prod
FROM menu
WHERE disponibilidad_prod = false;
