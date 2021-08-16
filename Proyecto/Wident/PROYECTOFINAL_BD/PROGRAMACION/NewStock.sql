CREATE OR REPLACE FUNCTION NewStock()
RETURNS trigger LANGUAGE plpgsql
AS 
$$
BEGIN
	IF stock <= 0 THEN 
		ROLLBACK;	  
		RAISE NOTICE 'Sin productos disponibles';
	ELSE 
	 	UPDATE inventario I SET stock = stock - cantidad
      	WHERE I.precio_unitario = venta_detalles.precio_unitario;
			IF stock <= 0 THEN
				ROLLBACK;
				RAISE NOTICE 'Producto agotado';
			ELSIF unidades_stock < 2 THEN
				RAISE NOTICE 'Quedan menos de dos productos en almacen';
			END IF;
	END IF;
END
$$;