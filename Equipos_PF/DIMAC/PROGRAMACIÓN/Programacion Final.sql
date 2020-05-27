-- PROGRAMACIÓN PARA REQUERIMIENTOS ----
--PARTE 1
-- Al recibir el código de barras de un producto, regrese la utilidad

CREATE FUNCTION Utilidad (barras varchar(30))
RETURNS varchar(70)
AS $$
DECLARE
	prov numeric(5,0)= (SELECT precio_compra from SUMINISTRA WHERE cod_barras=barras);
	venta numeric(5,0)=(SELECT precio_prod FROM PRODUCTO WHERE cod_barras=barras);
	resultado numeric(5,0)=venta-prov;
	cadena varchar(70);
BEGIN
	cadena='La utilidad del producto'||' '||'con código de barras'||' '||barras||' '||'es'||' '||cast(resultado as varchar(10));
RETURN cadena;
END;
$$ Language  plpgsql;


SELECT utilidad('264782')
--------------------------------------------------------------------
--Dada una fecha, o una fecha de inicio y fecha de fin, 
--regresar la cantidad total que se -vendió en esa fecha/periodo.

CREATE OR REPLACE FUNCTION cantidad_vendida_por_fecha(fecha1 varchar(30), fecha2 varchar(30))
RETURNS varchar(70) AS $$
DECLARE 
	cadena varchar(70);
	total numeric(5,0);
BEGIN
	IF fecha2 IS NOT NULL THEN
		IF fecha1 IS NOT NULL THEN
		   SELECT SUM(cantidad_a_pagar) into total FROM VENTA 
		   WHERE fecha_venta IN (CAST (fecha1 as DATE), CAST(fecha2 as DATE));
		   cadena='La cantidad vendida entre'|| '  ' ||fecha1 ||' '|| 'y'
		   || ' ' || fecha2 || ' ' || 'es' || ' '||CAST(total as varchar(6));
		ELSE
			SELECT SUM(cantidad_a_pagar) into total FROM VENTA
		WHERE fecha_venta IN (CAST(fecha2 as DATE));
		cadena='La cantidad vendida el'|| '  ' ||fecha2 ||' '|| 'es' || ' '||CAST(total as varchar(6));
		END IF;
	ELSE
			SELECT SUM(cantidad_a_pagar) into total FROM VENTA
			WHERE fecha_venta IN (CAST(fecha1 as DATE));
			cadena='La cantidad vendida el'|| '  ' ||fecha1 ||' '|| 'es' || ' '||CAST(total as varchar(6));
		
	END IF;
	RETURN cadena;
END;
$$ Language plpgsql;
-----------------------------------------------------------------------------------
-- Permitir obtener el nombre de aquellos productos de los cuales hay menos de 3 en -stock. 

SELECT nom_prod, stock_prod FROM PRODUCTO 
WHERE stock_prod < 3

--De manera automática se genere una vista que contenga información 
--necesaria para asemejarse a una factura de una compra. 

CREATE VIEW view_factura
AS SELECT pv.num_venta,v.fecha_venta,v.rs_cliente,cl.nom_cliente,
prod.nom_prod,pv.precio_por_producto, pv.cantidad_producto, v.cantidad_a_pagar  
FROM VENTA V INNER JOIN CLIENTE Cl
ON V.rs_cliente = CL.rs_cliente
INNER JOIN PRODUCTO_VENTA PV
ON PV.num_venta = V.num_venta
INNER JOIN PRODUCTO PROD
ON PROD.cod_barras = PV.cod_barras

CREATE FUNCTION registro(vent varchar(30))
RETURNS record AS $$
	DECLARE 
	   registro record;
	BEGIN
		SELECT * into registro FROM view_factura WHERE num_venta=vent;
	 RETURN registro;
	END;
	$$ Language plpgsql;
				 
SELECT registro('VENT-011')

--Crear al menos, un índice, del tipo que se prefiera
-- y donde se prefiera. Justificar el -porqué de la elección en ambos aspectos.

CREATE INDEX stock_menor_a_tres ON PRODUCTO(stock_prod) 

--INSERCIONES GENERALES

CREATE FUNCTION inserta_productos(prod1 varchar(30), cant1 int,
	prod2 varchar(30), cant2 int, prod3 varchar(30), cant3 int, cliente varchar(30))
	RETURNS void as $$
	DECLARE 
	    codigo1 varchar(30);
		codigo2 varchar(30);
		codigo3 varchar(30);
		cod_venta varchar(30);
	BEGIN
		SELECT genera_num_venta() into cod_venta;
		INSERT INTO VENTA VALUES(cod_venta, now(), DEFAULT, cliente);
	    SELECT cod_barras into codigo1 FROM PRODUCTO WHERE nom_prod=prod1;
		SELECT cod_barras into codigo2 FROM PRODUCTO WHERE nom_prod=prod2;
		SELECT cod_barras into codigo3 FROM PRODUCTO WHERE nom_prod=prod3;
		
		IF prod1 IS NOT NULL THEN
			IF prod2 IS NOT NULL THEN
				IF prod3 IS NOT NULL THEN 
					INSERT INTO PRODUCTO_VENTA VALUES(codigo1, cod_venta, cant1, DEFAULT);
					INSERT INTO PRODUCTO_VENTA VALUES(codigo2, cod_venta, cant2, DEFAULT);
					INSERT INTO PRODUCTO_VENTA VALUES(codigo3, cod_venta, cant3, DEFAULT);
				ELSE
					INSERT INTO PRODUCTO_VENTA VALUES(codigo1, cod_venta, cant1, DEFAULT);
					INSERT INTO PRODUCTO_VENTA VALUES(codigo2, cod_venta, cant2, DEFAULT);
				END IF;
			ELSE
				IF prod3 IS NOT NULL THEN 
					INSERT INTO PRODUCTO_VENTA VALUES(codigo1, cod_venta, cant1, DEFAULT);
					INSERT INTO PRODUCTO_VENTA VALUES(codigo3, cod_venta, cant3, DEFAULT);
				ELSE
					INSERT INTO PRODUCTO_VENTA VALUES(codigo1, cod_venta, cant1, DEFAULT);
				END IF;
			END IF;
		ELSE
			IF prod2 IS NOT NULL THEN
				IF prod3 IS NOT NULL THEN 
					INSERT INTO PRODUCTO_VENTA VALUES(codigo2, cod_venta, cant2, DEFAULT);
					INSERT INTO PRODUCTO_VENTA VALUES(codigo3, cod_venta, cant3, DEFAULT);
				 ELSE
				 	INSERT INTO PRODUCTO_VENTA VALUES(codigo2, cod_venta, cant2, DEFAULT);
				END IF;
			 ELSE
			 	IF prod3 IS NOT NULL THEN
					INSERT INTO PRODUCTO_VENTA VALUES(codigo3, cod_venta, cant3, DEFAULT);
				ELSE
					RAISE EXCEPTION 'Ingrese al menos un producto';
				END IF;
			END IF;
		END IF;
