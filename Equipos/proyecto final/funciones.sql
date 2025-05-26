/*
Script DDL para la creación de las funciones.
*/

--PARA INDICE NON-CLUSTERED EN SUCURSAL
CREATE INDEX CONCURRENTLY idx_empleado_sucursal ON empleado(id_sucursal);
-- Mejora validaciones y jerarquías entre empleados (en validacion_empleados)

--FOLIO DE VENTA
CREATE SEQUENCE venta_folio_seq START 1;

ALTER TABLE VENTA 
ALTER COLUMN FOLIO 
SET DEFAULT 'MBL-' || LPAD(nextval('venta_folio_seq')::TEXT, 6, '0');

--FOLIO_FACTURACION
ALTER TABLE VENTA
ALTER COLUMN FOLIO_FACTURACION
SET DEFAULT 'FAC-' || substr(md5(random()::text), 1, 8);

--FUNCIÓN RAZÓN SOCIAL
CREATE OR REPLACE FUNCTION razon_social_default() RETURNS TRIGGER AS $$
BEGIN
	IF NEW.RAZON_SOCIAL IS NULL OR NEW.RAZON_SOCIAL = '' THEN
		NEW.RAZON_SOCIAL := NEW.NOMBRE || ' ' || NEW.APELLIDO_PATERNO ||
								COALESCE(' ' ||NEW.APELLIDO_MATERNO, '');
	END IF;
	RETURN NEW;
END; 
$$LANGUAGE PLPGSQL;

CREATE TRIGGER razon_social_default
BEFORE INSERT ON CLIENTE
FOR EACH ROW
EXECUTE FUNCTION razon_social_default();

--VISTA PARA VER EL STOCK
CREATE VIEW restriccion_stock as
SELECT CODIGO_BARRAS, NOMBRE, STOCK,
CASE WHEN STOCK = 0 THEN 'NO DISPONIBLE'
ELSE 'STOCK BAJO'
END AS ESTADO
FROM ARTICULO WHERE STOCK < 3;
SELECT * FROM restriccion_stock;

--RESTAR STOCK
CREATE FUNCTION restar_stock() RETURNS TRIGGER AS $$
BEGIN
	UPDATE Articulo SET Stock = stock - new.cantidad WHERE CODIGO_BARRAS = NEW.CODIGO_BARRAS;
	RETURN NEW;
END; 
$$LANGUAGE plpgsql;

CREATE TRIGGER restar_stock 
AFTER INSERT ON VENTA_ARTICULO
FOR EACH ROW
EXECUTE FUNCTION restar_stock();

--FUNCIÓN DE VALIDACION DE VENDEDOR Y CAJERO SEAN DE LA MISMA SUCURSAL
CREATE FUNCTION validacion_empleados() RETURNS TRIGGER AS $$
DECLARE
	sucursal_ven int;
	sucursal_caj int;
BEGIN
	SELECT ID_SUCURSAL into sucursal_ven from empleado where numero_empleado = new.numero_empleado_ven;
	SELECT ID_SUCURSAL into sucursal_caj from empleado where numero_empleado = new.numero_empleado_caj;

	IF sucursal_ven is distinct from sucursal_caj then
	raise exception 'El cajero y vendedor no pertenecen a la misma sucursal, no se puede realizar la venta';
	end if;
	RETURN NEW;
END; 
$$LANGUAGE plpgsql;

CREATE TRIGGER validacion_empleados 
BEFORE INSERT ON VENTA
FOR EACH ROW
EXECUTE FUNCTION validacion_empleados();

--FUNCIÓN PRECIO TOTAL POR EL NÚMERO DE ARTICULOS
CREATE FUNCTION calculo_total_por_articulos() RETURNS TRIGGER AS $$
DECLARE
	precio_unitario money;
BEGIN
	SELECT PRECIO_VENTA INTO precio_unitario FROM ARTICULO WHERE CODIGO_BARRAS = NEW.CODIGO_BARRAS;
	NEW.PRECIO_TOTAL_ARTICULOS := precio_unitario * NEW.CANTIDAD;
	RETURN NEW;
END; 
$$LANGUAGE plpgsql;

CREATE TRIGGER calculo_total_por_articulos 
BEFORE INSERT ON VENTA_ARTICULO
FOR EACH ROW
EXECUTE FUNCTION calculo_total_por_articulos();

