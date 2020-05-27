CREATE OR REPLACE FUNCTION stock()
  RETURNS trigger AS $$
BEGIN
	  IF unidades_stock<=0 THEN 
		ROLLBACK;	  
		RAISE NOTICE 'No hay productos en almacen';
	  ELSE 
	  	--BEGIN
		UPDATE productos SET
      	unidades_stock=unidades_stock-cantidad
      	WHERE productos.precio_unitario=venta_detalles.precio_unitario and 
		productos.id_producto=venta_detalles.id_producto;
		--COMMIT
				IF unidades_stock<0 THEN
					ROLLBACK;
					RAISE NOTICE 'No se puede hacer la venta';
				ELSIF unidades_stock<3 THEN
					RAISE NOTICE 'Hay menos de 3 productos en almacen';
				END IF;
       END IF;
--RETURN NULL;
END

$$ LANGUAGE plpgsql;

