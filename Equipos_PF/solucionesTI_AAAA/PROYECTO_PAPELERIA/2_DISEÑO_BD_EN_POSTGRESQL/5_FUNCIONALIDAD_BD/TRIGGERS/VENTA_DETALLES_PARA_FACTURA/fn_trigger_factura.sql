CREATE OR REPLACE FUNCTION fn_genera_factura()
RETURNS TRIGGER LANGUAGE plpgsql
--===========================================================================================
--AUTORES: solucionesTI_AAAA
--BD:PROYECTO_PAPELERIA
--DESCRIPCIÓN: Genera datos de factura, de forma automática al generar una venta.
--FECHA DE CREACIÓN 
--===========================================================================================
AS
$$
DECLARE li_id_venta 		VARCHAR(50);
		ls_razon_social 	VARCHAR(100);
		ld_fecha_date		DATE:=current_date;
		li_cantidad			INT:=0;
		ls_nombre_producto  VARCHAR(50);
		ls_descripcion		VARCHAR(100);
		li_importe			NUMERIC;
BEGIN
	li_id_venta:=new.id_venta;
	------------------------------------------------------------------------
	SELECT razon_social
	FROM CLIENTES Cte
	INNER JOIN VENTAS V 		 ON V.id_cliente=Cte.id_cliente
	INNER JOIN VENTA_DETALLES VD ON VD.id_venta=V.id_venta
	WHERE VD.id_venta=new.id_venta 
	INTO ls_razon_social;--Obtenemos la razon social del cliente que compra.
	------------------------------------------------------------------------
	li_cantidad:=new.cantidad;
	------------------------------------------------------------------------
	SELECT nombre_producto
	FROM PRODUCTOS
	WHERE id_producto=new.id_producto
	INTO ls_nombre_producto;
	------------------------------------------------------------------------
	SELECT descripcion
	FROM PRODUCTOS
	WHERE id_producto=new.id_producto
	INTO ls_descripcion;
	------------------------------------------------------------------------
	li_importe:=new.cantidad*new.precio_unitario;
	------------------------------------------------------------------------
	
	INSERT INTO FACTURA(id_venta,razon_social,fecha,cantidad,nombre_producto,descripcion,importe)
	VALUES(li_id_venta,ls_razon_social,ld_fecha_date,li_cantidad,ls_nombre_producto,
		   ls_descripcion,li_importe);
	
	return new;
END
$$;