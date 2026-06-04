--TRIGGERS

-- TRIGGER 1: Valida disponibilidad y calcula el precio por producto (Cantidad * Precio)
CREATE OR REPLACE FUNCTION fn_calcular_detalle_orden()
RETURNS TRIGGER AS $$
DECLARE
    v_precio NUMERIC(10,2);
    v_disponible BOOLEAN;
BEGIN
    -- Obtenemos el precio y disponibilidad del producto
    SELECT precio, disponibilidad INTO v_precio, v_disponible
    FROM producto 
    WHERE id_producto = NEW.id_producto;

    -- Validar disponibilidad
    IF NOT v_disponible THEN
        RAISE EXCEPTION 'El producto ID % no se encuentra disponible actualmente.', NEW.id_producto;
    END IF;

    -- Calcular el total del producto (Nombre de columna corregido)
    NEW.precio_total_producto := NEW.cantidad * v_precio;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calcular_detalle_orden
BEFORE INSERT OR UPDATE ON producto_orden
FOR EACH ROW EXECUTE FUNCTION fn_calcular_detalle_orden();


-- TRIGGER 2: Actualiza el montoTotal de la Orden cada vez que se agrega/elimina un producto
CREATE OR REPLACE FUNCTION fn_actualizar_total_orden()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        -- Usamos folio_orden, monto_total y precio_total_producto
        UPDATE orden 
        SET monto_total = (SELECT COALESCE(SUM(precio_total_producto), 0) FROM producto_orden WHERE folio_orden = OLD.folio_orden)
        WHERE folio_orden = OLD.folio_orden;
        RETURN OLD;
    ELSE
        -- Usamos folio_orden, monto_total y precio_total_producto
        UPDATE orden 
        SET monto_total = (SELECT COALESCE(SUM(precio_total_producto), 0) FROM producto_orden WHERE folio_orden = NEW.folio_orden)
        WHERE folio_orden = NEW.folio_orden;
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_actualizar_total_orden
AFTER INSERT OR UPDATE OR DELETE ON producto_orden
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_total_orden();


-- TRIGGER 3: Calcular la edad automáticamente a partir de la fecha de nacimiento
CREATE OR REPLACE FUNCTION fn_calcular_edad_empleado()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificamos que venga una fecha de nacimiento
    IF NEW.fecha_nacimiento IS NOT NULL THEN
        NEW.edad := EXTRACT(YEAR FROM age(CURRENT_DATE, NEW.fecha_nacimiento));
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calcular_edad_empleado
BEFORE INSERT OR UPDATE ON empleado
FOR EACH ROW EXECUTE FUNCTION fn_calcular_edad_empleado();


-- INDICES
-- Creación de un índice en la columna fecha_hora de la tabla orden
CREATE INDEX idx_orden_fecha ON orden(fecha_hora);

-- Creación de un índice en el rfc_cliente de la tabla factura
CREATE INDEX idx_factura_rfc ON factura(rfc_cliente);


-- FUNCIONES
-- Funcion 1: Determina el rendimiento de un mesero en un dia
CREATE OR REPLACE FUNCTION fn_rendimiento_mesero_hoy(p_num_empleado INT, OUT cantidad_ordenes INT, OUT total_cobrado NUMERIC)
AS $$
DECLARE
    v_es_mesero BOOLEAN;
BEGIN
    -- Validar si el empleado existe en la tabla subtipo 'mesero'
    SELECT EXISTS(SELECT 1 FROM mesero WHERE num_empleado = p_num_empleado) INTO v_es_mesero;
    
    IF NOT v_es_mesero THEN
        RAISE EXCEPTION 'Operación denegada. El empleado % no tiene el rol de mesero.', p_num_empleado;
    END IF;

    -- Calcular ventas del día (CURRENT_DATE)
    SELECT COUNT(folio), COALESCE(SUM(montoTotal), 0.00)
    INTO cantidad_ordenes, total_cobrado
    FROM orden
    WHERE num_empleado = p_num_empleado AND fecha::DATE = CURRENT_DATE;
END;
$$ LANGUAGE plpgsql;

--Funcion 2: Muestra las ventas por periodo especifico, ya sea con fecha de inicio y fin o solo fecha de inicio
CREATE OR REPLACE FUNCTION fn_ventas_por_periodo(p_fecha_inicio DATE, p_fecha_fin DATE DEFAULT NULL)
RETURNS TABLE (total_ventas BIGINT, monto_acumulado NUMERIC) AS $$
BEGIN
    -- Si no se provee fecha fin, se asume que se quiere consultar solo el día de inicio
    IF p_fecha_fin IS NULL THEN
        p_fecha_fin := p_fecha_inicio;
    END IF;

    RETURN QUERY
    -- Corregido: folio_orden, monto_total y fecha_hora
    SELECT COUNT(folio_orden), COALESCE(SUM(monto_total), 0.00)
    FROM orden
    WHERE fecha_hora::DATE BETWEEN p_fecha_inicio AND p_fecha_fin;
