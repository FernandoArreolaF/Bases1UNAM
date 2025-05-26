------------------ INDICES ------------------

CREATE INDEX idx_articulo_nombre ON public.articulo(nom_articulo); --Acelera búsquedas por nombre de artículo
CREATE INDEX idx_cliente_rfc ON public.cliente(rfc_cliente); --Optimiza búsquedas por RFC de cliente
CREATE INDEX idx_empleado_num ON public.empleado(num_empleado); --Mejora búsquedas por número de empleado
CREATE INDEX idx_venta_fecha ON public.venta(fecha_venta); --Acelera consultas que filtran por fecha de venta

------------------ VISTAS ------------------

CREATE OR REPLACE VIEW vw_stock_art AS -- las siguiente lineas de codigo muestra información crítica sobre el stock de artículos, especialmente aquellos con baja disponibilidad
SELECT 
    codigo_barras,
    nom_articulo,
    precio_venta,
    precio_compra,
    CASE -- lista artículos con stock bajo (menos de 3 unidades) o agotados
        WHEN stock = 0 THEN 'No disponible'
        WHEN stock < 3 THEN 'Baja disponibilidad'
        ELSE 'Disponible'
    END AS disponibilidad,
    stock,
    id_categoria
FROM public.articulo
WHERE stock < 3 OR stock = 0
ORDER BY stock ASC;

CREATE OR REPLACE VIEW vw_ticket_venta AS --Proporciona una vista detallada de los tickets de venta
SELECT 
    v.folio_venta,
    v.fecha_venta,
    a.nom_articulo,
    t.cantidad,
    t.precio_unitario,
    t.subtotal,
    v.monto_total,
    CONCAT(emp_vende.nombre_pila, ' ', emp_vende.apellido_paterno) AS vendedor,
    CONCAT(emp_cobra.nombre_pila, ' ', emp_cobra.apellido_paterno) AS cajero,
    s.nom_sucursal,
    COALESCE(c.razon_socialc, 'Cliente no registrado') AS cliente
FROM venta v
JOIN ticket t ON v.folio_venta = t.folio_venta
JOIN articulo a ON t.codigo_barras = a.codigo_barras
JOIN empleado emp_vende ON v.id_vendedor = emp_vende.num_empleado
JOIN empleado emp_cobra ON v.id_cajero = emp_cobra.num_empleado
JOIN sucursal s ON v.id_sucrusal = s.id_sucursal
LEFT JOIN cliente c ON v.rfc_cliente = c.rfc_cliente;

CREATE OR REPLACE VIEW vw_organigrama AS -- Esta funcion muestra la estructura organizacional de los empleados
SELECT 
    e.num_empleado,
    e.nombre_pila || ' ' || e.apellido_paterno AS nombre,
    e.tipo_empleado,
    e.id_supervisor,
    s.nombre_pila || ' ' || s.apellido_paterno AS nombre_supervisor
FROM empleado e
LEFT JOIN empleado s ON e.id_supervisor = s.num_empleado
ORDER BY e.id_supervisor NULLS FIRST, e.num_empleado; --Ordena jerárquicamente tanto los empleados primero y sus supervisores

------------------ FUNCIONES ------------------

CREATE OR REPLACE FUNCTION venta( --Registra una ventana en el sistema
    p_vendedor_id VARCHAR(10),
    p_cajero_id VARCHAR(10),
    p_cliente_rfc VARCHAR(13) DEFAULT NULL,
    p_articulos_codigos BIGINT[] DEFAULT NULL,
    p_articulos_cantidades INTEGER[] DEFAULT NULL
)
RETURNS VARCHAR(10) AS $$
DECLARE
    v_folio_venta VARCHAR(10);
    v_sucursal_id INTEGER;
    v_monto_total NUMERIC(10,2) := 0;
    v_cantidad_total INTEGER := 0;
    v_precio_articulo NUMERIC(10,2);
    v_stock_actual INTEGER;
    i INTEGER;
