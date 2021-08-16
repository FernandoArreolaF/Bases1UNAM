--------------------------------------------------------------------------------------
-------------------------------------Toci Software------------------------------------
--------------------------------------------------------------------------------------
/* Proyecto Base de datos del quipo Toci Software.
Integrantes:
*Arreguin Portillo Diana Laura
*Brito Serrano Miguel Ángel
*Marentes Degollado Ian Paul
*Meza Vega Hugo Adrián
*/

--Secuencia para la parte del id de venta
CREATE SEQUENCE numervent
START WITH 1
INCREMENT BY 1
MAXVALUE 999
MINVALUE 1
CYCLE;

--Función que se encarga de generar el id de venta en formato "VENT-#"
CREATE OR REPLACE FUNCTION idventa() RETURNS VARCHAR AS $idventa$
DECLARE identificador varchar(8);
BEGIN
identificador:=CONCAT('VENT-',CAST((SELECT nextval('numervent')) AS VARCHAR));
RETURN identificador;
END;
$idventa$ LANGUAGE plpgsql;



--Funcion que al ingresar el codigo de barras nos regrese la utilidad
CREATE FUNCTION utilidadc(codbarras varchar(30)) 
RETURNS DECIMAL AS $utilidadc$
DECLARE utilidadup decimal = (SELECT utilidad FROM producto WHERE codbarras = codigo_barras);
BEGIN
	RETURN utilidadup;
END;
$utilidadc$ LANGUAGE plpgsql;




--Funcion que al ingresar una fecha regrese la cantidad total que se vendio
CREATE OR REPLACE FUNCTION cantidad_vendida(fecha DATE) 
RETURNS DECIMAL AS $cantidad_vendida$
DECLARE cant_vendida decimal = (SELECT SUM(monto_total) FROM venta WHERE fecha = fecha_venta);
BEGIN
	RETURN cant_vendida;
END;
$cantidad_vendida$ LANGUAGE plpgsql;



--Funcion que al ingresar un intervalo de fechas regrese la cantidad total que se vendio
CREATE OR REPLACE FUNCTION cantidad_vendida_rango(fecha1 DATE, fecha2 DATE) 
RETURNS DECIMAL AS $cantidad_vendida_rango$
DECLARE cant_vendida_f1 decimal = (SELECT SUM(monto_total) FROM venta WHERE fecha1 = fecha_venta);
DECLARE cant_vendida_f2 decimal = (SELECT SUM(monto_total) FROM venta WHERE fecha2 = fecha_venta);
DECLARE cant_vendida_total decimal = (SELECT SUM(monto_total) FROM venta WHERE fecha_venta BETWEEN fecha1 AND fecha2);
BEGIN
	RETURN cant_vendida_total;
END;
$cantidad_vendida_rango$ LANGUAGE plpgsql;



--Funcion que obtiene los productos de los cuales hay menos de 3 en stock
CREATE OR REPLACE FUNCTION enstock()
RETURNS TABLE (Productos_con_menos_tres_stock varchar(250)) AS $enstock$
BEGIN
	RETURN QUERY
	SELECT descripcion FROM producto WHERE stock < 3;
END;
$enstock$ LANGUAGE plpgsql;



--Trigger que se encarga de decrementar el stock en cada venta
CREATE OR REPLACE FUNCTION atualiza_stock_utilidad() RETURNS TRIGGER AS $$
	DECLARE stock_disp int;
	DECLARE aux int;
	DECLARE act_utilidad decimal(10,2);
	BEGIN
		stock_disp=(SELECT stock FROM producto WHERE id_producto=new.id_producto);
		IF ( stock_disp > 0) THEN
			IF (new.cantidad_articulo<=stock_disp) THEN 
				aux=(SELECT stock FROM producto WHERE id_producto=new.id_producto) - new.cantidad_articulo;
				UPDATE producto SET stock=aux WHERE id_producto=new.id_producto;
				act_utilidad=((SELECT precio_unidad FROM producto WHERE id_producto=new.id_producto)-
				(SELECT precio_proveedor FROM producto WHERE id_producto=new.id_producto))*new.cantidad_articulo+
				(SELECT utilidad FROM producto WHERE id_producto=new.id_producto); --Se almacena el valor actualizado de la utilidad del producto
				UPDATE producto SET utilidad=act_utilidad WHERE id_producto=new.id_producto; --actualización de la nueva utilidad
				stock_disp=(SELECT stock FROM producto WHERE id_producto=new.id_producto); -- actualización del stock
				IF stock_disp<=3 THEN
					RAISE NOTICE 'Hay % productos en stock del producto con id %', stock_disp,new.id_producto;
				END IF;
			ELSE
				RAISE NOTICE 'Se ha cancelado la transacción. No hay stock suficiente del producto con id %', new.id_producto;
			END IF;
		ELSE
			RAISE NOTICE 'Se ha cancelado la transacción. No hay stock del producto con id %', new.id_producto;
			RETURN NULL;
		END IF;
		RETURN new;
	END 
$$ LANGUAGE plpgsql;


--Creación de la vista "factura"
CREATE OR REPLACE FUNCTION gen_factura(rfc_cons varchar(13), numvent varchar(8))
RETURNS 
TABLE (
	nombre character varying, 
	ap_paterno character varying, 
	rfc character varying, 
	calle character varying, 
	numero integer, 
	colonia character varying, 
	codigo_postal integer, 
	num_venta character varying, 
	monto_total numeric, 
	fecha_compra date)
AS $$
	BEGIN
	RETURN QUERY
	SELECT cl.nombre_pila, cl.ap_paterno, cl.rfc, cl.calle, cl.numero, cl.colonia, cl.codigo_postal, 
	v.num_venta, v.monto_total, v.fecha_venta
	FROM cliente cl
		INNER JOIN venta v ON cl.rfc=v.rfc
	WHERE cl.rfc=rfc_cons AND v.num_venta=numvent;
END;
$$ LANGUAGE plpgsql;


	
--Creación del índice
CREATE INDEX nombre_cliente ON cliente USING btree (nombre_pila, ap_paterno, ap_materno);
	
	
	
	
