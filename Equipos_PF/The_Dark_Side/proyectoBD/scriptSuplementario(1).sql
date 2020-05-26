alter table detalle_orden alter numVenta drop not null;
ALTER TABLE ORDEN DROP CONSTRAINT orden_total_check;
ALTER TABLE ORDEN ADD CONSTRAINT orden_total_chec CHECK (total >=0 );
ALTER TABLE ORDEN ALTER COLUMN total SET DEFAULT 0;


CREATE OR REPLACE FUNCTION stockDec() RETURNS TRIGGER AS $$
DECLARE _dispA integer;
DECLARE _price decimal(6,2);
BEGIN 
	SELECT stock p INTO _dispA from producto p WHERE p.codigoBarras = new.codigoBarras;
	SELECT precioVenta p INTO _price from producto p WHERE p.codigoBarras = new.codigoBarras;
	--SELECT new.cantidadArticulos INTO _dispB from NEW;
	IF (_dispA >= new.cantidadArticulos) THEN
		if(_dispA < 3) THEN
		RAISE NOTICE 'Advertencia: Queda(n) % articulo(s) en stock!',_dispA-new.cantidadArticulos;
		end if;
		UPDATE producto 
		SET stock = _dispA - new.cantidadArticulos 
		WHERE producto.codigoBarras = new.codigoBarras;
		
		new.subtotal := new.cantidadArticulos*_price;
		new.numVenta := (SELECT numVenta from orden ORDER BY numVenta DESC LIMIT 1);--nueva característica

		UPDATE orden
		SET total=total+(new.cantidadArticulos*_price)
		WHERE orden.numVenta = new.numVenta;
		RETURN NEW;
	else
		RAISE EXCEPTION 'No hay suficiente stock, queda(n) % pieza(s) en stock',  _dispA ;
	END IF;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
----FUNCION DE VENTA************************** METE EN DETALLE ORDEN
CREATE OR REPLACE FUNCTION ultimaVenta(cd integer, qty integer) RETURNS BOOLEAN as $$
BEGIN
	INSERT INTO detalle_orden(codigoBarras,numventa,cantidadArticulos) VALUES(cd,(SELECT numventa from orden ORDER BY numventa DESC LIMIT 1),qty);
	RETURN 1;
END;$$ LANGUAGE 'plpgsql';

--TRIGGER DEL DETALLE_ORDEN ARREGLADO
--	AHORA SE PUEDEN MODIFICAR LAS OTRAS VENTAS


CREATE OR REPLACE FUNCTION stockDec() RETURNS TRIGGER AS $$
DECLARE _dispA integer;
DECLARE _price decimal(6,2);
BEGIN 
	SELECT stock p INTO _dispA from producto p WHERE p.codigoBarras = new.codigoBarras;
	SELECT precioVenta p INTO _price from producto p WHERE p.codigoBarras = new.codigoBarras;
	--SELECT new.cantidadArticulos INTO _dispB from NEW;
	IF (_dispA >= new.cantidadArticulos) THEN
		if(_dispA < 3) THEN
		RAISE NOTICE 'Advertencia: Queda(n) % articulo(s) en stock!',_dispA-new.cantidadArticulos;
		end if;
		UPDATE producto 
		SET stock = _dispA - new.cantidadArticulos 
		WHERE producto.codigoBarras = new.codigoBarras;
		
		new.subtotal := new.cantidadArticulos*_price;
		--new.numVenta := (SELECT numVenta from orden ORDER BY numVenta DESC LIMIT 1);
		UPDATE orden
		SET total=total+(new.cantidadArticulos*_price)
		WHERE orden.numVenta = new.numVenta;
		RETURN NEW;
	else
		RAISE EXCEPTION 'No hay suficiente stock, queda(n) % pieza(s) en stock',  _dispA ;
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION stockPlus() RETURNS TRIGGER AS $$
DECLARE _dispA integer;
DECLARE _price decimal(6,2);
BEGIN 
	SELECT stock p INTO _dispA from producto p WHERE p.codigoBarras = old.codigoBarras;
	SELECT precioVenta p INTO _price from producto p WHERE p.codigoBarras = old.codigoBarras;
	--SELECT new.cantidadArticulos INTO _dispB from NEW;
	UPDATE producto 
		SET stock = _dispA + old.cantidadArticulos 
		WHERE producto.codigoBarras = old.codigoBarras;
		
		--old.numVenta := (SELECT numVenta from orden ORDER BY numVenta DESC LIMIT 1);

	UPDATE orden
		SET total=total-(old.cantidadArticulos*_price)
		WHERE orden.numVenta = old.numVenta;
		RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER stockPlus BEFORE DELETE ON detalle_orden
	FOR EACH ROW EXECUTE PROCEDURE stockPlus(); 
