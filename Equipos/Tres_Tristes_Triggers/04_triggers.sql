-- 03_triggers.sql
-- Triggers del sistema de restaurante
-- Proyecto Final BD - Grupo 01
-- PostgreSQl
-- TRIGGER 1: Generacion automatica de folio en ORDEN
-- Se dispara BEFORE INSERT en ORDEN
-- Asigna automaticamente el folio con formato ORD-XXX

CREATE OR REPLACE FUNCTION fn_generar_folio_orden()
RETURNS TRIGGER AS $$
BEGIN
    -- Generar folio automaticamente usando la funcion generar_folio()
    NEW.folio := generar_folio();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_generar_folio ON ORDEN;

CREATE TRIGGER trg_generar_folio
    BEFORE INSERT ON ORDEN
    FOR EACH ROW
    EXECUTE FUNCTION fn_generar_folio_orden();

-- Comportamiento esperado:
-- INSERT INTO ORDEN (fecha, hora, num_empleado) VALUES (...)
-- -> El folio se asigna automaticamente: ORD-001, ORD-002, etc.
-- El usuario NO debe proporcionar el folio manualmente.



-- TRIGGER 2: Actualizacion de totales al INSERTAR en DETALLE_ORDEN
-- Valida disponibilidad del producto
-- Calcula precio_platillo = cantidad x precio del producto
-- Recalcula el total de la orden


CREATE OR REPLACE FUNCTION fn_insertar_detalle_orden()
RETURNS TRIGGER AS $$
DECLARE
    v_disponible    BOOLEAN;
    v_precio        NUMERIC(8,2);
    v_nombre        VARCHAR(40);
BEGIN
    --Verificamos que el producto exista y este disponible
    SELECT disponibilidad, precio, nombre
    INTO v_disponible, v_precio, v_nombre
    FROM PRODUCTO
    WHERE producto_id = NEW.producto_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El producto con ID % no existe.', NEW.producto_id;
    END IF;

    IF v_disponible = FALSE THEN
        RAISE EXCEPTION 'El producto "%" no esta disponible actualmente.', v_nombre;
    END IF;

    --Calcula el subtotal del detalle (cantidad x precio unitario)
    NEW.precio_platillo := NEW.cantidad * v_precio;

    --Recalcula el total de la orden sumando todos los subtotales
    UPDATE ORDEN
    SET total = (
        SELECT COALESCE(SUM(precio_platillo), 0) + NEW.precio_platillo
        FROM DETALLE_ORDEN
        WHERE folio = NEW.folio
    )
    WHERE folio = NEW.folio;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_insertar_detalle ON DETALLE_ORDEN;

CREATE TRIGGER trg_insertar_detalle
    BEFORE INSERT ON DETALLE_ORDEN
    FOR EACH ROW
    EXECUTE FUNCTION fn_insertar_detalle_orden();

-- Comportamiento esperado:
-- INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad) VALUES (...)
-- -> Si producto no disponible: EXCEPTION con mensaje descriptivo
-- -> Si disponible: precio_platillo = cantidad x precio
-- -> total en ORDEN se actualiza automaticamente


-- TRIGGER 3: Actualizacion de totales al ACTUALIZAR en DETALLE_ORDEN
-- Si se cambia la cantidad de un producto en la orden
-- recalcula el subtotal y el total de la orden


CREATE OR REPLACE FUNCTION fn_actualizar_detalle_orden()
RETURNS TRIGGER AS $$
DECLARE
    v_precio    NUMERIC(8,2);
BEGIN
    -- Obtener precio unitario actual del producto
    SELECT precio INTO v_precio
    FROM PRODUCTO
    WHERE producto_id = NEW.producto_id;

    -- Recalcular subtotal del detalle
    NEW.precio_platillo := NEW.cantidad * v_precio;

    -- Recalcular total de la orden
    UPDATE ORDEN
    SET total = (
        SELECT COALESCE(SUM(
            CASE
                WHEN folio = NEW.folio AND producto_id = NEW.producto_id
                THEN NEW.precio_platillo
                ELSE precio_platillo
            END
        ), 0)
        FROM DETALLE_ORDEN
        WHERE folio = NEW.folio
    )
    WHERE folio = NEW.folio;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_actualizar_detalle ON DETALLE_ORDEN;

CREATE TRIGGER trg_actualizar_detalle
    BEFORE UPDATE ON DETALLE_ORDEN
    FOR EACH ROW
    EXECUTE FUNCTION fn_actualizar_detalle_orden();


-- Comportamiento esperado:
-- UPDATE DETALLE_ORDEN SET cantidad = 3 WHERE folio = 'ORD-001' AND producto_id = 1
-- -> precio_platillo se recalcula con la nueva cantidad
-- -> total de ORDEN se recalcula sumando todos los subtotales actualizados


-- TRIGGER 4: Actualizacion de totales al ELIMINAR en DETALLE_ORDEN
-- Si se elimina un producto de la orden
-- recalcula el total de la orden


CREATE OR REPLACE FUNCTION fn_eliminar_detalle_orden()
RETURNS TRIGGER AS $$
BEGIN
    --Recalcula el total de la orden sin el registro eliminado
    UPDATE ORDEN
    SET total = (
        SELECT COALESCE(SUM(precio_platillo), 0)
        FROM DETALLE_ORDEN
        WHERE folio = OLD.folio
          AND producto_id != OLD.producto_id
    )
    WHERE folio = OLD.folio;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_eliminar_detalle ON DETALLE_ORDEN;

CREATE TRIGGER trg_eliminar_detalle
    AFTER DELETE ON DETALLE_ORDEN
    FOR EACH ROW
    EXECUTE FUNCTION fn_eliminar_detalle_orden();



