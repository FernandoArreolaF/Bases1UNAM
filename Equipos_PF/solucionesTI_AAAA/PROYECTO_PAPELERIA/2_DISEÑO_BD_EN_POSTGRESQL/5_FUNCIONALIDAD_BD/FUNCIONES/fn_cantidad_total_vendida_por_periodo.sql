CREATE OR REPLACE FUNCTION fn_cantidad_total_vendida_por_periodo(ps_fecha_inicio VARCHAR(50)
														     ,ps_fecha_fin	   VARCHAR(50))
													
RETURNS NUMERIC LANGUAGE plpgsql
AS
$$
--===========================================================================================
--AUTORES: solucionesTI_AAAA
--BD:PROYECTO_PAPELERIA
--DESCRIPCIÓN: Dada una fecha de inicio y una fecha de fin, regresar la cantidad total que
--			   se vendió en esa fecha/periodo. 
--===========================================================================================
DECLARE ln_total_vendido_por_periodo NUMERIC :=0;
		ld_fecha_inicio DATE:=to_date(ps_fecha_inicio,'YYYYMMDD');
		ld_fecha_fin	DATE:=to_date(ps_fecha_fin,'YYYYMMDD');
BEGIN
	SELECT SUM (precio_unitario*cantidad) 
	FROM VENTA_DETALLES VD
		INNER JOIN VENTAS V on V.id_venta=VD.id_venta 
	WHERE V.fecha_venta BETWEEN ld_fecha_inicio AND ld_fecha_fin
	INTO ln_total_vendido_por_periodo;
	 --Mediante esta consulta, se obtienen 
									   --la cantidad de dinero vendido en el periodo solicitado.
	
	RETURN ln_total_vendido_por_periodo;
--select public.fn_cantidad_total_vendida_por_periodo('20200507','20200507');
END
$$;

