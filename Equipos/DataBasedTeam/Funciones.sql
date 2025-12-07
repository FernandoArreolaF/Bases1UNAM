--Funciones
--Función Generar proximo folio
CREATE OR REPLACE FUNCTION generar_proximo_folio() 
RETURNS VARCHAR AS $$
DECLARE
    ultimo_id INT;
BEGIN

    SELECT MAX(numVenta) INTO ultimo_id FROM venta;

    -- La primera venta, empieza en 0
    IF ultimo_id IS NULL THEN 
        ultimo_id := 0; 
    END IF;

    -- Sumamos 1 
    RETURN 'VENT-' || LPAD((ultimo_id + 1)::TEXT, 3, '0');
END;
$$ LANGUAGE plpgsql;

--Funcion Utilidad

CREATE OR REPLACE FUNCTION calcular_utilidad(p_codigoBarras VARCHAR) 
RETURNS NUMERIC AS $$
DECLARE
    v_costo NUMERIC;
    v_precio NUMERIC;
BEGIN
    SELECT precioCompra, precioVenta INTO v_costo, v_precio
    FROM producto
    WHERE codigoBarras = p_codigoBarras;

    IF v_costo IS NULL THEN
        RETURN 0;
    END IF;

    RETURN v_precio - v_costo;
END;
$$ LANGUAGE plpgsql;

--Funcion Bajo Stock
CREATE OR REPLACE FUNCTION obtener_productos_bajo_stock()
RETURNS TABLE (
    codigo VARCHAR,
    nombre_prod VARCHAR,
    stock_actual INT
) AS $$
BEGIN
    RETURN QUERY 
    SELECT codigoBarras, descripcion, stock
    FROM producto
    WHERE stock < 3;
END;
$$ LANGUAGE plpgsql;

----TRIGGERS----
--Trigger Gestionar detalle de venta
CREATE OR REPLACE FUNCTION tf_gestionar_detalle_venta()
RETURNS TRIGGER AS $$
DECLARE
    v_stock_actual INT;
    v_precio_venta NUMERIC;
    v_descripcion VARCHAR;
BEGIN
    -- Obtener datos actuales del producto
    SELECT stock, precioVenta, descripcion INTO v_stock_actual, v_precio_venta, v_descripcion
    FROM producto
    WHERE codigoBarras = NEW.codigoBarras;

    -- Validar que el producto exista
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El producto % no existe.', NEW.codigoBarras;
    END IF;

    -- Validar Stock Suficiente ( si llega a 0 o insuficiente)
    IF v_stock_actual < NEW.cantidad THEN
        RAISE EXCEPTION 'Stock insuficiente para el producto %. Disponible: %, Solicitado: %', 
                        v_descripcion, v_stock_actual, NEW.cantidad;
    END IF;

    -- Cálculo automático del importe 
    NEW.importe := NEW.cantidad * v_precio_venta;

    -- Disminuir el Stock
    UPDATE producto 
    SET stock = stock - NEW.cantidad
    WHERE codigoBarras = NEW.codigoBarras;

    -- Verificar nivel de stock para alerta 
    -- Se calcula el stock resultante
    IF (v_stock_actual - NEW.cantidad) < 3 THEN
        RAISE NOTICE 'ALERTA DE INVENTARIO: El producto "%" (%) tiene stock bajo (% unidades restantes).', 
                     v_descripcion, NEW.codigoBarras, (v_stock_actual - NEW.cantidad);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Este comando solo se necesita usar una sola vez, de ahi en fuera si se vuelve a ejecutar el script manda error, 
--Se recomienda ponerlo como comentario
CREATE TRIGGER tg_gestionar_detalle_venta
BEFORE INSERT ON CONTIENE_PRODUCTO
FOR EACH ROW
EXECUTE FUNCTION tf_gestionar_detalle_venta();


--Trigger Actualizar total de venta
CREATE OR REPLACE FUNCTION tf_actualizar_total_venta()
RETURNS TRIGGER AS $$
BEGIN
    -- Actualizar el total de la venta afectada
    IF (TG_OP = 'DELETE') THEN
        UPDATE venta
        SET totalPago = (
            SELECT COALESCE(SUM(importe), 0)
            FROM CONTIENE_PRODUCTO
            WHERE numVenta = OLD.numVenta
        )
        WHERE numVenta = OLD.numVenta;
        RETURN OLD;
    ELSE
        UPDATE venta
        SET totalPago = (
            SELECT COALESCE(SUM(importe), 0)
            FROM CONTIENE_PRODUCTO
            WHERE numVenta = NEW.numVenta
        )
        WHERE numVenta = NEW.numVenta;
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

