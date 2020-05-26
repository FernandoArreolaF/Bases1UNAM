--create store procedure (function) that given a date, returns all sales on these date
CREATE OR REPLACE FUNCTION salesbydate(datestart date, dateend date)
RETURNS TABLE(
            sale_identifier VARCHAR,
            sale_date DATE,
            sale_amount FLOAT,
            rfc_sale VARCHAR) 
AS $$
BEGIN
    IF (dateend is null) THEN
        RETURN QUERY SELECT
            idsale,
            datesale,
            totalamountproduct,
            rfc
        FROM
            sale
        WHERE
            datesale=datestart;
    ELSE
        RETURN QUERY SELECT
                idsale,
                datesale,
                totalamountproduct,
                rfc
            FROM
                sale
            WHERE
                datesale BETWEEN datestart and dateend
            ORDER BY datesale;
    END IF;
END; $$
LANGUAGE 'plpgsql';
 
       
--insert
--INSERT INTO sale VALUES 
--(default,'2020-05-16',490,'CAMC041284'),
--(default,'2020-05-16',580,'CAMC041284'),
--(default,current_date,650,'CAMC041284'),
--(DEFAULT,CURRENT_DATE,850,'CAMC041284'),
--(default,'2020-05-16',120,'CAMC041284');