BEGIN
    -- Validación de empleados
    IF NOT EXISTS (SELECT 1 FROM empleado WHERE num_empleado = p_vendedor_id) THEN
        RAISE EXCEPTION 'Vendedor no encontrado';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM empleado WHERE num_empleado = p_cajero_id) THEN
        RAISE EXCEPTION 'Cajero no encontrado';
    END IF;

    -- Obtener sucursal (debe ser la misma para ambos)
    SELECT e1.id_sucursal INTO v_sucursal_id
    FROM empleado e1
    JOIN empleado e2 ON e1.id_sucursal = e2.id_sucursal
    WHERE e1.num_empleado = p_vendedor_id AND e2.num_empleado = p_cajero_id;
    
    IF v_sucursal_id IS NULL THEN
        RAISE EXCEPTION 'Vendedor y cajero deben pertenecer a la misma sucursal';
    END IF;

    -- Validar cliente si se proporcionó
    IF p_cliente_rfc IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cliente WHERE rfc_cliente = p_cliente_rfc) THEN
        RAISE EXCEPTION 'Cliente no registrado';
    END IF;

    -- Procesar artículos si se proporcionaron
    IF p_articulos_codigos IS NOT NULL THEN
        -- Validar coincidencia de arrays
        IF array_length(p_articulos_codigos, 1) != array_length(p_articulos_cantidades, 1) THEN
            RAISE EXCEPTION 'La cantidad de códigos y cantidades no coincide';
        END IF;

        -- Procesar cada artículo
        FOR i IN 1..array_length(p_articulos_codigos, 1) LOOP
            -- Obtener precio y stock del artículo
            SELECT precio_venta, stock INTO v_precio_articulo, v_stock_actual
            FROM articulo
            WHERE codigo_barras = p_articulos_codigos[i];
            
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Artículo con código % no encontrado', p_articulos_codigos[i];
            END IF;
            
            -- Verificar stock suficiente
            IF v_stock_actual < p_articulos_cantidades[i] THEN
                RAISE EXCEPTION 'Stock insuficiente para el artículo % (disponible: %, solicitado: %)', 
                                p_articulos_codigos[i], v_stock_actual, p_articulos_cantidades[i];
            END IF;
            
            -- Acumular totales
            v_monto_total := v_monto_total + (p_articulos_cantidades[i] * v_precio_articulo);
            v_cantidad_total := v_cantidad_total + p_articulos_cantidades[i];
        END LOOP;
    END IF;

    -- Registrar la venta 

    INSERT INTO venta (
        monto_total,
        cantidad_total_articulos,
        id_vendedor,
        id_cajero,
        id_sucrusal,  
        rfc_cliente
    ) VALUES (
        v_monto_total,
        v_cantidad_total,
        p_vendedor_id,
        p_cajero_id,
        v_sucursal_id,
        p_cliente_rfc
    ) RETURNING folio_venta INTO v_folio_venta;

    -- Registrar detalles del ticket y actualizar stock
    IF p_articulos_codigos IS NOT NULL THEN
        FOR i IN 1..array_length(p_articulos_codigos, 1) LOOP
            -- Obtener precio nuevamente para consistencia
            SELECT precio_venta INTO v_precio_articulo
            FROM articulo
            WHERE codigo_barras = p_articulos_codigos[i];
            
            -- Registrar en ticket (el subtotal se calcula automáticamente)
            INSERT INTO ticket (
                folio_venta,
                codigo_barras,
                cantidad,
                precio_unitario
            ) VALUES (
                v_folio_venta,
                p_articulos_codigos[i],
                p_articulos_cantidades[i],
                v_precio_articulo
            );
            
            -- Actualizar stock
            UPDATE articulo
            SET stock = stock - p_articulos_cantidades[i]
            WHERE codigo_barras = p_articulos_codigos[i];
        END LOOP;
    END IF;

    RETURN v_folio_venta;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION reporteIngresos(anio INTEGER)
