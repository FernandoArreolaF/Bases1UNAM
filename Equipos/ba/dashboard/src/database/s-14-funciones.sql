CREATE OR REPLACE FUNCTION OBTENER_ORDENES_MESERO(NUMERO_EMPLEADO_PARAM 
INT) RETURNS TABLE(CANTIDAD_ORDENES BIGINT, TOTAL_PAGADO 
NUMERIC) AS
	$$ DECLARE es_mesero_boolean BOOLEAN;
	BEGIN
	SELECT
	    es_mesero INTO es_mesero_boolean
	FROM empleado
	WHERE
	    numero_empleado_id = numero_empleado_param;
	IF NOT es_mesero_boolean THEN RAISE EXCEPTION 'El empleado con número % no es un mesero.',
	numero_empleado_param;
	END IF;
	RETURN QUERY
	SELECT
	    count(*) as cantidad_ordenes,
	    COALESCE(sum(og.total), 0) as total_pagado
	FROM orden_general og
	WHERE
	    og.numero_empleado_id = numero_empleado_param
	    and to_char(og.fecha, 'YYYY-MM-DD') = to_char(CURRENT_DATE, 'YYYY-MM-DD');
	END;
	$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION obtener_estadisticas_ventas(
    fecha_inicio_param DATE,
    fecha_fin_param DATE DEFAULT NULL
)
RETURNS TABLE (
    total_ventas BIGINT,
    monto_total NUMERIC
)
AS $$
BEGIN
    IF fecha_fin_param IS NULL THEN
        RETURN QUERY
        SELECT
            COUNT(orden_general_id) AS total_ventas,
            COALESCE(SUM(total), 0) AS monto_total
        FROM
            orden_general
        WHERE
            DATE_TRUNC('day', fecha) = DATE_TRUNC('day', fecha_inicio_param);
    ELSE
        RETURN QUERY
        SELECT
            COUNT(orden_general_id) AS total_ventas,
            COALESCE(SUM(total), 0) AS monto_total
        FROM
            orden_general
        WHERE
            fecha BETWEEN fecha_inicio_param AND fecha_fin_param;
    END IF;
END;
$$ LANGUAGE plpgsql;
