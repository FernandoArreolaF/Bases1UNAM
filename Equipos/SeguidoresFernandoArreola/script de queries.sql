
-- Dado un numero de empleado, mostrar la cantidad de ´ordenes que ha registrado en el dıa ası como el total que se ha pagado por dichas ´ordenes.
-- Si no se trata de un mesero, mostrar un mensaje de error --

CREATE OR REPLACE FUNCTION datos_ordenes_mesero(numEmpleado INT)
RETURNS TABLE (
    nom_empleado VARCHAR(50),
    apPat_empleado VARCHAR(50),
    total_vendido NUMERIC,
    num_de_ordenes BIGINT,
    mensaje_error TEXT -- Mantener el tipo de dato como TEXT
) AS $$
BEGIN
    RETURN QUERY
    WITH es_mesero AS (
        SELECT esMesero 
        FROM empleado 
        WHERE num_empleado = numEmpleado
    ),
    ordenes_mesero AS (
        SELECT 
            e.nom_empleado, 
            e.apPat_empleado, 
            SUM(o.total) AS total_vendido, 
            COUNT(o.folio) AS num_de_ordenes
        FROM empleado AS e
        JOIN orden AS o ON e.num_empleado = o.num_empleado
        WHERE e.num_empleado = numEmpleado
        AND DATE_TRUNC('day', o.fecha_orden) = DATE_TRUNC('day', CURRENT_TIMESTAMP)
        GROUP BY e.nom_empleado, e.apPat_empleado
    )
    SELECT 
        e.nom_empleado, 
        e.apPat_empleado, 
        om.total_vendido, 
        om.num_de_ordenes, 
        CASE 
            WHEN (SELECT esMesero FROM es_mesero) = FALSE THEN '.....NO ES MESERO......'
            ELSE NULL 
        END AS mensaje_error
    FROM empleado AS e
    LEFT JOIN ordenes_mesero AS om ON e.num_empleado = numEmpleado
    WHERE e.num_empleado = numEmpleado;
END;
$$ LANGUAGE plpgsql;
-- SELECT * FROM datos_ordenes_mesero(2);



-- Vista producto mas vendido

CREATE VIEW platilloMasVendido AS

WITH vecesVendido AS (
    SELECT id_platillo, SUM(cantidadporproducto) AS veces 
    FROM orden_platillo 
    GROUP BY id_platillo
)
SELECT 
    nombre_plat, 
    veces, 
    receta, 
    precio, 
    platillo.descripcion, 
    disponibilidad, 
    CASE 
        WHEN tipo = '1' THEN 'bebida'
        WHEN tipo = '2' THEN 'comida'
        ELSE 'otro' -- En caso de que haya otros tipos no especificados
    END AS tipo,
    nombre_cat 
FROM vecesVendido 
JOIN platillo ON vecesVendido.id_platillo = platillo.id_platillo
JOIN categoria ON platillo.id_categoria = categoria.id_categoria
WHERE veces = (SELECT MAX(veces) FROM vecesVendido); -- si hay empate imprime todos

/*select * from platilloMasVendido; */


--Vista productos no disponibles

CREATE VIEW productosNoDisponibles AS (
SELECT * FROM Platillo WHERE (disponibilidad=FALSE);
--select * from productosNoDisponibles;



--Total de número de ventas y monto total segun una fecha o un intervalo

CREATE OR REPLACE FUNCTION obtener_ventas(fecha_inicio DATE, fecha_fin DATE DEFAULT NULL)
RETURNS TABLE (
    fecha DATE,
    numero_ventas INTEGER,
    total_ventas NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        DATE_TRUNC('day', fecha_orden)::date AS fecha, 
        COUNT(*)::integer AS numero_ventas, 
        SUM(total) AS total_ventas 
    FROM Orden 
    WHERE (DATE_TRUNC('day', fecha_orden)::date > fecha_inicio and fecha_fin is NULL)
       OR (fecha_fin IS NOT NULL AND DATE_TRUNC('day', fecha_orden)::date BETWEEN fecha_inicio AND fecha_fin)
    GROUP BY DATE_TRUNC('day', fecha_orden)::date;
END;
$$ LANGUAGE plpgsql; 

--SELECT * FROM obtener_ventas('2002-01-01','2005-01-01'); --SOPORTA dos valores o un valor

--Vista de la factura

CREATE VIEW print_Factura AS
SELECT 
	'Factura' as Titulo,
    f.folioorden,
    o.fecha_orden,
    o.total,
    (c.nombre_clie || ' ' || c.appat_clie || ' ' || COALESCE(c.apmat_clie, '')) AS nombreCompleto,
    f.rfc,
    c.razonsocial,
    nf.fecha_nacimiento,
    f.email,
    f.numero_factura AS telefono,
    (df.calle_factura || ', ' || df.colonia_factura || ', ' || df.edo_factura || ', ' || df.cp_factura) AS domicilio
FROM 
    factura f 
    NATURAL JOIN fecha_nac_factura nf
    NATURAL JOIN direccion_factura df
    NATURAL JOIN cliente c
    JOIN orden o ON f.folioorden = o.folio
WHERE 
    f.id_factura = 2;
	
--select * from print_Factura;