RETURNS TABLE (
    sucursal VARCHAR,
    enero NUMERIC,
    febrero NUMERIC,
    marzo NUMERIC,
    abril NUMERIC,
    mayo NUMERIC,
    junio NUMERIC,
    julio NUMERIC,
    agosto NUMERIC,
    septiembre NUMERIC,
    octubre NUMERIC,
    noviembre NUMERIC,
    diciembre NUMERIC,
    total_anual NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.nom_sucursal AS sucursal,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 1 THEN v.monto_total ELSE 0 END) AS enero,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 2 THEN v.monto_total ELSE 0 END) AS febrero,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 3 THEN v.monto_total ELSE 0 END) AS marzo,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 4 THEN v.monto_total ELSE 0 END) AS abril,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 5 THEN v.monto_total ELSE 0 END) AS mayo,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 6 THEN v.monto_total ELSE 0 END) AS junio,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 7 THEN v.monto_total ELSE 0 END) AS julio,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 8 THEN v.monto_total ELSE 0 END) AS agosto,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 9 THEN v.monto_total ELSE 0 END) AS septiembre,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 10 THEN v.monto_total ELSE 0 END) AS octubre,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 11 THEN v.monto_total ELSE 0 END) AS noviembre,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 12 THEN v.monto_total ELSE 0 END) AS diciembre,
        SUM(v.monto_total) AS total_anual
    FROM sucursal s
    LEFT JOIN venta v ON s.id_sucursal = v.id_sucrusal AND EXTRACT(YEAR FROM v.fecha_venta) = anio
    GROUP BY s.nom_sucursal
    ORDER BY total_anual DESC;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION reporteInventario() -- Proporciona un reporte completo del estado del inventario
