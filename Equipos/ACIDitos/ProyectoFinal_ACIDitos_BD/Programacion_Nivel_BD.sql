-- ÏNDICE
CREATE INDEX idx_orden_fecha ON orden(fecha_hora);
-- Dado que el sistema debe reportar ventas diarias de meseros y consultar totales por periodos de tiempo
-- (fechas de inicio y fin), este índice optimizará significativamente la velocidad de esas búsquedas,
-- evitando que el DBMS revise toda la tabla al hacer los reportes.


-- TRIGGERS 
-- TRIGGER PREFIJO 'ORD-001'
CREATE SEQUENCE seq_folio_orden START 1;

-- Función del trigger
CREATE OR REPLACE FUNCTION generar_folio_orden()
RETURNS TRIGGER AS $$
BEGIN
    -- Concatena 'ORD-' con el número secuencial rellenado con ceros (LPAD)
    IF NEW.folio_orden IS NULL THEN
        NEW.folio_orden := 'ORD-' || LPAD(nextval('seq_folio_orden')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Disparador
CREATE TRIGGER trg_generar_folio
BEFORE INSERT ON orden
FOR EACH ROW EXECUTE FUNCTION generar_folio_orden();


-- TRIGGER ACTUALIZACION PRODUCTO
-- Función del trigger
CREATE OR REPLACE FUNCTION validar_y_calcular_detalle()
RETURNS TRIGGER AS $$
DECLARE
    disp BOOLEAN;
    val_precio NUMERIC(10,2);
BEGIN
    -- Validar disponibilidad y precio
    SELECT disponibilidad, precio INTO disp, val_precio
    FROM producto
    WHERE id_producto = NEW.id_producto;
	
	IF disp IS NULL THEN
    RAISE EXCEPTION 'El producto no existe.';
	END IF;
	
    IF NOT disp THEN
        RAISE EXCEPTION 'El producto seleccionado no está disponible en este momento.';
    END IF;

    -- Asignar el precio unitario del catálogo si no se envía explícitamente
    IF NEW.precio_unitario IS NULL THEN
        NEW.precio_unitario := val_precio;
    END IF;

    -- Calcular el subtotal por producto (cantidad * precio)
    NEW.subtotal := NEW.cantidad * NEW.precio_unitario;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Disparador
CREATE TRIGGER trg_validar_calcular_detalle
BEFORE INSERT ON historial_orden
FOR EACH ROW EXECUTE FUNCTION validar_y_calcular_detalle();

-- TRIGGER ACTUALIZACIÓN VENTA
-- Función del trigger
CREATE OR REPLACE FUNCTION actualizar_total_orden()
RETURNS TRIGGER AS $$
BEGIN
    -- Si es una inserción o actualización
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        UPDATE orden
        SET total = (
            SELECT COALESCE(SUM(subtotal), 0) 
            FROM historial_orden 
            WHERE folio_orden = NEW.folio_orden
        )
        WHERE folio_orden = NEW.folio_orden;
        RETURN NEW;
        
    -- Si se elimina un detalle de la orden
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE orden
        SET total = (
            SELECT COALESCE(SUM(subtotal), 0) 
            FROM historial_orden 
            WHERE folio_orden = OLD.folio_orden
        )
        WHERE folio_orden = OLD.folio_orden;
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Disparador
CREATE TRIGGER trg_actualizar_total
AFTER INSERT OR UPDATE OR DELETE ON historial_orden
FOR EACH ROW EXECUTE FUNCTION actualizar_total_orden();

-- VISTAS
-- PLATILLO MAS VENDIDO
CREATE OR REPLACE VIEW vista_platillo_mas_vendido AS
SELECT p.*, SUM(h.cantidad) AS total_vendido
FROM producto p
JOIN historial_orden h
ON p.id_producto = h.id_producto
WHERE p.tipo_producto = 'PLATILLO'
GROUP BY p.id_producto
ORDER BY total_vendido DESC
LIMIT 1;

-- SIMULA FACTURA
CREATE OR REPLACE VIEW vista_factura_orden AS
SELECT 
    f.id_factura,
    f.fecha_factura,
    c.rfc_cliente,
    c.nombre || ' ' || c.apellido_paterno AS cliente,
    c.razon_social,
    o.folio_orden,
    o.fecha_hora AS fecha_consumo,
    p.nombre AS producto,
    h.cantidad,
    h.precio_unitario,
    h.subtotal,
    o.total AS total_orden
FROM factura f
JOIN cliente c ON f.rfc_cliente = c.rfc_cliente
JOIN orden o ON f.folio_orden = o.folio_orden
JOIN historial_orden h ON o.folio_orden = h.folio_orden
JOIN producto p ON h.id_producto = p.id_producto;


-- CONSULTAS
-- PRODUCTOS NO DISPONIBLES
CREATE OR REPLACE VIEW vista_productos_agotados AS
SELECT nombre 
FROM producto 
WHERE disponibilidad = FALSE;


-- FUNCIONES
-- VENTAS POR MESERO
CREATE OR REPLACE FUNCTION reporte_diario_mesero(p_id_empleado INT)
RETURNS TABLE (cantidad_ordenes BIGINT, total_recaudado NUMERIC) AS $$
DECLARE
    val_mesero BOOLEAN;
BEGIN
    -- Validar si el empleado es mesero
    SELECT EXISTS(SELECT 1 FROM mesero WHERE id_empleado = p_id_empleado) INTO val_mesero;
    
    IF NOT val_mesero THEN
        RAISE EXCEPTION 'Error: El empleado no tiene el puesto de mesero.';
    END IF;

    -- Retornar la consulta filtrada al día actual
    RETURN QUERY 
    SELECT COUNT(folio_orden), COALESCE(SUM(total), 0)
    FROM orden
    WHERE id_mesero = p_id_empleado AND DATE(fecha_hora) = CURRENT_DATE;
END;
$$ LANGUAGE plpgsql;

-- VENTAS POR PERIODO
CREATE OR REPLACE FUNCTION reporte_ventas_periodo(fecha_inicio DATE, fecha_fin DATE DEFAULT NULL)
RETURNS TABLE (numero_ventas BIGINT, monto_total NUMERIC) AS $$
BEGIN
    -- Si no se proporciona fecha_fin, se asume que es de un solo dia
    IF fecha_fin IS NULL THEN
        fecha_fin := fecha_inicio;
    END IF;

    RETURN QUERY 
    SELECT COUNT(folio_orden), COALESCE(SUM(total), 0)
    FROM orden
    WHERE DATE(fecha_hora) BETWEEN fecha_inicio AND fecha_fin;
END;
$$ LANGUAGE plpgsql;