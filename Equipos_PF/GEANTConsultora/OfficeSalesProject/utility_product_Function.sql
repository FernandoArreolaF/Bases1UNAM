CREATE OR REPLACE FUNCTION utility(barcode_chose VARCHAR) 
RETURNS TABLE(
    barcode_product VARCHAR,
    trade_product VARCHAR,
    description_product VARCHAR,
    utility_product FLOAT)
AS $$
DECLARE
    price_prov FLOAT;
    price_ven FLOAT;
    utility_net FLOAT;
BEGIN
    SELECT priceprovider INTO price_prov FROM product WHERE barcode=barcode_chose;
    SELECT pricevendor INTO price_ven FROM product WHERE barcode=barcode_chose;
    utility_net= price_ven-price_prov;
    RETURN QUERY SELECT
        barcode,
        trade,
        description,
        utility_net
        FROM 
            product
        WHERE
            barcode=barcode_chose;
END; $$
LANGUAGE 'plpgsql';