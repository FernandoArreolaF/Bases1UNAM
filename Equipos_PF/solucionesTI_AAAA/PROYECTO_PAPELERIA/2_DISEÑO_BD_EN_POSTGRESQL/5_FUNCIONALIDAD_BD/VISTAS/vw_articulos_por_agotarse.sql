CREATE VIEW vw_articulos_por_agotarse
AS
--===========================================================================================
--AUTORES: solucionesTI_AAAA
--BD:PROYECTO_PAPELERIA
--DESCRIPCIÓN: Obtención de productos que estén por agotarse, es decir, aquellos productos
--			   cuyas unidades en stock sean menores a 3.
--LLAMADO: SELECT * FROM vw_articulos_por_agotarse
--===========================================================================================
	SELECT nombre_producto,descripcion 
	FROM PRODUCTOS
	WHERE unidades_stock <=2 AND unidades_stock>0;