RETURNS TABLE ( -- Esta es la informacion que implementa información básica del artículo (código, nombre, categoría)
    codigo_barras BIGINT,
    articulo VARCHAR(100),
    categoria VARCHAR(100),
    stock_actual INTEGER,
    estado_stock TEXT,
    reporteVentas INTEGER,
    restock TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.codigo_barras,
        a.nom_articulo,
        c.nom_categoria,
        a.stock,
        
        -- Estado del stock según cantidad
        CASE --Stock actual y estado (AGOTADO, BAJO, MEDIO, NORMAL)
            WHEN a.stock = 0 THEN 'AGOTADO'
            WHEN a.stock < 3 THEN 'BAJO'
            WHEN a.stock < 10 THEN 'MEDIO'
            ELSE 'NORMAL'
        END AS estado_stock,
        
        -- Ventas de los últimos 30 días
        (
            SELECT COALESCE(SUM(t.cantidad), 0)
            FROM ticket t
            JOIN venta v ON t.folio_venta = v.folio_venta
            WHERE t.codigo_barras = a.codigo_barras
              AND v.fecha_venta >= CURRENT_DATE - INTERVAL '30 days'
        ) AS reporteVentas,
        
        -- Sugerencia de reposición sencilla
        CASE 
            WHEN a.stock = 0 THEN 'REPONER URGENTE'
            WHEN a.stock < 3 THEN 'REPONER PRONTO'
            WHEN a.stock < 10 THEN 'REVISAR STOCK'
            ELSE 'STOCK DISPONIBLE'
        END AS restock

    FROM articulo a
    JOIN categoria c ON a.id_categoria = c.id_categoria
    ORDER BY a.stock ASC;
END;
$$ LANGUAGE plpgsql;


------------------ DASHBOARD ------------------

-- Ingresos mensuales
SELECT 
    s.nom_sucursal,
    EXTRACT(MONTH FROM v.fecha_venta) AS mes,
    SUM(v.monto_total) AS ingresos
FROM public.venta v
JOIN public.sucursal s ON v.id_sucrusal = s.id_sucursal
WHERE EXTRACT(YEAR FROM v.fecha_venta) = 2025  -- Año específico
GROUP BY s.nom_sucursal, EXTRACT(MONTH FROM v.fecha_venta)
ORDER BY s.nom_sucursal, mes;

-- Articulo más vendido / Mayor ganancia

SELECT 
    c.nom_categoria,
    a.nom_articulo,
    SUM(t.cantidad) AS total_vendido,
    SUM(t.subtotal) AS ingresos_totales
FROM public.ticket t
JOIN public.articulo a ON t.codigo_barras = a.codigo_barras
JOIN public.categoria c ON a.id_categoria = c.id_categoria
GROUP BY c.nom_categoria, a.nom_articulo
ORDER BY 
    ingresos_totales DESC, 
    total_vendido DESC;


-- Comparativo de sucursales
SELECT 
    s.nom_sucursal,
    COUNT(v.folio_venta) AS total_ventas,
    SUM(v.monto_total) AS ingresos_totales
FROM venta v
JOIN sucursal s ON v.id_sucrusal = s.id_sucursal
WHERE v.fecha_venta >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY s.nom_sucursal
ORDER BY ingresos_totales DESC;


-- Consulta para KPIs principales
SELECT 
    COUNT(DISTINCT v.folio_venta) AS total_ventas,
    COALESCE(SUM(v.monto_total), 0) AS ingresos_totales,
    CASE WHEN COUNT(DISTINCT v.folio_venta) > 0 
         THEN ROUND(AVG(v.monto_total)::numeric, 2) 
         ELSE 0 
    END AS ticket_promedio,
    COUNT(DISTINCT v.rfc_cliente) AS clientes_activos,
    (SELECT COUNT(*) FROM articulo WHERE stock < 5) AS articulos_stock_bajo
FROM venta v
WHERE v.fecha_venta >= CURRENT_DATE - INTERVAL '30 days'
  AND v.fecha_venta <= CURRENT_DATE + INTERVAL '1 day';  



SELECT s.nom_sucursal, SUM(v.monto_total) AS ventas_totales
FROM venta v JOIN sucursal s ON v.id_sucrusal = s.id_sucursal
GROUP BY s.nom_sucursal;


------------------ TRIGGERS ------------------

CREATE OR REPLACE FUNCTION validar_sucursal_empleados()
RETURNS TRIGGER AS $$
DECLARE
    sucursal_vendedor INTEGER;
    sucursal_cajero INTEGER;
BEGIN
    -- Buscar la sucursal del vendedor
    SELECT id_sucursal INTO sucursal_vendedor
    FROM empleado
    WHERE num_empleado = NEW.id_vendedor;
    
    -- Buscar la sucursal del cajero
    SELECT id_sucursal INTO sucursal_cajero
    FROM empleado
    WHERE num_empleado = NEW.id_cajero;
    
    -- Comparar sucursales
    IF sucursal_vendedor <> sucursal_cajero THEN
        RAISE EXCEPTION 'El vendedor y cajero deben pertenecer a la misma sucursal';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_validar_sucursal_empleados
BEFORE INSERT OR UPDATE ON venta
FOR EACH ROW
EXECUTE FUNCTION validar_sucursal_empleados();


---------- Disponiblidad

CREATE OR REPLACE FUNCTION validar_stock_articulo()
RETURNS TRIGGER AS $$
DECLARE
    disponibilidad INTEGER;
BEGIN
    -- Buscar cuántos artículos hay disponibles
    SELECT stock INTO disponibilidad
    FROM articulo
    WHERE codigo_barras = NEW.codigo_barras;

    -- Si no hay suficientes, mostrar un error
    IF disponibilidad < NEW.cantidad THEN
        RAISE EXCEPTION 'No hay suficiente stock. Solo hay % unidades disponibles.', disponibilidad;
    END IF;

    -- Si todo está bien, continuar
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--------- ACTUALIZAR STOCK

CREATE OR REPLACE FUNCTION actualizar_stock_venta()
RETURNS TRIGGER AS $$
BEGIN
    -- Restar la cantidad vendida del stock del artículo
    UPDATE articulo
    SET stock = stock - NEW.cantidad
    WHERE codigo_barras = NEW.codigo_barras;

    -- Continuar con la operación
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


----------- ACTUALIZAR TOTALES DE VENTAS



-- Función para actualizar el total de una venta automáticamente
CREATE OR REPLACE FUNCTION actualizar_totales_venta()
RETURNS TRIGGER AS $$
BEGIN
    -- Actualiza el total y la cantidad de artículos en la tabla venta
    UPDATE venta
    SET 
        monto_total = COALESCE((SELECT SUM(subtotal) FROM ticket WHERE folio_venta = NEW.folio_venta), 0),
        cantidad_total_articulos = COALESCE((SELECT SUM(cantidad) FROM ticket WHERE folio_venta = NEW.folio_venta), 0)
    WHERE folio_venta = NEW.folio_venta;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que ejecuta la función después de cambios en la tabla ticket
CREATE TRIGGER tr_actualizar_totales
AFTER INSERT OR UPDATE OR DELETE ON ticket
FOR EACH ROW
EXECUTE FUNCTION actualizar_totales_venta();
