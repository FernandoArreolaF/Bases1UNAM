
-- Cada que se solicite se genere una muestra de informaci´on que contengainformaci´on necesaria para asemejarse a una factura de una compra.

select * from contiene_producto_venta



SELECT 
    venta.numero AS numeroVenta, 
    venta.fecha AS fecha_Compra, 
    venta.total, 
    empleado.nombre
FROM venta
INNER JOIN empleado ON venta.clave = empleado.clave
WHERE venta.numero = 'VENT-001';




CREATE OR REPLACE FUNCTION Generar_Ticket(NumeroDeVenta TEXT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    ticket TEXT;
BEGIN
    SELECT 
        '***************************' || E'\n' ||
        '       TICKET DE VENTA      ' || E'\n' ||
        '***************************' || E'\n' ||
        'Número de Venta: ' || NumeroDeVenta || E'\n' ||

        'Fecha de Compra: ' || TO_CHAR(venta.fecha, 'YYYY-MM-DD') || E'\n' ||
		
        'Total: $' || venta.total || E'\n' ||
        'Atendido por: ' || empleado.nombre ||' ' || empleado.apellidop ||  E'\n' ||

		'       Cliente     '|| E'\n' ||
		'Compra realizada por '|| cliente.nombre|| ' '|| cliente.apellidop || E'\n' ||
		
        '***************************'
    INTO ticket
    FROM venta
    INNER JOIN empleado ON venta.clave = empleado.clave
	INNER JOIN cliente ON venta.rfc = cliente.rfc
    WHERE venta.numero = NumeroDeVenta;
    RETURN ticket;
END;
$$;


SELECT Generar_Ticket('VENT-005');


CREATE OR REPLACE FUNCTION Facturar(NumeroDeVenta TEXT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    ticket TEXT;
BEGIN
    SELECT 
        '***************************' || E'\n' ||
        '       Factura     ' || E'\n' ||
        '***************************' || E'\n' ||
        'Número de Venta: ' || NumeroDeVenta || E'\n' ||
        'Fecha de Compra: ' || TO_CHAR(venta.fecha, 'YYYY-MM-DD') || E'\n' ||
        'Total: $' || venta.total || E'\n' ||
        'Atendido por: ' || empleado.nombre ||' ' || empleado.apellidop ||  E'\n' ||

		'       Cliente     '|| E'\n' ||
		'Compra realizada por '|| cliente.nombre|| ' '|| cliente.apellidop || E'\n' ||
		'RFC a facturar 	' 	|| venta.rfc  || E'\n' ||
		
        '***************************'
    INTO ticket
    FROM venta
    INNER JOIN empleado ON venta.clave = empleado.clave
	INNER JOIN cliente ON venta.rfc = cliente.rfc
    WHERE venta.numero = NumeroDeVenta;
    RETURN ticket;
END;
$$;


SELECT Generar_Ticket('VENT-005');

SELECT facturar('VENT-005');

