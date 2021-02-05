CREATE OR REPLACE FUNCTION fFactura()
RETURNS TRIGGER LANGUAGE plpgsql
AS
$$
DECLARE 
	fNumero_venta VARCHAR(10);
	fFecha DATE:=current_date;
	fRazon_social VARCHAR(50);
	fConcepto VARCHAR(50);
	fCantidad INT:=0;
	fMonto_total NUMERIC;
BEGIN
	fNumero_venta:=new.numero_venta;
	
	SELECT razon_social
	FROM CLIENTE C
	INNER JOIN VENTA V ON V.id_cliente=C.id_cliente
	INNER JOIN VENTA_DETALLES VD ON VD.numero_venta=V.numero_venta
	WHERE VD.numero_venta=new.numero_venta 
	INTO fRazon_social;

	SELECT descripcion_producto
	FROM PRODUCTO
	WHERE id_producto=new.id_producto
	INTO fConcepto;

	fCantidad:=new.cantidad;
	
	fMonto_total:=new.cantidad*new.precio_unitario;
	
	INSERT INTO FACTURA(numero_venta,fecha,razon_social,concepto,cantidad,monto_total)
	VALUES(fNumero_venta, fFecha,fRazon_social,fConcepto,fCantidad,fMonto_total);

	return new;
END
$$;

