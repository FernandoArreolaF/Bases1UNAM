/* ============================================================
    PapyrusDB Solutions - Sistema de Gestión para Papelería

    Archivo: [SCRUM-28_Para programación a nivel base de datos.sql]
    Descripcion: En este scrip se mostrara la programación a nivel base de datos
	que se utilizo en la elabaroacion del proyecto, esto con el fin de cumplir los 
	requerimientos solicitados.

    Fecha: [6 de diciembre del 2025]
   ============================================================*/


--PRIMEROS TRIGGERS ANTES DE INSERTAR LOS REGISTROS DE PRUEBA PARA LAS TABLAS
/*--------------------------------------------------------------
 TRIGGER: Garantizar que cada cliente tenga al menos un email
 AUTOR: PapyrusDB Solutions
 DESCRIPCIÓN:
    Este trigger evita que un cliente se quede sin correos electrónicos.
    - Permite borrar emails solo si existe más de uno.
    - Si intentas borrar el único email del cliente, se bloquea la operación.
    - Compatible con el modelo actual (cliente + emailCliente).

 NOTA:
    Este trigger no bloquea la inserción de clientes sin email,
    porque la captura de datos se realiza en pasos separados.
---------------------------------------------------------------*/

-- 1) Función del trigger
CREATE OR REPLACE FUNCTION validar_email_minimo()
RETURNS TRIGGER AS $$
DECLARE
    totalEmails INT;
BEGIN
    -- Contar cuántos emails tiene el cliente asociado
    SELECT COUNT(*) INTO totalEmails
    FROM emailCliente
    WHERE idCliente = OLD.idCliente;

    -- Si solo existía un correo, no permitir eliminarlo
    IF totalEmails = 1 THEN
        RAISE EXCEPTION 'No se puede eliminar el único email del cliente %', OLD.idCliente;
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


-- 2) Trigger que ejecuta la validación antes de cada eliminación
CREATE TRIGGER trg_email_minimo
BEFORE DELETE ON emailCliente
FOR EACH ROW
EXECUTE FUNCTION validar_email_minimo();

/*--------------------------------------------------------------
 TRIGGER 1 (Antes del insert):
 Manejo de stock + precios + totales al insertar un detalle de venta

 Este trigger:
  - Verifica existencia del producto en el inventario
  - Verifica el stock disponible 
  - Envia una alerta si hay un stock por debajo de 3: 'NOTICE: Poco stock'
  - Actualiza el stock en inventario
  - Obtiene precio unitario del producto
  - Calcula el total por producto
---------------------------------------------------------------*/

CREATE OR REPLACE FUNCTION trg_detalleVenta_before_insert()
RETURNS TRIGGER AS $$
DECLARE
    stock_actual INT;
    precio_unitario NUMERIC(10,2);
    nuevo_stock INT;
BEGIN
    -- Obtener stock actual del inventario
    SELECT stock INTO stock_actual
    FROM inventario
    WHERE idProducto = NEW.idProducto;

    IF stock_actual IS NULL THEN
        RAISE EXCEPTION 'El producto % no existe en inventario.', NEW.idProducto;
    END IF;

    -- Calcular el nuevo stock
    nuevo_stock := stock_actual - NEW.cantidadProducto;

    -- Validar si queda sin stock o negativo
    IF nuevo_stock <= 0 THEN
        RAISE EXCEPTION 'Stock insuficiente para vender el producto %', NEW.idProducto;
    END IF;

    -- Alertar si queda menos de 3
    IF nuevo_stock < 3 THEN
        RAISE NOTICE 'ALERTA: Poco stock restante para el producto % (quedan % unidades).',
                     NEW.idProducto, nuevo_stock;
    END IF;

    -- Actualizar stock en inventario
    UPDATE inventario
    SET stock = nuevo_stock
    WHERE idProducto = NEW.idProducto;

    -- Obtener precio de venta del producto
    SELECT precioVenta INTO precio_unitario
    FROM producto
    WHERE idProducto = NEW.idProducto;

    -- Forzar el precio unitario desde producto
    NEW.precioUnitarioPorProd := precio_unitario;

    -- Calcular el precio total por producto
    NEW.precioTotalPorProd := NEW.cantidadProducto * precio_unitario;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER before_insert_detalleVenta
BEFORE INSERT ON detalleVenta
FOR EACH ROW
EXECUTE FUNCTION trg_detalleVenta_before_insert();

