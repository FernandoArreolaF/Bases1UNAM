/* ============================================================
   FUNCIONES
============================================================

ACTUALIZAR TOTALES Y VALIDAR DISPONIBILIDAD
   Con esta función cada que se agrega un producto a detalle_orden:
   1)Valida que el producto exista.
   2)Valida que esté disponible.
   3)Calcula subtotal_prod = cant_prod * precio.
   4)Actualiza total_pagar de la orden.
*/

-- Aquí se valida la disponibilidad y se calcula el subtotal del producto
CREATE FUNCTION fn_calcular_subtotal()
RETURNS TRIGGER AS $$
DECLARE
    precio_prod NUMERIC(10,2);
    disponible BOOLEAN;
BEGIN
    SELECT precio, disponibilidad
    INTO precio_prod, disponible
    FROM producto
    WHERE id_producto = NEW.id_producto;

    IF precio_prod IS NULL THEN
        RAISE EXCEPTION 'El producto con id % no existe.', NEW.id_producto;
    END IF;

    IF disponible = FALSE THEN
        RAISE EXCEPTION 'El producto con id % no está disponible.', NEW.id_producto;
    END IF;

    NEW.subtotal_prod := NEW.cant_prod * precio_prod; -- Aquí se calcula el total por producto

    RETURN NEW; --Regresa el registro nuevo ya modificado
END;
$$ LANGUAGE plpgsql;


--Acá se actualiza el total de la orden
CREATE FUNCTION fn_actualizar_totalOrden()
RETURNS TRIGGER AS $$
DECLARE
    v_folio VARCHAR(10); --Acá se guarda el folio de la orden que debe actualizarse
BEGIN
    IF TG_OP = 'DELETE' THEN --TG_OP guarda qué operación activó el trigger (INSERT, UPDATE O DELETE)
        v_folio := OLD.folio; --Si es DELETE el folio se encuentra en OLD, porque el registro ya no existe
    ELSE
        v_folio := NEW.folio; --Si es UPDATE O INSERT el folio se encuentra en NEW
    END IF;

    UPDATE orden
    SET total_pagar = COALESCE(( --COALESCE sirve para evitar que el total quede en NULL, si no hay productos, queda en 0
        SELECT SUM(subtotal_prod)
        FROM detalle_orden
        WHERE folio = v_folio
    ), 0)
    WHERE folio = v_folio;

    RETURN NULL; --Como este trigger se ejecuta después de insertar, actualizar o eliminar ya no necesita modificar el registro
END;
$$ LANGUAGE plpgsql;

/* 
    Esta función calcula el rendimiento de ventas dentro de un rango de fechas.
    Si no se manda fecha_fin_p, se toma la misma fecha de inicio.
    COUNT(o.folio) cuenta el total de órdenes y COALESCE evita que SUM regrese NULL,
    mostrando 0.00 cuando no hay ventas en ese periodo.
*/

CREATE OR REPLACE FUNCTION rendimiento_ventas(
    fecha_inicio_p TIMESTAMP,
    fecha_fin_p TIMESTAMP DEFAULT NULL
)
RETURNS TABLE (
    total_ventas INTEGER,
    monto_total NUMERIC(10,2)
) AS $$
BEGIN
    -- Si no se proporciona fecha de fin, se toma todo el día de la fecha inicial
    IF fecha_fin_p IS NULL THEN
        fecha_fin_p := fecha_inicio_p + INTERVAL '1 day';
    END IF;

    RETURN QUERY
    SELECT 
        COUNT(o.folio)::INTEGER AS total_ventas,
        COALESCE(SUM(o.total_pagar), 0.00)::NUMERIC(10,2) AS monto_total
    FROM orden o
    WHERE o.fecha BETWEEN fecha_inicio_p AND fecha_fin_p;
END;
$$ LANGUAGE plpgsql;


/* ============================================================
   FUNCION: RENDIMIENTO DEL MESERO
   Esta función permite consultar el rendimiento de un mesero dentro
   de un rango de fechas y horas.
   Recibe el número de empleado, una fecha/hora de inicio y una fecha/hora de fin.
   Si no se manda fecha/hora de fin, se toma la misma fecha/hora de inicio.
   Devuelve el total de órdenes registradas por ese mesero y el monto total
   vendido en esas órdenes.
   Si el número de empleado no corresponde a un mesero, se muestra un mensaje
   de error.
   ============================================================ */

