CREATE OR REPLACE FUNCTION fCantidad_Total_Periodo(fecha_Inicio DATE, fecha_Fin DATE)
RETURNS NUMERIC LANGUAGE plpgsql
AS $$
DECLARE
	venta_Total_Periodo NUMERIC:=0;
BEGIN
	SELECT SUM(cantidad) 
	FROM VENTA_DETALLES VD
	INNER JOIN VENTA V ON V.numero_venta=VD.numero_venta
	WHERE V.fecha_venta BETWEEN fecha_Inicio AND fecha_Fin
	INTO venta_Total_Periodo;
	
	RETURN venta_Total_Periodo;
END
$$;

SELECT fCantidad_Total_Periodo('20201202', '20210110');

--DROP FUNCTION fCantidad_Total_Periodo(fecha_Inicio DATE, fecha_Fin DATE);--No Usar
