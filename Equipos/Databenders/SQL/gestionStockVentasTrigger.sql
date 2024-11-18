-- ========================================
-- Creación del trigger y función para manejar ventas y stock
-- Este script implementa la lógica requerida para decrementar el stock,
-- abortar la transacción si el stock es insuficiente, emitir alertas y actualizar totales.
-- ========================================

-- Función que se ejecutará antes de insertar en detalleventa
CREATE OR REPLACE FUNCTION fn_procesar_venta()
RETURNS TRIGGER AS $$
DECLARE
    stock_actual INT;
    nuevo_stock INT;
BEGIN
    -- Obtener el stock actual del producto
    SELECT cantidadstock INTO stock_actual
    FROM productos
    WHERE productoid = NEW.productoid;

    -- Verificar si se obtuvo el stock actual
    IF stock_actual IS NULL THEN
        RAISE EXCEPTION 'No se encontró el producto con ID %.', NEW.productoid;
    END IF;

    -- Calcular el nuevo stock
    nuevo_stock := stock_actual - NEW.cantidadproducto;

    -- Verificar si hay suficiente stock
    IF nuevo_stock < 0 THEN
        RAISE EXCEPTION 'Stock insuficiente para el producto ID %.', NEW.productoid;
        -- Abortará la transacción
    END IF;

    -- Actualizar el stock del producto
    UPDATE productos
    SET cantidadstock = nuevo_stock
    WHERE productoid = NEW.productoid;

    -- Emitir alerta si el nuevo stock es menor que 3
    IF nuevo_stock < 3 THEN
        RAISE NOTICE 'Alerta: El stock del producto ID % es menor que 3 (Stock actual: %).', NEW.productoid, nuevo_stock;
        -- Aquí podrías implementar lógica adicional para enviar una notificación
    END IF;

    -- Calcular el precio total por artículo
    SELECT precioventa INTO NEW.preciototalarticulo
    FROM productos
    WHERE productoid = NEW.productoid;

    NEW.preciototalarticulo := NEW.cantidadproducto * NEW.preciototalarticulo;

    -- Actualizar el total a pagar por la venta
    UPDATE ventas
    SET cantidadtotalpagar = COALESCE(cantidadtotalpagar, 0) + NEW.preciototalarticulo
    WHERE ventaid = NEW.ventaid;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que llama a la función antes de insertar en detalleventa
CREATE TRIGGER trg_procesar_venta
BEFORE INSERT ON detalleventa
FOR EACH ROW
EXECUTE FUNCTION fn_procesar_venta();

-- ========================================
-- Uso del trigger en una transacción de ejemplo
-- ========================================

-- Ejemplo de inserción en detalleventa que activará el trigger
BEGIN;
INSERT INTO detalleventa (ventaid, productoid, cantidadproducto, clienteid)
VALUES (1, 1, 2, 1); -- Reemplaza con los IDs correspondientes
COMMIT;


-- ========================================
-- Script de prueba para el trigger 'trg_procesar_venta'
-- ========================================

-- 1. Verificar el stock actual del producto antes de la venta
SELECT productoid, nombre, cantidadstock
FROM productos
WHERE productoid = 1;

-- 2. Iniciar una transacción
BEGIN;

-- 3. Insertar un nuevo detalle de venta que activará el trigger
INSERT INTO detalleventa (ventaid, productoid, cantidadproducto, clienteid)
VALUES (1, 1, 2, 1);  -- Reemplaza los IDs si es necesario

-- 4. Confirmar la transacción
COMMIT;

-- 5. Verificar el stock del producto después de la venta
SELECT productoid, nombre, cantidadstock
FROM productos
WHERE productoid = 1;

-- 6. Verificar el precio total del artículo en detalleventa
SELECT detalleventaid, ventaid, productoid, cantidadproducto, preciototalarticulo
FROM detalleventa
WHERE ventaid = 1;

-- 7. Verificar el total a pagar por la venta
SELECT ventaid, folio, fechaventa, cantidadtotalpagar
FROM ventas
WHERE ventaid = 1;

