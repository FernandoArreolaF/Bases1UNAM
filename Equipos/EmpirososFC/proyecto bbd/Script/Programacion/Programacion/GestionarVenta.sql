-- realizar venta


-- quitamos el not null para hacer que podamos insertar sin meter el precio, el cual se pondra automaticamente despues

ALTER TABLE venta
ALTER COLUMN total DROP NOT NULL;

ALTER TABLE contiene_producto_venta
ALTER COLUMN precioarticulo DROP NOT NULL;



CREATE OR REPLACE FUNCTION gestionar_venta()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    stock_actual INT;         -- Para almacenar el stock actual del producto
    precio_producto NUMERIC;  -- Para almacenar el precio del producto
BEGIN
    -- Obtener el stock actual y el precio del producto
    SELECT stock, precio
    INTO stock_actual, precio_producto
    FROM producto
    WHERE codbarras = NEW.codbarras;

    -- Verificar si el producto existe
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El producto con código de barras % no existe.', NEW.codbarras;
    END IF;

    -- Verificar si el stock es suficiente
    IF stock_actual < NEW.cantarticulo THEN
        RAISE EXCEPTION 'Stock insuficiente para el producto con código de barras %', NEW.codbarras;
    END IF;

    -- Actualizar el stock del producto
    UPDATE producto
    SET stock = stock - NEW.cantarticulo
    WHERE codbarras = NEW.codbarras;

    -- Emitir alerta si el stock restante es menor a 3
    IF stock_actual - NEW.cantarticulo < 3 THEN
        RAISE NOTICE 'Alerta: Stock bajo para el producto con código de barras %', NEW.codbarras;
    END IF;

    -- Asignar el precio del producto al campo `precioarticulo` en la tabla contiene_producto_venta
   
    -- Actualizar el total de la venta
 -- Asignar el precio del producto al campo `precioarticulo`
    NEW.precioarticulo := COALESCE(precio_producto, 0) * COALESCE(NEW.cantarticulo, 0);
	NEW.precioarticulo := (precio_producto * NEW.cantarticulo) * 2;


    -- Actualizar el total de la venta
    UPDATE venta
    SET total = COALESCE(total, 0) + NEW.precioarticulo
    WHERE numero = NEW.numero;

    RETURN NEW; 
END;
$$;

CREATE OR REPLACE TRIGGER trigger_gestionar_venta
before INSERT ON contiene_producto_venta
FOR EACH ROW
EXECUTE FUNCTION gestionar_venta();

BEGIN;
DELETE FROM venta WHERE numero = 'VENT-028';
end

select * from producto
where codbarras ='7501001234574'

select * from venta
select * from contiene_producto_venta



INSERT INTO venta (numero, fecha, clave,RFC) 
VALUES ('VENT-027', '2024-01-26', 'EMP001','GARC980324XYZ');

INSERT INTO contiene_producto_venta (numero, codbarras,cantarticulo)
VALUES ('VENT-027', '7501001234569',1);

INSERT INTO venta (numero, fecha, clave,RFC) 
VALUES ('VENT-028', '2024-01-26', 'EMP001','GARC980324XYZ');

update producto
set stock = 3
where codbarras = '7501001234574'

INSERT INTO contiene_producto_venta (numero, codbarras,cantarticulo)
VALUES ('VENT-028', '7501001234574',2);	
