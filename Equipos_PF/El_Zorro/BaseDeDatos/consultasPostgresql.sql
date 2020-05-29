-----------------------Consultas---------------------------------------------------------------

-----Dada una fecha de inicio y fin, numero de productos vendidos, del más vendido al menos---


CREATE OR REPLACE FUNCTION venta_periodo(varchar, varchar) 
returns TABLE (cod_Barras varchar(80), cantidad bigint)
as
$$
   declare fin date;
   declare inicio date;
   BEGIN 
   fin = date($2);
   inicio = date($1);
   
   raise notice 'Fecha inicio: %', inicio;
   raise notice 'Fecha fin: %', fin;
   
   RETURN QUERY SELECT r.cod_barras, sum(r.cantidad)
                       FROM registrar r 
					   inner join VENTA V ON R.id_Venta = V.id_Venta
					   GROUP BY R.COD_BARRAS, R.CANTIDAD, V.ID_VENTA
					   HAVING fecha_Venta>= inicio and fecha_Venta<=fin
					   ORDER BY R.cantidad DESC;		   
   
   	END;
	$$
	LANGUAGE PLPGSQL;
		
--------------REALIZANDO LA CONSULTA-------------------------------------------
SELECT VENTA_PERIODO('2015-05-24', '2018-05-24');


/*Venta periodo, dada una fecha de inicio y fin, total productos*/

CREATE OR REPLACE FUNCTION TOTALventa_periodo(varchar, varchar) 
 returns int
as
$$
   declare fin date;
   declare inicio date;
   declare totalProductos int;
   BEGIN 
   fin = date($2);
   inicio = date($1);   
   raise notice 'Fecha inicio: %', inicio;
   raise notice 'Fecha fin: %', fin;   
  totalProductos:= (SELECT SUM(R.cantidad) as CantidadProductosVendidos
				FROM Venta V
				INNER JOIN Registrar R ON R.id_Venta=v.id_Venta
				WHERE fecha_Venta between inicio and fin);		   
   	RETURN totalProductos;
   	END;
	$$
	LANGUAGE PLPGSQL;
	
--------------REALIZANDO LA CONSULTA-------------------------------------------
SELECT totalVENTA_PERIODO('2015-05-24', '2018-05-24');



-------------Funcion utilidad------------------------------------------------
CREATE OR REPLACE FUNCTION UTILIDAD (varchar(80))
RETURNS numeric
AS $$
     declare compra numeric;
	 declare venta numeric;
	 declare utilidad numeric;
    BEGIN
    compra:= (SELECT precio_Compra FROM INVENTARIO i WHERE i.cod_Barras = $1);
    venta := (Select precio_venta FROM INVENTARIO i where i.cod_Barras = $1);
	utilidad = venta - compra;
	RETURN utilidad;
	END;
$$LANGUAGE PLPGSQL;

  
-----------EJECUTANDO LA FUNCION UTILIDAD-----------------------------------
SELECT *FROM utilidad ('GT28 NYRO ZVT0 3QFV CTFT 3AKV RV8Q');


/*CREAR FUNCION UTILIDAD QUE REGRESE UNA TABLA CON COD_bARRAS*/
CREATE OR REPLACE FUNCTION utilidad_precio (varchar (80))
RETURNS TABLE (cod_Barras varchar(80), utilidad numeric)
AS $$
	BEGIN 
	RETURN query 
	       SELECT i.cod_Barras, sum(i.precio_venta - i.precio_Compra) as Utilidad
		   FROM INVENTARIO i
		   WHERE i.cod_Barras=$1;
   END;
   
   
/*---------CUANDO STOCK SEA MENOR A 3---------------*/
CREATE OR REPLACE FUNCTION STOCK ()
RETURNS TABLE (cod_Barras varchar(80), cantidad int )
AS 
	$$
	BEGIN 
	RETURN query 
	       SELECT i.cod_Barras, i.stock
		   FROM INVENTARIO i
		   WHERE stock<= 3;
   END;
 $$LANGUAGE PLPGSQL;
 --------------EJECUCION STOCK------------------------  
  select *from stock();
 

 /*---------------------------------Vista de una factura---------------------------------------------------*/
