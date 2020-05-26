CREATE OR REPLACE FUNCTION checkstock() RETURNS TABLE(
    barcode_checks VARCHAR,
    priceprovider_check FLOAT,
    stock_checks INTEGER,
    trade_checks VARCHAR,
    description_checks VARCHAR,
    pricevendor_check FLOAT,
    product_type VARCHAR
)
AS $$
BEGIN
    RETURN QUERY SELECT
        barcode,
        priceprovider,
        stock,
        trade,
        description,
        pricevendor,
        producttype
        FROM
            product
        WHERE
            stock<3;
END; $$
LANGUAGE 'plpgsql';
