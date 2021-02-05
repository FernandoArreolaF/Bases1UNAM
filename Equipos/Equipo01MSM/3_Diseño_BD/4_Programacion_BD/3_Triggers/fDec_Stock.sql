CREATE OR REPLACE FUNCTION decStock()
RETURNS trigger LANGUAGE plpgsql
AS 
$$
BEGIN
	IF stock<=0 THEN 
		ROLLBACK;	  
		RAISE NOTICE 'Sin productos disponibles';
	ELSE 
		UPDATE inventario SET stock=stock-cantidad
      	WHERE inventario.precio_unitario=venta_detalles.precio_unitario;
			IF stock<0 THEN
				ROLLBACK;
				RAISE NOTICE 'Producto agotado';
			ELSIF unidades_stock<3 THEN
				RAISE NOTICE 'Quedan menos de tres productos en almacen';
			END IF;
	END IF;
END
$$;