--Este comando solo se necesita usar una sola vez, de ahi en fuera si se vuelve a ejecutar el script manda error, 
--Se recomienda ponerlo como comentario
CREATE TRIGGER tg_actualizar_total_venta
AFTER INSERT OR UPDATE OR DELETE ON CONTIENE_PRODUCTO
FOR EACH ROW
EXECUTE FUNCTION tf_actualizar_total_venta();

---Vistas
CREATE OR REPLACE VIEW V_FACTURA_DETALLADA AS
SELECT 
    v.numVenta AS "Folio Factura",
    v.fechaVenta AS "Fecha Emisión",
    -- Datos del Cliente
    c.rfc AS "RFC Cliente",
    CONCAT(c.primNombre, ' ', c.apPat, ' ', COALESCE(c.apMat, '')) AS "Nombre Cliente",
    CONCAT(c.calle, ' #', c.numero, ', Col. ', c.colonia, ', ', c.estado) AS "Dirección Cliente",
    -- Detalle del Producto
    cp.codigoBarras AS "Código Producto",
    p.descripcion AS "Descripción",
    p.marca AS "Marca",
    cp.cantidad AS "Cantidad",
    p.precioVenta AS "Precio Unitario",
    cp.importe AS "Subtotal Línea",
    -- Total General de la Venta 
    v.totalPago AS "Total a Pagar"
FROM VENTA v
JOIN CLIENTE c ON v.rfc = c.rfc
JOIN CONTIENE_PRODUCTO cp ON v.numVenta = cp.numVenta
JOIN PRODUCTO p ON cp.codigoBarras = p.codigoBarras
ORDER BY v.numVenta DESC;

-- EJEMPLO
SELECT * FROM V_FACTURA_DETALLADA WHERE "Folio Factura" = 2;

---Reporte de ventas

-- Reporte de Ventas por una fecha específica
CREATE OR REPLACE FUNCTION reporte_ventas_por_fecha(p_fecha DATE)
RETURNS TABLE (
    folio INT,
    rfc_cliente VARCHAR,
    total_venta DECIMAL(10,2)
) AS $$
BEGIN
    RETURN QUERY 
    SELECT numVenta, rfc, totalPago
    FROM VENTA
    WHERE fechaVenta = p_fecha;
END;
$$ LANGUAGE plpgsql;

-- EJEMPLO:
SELECT * FROM reporte_ventas_por_fecha('2025-12-06');


-- Reporte de Ventas por rango de fechas
CREATE OR REPLACE FUNCTION reporte_ventas_por_rango(p_fecha_inicio DATE, p_fecha_fin DATE)
RETURNS TABLE (
    fecha DATE,
    folio INT,
    rfc_cliente VARCHAR,
    total_venta DECIMAL(10,2)
) AS $$
BEGIN
    RETURN QUERY 
    SELECT fechaVenta, numVenta, rfc, totalPago
    FROM VENTA
    WHERE fechaVenta BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY fechaVenta ASC;
END;
$$ LANGUAGE plpgsql;

-- EJEMPLO:
SELECT * FROM reporte_ventas_por_rango('2025-12-05', '2025-12-06');


-- Ganancia Total del Periodo
CREATE OR REPLACE FUNCTION calcular_ganancia_periodo(p_fecha_inicio DATE, p_fecha_fin DATE)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    ganancia_total DECIMAL(10,2);
BEGIN
    SELECT COALESCE(SUM((p.precioVenta - p.precioCompra) * cp.cantidad), 0)
    INTO ganancia_total
    FROM VENTA v
    JOIN CONTIENE_PRODUCTO cp ON v.numVenta = cp.numVenta
    JOIN PRODUCTO p ON cp.codigoBarras = p.codigoBarras
    WHERE v.fechaVenta BETWEEN p_fecha_inicio AND p_fecha_fin;

    RETURN ganancia_total;
END;
$$ LANGUAGE plpgsql;

-- EJEMPLO:
SELECT calcular_ganancia_periodo('2025-12-01', '2025-12-31') AS Ganancia_Diciembre;
