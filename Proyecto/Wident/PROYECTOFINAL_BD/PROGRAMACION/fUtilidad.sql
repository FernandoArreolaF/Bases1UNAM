CREATE FUNCTION fUtilidad(codigo_barras_prd VARCHAR(30))
RETURNS NUMERIC LANGUAGE plpgsql
AS $$
DECLARE
	precio_venta NUMERIC;
	ganancia NUMERIC;
	utilidad NUMERIC;
BEGIN
	SELECT precio
	FROM PRODUCTO
	WHERE codigo_barras=codigo_barras_prd
	INTO precio_venta;
	
	SELECT precio_compra
	FROM VENTA_PROVEEDOR
	INTO ganancia;
	
	utilidad:= precio_venta - ganancia;
	RETURN utilidad;
END
$$;

SELECT fUtilidad('P56420K1')