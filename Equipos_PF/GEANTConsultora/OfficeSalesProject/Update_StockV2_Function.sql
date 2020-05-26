CREATE OR REPLACE FUNCTION updatestock2(id_sale VARCHAR, barcode_product VARCHAR)
RETURNS INTEGER AS $$ 
DECLARE 
    stock2 INTEGER; 
    stock1 INTEGER; 
    newstock INTEGER;
BEGIN
    SELECT stock INTO stock2 FROM product WHERE barcode=barcode_product;
    SELECT quantityproduct INTO stock1 from sale where idsale=id_sale;
    CASE
        WHEN stock2=1 or stock2<=0 THEN
            RAISE NOTICE  'No hay productos en stock. %', NOW();
            DELETE 
            FROM sale
            WHERE idsale=id_sale;
        
        WHEN stock2<=3 THEN
            RAISE WARNING 'Quedan 3 o menos piezas en Stock, stock % pz. - %', newstock, NOW();
            newstock=stock2-stock1;
            UPDATE product
            SET stock=newstock
            WHERE barcode=barcode_product;

        WHEN stock2>3 THEN
            newstock=stock2-stock1;
            UPDATE product
            SET stock=newstock
            WHERE barcode=barcode_product;
            RAISE NOTICE 'Se realizo correctamente la actualización del stock %', now();

        ELSE
            RAISE NOTICE 'Error en actualizar stock';
    END CASE;
    RETURN newstock;
END; $$
LANGUAGE 'plpgsql';
/**
original

**/