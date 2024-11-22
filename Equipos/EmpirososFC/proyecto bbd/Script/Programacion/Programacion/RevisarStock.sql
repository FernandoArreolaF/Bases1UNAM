
-- Aqui se almacenaran los valores

CREATE TABLE productos_stock_bajo (
    codbarras VARCHAR(50) PRIMARY KEY, 
    rs VARCHAR(100),              
    stock INT                          
);



select * from productos_stock_bajo
select * from contiene_producto_venta
select * from producto





CREATE OR REPLACE FUNCTION revisar_stock()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    producto RECORD; -- Variable para almacenar temporalmente los datos de cada producto
BEGIN
    -- Recorrer todos los productos
    FOR producto IN
        SELECT codbarras, rs, stock
        FROM producto
    LOOP
        -- Si el stock es menor a 3, emitir alerta o realizar acción
        IF producto.stock < 3 THEN
            -- Insertar en la tabla productos_stock_bajo
            INSERT INTO productos_stock_bajo (codbarras, rs, stock)
            VALUES (producto.codbarras, producto.rs, producto.stock)
            ON CONFLICT (codbarras)
            DO UPDATE SET stock = EXCLUDED.stock;

            -- Emitir alerta
            RAISE NOTICE 'Producto % tiene stock bajo: % unidades.', producto.rs, producto.stock;
        ELSE
            -- Si el stock es suficiente, eliminarlo de la tabla productos_stock_bajo
            DELETE FROM productos_stock_bajo WHERE codbarras = producto.codbarras;
        END IF;
    END LOOP;
END;
$$;




UPDATE producto
SET stock = 7
WHERE codbarras = '7501001234574';



INSERT INTO contiene_producto_venta (numero, codbarras,cantarticulo)
VALUES ('VENT-002', '7501001234571',1)

CREATE OR REPLACE FUNCTION llamar_stock_bajo()
RETURNS TABLE(codbarras VARCHAR, rs VARCHAR, stock INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Llamar a la función revisar_stock para actualizar los productos con stock bajo
    PERFORM revisar_stock();

    -- Devolver todos los valores de la tabla productos_stock_bajo tal cual
    RETURN QUERY
    SELECT *
    FROM productos_stock_bajo;
END;
$$;

SELECT * FROM llamar_stock_bajo();



