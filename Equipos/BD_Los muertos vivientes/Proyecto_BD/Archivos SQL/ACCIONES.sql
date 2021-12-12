--- Regrese utilidad
CREATE FUNCTION regresa_utilidad(id_producto INTEGER ) RETURNS REAL AS $$
DECLARE producto record;
DECLARE utilidad REAL;
 BEGIN
	select * into producto from producto_almacen where codigo_barras = $1;
	RAISE NOTICE 'Utilidad = %',producto.precio_venta -producto.precio_compra;
	utilidad =  producto.precio_venta-producto.precio_compra;
	RETURN utilidad;
 END;
$$ LANGUAGE plpgsql;


---------------

CREATE FUNCTION veririfica_Stock() RETURNS trigger AS $$
DECLARE Producto_Stock record;
DECLARE cantidad_Actual INTEGER;
 BEGIN
	select * into Producto_Stock from producto_almacen where codigo_barras = NEW.codigo_barras;
	cantidad_Actual = Producto_Stock.cantidad_ejemplares - NEW.cantidad;
	IF cantidad_Actual = 0 AND  cantidad_Actual < 0THEN
		RAISE NOTICE 'No se completo la operación porque ya que nos quedamos sin productos';
		RETURN OLD;
	END IF;
	IF cantidad_Actual > 0 AND  cantidad_Actual < 3 THEN
		RAISE NOTICE 'Quedan menos de 3';
		UPDATE producto_almacen set cantidad_ejemplares = cantidad_Actual where codigo_barras = New.codigo_barras;
		RETURN NEW;
	END IF;
	UPDATE producto_almacen set cantidad_ejemplares = cantidad_Actual where codigo_barras = New.codigo_barras;
	RAISE NOTICE 'Transaccion completada numero actual % de producto %',cantidad_Actual,Producto_Stock.codigo_barras;
	RETURN NEW;
 END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER veririfica_Stock_trigger BEFORE INSERT ON producto_venta
FOR EACH ROW EXECUTE PROCEDURE veririfica_Stock();

-----



---
--- Funcion regresa de almacen menores a 3
CREATE FUNCTION veririfica_menor_3() RETURNS TABLE(codigo_barras integer, cantidad integer) AS $$
 BEGIN
	RETURN query Select p.codigo_barras,p.cantidad_ejemplares from producto_almacen p where p.cantidad_ejemplares<3 ;
 END;
$$ LANGUAGE plpgsql;

---FECHAS con codigo barras
CREATE FUNCTION ventas_rango_codigo(inicio date, fin date) 
RETURNS TABLE(cantidad_f bigint, tota_f real, codigo_barras_f integer)
AS $$
BEGIN
	RETURN query select sum(cantidad) as cantidad_total, sum(total_articulo) as ganacia_total, codigo_barras from venta
	inner join producto_venta on venta.id_venta = producto_venta.id_venta 
	where fecha_venta  between inicio and fin group by codigo_barras;	
END;
$$ LANGUAGE plpgsql;


-- rango fechas cantidad y total
CREATE FUNCTION ventas_rango(inicio date, fin date) 
RETURNS TABLE(cantidad_f bigint, tota_f real)
AS $$
BEGIN
	RETURN query select sum(cantidad) as cantidad_total, sum(total_articulo) as ganacia_total from venta
	inner join producto_venta on venta.id_venta = producto_venta.id_venta 
	where fecha_venta  between inicio and fin;	
END;
$$ LANGUAGE plpgsql;

-- CREACION DE FACTURAS(VISTA)

---Genera factura
CREATE FUNCTION generar_vista() RETURNS trigger AS $$
DECLARE aux integer;
 BEGIN
 	CREATE OR REPLACE VIEW  factura
	 AS
	 SELECT * FROM (SELECT venta.id_venta ,codigo_barras, cantidad,total_articulo,descripcion,marca,fecha_venta FROM venta
	 INNER join producto_venta on venta.id_venta = producto_venta.id_venta) as a WHERE a.id_venta = "id_venta";
	 RETURN NEW;
 END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER generar_vista_trigger BEFORE INSERT ON producto_venta
FOR EACH ROW EXECUTE PROCEDURE generar_vista();



---EXTRAS

--- calcula el total del articulo
CREATE FUNCTION calcula_totales() RETURNS trigger AS $$
DECLARE producto record;
DECLARE aux record;
 BEGIN
    --Actualiza el total articulo
    SELECT * INTO producto FROM producto_almacen WHERE codigo_barras = NEW.codigo_barras;
	NEW.total_articulo = producto.precio_venta * NEW.cantidad;
    ---Actualiza el total venta
    SELECT * INTO aux FROM venta WHERE id_venta = NEW.id_venta;
    UPDATE venta set total_venta =  (aux.total_venta + (producto.precio_venta * NEW.cantidad)) WHERE id_venta = NEW.id_venta;
	
    RETURN NEW;
 END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calcula_totales_trigger BEFORE INSERT ON producto_venta
FOR EACH ROW EXECUTE PROCEDURE calcula_totales();