--FUNCIÓN CÁLCULO DEL MONTO TOTAL
CREATE FUNCTION calculo_monto_total() RETURNS TRIGGER AS $$
BEGIN
	UPDATE VENTA SET MONTO_TOTAL = 
	(SELECT COALESCE(SUM(PRECIO_TOTAL_ARTICULOS),0::money) FROM VENTA_ARTICULO WHERE FOLIO = NEW.FOLIO)
	WHERE FOLIO = NEW.FOLIO;
	RETURN NULL;
END; 
$$LANGUAGE plpgsql;

CREATE TRIGGER calculo_monto_total 
AFTER INSERT ON VENTA_ARTICULO
FOR EACH ROW
EXECUTE FUNCTION calculo_monto_total();

--FUNCIÓN SUMA DEL TOTAL DE ARTÍCULOS
CREATE FUNCTION suma_total_articulos() RETURNS TRIGGER AS $$
BEGIN
	UPDATE VENTA SET TOTAL_ARTICULOS =
	(SELECT COALESCE(SUM(CANTIDAD),0) FROM VENTA_ARTICULO WHERE FOLIO = NEW.FOLIO)
	WHERE FOLIO = NEW.FOLIO;
	RETURN NULL;
END;
$$LANGUAGE plpgsql;

CREATE TRIGGER suma_total_articulos 
AFTER INSERT ON VENTA_ARTICULO
FOR EACH ROW
EXECUTE FUNCTION suma_total_articulos();

--FUNCIÓN VALIDACIÓN DE LA DISPONIBLIDAD DE ARTÍCULOS
CREATE FUNCTION disponibilidad_articulo() RETURNS TRIGGER AS $$
DECLARE 
stock_actual int;
BEGIN
	SELECT STOCK INTO stock_actual FROM ARTICULO WHERE CODIGO_BARRAS = NEW.CODIGO_BARRAS;
	IF stock_actual = 0 
	THEN
	RAISE NOTICE 'El artículo con código % que desea agregar no está disponible',NEW.CODIGO_BARRAS;
	RETURN NULL;
	END IF;
	
	IF stock_actual < NEW.CANTIDAD
	THEN
	RAISE NOTICE 'El artículo con código % no cuenta con stock suficiente, stock disponible: %',NEW.CODIGO_BARRAS,stock_actual;
	RETURN NULL;
	END IF;
	RETURN NEW;
END; 
$$LANGUAGE plpgsql;

CREATE TRIGGER disponibilidad_articulo 
BEFORE INSERT ON VENTA_ARTICULO
FOR EACH ROW
EXECUTE FUNCTION disponibilidad_articulo();

--FUNCIÓN PARA MOSTRAR LA JERARQUÍA ORGANIZACINAL
CREATE OR REPLACE FUNCTION jerarquia_empleado(emp_id INT)
RETURNS TABLE (numero_empleado INT,nombre VARCHAR(50),apellido_paterno VARCHAR(50),apellido_materno VARCHAR(50),
  supervisor INT,id_sucursal INT,nivel INT)
AS $$
BEGIN
  RETURN QUERY
  WITH RECURSIVE jerarquia AS (
    SELECT
      e.numero_empleado,
      e.nombre,
      e.apellido_paterno,
      e.apellido_materno,
      e.supervisor,
      e.id_sucursal,
      1 AS nivel
    FROM empleado e
    WHERE e.numero_empleado = emp_id

    UNION ALL

    SELECT
      sup.numero_empleado,
      sup.nombre,
      sup.apellido_paterno,
      sup.apellido_materno,
      sup.supervisor,
      sup.id_sucursal,
      j.nivel + 1
    FROM empleado sup
    INNER JOIN jerarquia j ON sup.numero_empleado = j.supervisor
    WHERE sup.id_sucursal = j.id_sucursal
  )
  SELECT * FROM jerarquia;
END;
$$ LANGUAGE plpgsql;
--Probar con:
SELECT * FROM JERARQUIA_EMPLEADO(10)

--VISTA PARA EL TICKET
CREATE OR REPLACE VIEW vista_ticket_venta AS
SELECT
    v.folio AS folio_venta,
    v.fecha_venta,
	v.rfc_cliente,
    va.codigo_barras,
    a.nombre AS nombre_articulo,
    va.cantidad,
    a.precio_compra ,
    va.precio_total_articulos,
    v.monto_total AS total_venta,
    COALESCE(v.folio_facturacion, 'NO FACTURADO') AS folio_facturacion
FROM venta v
JOIN venta_articulo va ON v.folio = va.folio
JOIN articulo a ON va.codigo_barras = a.codigo_barras;