-- pruebas Realizadas 
SELECT codigo_barras, stock FROM producto WHERE codigo_barras = '750100000001';

SELECT folio_venta, monto_total FROM venta WHERE folio_venta = 'VENT-001';

SELECT * FROM detalle_venta WHERE folio_venta = 'VENT-001';

UPDATE detalle_venta
SET cantidad = 4
WHERE folio_venta = 'VENT-001'
AND codigo_barras = '750100000001';

SELECT codigo_barras, stock 
FROM producto 
WHERE codigo_barras = '750100000001';
SELECT * FROM detalle_venta WHERE folio_venta = 'VENT-001';

SELECT folio_venta, monto_total 
FROM venta 
WHERE folio_venta = 'VENT-001';


--Pruebas realizadas para trigger venta y stock
--Para ver todos los triggers
SELECT tgname, tgrelid::regclass
FROM pg_trigger
WHERE NOT tgisinternal;
--Prueba para insert before

INSERT INTO detalle_venta (folio_venta, codigo_barras, cantidad, precio_unitario_aplicado)
VALUES ('VENT-001', '750100000006', 2, 6.00);
--prueba para ver stock actualizado

SELECT codigo_barras, stock
FROM producto
WHERE codigo_barras = '750100000006';


--Veridicacion si se creo el registro con subtotal
SELECT *
FROM detalle_venta
WHERE folio_venta = 'VENT-001'
  AND codigo_barras = '750100000006';

  --prueba para trigger update

  UPDATE detalle_venta
SET cantidad = 5
WHERE folio_venta = 'VENT-001'
  AND codigo_barras = '750100000006';

  --prueba para stock actualizado otra vez

  SELECT codigo_barras, stock
FROM producto
WHERE codigo_barras = '750100000006';

--prueba para subtotal recalculado

SELECT *
FROM detalle_venta
WHERE folio_venta = 'VENT-001'
  AND codigo_barras = '750100000006';

  --prueba para monto total actualizado

  SELECT folio_venta, monto_total
FROM venta
WHERE folio_venta = 'VENT-001';





-------------------------------------------




CREATE OR REPLACE FUNCTION actualizar_venta_update()
RETURNS TRIGGER AS $$
DECLARE
    stock_original INT;
    stock_despues INT;
    subtotal_anterior DECIMAL(10,2);
    subtotal_nuevo DECIMAL(10,2);
BEGIN
    -- 1. Recuperar el subtotal anterior
    subtotal_anterior := OLD.subtotal_articulo;

    -- 2. Regresar lo que se había apartado antes
    UPDATE producto
    SET stock = stock + OLD.cantidad
    WHERE codigo_barras = OLD.codigo_barras;

    -- 3. Verificar Stock disponible para la NUEVA cantidad
    SELECT stock INTO stock_despues
    FROM producto
    WHERE codigo_barras = NEW.codigo_barras;

    -- REGLA: Abortar si llega a cero (insuficiente para cubrir la nueva demanda) "ESTA EN EL PDF del profe"
    IF stock_despues < NEW.cantidad THEN
        RAISE EXCEPTION 'Stock insuficiente. Disponibles: %, Solicitados: %', stock_despues, NEW.cantidad;
    END IF;

    -- 4. Descontar la nueva cantidad
    UPDATE producto
    SET stock = stock - NEW.cantidad
    WHERE codigo_barras = NEW.codigo_barras;

    -- REGLA: Alerta de Stock Bajo "Está EN EL PDF del profe"
    -- Verificamos cuánto quedó después de la resta
    IF (stock_despues - NEW.cantidad) < 3 THEN
        RAISE NOTICE 'ALERTA: El stock del producto % es bajo (Quedan %)', NEW.codigo_barras, (stock_despues - NEW.cantidad);
    END IF;

    -- 5. Recalcular subtotal
    subtotal_nuevo := NEW.cantidad * NEW.precio_unitario_aplicado;
    NEW.subtotal_articulo := subtotal_nuevo;

    -- 6. Actualizar monto_total en tabla VENTA
    UPDATE venta
    SET monto_total = COALESCE(monto_total, 0) - subtotal_anterior + subtotal_nuevo
    WHERE folio_venta = NEW.folio_venta;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger asociado
DROP TRIGGER IF EXISTS tr_update_detalle_venta ON detalle_venta;
CREATE TRIGGER tr_update_detalle_venta
BEFORE UPDATE ON detalle_venta
FOR EACH ROW
EXECUTE FUNCTION actualizar_venta_update();



--Trigger de Stock y venta

