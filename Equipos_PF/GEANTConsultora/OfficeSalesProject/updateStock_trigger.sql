CREATE OR REPLACE FUNCTION INVENTARIO () RETURNS TRIGGER AS $$
DECLARE
 stock2 INTEGER;
 stock1 INTEGER;
BEGIN
    select stock INTO stock2 FROM product WHERE barcode=new.idproduct;
    stock1=new.quantityproduct;
    RAISE NOTICE 'new idsale: %',new.idsale;
    RAISE NOTICE 'stock1=quantityproduct: %',stock1;
    CASE
        WHEN stock2=1 or stock2<=0 THEN
            RAISE EXCEPTION USING MESSAGE = 'No hay productos en stock.';
        WHEN stock2<=3 THEN
            RAISE WARNING 'Quedan 3 o menos piezas en Stock, stock % pz. - %',stock2, NOW();
            UPDATE product
            SET stock=stock2-stock1
            WHERE barcode=new.idproduct;
        WHEN stock2>3 THEN
            UPDATE product
            SET stock=stock2-stock1
            WHERE barcode=new.idproduct;
            RAISE NOTICE 'Se realizo correctamente la actualización del stock %. stock2 %, stock1 %', now(), stock2, stock1;
        ELSE
            RAISE NOTICE 'Error en actualizar stock';
    END CASE;
    RETURN NEW;
END; $$
LANGUAGE 'plpgsql';

create trigger trstock before insert on sale
for each row execute procedure INVENTARIO();
