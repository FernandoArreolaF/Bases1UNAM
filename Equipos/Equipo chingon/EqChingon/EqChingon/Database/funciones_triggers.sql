
-- FUNCIÓN PARA CALCULAR LA EDAD

CREATE OR REPLACE FUNCTION calcular_edad(fecha_nac_emp DATE)
RETURNS INT AS $$
DECLARE
    edad_emp INT;
BEGIN
    SELECT DATE_PART('year', age(fecha_nac_emp)) INTO edad_emp;
    RETURN edad_emp;
END;
$$ LANGUAGE plpgsql;

-- FUNCIÓN PARA ACTUALIZAR LA EDAD

CREATE OR REPLACE FUNCTION actualizar_edad()
RETURNS TRIGGER AS $$
BEGIN
    NEW.edad_emp := calcular_edad(NEW.fecha_nac_emp);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER PARA ACTUALIZAR LA EDAD AL INSERTAR UN EMPLEADO

CREATE TRIGGER trigger_actualizar_edad
BEFORE INSERT OR UPDATE ON empleado
FOR EACH ROW EXECUTE FUNCTION actualizar_edad();


-- FUNCIÓN PARA CALCULAR EL ATRIBUTO TOTAL_ORDEN

CREATE OR REPLACE FUNCTION actualizar_total_orden() RETURNS TRIGGER AS $$
DECLARE
    total_orden_actual DECIMAL(8, 2);
BEGIN
    -- Calcular el nuevo total de la orden
    SELECT COALESCE(SUM(precio_total_prod), 0) INTO total_orden_actual FROM contiene WHERE folio_orden = NEW.folio_orden;

    -- Actualizar el total de la orden en la tabla orden
    UPDATE orden SET total_orden = total_orden_actual WHERE folio_orden = NEW.folio_orden;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER PARA ACTUALIZAR DESPUÉS DE INSERTAR EN LA TABLA CONTIENE

CREATE TRIGGER trigger_actualizar_total_orden
AFTER INSERT OR UPDATE ON contiene
FOR EACH ROW
EXECUTE FUNCTION actualizar_total_orden();



-- FUNCIÓN PARA ACTUALIZAR EL PRECIO_TOTAL_PROD

CREATE OR REPLACE FUNCTION calcular_precio_total() RETURNS TRIGGER AS $$
BEGIN

    IF EXISTS (SELECT 1 FROM menu WHERE id_prod = NEW.id_prod AND disponibilidad_prod) THEN

        NEW.precio_total_prod = NEW.cantidad_prod * (SELECT precio_unitario_prod FROM menu WHERE id_prod = NEW.id_prod);
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'El producto no está disponible en el menú.';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER PARA ACTUALIZAR CADA QUE SE INSERTE UN REGISTRO

CREATE TRIGGER trigger_actualizar_precio_total
BEFORE INSERT OR UPDATE ON contiene
FOR EACH ROW
EXECUTE FUNCTION calcular_precio_total();


--Cada que se agregue un producto a la orden, debe actualizarse los totales (por --producto y venta), as ́ı como validar que el producto est ́e disponible

CREATE OR REPLACE FUNCTION actualizar_totales_orden()
RETURNS TRIGGER AS $$
BEGIN
    -- Calcular el precio total del producto
    NEW.precio_total_prod = NEW.precio_unitario_prod * NEW.cantidad_prod;
    
    -- Actualizar el precio total de la orden
    UPDATE orden
    SET total_orden = (
        SELECT COALESCE(SUM(precio_total_prod), 0)
        FROM contiene
        WHERE folio_orden = NEW.folio_orden
    )
    WHERE folio_orden = NEW.folio_orden;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_totales_orden
BEFORE INSERT ON contiene
FOR EACH ROW
EXECUTE FUNCTION actualizar_totales_orden();

-- trigger que se ejecute antes de insertar en la tabla contiene para validar la --disponibilidad del producto:

CREATE OR REPLACE FUNCTION validar_disponibilidad_producto()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM menu WHERE id_prod = NEW.id_prod AND disponibilidad_prod = true
    ) THEN
        RAISE EXCEPTION 'El producto no está disponible';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_disponibilidad_producto
BEFORE INSERT ON contiene
FOR EACH ROW
EXECUTE FUNCTION validar_disponibilidad_producto();
