CREATE OR REPLACE FUNCTION Factura()
RETURNS TRIGGER LANGUAGE plpgsql
AS
$$
DECLARE 
	fNumero_venta VARCHAR(10);
	fFecha DATE:=current_date;
	fConcepto VARCHAR(50);
	fMonto_total NUMERIC;
BEGIN
	fNumero_venta:=new.numero_venta;
	
	SELECT razon_social
	FROM CLIENTE C
	INNER JOIN VENTA VT ON VT.id_cliente = C.id_cliente
	INNER JOIN DETALLE_COMPRA DC ON DC.num_venta = VT.num_venta
	WHERE VD.num_venta = new.num_venta 
	INTO fRazon_social;

	SELECT nom_producto
	FROM PRODUCTO
	WHERE codigo_barras = new.codigo_barras
	INTO fConcepto;
	
	fMonto_total:=new.precio;
	
	INSERT INTO FACTURA(num_venta,fecha,concepto,precio_total)
	VALUES(fNumero_venta, fFecha,fConcepto,fMonto_total);

	return new;
END
$$;

