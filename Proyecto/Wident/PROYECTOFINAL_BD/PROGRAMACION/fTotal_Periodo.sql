CREATE OR REPLACE FUNCTION fTotal_Periodo(fecha_Inicio DATE, fecha_Fin DATE)
RETURNS NUMERIC LANGUAGE plpgsql
AS $$
DECLARE
	venta_Total_Periodo INT:=0;
BEGIN
	SELECT SUM(cantidad_total) FROM VENTA 
	WHERE fecha_venta BETWEEN fecha_Inicio AND fecha_Fin
	INTO venta_Total_Periodo;
	
	RETURN venta_Total_Periodo;
END
$$;

SELECT fTotal_Periodo('2021-07-05','2021-07-05');

--DROP FUNCTION fCantidad_Total_Periodo(fecha_Inicio DATE, fecha_Fin DATE);--No Usar