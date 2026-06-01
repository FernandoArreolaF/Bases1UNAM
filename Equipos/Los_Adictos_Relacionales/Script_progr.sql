    

--Trigger para el calculo del monto total por producto.

CREATE OR REPLACE FUNCTION fn_total_per_producto()
RETURNS TRIGGER AS $$
DECLARE
    temp_precio NUMERIC(7,2); 
    temp_disponibilidadP BOOLEAN; 
    temp_stock INTEGER;
BEGIN

    IF TG_OP = 'DELETE' THEN

        UPDATE ORDEN SET total_pago = total_pago - OLD.total_producto WHERE folio_orden = OLD.folio_orden;
    
        UPDATE PRODUCTO SET stock_producto = stock_producto + OLD.cantidad_producto WHERE id_producto = OLD.id_producto;
        
        RETURN OLD; 
    END IF;


    SELECT precio_producto, disponibilidad_producto, stock_producto 
    INTO temp_precio, temp_disponibilidadP, temp_stock 
    FROM PRODUCTO 
    WHERE id_producto = NEW.id_producto;


    IF temp_precio IS NULL THEN 
        RAISE EXCEPTION 'El producto solicitado no existe: %', NEW.id_producto;
    ELSIF temp_disponibilidadP = FALSE THEN 
        RAISE EXCEPTION 'El producto no está disponible para venta.';
    ELSIF temp_stock < NEW.cantidad_producto THEN
        RAISE EXCEPTION 'La disponibilidad no cubre la cantidad solicitada. Cantidad disponible: %', temp_stock;
    END IF;      
    
   
    NEW.total_producto := NEW.cantidad_producto * temp_precio;

    IF TG_OP = 'INSERT' THEN
        UPDATE ORDEN SET total_pago = total_pago + NEW.total_producto WHERE folio_orden = NEW.folio_orden;
        UPDATE PRODUCTO SET stock_producto = stock_producto - NEW.cantidad_producto WHERE id_producto = NEW.id_producto;
        
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE ORDEN SET total_pago = total_pago - OLD.total_producto + NEW.total_producto WHERE folio_orden = NEW.folio_orden;
        UPDATE PRODUCTO SET stock_producto = stock_producto + OLD.cantidad_producto - NEW.cantidad_producto WHERE id_producto = NEW.id_producto;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_orden_producto
BEFORE INSERT OR UPDATE OR DELETE ON ORDEN_POR_PRODUCTO
FOR EACH ROW
EXECUTE FUNCTION fn_total_per_producto();

--TRIGGER PARA GENERAR EL FOLIO DE LA ORDEN 
CREATE SEQUENCE seq_orden_folio --  Secuencia para generar folios (Trigger pendiente)
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 999
    START 1
    NO CYCLE;

CREATE OR REPLACE FUNCTION fn_generar_folio_orden()
RETURNS TRIGGER AS $$
BEGIN

    NEW.folio_orden := 'ORD-' || LPAD(nextval('seq_orden_folio')::TEXT, 3, '0');

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_folio_orden
BEFORE INSERT ON ORDEN
FOR EACH ROW
EXECUTE FUNCTION fn_generar_folio_orden();


CREATE OR REPLACE FUNCTION fn_calcular_edad_empleado()
RETURNS TRIGGER AS $$
BEGIN
    NEW.edad_empleado := EXTRACT(YEAR FROM AGE(CURRENT_DATE, NEW.fecha_nacimiento_empleado));
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calcular_edad_empleado
BEFORE INSERT OR UPDATE ON EMPLEADO
FOR EACH ROW
EXECUTE FUNCTION fn_calcular_edad_empleado();

-- FUNCIONES

-- CANTIDAD DE ORDENES REALIZADAS EN UN DIA POR UN MESERO Y TOTAL PAGADO POR ESAS ORDENES
CREATE OR REPLACE FUNCTION orden_empleado (p_empleado int)
RETURNS TABLE (cant_ordenes int, total_pagado numeric(10,2)) AS $$
DECLARE 
    v_mesero BOOLEAN;
BEGIN
    SELECT es_mesero INTO v_mesero
    FROM EMPLEADO
    WHERE num_empleado = p_empleado;

    IF v_mesero IS NULL THEN
        RAISE EXCEPTION 'El empleado con numero % no existe', p_empleado;
    ELSIF v_mesero IS FALSE THEN 
        RAISE EXCEPTION 'El empleado no es mesero, consulta exclusiva para meseros';
    END IF;

    RETURN QUERY 
    SELECT 
        COUNT(folio_orden)::INT, 
        COALESCE(SUM(total_pago), 0.00)::NUMERIC(10,2)
    FROM ORDEN
    WHERE num_empleado = p_empleado 
      AND fecha_orden::DATE = CURRENT_DATE;
END;
$$ LANGUAGE plpgsql;

-- TOTAL DE VENTAS Y MONTO TOTAL EN UN PERIODO DE TIEMPO
CREATE OR REPLACE FUNCTION ventas_realizadas (fecha_inicio DATE, fecha_fin DATE)
RETURNS TABLE (num_ventas INT, monto_total NUMERIC (10,2)) AS $$

BEGIN
    RETURN QUERY
    SELECT COUNT(folio_orden):: INT AS num_ventas,
    SUM(total_pago):: numeric(10,2) AS monto_total
    FROM ORDEN
    WHERE fecha_orden:: DATE BETWEEN fecha_inicio AND fecha_fin;
END;

$$ LANGUAGE plpgsql;


-- Para probar la del mesero (suponiendo que el empleado 1 es mesero)
SELECT * FROM orden_empleado(1);

-- Para probar la de fechas
SELECT * FROM ventas_realizadas('2026-05-01', '2026-05-31');



-- VISTAS


--VISTA A productos no disponibles
CREATE OR REPLACE VIEW prod_noDisponibles AS
SELECT nombre_producto
FROM PRODUCTO
WHERE disponibilidad_producto IS FALSE;


-- Detalles a platillo mas vendido
CREATE OR REPLACE VIEW detalles_platillo AS
SELECT * FROM PRODUCTO
WHERE id_producto = (
    SELECT id_producto 
    FROM ORDEN_POR_PRODUCTO 
    GROUP BY id_producto
    ORDER BY SUM(cantidad_producto) DESC 
    LIMIT 1
);


-- DETALLES TIPO FACTURA ORDEN
CREATE OR REPLACE VIEW factura_orden AS
SELECT 
    o.folio_orden AS "Folio Factura",
    o.fecha_orden AS "Fecha de Emision",
    
    -- permitiendo datos null, cs de diseño
    c.rfc_cliente AS "RFC Cliente",
    c.nombre_cliente || ' ' || c.apellido_paterno_cliente || ' ' || COALESCE(c.apellido_materno_cliente, '') AS "Razon Social / Nombre",
    c.calle_cliente || ' Num. ' || c.numero_dom_cliente || ', Col. ' || c.colonia_cliente || ', CP: ' || c.codigo_postal_cliente AS "Direccion Fiscal",
    
    op.cantidad_producto AS "Cantidad",
    p.nombre_producto AS "Concepto",
    p.precio_producto AS "Precio Unitario",
    op.total_producto AS "Importe",
    o.total_pago AS "Total a Pagar"
    
FROM ORDEN o
LEFT JOIN CLIENTE c ON o.id_cliente = c.id_cliente
JOIN ORDEN_POR_PRODUCTO op ON o.folio_orden = op.folio_orden
JOIN PRODUCTO p ON op.id_producto = p.id_producto;