CREATE VIEW FACTURA
AS
Select* FROM(
 	SELECT 1 AS Factura, 'Datos de Factura:' as PapeleriaBaseDeDatos, 
	CONCAT('Cliente: ', CAST(C.id_Cliente AS varchar(10))) as Tel55070220,  
	CONCAT('Fecha: ',CAST(V.fecha_Venta AS varchar(10))) as AV20DENOVIEMBRE, 
	CONCAT('Venta: ', v.id_Venta) as Num1024, ' ' as Pago
 	FROM CLIENTE C
	INNER JOIN Venta V ON V.id_Cliente = C.id_Cliente
 	Where v.id_Venta= 'VENT-001'
 UNION
	SELECT 2,CONCAT( 'Facturar A: ',C.appat_Cliente,' ',C.nombre_Cliente) as Nombre,C.rs_Cliente as Compañia,
	CONCAT(C.calle_Cliente,' #',C.num_Cliente, ', Col.',C.col_Cliente, ', CP.',C.cp_Cliente) as Direccion,
	E.email as CorreoElectronico, ' '
	FROM CLIENTE C
	INNER JOIN Venta V ON V.id_Cliente = C.id_Cliente
 	INNER JOIN email E ON E.id_Cliente = C.id_Cliente
  	Where v.id_Venta= 'VENT-001'
 UNION 
 	SELECT '3', ' ', ' ', ' ', ' ', ' '
 UNION 
 	SELECT '3', 'Codigo Barras', 'Producto', 'Precio unitario', 'Cantidad ', ' '
 UNION
	SELECT 4, r.cod_Barras, P.descripcion as Producto, CAST(r.precio_Venta AS varchar(10)), 
	CAST(r.cantidad AS varchar(10)),CAST(r.pago AS varchar(10)) 
	From Venta v
	inner join registrar r on v.id_Venta = r.id_Venta
	inner join inventario I on r.cod_Barras= i.cod_Barras
	inner join producto P on p.id_Prod=i.id_Prod
	Where v.id_Venta= 'VENT-001'
UNION
	SELECT 5, ' ', ' ', ' ', 'SUBTOTAL', CAST(SUM(r.pago) AS varchar(10))
	FROM Venta V
	inner join registrar r on v.id_Venta = r.id_Venta
	Where v.id_Venta= 'VENT-001'
UNION
	SELECT 6, ' ', ' ', ' ', 'IVA 16%', CAST((SUM(r.pago))*0.16 AS varchar(10))
	FROM Venta V
	inner join registrar r on v.id_Venta = r.id_Venta
	Where v.id_Venta= 'VENT-001'
UNION
	SELECT 7, ' ', ' ', ' ', 'TOTAL', CAST((SUM(r.pago)+(SUM(r.pago))*0.16) AS varchar(10))
	FROM Venta V
	inner join registrar r on v.id_Venta = r.id_Venta
	Where v.id_Venta= 'VENT-001'
) as FACT
ORDER BY Factura;

-----------EJECUCION DE FACTURA---------------------------------------------------------------
Select * From FACTURA


 ----------------VISTA DE LA INFORMACION DE UNA FACTURA--------------- 
CREATE VIEW FACTURAsimple
AS
SELECT v.id_Venta, v.id_Cliente, v.fecha_Venta, r.cod_Barras, r.precio_Venta, r.cantidad, r.pago,rp.subtotal,rp.iva,rp.total
From Venta v
inner join registrar r on v.id_Venta = r.id_Venta
inner join registrar_pago rp on rp.id_Venta = r.id_Venta
Where v.id_Venta= 'VENT-001'

-----------EJECUCION DE FACTURA 
Select * From FACTURAsimple



/*Creación de índice*/
--El indice se crea en el codigo de barras para poder hacer una busqueda mas rapida a la hora de hacer ventas. 
CREATE INDEX Indice_Baras on INVENTARIO(cod_Barras);
