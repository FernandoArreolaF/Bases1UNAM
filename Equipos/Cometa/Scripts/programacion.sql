--Creación de la función que devuelve utilidad
CREATE OR REPLACE FUNCTION obten_utilidad(codigo_Bar varchar(15)) returns int 
as 
$$
	select prod.precio_Venta - sumi.precio_Compra FROM PRODUCTO prod
	INNER JOIN SUMINISTRA sumi ON (prod.codigo_Barras = sumi.codigo_Barras)
	where prod.codigo_Barras=codigo_Bar; 
$$ 
language sql;
--Llamada a la funcion de utilidad
SELECT obten_utilidad('7502247683709');

	
/*Dada una fecha regresar la cantidad total
que se vendio en esa fecha*/
CREATE OR REPLACE FUNCTION obten_CantidadVendida(fecha_Esp date) returns integer
as
$$
	select SUM(det.cantidad) FROM VENTA vent
	FULL JOIN DETALLE det ON (det.no_Venta = vent.no_Venta)
	where fecha_Venta = fecha_Esp GROUP BY fecha_Venta;
$$
language sql;
--Llamada a la función
SELECT obten_CantidadVendida ('2020-07-28');

/*Obtiene la cantidad vendida en un 
periodo de tiempo*/

CREATE OR REPLACE FUNCTION obten_CantidadVendida(fecha1 date, fecha2 date) returns integer
AS
$$
	select SUM(det.cantidad) FROM VENTA vent
	INNER JOIN DETALLE det ON (det.no_Venta = vent.no_Venta)
	WHERE vent.fecha_Venta BETWEEN fecha1 AND fecha2;
$$
language sql

--Llamada a la funcion obten cantidad dado un periodo de tiempo
select * from obten_CantidadVendida('2020-11-12', '2020-12-24');

/*Obtener el nombre de productos de los cuales 
hay menos de 3 en stock*/
CREATE OR REPLACE FUNCTION obtenStock() RETURNS TABLE(producto varchar(20)) AS $$
BEGIN 
	RETURN QUERY EXECUTE
	format($f$SELECT descripcion FROM PRODUCTO WHERE stock<3$f$);
END $$
language plpgsql VOLATILE;
--Llamada a funcion
SELECT * FROM obtenStock();

--Secuencia para generar numero de factura
CREATE SEQUENCE noFactura
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 1000
	MINVALUE 1;
	
--Vista de factura (DISEÑO DOC)
CREATE OR REPLACE FUNCTION factura(numVenta text) RETURNS void AS $$
DECLARE contador int DEFAULT 0;
DECLARE registro record;
DECLARE registro1 record;
DECLARE contador1 int DEFAULT 0;
DECLARE registro2 record;

BEGIN
	FOR registro IN select fecha_Venta as FECHA, nextval('noFactura') as FACTURA, cli.razon_Social as compañia, concat(cli.nombre,' ',ap_Pat,' ', ap_Mat) as NOMBRE, 
	concat(calle, ' ',numero, ', ', colonia, ', ', estado, ' ', codigo_Postal ) AS DIRECCION
	FROM VENTA vent
	INNER JOIN CLIENTE cli ON(vent.razon_Social = cli.razon_Social)
	WHERE no_Venta = numVenta LOOP
		contador = contador+1;
		RAISE NOTICE 'Fecha: %', registro.fecha;
		RAISE NOTICE 'No Factura: %', registro.factura;
		RAISE NOTICE 'Razon Social: %', registro.compañia;
		RAISE NOTICE 'Nombre: %', registro.nombre;
		RAISE NOTICE 'Direccion: %', registro.direccion;							
	END LOOP;
	RAISE NOTICE '';
	RAISE NOTICE 'DESCRIPCION    PRECIO UNITARIO   CANTIDAD    TOTAL PROD';
	FOR registro1 IN select pro.descripcion AS descripcion, pro.precio_venta as precio_Unitario, det.cantidad as cantidad, det.total_Prod as totalProd FROM DETALLE det
	INNER JOIN PRODUCTO pro ON (det.codigo_Barras = pro.codigo_Barras)
	WHERE no_Venta  = numVenta LOOP
		RAISE NOTICE '%       %        %          $%', registro1.descripcion, registro1.precio_Unitario, registro1.cantidad, registro1.totalProd;
		contador1=contador1+1;
	END LOOP;	
	
	RAISE NOTICE '';
	
	FOR registro2 IN SELECT total_Venta FROM VENTA WHERE VENTA.no_Venta = numVenta LOOP
		RAISE NOTICE 'Total= $%', registro2.total_Venta;
	END LOOP;
END;
$$
LANGUAGE plpgsql;

--Llamada a la funcion que genera la factura 
--Unicamente se pasa como parametro el numero de venta
--En caso de usar pgAdmin la información
--se visualizará en el area de mensajes
SELECT factura('VENT-04');

--Procedimiento de actualizacion de stock
CREATE  OR REPLACE PROCEDURE ingresa_Detalle (codigo_bar varchar(15), no_vent text, cantidad numeric)
LANGUAGE PLPGSQL
AS $$
DECLARE 
	stockAct int;
	stockUp int;
	BEGIN
		INSERT INTO DETALLE (codigo_barras, no_venta, cantidad)
		VALUES ($1, $2, $3);
		stockAct=(SELECT stock FROM PRODUCTO WHERE codigo_barras = $1);
		if(stockAct>$3) then 
			UPDATE PRODUCTO SET stock= stockAct- $3
			WHERE codigo_Barras = $1;
			COMMIT;
		end if;
		stockUp = (SELECT stock FROM PRODUCTO WHERE codigo_Barras = $1);
		if(stockUp>0 and stockUp<3) then
			RAISE NOTICE 'El producto esta próximo a agotarse';
		elsif(stockUp= 0) then
			ROLLBACK;
		end if;
	end;
$$;