/*--------------------------------------------------------------
 TRIGGER 2(Después del insert):
 
 Actualizar pagoTotal de la venta después de insertar un detalle
  - Cada que se inserta un producto nuevo se recalcula el total de la venta
---------------------------------------------------------------*/

CREATE OR REPLACE FUNCTION trg_detalleVenta_after_insert()
RETURNS TRIGGER AS $$
DECLARE
    suma NUMERIC(10,2);
BEGIN
    -- Sumar todos los detalles asociados a esta venta
    SELECT SUM(precioTotalPorProd)
    INTO suma
    FROM detalleVenta
    WHERE idVenta = NEW.idVenta;

    -- Actualizar pagoTotal en venta
    UPDATE venta
    SET pagoTotal = suma
    WHERE idVenta = NEW.idVenta;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER after_insert_detalleVenta
AFTER INSERT ON detalleVenta
FOR EACH ROW
EXECUTE FUNCTION trg_detalleVenta_after_insert();

/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


TRIGGERS QUE SE DEBEN DE EJECUTAR ANTES DE LA INSERCION DE REGISTROS CONSIDERANDO YA LA GENERACION
DE PK'S AUTOMATICA MEDIANTE SECUENCIAS.
 - Si se ingresa un 'NULL', se genera un id con secuencia que sigue un mismo patrón
--------------------------------------------------
SECUENCIAS PARA GENERAR PK DE FORMA AUTOMATICA
--------------------------------------------------
*/

CREATE SEQUENCE seq_proveedor START WITH 5;