END;
$$ Language plpgsql;



--TRIGGERS
--Trigger para verificar stock

CREATE OR REPLACE FUNCTION verifica_stock()
RETURNS TRIGGER AS $tg_comprueba_stock$
	DECLARE
		stock INTEGER;
	BEGIN
		SELECT stock_prod into stock FROM PRODUCTO WHERE cod_barras=NEW.cod_barras;
		IF(stock=0) THEN
			RAISE EXCEPTION 'No hay productos en almacen';
		ELSEIF (stock>NEW.cantidad_producto) THEN
			IF (stock<3) THEN 
			UPDATE PRODUCTO SET stock_prod=stock_prod-NEW.cantidad_producto
			WHERE cod_barras=NEW.cod_barras;
		    RAISE NOTICE 'Contamos con menos de 3 productos en  almacen';
			ELSE
			  UPDATE PRODUCTO SET stock_prod=stock_prod-NEW.cantidad_producto
			  WHERE cod_barras=NEW.cod_barras;
			END IF;	
		ELSEIF (stock=NEW.cantidad_producto) THEN
			--RAISE NOTICE 'Compraste los ultimos productos en almacen';
			UPDATE PRODUCTO SET stock_prod=stock_prod-NEW.cantidad_producto
			WHERE cod_barras=NEW.cod_barras;
			RAISE NOTICE 'Compraste los últimos  productos en almacen';
		ELSEIF (stock<NEW.cantidad_producto) THEN
			IF stock<3 then
				RAISE EXCEPTION 'Contamos con menos de 3 productos en  almacen';
			ELSE
				RAISE EXCEPTION 'No hay suficientes unidades en almacen para completar su compra';
		END IF;
		END IF;
		RETURN NEW;
	END; $tg_comprueba_stock$
	Language plpgsql;
	
CREATE TRIGGER tg_comprueba_stock
BEFORE INSERT ON PRODUCTO_VENTA
FOR EACH ROW
EXECUTE PROCEDURE verifica_stock();


--FUNCIONES IMPLÍCITAS 
--actualiza monto total y fecha

CREATE OR REPLACE FUNCTION total () RETURNS TRIGGER AS $tg_monto_total$
DECLARE 
cantidad INTEGER;
precio NUMERIC(5,0);
monto_total NUMERIC(5,0);
fecha date;
BEGIN
--OBTIENE LA CANTIDAD DE PRODUCTOS QUE SE INSERTA EN UNA VENTA
	SELECT now() into fecha;
	SELECT cantidad_producto INTO cantidad FROM PRODUCTO_VENTA WHERE
	cod_barras = NEW.cod_barras AND num_venta = NEW.num_venta; 
--OBTIENE EL PRECIO POR PRODUCTO DE LA TABLA QUE SE INSERTA EN UNA VENTA
	SELECT precio_prod INTO precio FROM PRODUCTO WHERE
	cod_barras = NEW.cod_barras; --AND num_venta = NEW.num_venta;
--CALCULANDO MONTO A PAGAR 
	monto_total= precio * cantidad;
--monto_total:= (SELECT precio_por_producto FROM PRODUCTO_VENTA WHERE 
--cod_barras = new.cod_barras AND num_venta = NEW.num_venta)* cantidad_producto;
	UPDATE VENTA SET cantidad_a_pagar = cantidad_a_pagar+monto_total WHERE num_venta = NEW.num_venta;
	UPDATE VENTA SET fecha_venta = fecha WHERE 
	num_venta = NEW.num_venta;
	RETURN NEW;
END
$tg_monto_total$ LANGUAGE PLPGSQL;

--TRIGGER 
CREATE TRIGGER tg_monto_total
AFTER INSERT ON PRODUCTO_VENTA
FOR EACH ROW
EXECUTE PROCEDURE total ();


--Obtiene el precio por producto

CREATE OR REPLACE FUNCTION precioProducto() RETURNS TRIGGER AS $tg_precio_producto$
DECLARE
	precio NUMERIC(5,0);
	BEGIN
	SELECT precio_prod into precio FROM PRODUCTO WHERE cod_barras=NEW.cod_barras;
	UPDATE PRODUCTO_VENTA SET precio_por_producto=precio
			WHERE cod_barras=NEW.cod_barras;
	RETURN NEW;
	END;
	$tg_precio_producto$ Language plpgsql;
--trigger
CREATE TRIGGER tg_precio_producto 
AFTER INSERT ON PRODUCTO_VENTA
FOR EACH ROW
EXECUTE PROCEDURE precioProducto();

