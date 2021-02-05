CREATE FUNCTION fUtilidad(codigo_barras_prd VARCHAR(30))
RETURNS NUMERIC LANGUAGE plpgsql
AS $$
DECLARE
	precio_venta NUMERIC;
	ganancia NUMERIC;
	utilidad NUMERIC;
BEGIN
	SELECT precio_unitario 
	FROM PRODUCTO
	WHERE codigo_barras=codigo_barras_prd
	INTO precio_venta;
	
	SELECT precio_compra
	FROM INVENTARIO
	INTO ganancia;
	
	utilidad:= precio_venta-ganancia;
	RETURN utilidad;
END
$$;

SELECT fUtilidad('B-16279-01')


