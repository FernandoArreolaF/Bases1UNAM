-- ============================================================
-- 05_funciones_consulta.sql
-- Función Órdenes del mesero en el día actual
-- Función Ventas por rango de fechas
-- Proyecto Final BD - Grupo 01
-- PostgreSQL
-- ============================================================



-- Función que recibe el número de empleado, verifica si es mesero y si sí lo es, 
-- cuenta las órdenes de su día y suma el dinero
CREATE OR REPLACE FUNCTION ordenes_mesero_hoy(p_num_empleado VARCHAR(10))
RETURNS TABLE (cantidad_ordenes BIGINT, total_cobrado NUMERIC) AS $$
DECLARE
    -- Bandera para validar si el empleado es mesero o no
    v_es_mesero BOOLEAN;
BEGIN
    -- Validamos en la tabla 'mesero' que el empleado realmente tenga este puesto
    SELECT EXISTS(SELECT 1 FROM mesero WHERE num_empleado = p_num_empleado) INTO v_es_mesero;

    -- Si no es mesero, lanzamos el error tal como pide el requerimiento
    IF NOT v_es_mesero THEN
        RAISE EXCEPTION 'Error: El empleado con número % no es un mesero válido.', p_num_empleado;
    END IF;

    -- Ejecuta la consulta y retorna los datos obtenidos
    RETURN QUERY
    SELECT 
        COUNT(folio)::BIGINT, 
        -- Usamos COALESCE por si el mesero no ha vendido nada hoy, para que devuelva 0 en vez de NULL
        COALESCE(SUM(total), 0)::NUMERIC 
    FROM orden
    WHERE num_empleado = p_num_empleado 
      AND fecha = CURRENT_DATE; -- Filtramos para que solo cuente lo del día de hoy
END;
$$ LANGUAGE plpgsql;



-- Función que recibe la fecha de inicio y la fecha de fin. Si la fecha no se envía,
-- se asume que solo queremos consultar las ventas de un día.

-- Se espera obtener el total de ventas y monto en un periodo de tiempo
CREATE OR REPLACE FUNCTION ventas_por_fechas(p_fecha_inicio DATE, p_fecha_fin DATE DEFAULT NULL)
RETURNS TABLE (total_ventas BIGINT, monto_total NUMERIC) AS $$
BEGIN
    -- Si no dan fecha_fin, se usa la misma que fecha_inicio para buscar en un solo día
    IF p_fecha_fin IS NULL THEN
        p_fecha_fin := p_fecha_inicio;
    END IF;

    -- Devolvemos el conteo de ventas y la suma total del dinero
    RETURN QUERY
    SELECT 
        COUNT(folio)::BIGINT,
        COALESCE(SUM(total), 0.00)::NUMERIC
    FROM orden
    WHERE fecha >= p_fecha_inicio 
      AND fecha <= p_fecha_fin;
END;
$$ LANGUAGE plpgsql;
