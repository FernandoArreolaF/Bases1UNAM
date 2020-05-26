CREATE OR REPLACE FUNCTION billinfo(IN id_sale VARCHAR)
RETURNS TABLE(
    id_sale_bill VARCHAR,
    barcode_bill VARCHAR,
    description_bill VARCHAR,
    quantityp_bill INTEGER,
    price_vendor_bill FLOAT,
    total_bill FLOAT
) AS $$
DECLARE
total_p FLOAT;
price_prod FLOAT;
quant INTEGER;
idd_sale VARCHAR;
name_bill VARCHAR;
last_name_bill VARCHAR;
rfc_bill VARCHAR;
street_bill VARCHAR;
house_bill VARCHAR;
colonia_bill VARCHAR;
postal_code_bill VARCHAR;
state_bill VARCHAR;
BEGIN
    SELECT c.name INTO name_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.lastname INTO last_name_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.rfc INTO rfc_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.street INTO street_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.housenumber INTO house_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.colonia INTO colonia_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.postalcode INTO postal_code_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.state INTO state_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;

    RAISE NOTICE 'GEANT S. de R.L. de C.V.';
    RAISE NOTICE 'www.geantcommerce.com.mx';
    RAISE NOTICE 'Telephone: 26-45-78-41';
    RAISE NOTICE 'Alvaro Obregón, Ciudad de México.';
    RAISE NOTICE 'Bill to % %',name_bill,last_name_bill;
    RAISE NOTICE 'RFC: %',rfc_bill;
    RAISE NOTICE 'Address: %, %, %, %, %',street_bill, house_bill, colonia_bill, postal_code_bill, state_bill;
    SELECT pricevendor INTO price_prod FROM product INNER JOIN sale ON barcode=idproduct WHERE idsale=id_sale;
    SELECT quantityproduct INTO quant FROM product INNER JOIN sale ON barcode=idproduct WHERE idsale=id_sale;
    total_p=quant*price_prod;
    idd_sale=id_sale;
    RETURN QUERY SELECT
        idd_sale,
        barcode,
        description,
        quant,
        price_prod,
        total_p
        FROM
        product INNER JOIN sale ON barcode=idproduct
        WHERE
        idsale=id_sale;
END; $$
LANGUAGE 'plpgsql';