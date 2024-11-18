-- ========================================
-- Script: actualizar_productos_stock_bajo.sql
-- Descripción:
-- Crea una tabla independiente 'productos_stock_bajo' que almacena los productos
-- con menos de 3 unidades en stock. Se implementan triggers para mantener
-- esta tabla actualizada cada vez que cambia el stock en la tabla 'productos'.
-- ========================================

-- 1. Crear la tabla independiente para almacenar los productos con stock bajo
CREATE TABLE IF NOT EXISTS productos_stock_bajo (
    productoid INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cantidadstock INT NOT NULL
);

-- 2. Insertar inicialmente los productos con stock menor a 3
INSERT INTO productos_stock_bajo (productoid, nombre, cantidadstock)
SELECT
    productoid,
    nombre,
    cantidadstock
FROM
    productos
WHERE
    cantidadstock < 3
ON CONFLICT (productoid) DO NOTHING; -- Evita errores si ya existen registros

-- 3. Crear una función que actualiza la tabla productos_stock_bajo después de INSERT o UPDATE en productos
CREATE OR REPLACE FUNCTION fn_actualizar_productos_stock_bajo()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.cantidadstock < 3 THEN
        -- Si el producto ya existe en productos_stock_bajo, actualizamos la cantidad
        IF EXISTS (SELECT 1 FROM productos_stock_bajo WHERE productoid = NEW.productoid) THEN
            UPDATE productos_stock_bajo
            SET cantidadstock = NEW.cantidadstock
            WHERE productoid = NEW.productoid;
        ELSE
            -- Si no existe, lo insertamos
            INSERT INTO productos_stock_bajo (productoid, nombre, cantidadstock)
            VALUES (NEW.productoid, NEW.nombre, NEW.cantidadstock);
        END IF;
    ELSE
        -- Si el stock es 3 o más y el producto existe en productos_stock_bajo, lo eliminamos
        DELETE FROM productos_stock_bajo
        WHERE productoid = NEW.productoid;
    END IF;
    RETURN NULL; -- En triggers AFTER, el retorno no se utiliza
END;
$$ LANGUAGE plpgsql;

-- 4. Crear triggers para INSERT y UPDATE en la tabla productos
-- Trigger después de insertar en productos
DROP TRIGGER IF EXISTS trg_insert_productos_stock_bajo ON productos;
CREATE TRIGGER trg_insert_productos_stock_bajo
AFTER INSERT ON productos
FOR EACH ROW
EXECUTE FUNCTION fn_actualizar_productos_stock_bajo();

-- Trigger después de actualizar en productos
DROP TRIGGER IF EXISTS trg_update_productos_stock_bajo ON productos;
CREATE TRIGGER trg_update_productos_stock_bajo
AFTER UPDATE OF cantidadstock ON productos
FOR EACH ROW
EXECUTE FUNCTION fn_actualizar_productos_stock_bajo();


-- ========================================
-- Script de prueba para verificar el trigger 'trg_update_productos_stock_bajo'
-- ========================================

-- 1. Verificar el stock actual del producto antes de la venta
SELECT productoid, nombre, cantidadstock
FROM productos
WHERE productoid = 1;

-- Supongamos que el stock inicial es 5

-- 2. Iniciar una transacción
BEGIN;

-- 3. Insertar un nuevo detalle de venta que activará el trigger
INSERT INTO detalleventa (ventaid, productoid, cantidadproducto, clienteid)
VALUES (1, 1, 3, 1); -- Vendemos 3 unidades

-- 4. Confirmar la transacción
COMMIT;

-- 5. Verificar el stock del producto después de la venta
SELECT productoid, nombre, cantidadstock
FROM productos
WHERE productoid = 1;

-- 6. Verificar la tabla 'productos_stock_bajo'
SELECT * FROM productos_stock_bajo;

-- 7. Verificar el precio total del artículo en detalleventa
SELECT detalleventaid, ventaid, productoid, cantidadproducto, preciototalarticulo
FROM detalleventa
WHERE ventaid = 1;

-- 8. Verificar el total a pagar por la venta
SELECT ventaid, folio, fechaventa, cantidadtotalpagar
FROM ventas
WHERE ventaid = 1;