CREATE OR REPLACE FUNCTION actualizar_venta_insert()
RETURNS TRIGGER AS $$
DECLARE
    stock_actual INT;
    subtotal_nuevo DECIMAL(10,2);
BEGIN
    -- 1. Verificar stock actual
    SELECT stock INTO stock_actual
    FROM producto
    WHERE codigo_barras = NEW.codigo_barras;

    IF stock_actual < NEW.cantidad THEN
        RAISE EXCEPTION 'Stock insuficiente. Disponibles: %, Solicitados: %',
        stock_actual, NEW.cantidad;
    END IF;

    UPDATE producto
    SET stock = stock - NEW.cantidad
    WHERE codigo_barras = NEW.codigo_barras;

    subtotal_nuevo := NEW.cantidad * NEW.precio_unitario_aplicado;
    NEW.subtotal_articulo := subtotal_nuevo;

    UPDATE venta
    SET monto_total = COALESCE(monto_total, 0) + subtotal_nuevo
    WHERE folio_venta = NEW.folio_venta;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_insert_detalle_venta ON detalle_venta;

CREATE TRIGGER tr_insert_detalle_venta
BEFORE INSERT ON detalle_venta
FOR EACH ROW
EXECUTE FUNCTION actualizar_venta_insert();

-------------------------------------------


SELECT codigo_barras, stock
FROM producto
WHERE codigo_barras = '750100000001';

SELECT * FROM detalle_venta
WHERE folio_venta = 'VENT-001'
AND codigo_barras = '750100000001';


--   SELECT folio_venta, monto_total FROM venta WHERE folio_venta = 'VENT-001';
SELECT * FROM detalle_venta WHERE folio_venta = 'VENT-001';
UPDATE detalle_venta
SET cantidad = 5
WHERE folio_venta = 'VENT-001'
AND codigo_barras = '750100000001';


-------------------------------------------




-- 1. Crear tabla de auditoría
CREATE TABLE IF NOT EXISTS auditoria (
    id SERIAL PRIMARY KEY,
    tabla TEXT NOT NULL,
    operacion TEXT NOT NULL,
    usuario_bd TEXT NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT NOW(),
    antes JSONB,
    despues JSONB
);

-- 2. Crear la función fn_auditoria (Antes de los triggers)
CREATE OR REPLACE FUNCTION fn_auditoria() 
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO auditoria(tabla, operacion, usuario_bd, antes, despues)
        VALUES (TG_TABLE_NAME, TG_OP, SESSION_USER, NULL, row_to_json(NEW));
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO auditoria(tabla, operacion, usuario_bd, antes, despues)
        VALUES (TG_TABLE_NAME, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO auditoria(tabla, operacion, usuario_bd, antes, despues)
        VALUES (TG_TABLE_NAME, TG_OP, SESSION_USER, row_to_json(OLD), NULL);
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 3. Crear Triggers

-- CLIENTE
DROP TRIGGER IF EXISTS trg_auditoria_clientes ON cliente;
CREATE TRIGGER trg_auditoria_clientes
AFTER INSERT OR UPDATE OR DELETE ON cliente
FOR EACH ROW EXECUTE FUNCTION fn_auditoria();

-- PRODUCTO
CREATE TRIGGER trg_auditoria_productos
AFTER INSERT OR UPDATE OR DELETE ON producto
FOR EACH ROW EXECUTE FUNCTION fn_auditoria();

-- EMAIL_CLIENTE
CREATE TRIGGER trg_aud_email_cliente
AFTER INSERT OR UPDATE OR DELETE ON email_cliente
FOR EACH ROW EXECUTE FUNCTION fn_auditoria();

-- PROVEEDOR
CREATE TRIGGER trg_aud_proveedor
AFTER INSERT OR UPDATE OR DELETE ON proveedor
FOR EACH ROW EXECUTE FUNCTION fn_auditoria();

-- TELEFONO_PROVEEDOR
CREATE TRIGGER trg_aud_tel
AFTER INSERT OR UPDATE OR DELETE ON telefono_proveedor
FOR EACH ROW EXECUTE FUNCTION fn_auditoria();

-- VENTA
CREATE TRIGGER trg_aud_venta
AFTER INSERT OR UPDATE OR DELETE ON venta
FOR EACH ROW EXECUTE FUNCTION fn_auditoria();

-- DETALLE_VENTA
CREATE TRIGGER trg_aud_detalle
AFTER INSERT OR UPDATE OR DELETE ON detalle_venta
FOR EACH ROW EXECUTE FUNCTION fn_auditoria();