CREATE OR REPLACE FUNCTION rendimiento_mesero(
    p_num_empleado INTEGER,
    p_fecha_inicio TIMESTAMP,
    p_fecha_fin TIMESTAMP DEFAULT NULL
)
RETURNS TABLE (
    total_ordenes INTEGER,
    monto_total NUMERIC(10,2)
) AS $$
DECLARE
    es_mesero BOOLEAN;
BEGIN
    -- Se verifica si el número de empleado corresponde a un mesero
    SELECT EXISTS (
        SELECT 1
        FROM mesero
        WHERE num_empleado = p_num_empleado
    ) INTO es_mesero;

    -- Si el empleado no es mesero, se detiene la función y se muestra un error
    IF NOT es_mesero THEN
        RAISE EXCEPTION 'El número de empleado % no corresponde a un mesero.', p_num_empleado;
    END IF;

    -- Si no se proporciona fecha de fin, se toma todo el día de la fecha inicial
    IF fecha_fin_p IS NULL THEN
        p_fecha_fin := p_fecha_inicio + INTERVAL '1 day';
    END IF;

    -- Si sí es mesero, se cuentan sus órdenes dentro del intervalo de fecha y hora definido
    RETURN QUERY
    SELECT 
        COUNT(o.folio)::INTEGER AS total_ordenes,
        -- COALESCE se utiliza para manejar el caso en que no haya órdenes, devolviendo 0 en lugar de NULL
        COALESCE(SUM(o.total_pagar), 0.00)::NUMERIC(10,2) AS monto_total
    FROM orden o
    WHERE o.num_mesero = p_num_empleado
      AND o.fecha BETWEEN p_fecha_inicio AND p_fecha_fin; -- Se consideran las órdenes dentro del intervalo de fecha y hora definido
END;
$$ LANGUAGE plpgsql;

/* ============================================================
   TRIGGERS PARA CALCULAR EL SUBTOTAL DE CADA PRODUCTO EN 
   DETALLE_ORDEN Y ACTUALIZAR EL TOTAL DE LA ORDEN CADA QUE SE INSERTA, 
   ACTUALIZA O ELIMINA UN PRODUCTO EN DETALLE_ORDEN.  
   ============================================================ */

--Trigger 1: antes de insertar o modificar un producto en la orden
CREATE TRIGGER trg_calcular_subtotal
BEFORE INSERT OR UPDATE OF id_producto, cant_prod
ON detalle_orden
FOR EACH ROW EXECUTE FUNCTION fn_calcular_subtotal();


--  Trigger 2: después de insertar, actualizar o eliminar detalle de orden
CREATE TRIGGER trg_actualizar_totalOrden
AFTER INSERT OR UPDATE OR DELETE
ON detalle_orden
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_totalOrden();


/* ============================================================
   PROCEDIMIENTO: AGREGAR PRODUCTO A ORDEN
   Este procedimiento agrega un producto a una orden existente.
   No calcula directamente el subtotal ni el total, porque eso ya lo hacen
   los triggers fn_calcular_subtotal() y fn_actualizar_totalOrden()
   ============================================================ */

CREATE PROCEDURE sp_agregar_producto_orden(
    p_folio VARCHAR(10),
    p_id_producto INTEGER,
    p_cant_prod INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    --se valida que la orden exista
    IF NOT EXISTS (
        SELECT 1
        FROM orden
        WHERE folio = p_folio
    ) THEN
        RAISE EXCEPTION 'La orden % no existe.', p_folio;
    END IF;

    --Valida que la cantidad sea mayor a cero
    IF p_cant_prod <= 0 THEN
        RAISE EXCEPTION 'La cantidad debe ser mayor a 0.';
    END IF;

    --iserta producto en la orden y se activan los triggers.
    INSERT INTO detalle_orden (folio, id_producto, cant_prod)
    VALUES (p_folio, p_id_producto, p_cant_prod);

    RAISE NOTICE 'Producto % agregado correctamente a la orden %.', p_id_producto, p_folio;
END;
$$;