CREATE OR REPLACE FUNCTION generar_id_proveedor()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idProveedor IS NULL THEN
        NEW.idProveedor := 'PROV-' || LPAD(NEXTVAL('seq_proveedor')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_id_proveedor
BEFORE INSERT ON proveedor
FOR EACH ROW
EXECUTE FUNCTION generar_id_proveedor();
--------------------------------------------------------------------------------
CREATE SEQUENCE seq_producto START WITH 19;

CREATE OR REPLACE FUNCTION generar_id_producto()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idProducto IS NULL THEN
        NEW.idProducto := 'PROD-' || LPAD(NEXTVAL('seq_producto')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_id_producto
BEFORE INSERT ON producto
FOR EACH ROW
EXECUTE FUNCTION generar_id_producto();
---------------------------------------------------------------------------------
CREATE SEQUENCE seq_empleado START WITH 6;

CREATE OR REPLACE FUNCTION generar_id_empleado()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idEmpleado IS NULL THEN
        NEW.idEmpleado := 'EMP-' || LPAD(NEXTVAL('seq_empleado')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_id_empleado
BEFORE INSERT ON empleado
FOR EACH ROW
EXECUTE FUNCTION generar_id_empleado();
-------------------------------------------------------------------------------------
CREATE SEQUENCE seq_cliente START WITH 6;

CREATE OR REPLACE FUNCTION generar_id_cliente()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idCliente IS NULL THEN
        NEW.idCliente := 'CLI-' || LPAD(NEXTVAL('seq_cliente')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_id_cliente
BEFORE INSERT ON cliente
FOR EACH ROW
EXECUTE FUNCTION generar_id_cliente();
-------------------------------------------------------------------------------
CREATE SEQUENCE seq_telprove START WITH 5;

CREATE OR REPLACE FUNCTION generar_id_telproveedor()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idTelefono IS NULL THEN
        NEW.idTelefono := 'TEL-' || LPAD(NEXTVAL('seq_telprove')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_id_telproveedor
BEFORE INSERT ON telProveedor
FOR EACH ROW
EXECUTE FUNCTION generar_id_telproveedor();
-------------------------------------------------------------------------------------------
CREATE SEQUENCE seq_email START WITH 6;

CREATE OR REPLACE FUNCTION generar_id_email()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idEmail IS NULL THEN
        NEW.idEmail := 'EMA-' || LPAD(NEXTVAL('seq_email')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_id_email
BEFORE INSERT ON emailCliente
FOR EACH ROW
EXECUTE FUNCTION generar_id_email();
--------------------------------------------------------------------------------------
CREATE SEQUENCE seq_inventario START WITH 6;

CREATE OR REPLACE FUNCTION generar_id_inventario()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.codigoBarras IS NULL THEN
        NEW.codigoBarras := 'INV-' || LPAD(NEXTVAL('seq_inventario')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_id_inventario
BEFORE INSERT ON inventario
FOR EACH ROW
EXECUTE FUNCTION generar_id_inventario();
-----------------------------------------------------------------------------------------------------------
CREATE SEQUENCE seq_venta START WITH 8;

CREATE OR REPLACE FUNCTION generar_id_venta()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idVenta IS NULL THEN
        NEW.idVenta := 'VENT-' || LPAD(NEXTVAL('seq_venta')::TEXT, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_id_venta
BEFORE INSERT ON venta
FOR EACH ROW
EXECUTE FUNCTION generar_id_venta();


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- FUNCIONES

/*--------------------------------------------------------------
 FUNCIÓN 1:
 - Recibe como parametros dos fechas: 'fechaInicio' y 'fechaFin'
 - Regresa la cantidad total que se vendió y la ganancia correspondiente a un periodo entre dos fechas 
---------------------------------------------------------------*/
CREATE FUNCTION periodo_ventas_ganancias(fechaInicio DATE, fechaFin DATE
)
RETURNS TABLE(total_vendido NUMERIC, ganancia NUMERIC) AS $$

BEGIN
    RETURN QUERY
    SELECT
    SUM(detalleVenta.precioTotalPorProd),
    SUM((producto.precioVenta - inventario.precioCompra) * detalleVenta.cantidadProducto)
    FROM venta
    JOIN detalleVenta ON venta.idVenta = detalleVenta.idVenta
    JOIN producto ON detalleVenta.idProducto = producto.idProducto
    JOIN inventario ON producto.idProducto = inventario.idProducto

    WHERE venta.fechaVenta BETWEEN fechaInicio AND fechaFin;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM periodo_ventas_ganancias('2025-12-01','2025-12-31')

/*--------------------------------------------------------------
 FUNCIÓN 2:
 - Permite tener el control de artículos con bajo stock
 - Permite obtener el id, nombre(descripción) de articulos con stock bajo
---------------------------------------------------------------*/
CREATE FUNCTION bajo_stock()
RETURNS TABLE(idProducto VARCHAR(15), Nombre TEXT, Stock INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT producto.idProducto, producto.descripcion, inventario.stock
    FROM inventario
    JOIN producto ON inventario.idProducto = producto.idProducto
    WHERE inventario.stock < 3;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM bajo_stock()

/*--------------------------------------------------------------
 FUNCIÓN 3:
 - Recibe como parametro el código de barras correspondiente a un producto existente en el inventario
 - A partir del precioVenta y precioCompra, se obtiene la utilidad del producto
---------------------------------------------------------------*/
CREATE FUNCTION obtener_utilidad(codBarras VARCHAR(15))
RETURNS NUMERIC(10,2) AS $$
DECLARE
    utilidad NUMERIC(10,2);
BEGIN
    SELECT (producto.precioVenta - inventario.precioCompra)
    INTO utilidad
    FROM inventario
    JOIN producto ON inventario.idProducto = producto.idProducto
    WHERE inventario.codigoBarras = codBarras;
    IF utilidad IS NULL THEN
        RAISE EXCEPTION 'No existe producto con código de barras %', codBarras;
    END IF;
    RETURN utilidad;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM obtener_utilidad('INV-001')

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--VISTAS

/*--------------------------------------------------------------
 VISTA DE FACTURA:
 - A partir de un idVenta, se genera una factura automaticamente
  Contiene
  - Datos de la venta
  - Datos del cliente
  - Productos vendidos y el total
---------------------------------------------------------------*/
CREATE VIEW factura_venta AS
SELECT
   -- Datos de la venta
    venta.idVenta,
    venta.fechaVenta,
    venta.pagoTotal,

    -- Datos del cliente
    cliente.idCliente,
    cliente.nombre AS clienteNombre,
    cliente.apPat AS clienteApellidoPaterno,
    cliente.apMat AS clienteApellidoMaterno,
    cliente.estado AS clienteEstado,
    cliente.colonia AS clienteColonia,
    cliente.calle AS clienteCalle,
    cliente.numero AS clienteNumero,
    cliente.cp AS clienteCP,

    -- Productos vendidos
    producto.idProducto,
    producto.marca,
    producto.descripcion,
    detalleVenta.cantidadProducto,
    detalleVenta.precioUnitarioPorProd,
    detalleVenta.precioTotalPorProd

FROM venta
JOIN cliente ON venta.idCliente = cliente.idCliente
JOIN detalleVenta ON detalleVenta.idVenta = venta.idVenta
JOIN producto ON detalleVenta.idProducto = producto.idProducto;

SELECT * FROM factura_venta
WHERE idVenta = 'VENT-001';