END;
$$ LANGUAGE plpgsql;


--Vistas

-- VISTA 1: Platillo más vendido (Muestra todos los detalles)
CREATE OR REPLACE VIEW vw_platillo_mas_vendido AS
SELECT p.*, v.total_vendido
FROM producto p
JOIN (
    -- Agrupamos y sumamos las cantidades vendidas, ordenadas de mayor a menor
    SELECT id_producto, SUM(cantidad) as total_vendido 
    FROM producto_orden 
    GROUP BY id_producto 
    ORDER BY total_vendido DESC 
    LIMIT 1
) v ON p.id_producto = v.id_producto;


-- VISTA 2: Nombres de productos no disponibles
CREATE OR REPLACE VIEW vw_productos_agotados AS
SELECT nombre 
FROM producto 
WHERE disponibilidad = FALSE;


-- VISTA 3: Simulación de Factura (Aplanando domicilios y nombres como solicitaste)
CREATE OR REPLACE VIEW vw_factura_orden AS
SELECT 
    o.folio_orden AS "Folio_Orden",
    o.fecha_hora AS "Fecha_Emision",
    f.rfc_cliente AS "RFC_Cliente",
    f.razon_social AS "Razon_Social",
    -- Composicion del nombre si aplica (si no es empresa)
    CONCAT_WS(' ', f.nombre_pila, f.apellido_paterno, f.apellido_materno) AS "Atencion_A",
    -- Composicion del domicilio
    CONCAT_WS(', ', f.calle || ' ' || f.numero, f.colonia, 'C.P. ' || f.codigo_postal, f.estado) AS "Domicilio_Fiscal",
    -- Agrupamos los platillos consumidos en una lista de texto separada por comas
    STRING_AGG(p.nombre || ' (x' || po.cantidad::TEXT || ')', ', ') AS "Conceptos",
    o.monto_total AS "Total_A_Pagar"
FROM orden o
JOIN factura f ON o.rfc_cliente = f.rfc_cliente
JOIN producto_orden po ON o.folio_orden = po.folio_orden
JOIN producto p ON po.id_producto = p.id_producto
GROUP BY o.folio_orden, o.fecha_hora, f.rfc_cliente, f.razon_social, f.nombre_pila, f.apellido_paterno, f.apellido_materno, f.calle, f.numero, f.colonia, f.codigo_postal, f.estado, o.monto_total;


-- Insercion
CREATE OR REPLACE PROCEDURE sp_orquestar_carga_diaria()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Iniciamos bloque transaccional simulado para atrapar errores
    RAISE NOTICE 'Iniciando ingesta de archivos del día...';

    BEGIN
        -- Suponiendo que el archivo está en el servidor local. 
        -- Nota: Requiere permisos de Superusuario o usar \copy desde terminal.
        EXECUTE 'COPY orden(folio, fecha, num_empleado, rfc_cliente) 
                 FROM ''/ruta/absoluta/al/archivo/ordenes_hoy.csv'' DELIMITER '','' CSV HEADER';
                 
        RAISE NOTICE 'Archivo de Órdenes cargado exitosamente.';

        EXECUTE 'COPY producto_orden(folio, id_producto, cantidad) 
                 FROM ''/ruta/absoluta/al/archivo/detalles_hoy.csv'' DELIMITER '','' CSV HEADER';
                 
        RAISE NOTICE 'Archivo de Detalles cargado exitosamente.';

    EXCEPTION
        -- Validación de flujo: Si algo falla (archivo no existe, formato incorrecto, llave foránea rota)
        WHEN unique_violation THEN
            RAISE WARNING 'Error de ingesta: Llave primaria duplicada detectada en el archivo. Se abortó la carga de este bloque.';
        WHEN foreign_key_violation THEN
            RAISE WARNING 'Error de ingesta: Un dato del archivo no existe en las tablas maestras (Ej. un empleado o rfc fantasma).';
        WHEN OTHERS THEN
            -- Captura cualquier otro error de sistema o formato de archivo
            RAISE WARNING 'Error fatal durante la ingesta de archivos: % %', SQLERRM, SQLSTATE;
            -- Al generar una excepción dentro de un bloque BEGIN...EXCEPTION,
            -- PostgreSQL hace automáticamente un ROLLBACK de estas inserciones fallidas.
    END;

    RAISE NOTICE 'Proceso de orquestación finalizado.';
END;
$$;

-- Pruebas
SELECT * FROM vw_factura_orden;

SELECT * FROM vw_productos_agotados;

SELECT * FROM fn_ventas_por_periodo('2026-05-01', '2026-05-31');