CREATE SEQUENCE ordenFolioSec START 1;

ALTER TABLE "ORDEN"
ALTER COLUMN folio SET DEFAULT 'ORD-' || LPAD(nextval('ordenFolioSec')::TEXT, 4, '0');


-- Calculando el total de prod en ORDPROD
CREATE OR REPLACE FUNCTION calculate_order_product_total() RETURNS TRIGGER AS $$
DECLARE
    product_price NUMERIC(10, 2);
BEGIN
    SELECT precio INTO product_price FROM "PRODUCTO" WHERE "idProducto" = NEW."idProducto";
    NEW."detallePrc" := NEW."detalleCnt" * product_price;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_order_product_total
BEFORE INSERT OR UPDATE ON "ORDPROD"
FOR EACH ROW
EXECUTE FUNCTION calculate_order_product_total();


-- Si no esta disponible un prod
CREATE OR REPLACE FUNCTION check_product_availability() RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM "PRODUCTO"
        WHERE "idProducto" = NEW."idProducto" AND disponibilidad = TRUE
    ) THEN
        RAISE EXCEPTION 'El producto no está disponible.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_availability_before_insert_or_update
BEFORE INSERT OR UPDATE ON "ORDPROD"
FOR EACH ROW
EXECUTE FUNCTION check_product_availability();


-- Calculando la cantTotPag
CREATE OR REPLACE FUNCTION actcantTotPag()
RETURNS TRIGGER AS
$$
DECLARE
    total NUMERIC(10, 2);
BEGIN
    -- Calcular la suma de detallePrc para la orden actual
    SELECT SUM("detallePrc") 
    INTO total
    FROM "ORDPROD"
    WHERE folio = NEW.folio;

    -- Actualizar cantTotPag en la tabla ORDEN
    UPDATE "ORDEN"
    SET "cantTotPag" = COALESCE(total, 0)  -- COALESCE para manejar NULL
    WHERE folio = NEW.folio;
    
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER actcantTotPagtrigger
AFTER INSERT OR UPDATE OR DELETE ON "ORDPROD"
FOR EACH ROW
EXECUTE FUNCTION actcantTotPag();  -- Nombre correcto

-- Obteniendo al mesero, las ordenes que ha atendido y el total que se ha pagado
CREATE OR REPLACE FUNCTION empMesero(numEmp INTEGER, OUT ordenesAtendidas INTEGER, OUT totalPagado NUMERIC)
RETURNS RECORD AS
$$
DECLARE
    esMesero BOOLEAN;
BEGIN
    -- Verificar si el empleado es un mesero
    SELECT EXISTS(SELECT 1 FROM "MESERO" WHERE "rfcMsr" = (SELECT rfc FROM "EMPLEADO" WHERE "numEmp" = numEmp)) INTO esMesero;

    IF esMesero THEN
        -- Contar la cantidad de órdenes registradas por el mesero en el día
        SELECT COUNT(*), COALESCE(SUM("cantTotPag"), 0)
        INTO ordenesAtendidas, totalPagado
        FROM "ORDEN"
        WHERE "rfcMsr" = (SELECT rfc FROM "EMPLEADO" WHERE "numEmp" = numEmp);
        
    ELSE
        -- Mostrar un mensaje de error si no es un mesero
        RAISE EXCEPTION 'El numero de empleado introducido no corresponde a un mesero';
    END IF;
END;
$$
LANGUAGE plpgsql;

-- Usarla como 
SELECT * FROM empMesero(7); -- Es el caso válido
SELECT * FROM empMesero(13); -- Es el caso que no va a salir, pq no es mesero

-- Índices creados para mayor rapidez
  --> Ver los productos no disponibles
  CREATE INDEX ixDispoProd ON "PRODUCTO" (disponibilidad) WHERE disponibilidad = TRUE;

SELECT "nomProd" FROM "PRODUCTO" WHERE disponibilidad = TRUE;




-- Devolviendo los productos que no se encuentran disponibles
CREATE OR REPLACE FUNCTION prodNoDisp()
RETURNS TABLE (
    productoNoDisponible varchar(100)
) AS
$$
BEGIN
    RETURN QUERY 
    SELECT "nomProd" FROM "PRODUCTO"
    WHERE disponibilidad = FALSE;
END;
$$
LANGUAGE plpgsql;

-- Usarla como
SELECT * FROM prodNoDisp();


-- Trigger para actualizar el número de ventas del producto
CREATE OR REPLACE FUNCTION update_product_sales() RETURNS TRIGGER AS $$
BEGIN
    UPDATE "PRODUCTO" 
    SET "numVentas" = "numVentas" + NEW."detalleCnt"
    WHERE "idProducto" = NEW."idProducto";
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_product_sales_trigger
AFTER INSERT ON "ORDPROD"
FOR EACH ROW
EXECUTE FUNCTION update_product_sales();

-- Funcion, dadas dos fechas, devuelve el total de ventas y el monto total entre esas fechas
CREATE OR REPLACE FUNCTION ventas(fechaI DATE, fechaF DATE)
RETURNS TABLE(totVentas INT, montTot NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        CAST(COUNT(DISTINCT folio) AS INTEGER) AS totVentas, 
        COALESCE(SUM("cantTotPag"), 0) AS montTot
    FROM
        "ORDEN"
    WHERE
        "fechaOrd" BETWEEN fechaI AND fechaF;
END;
$$ LANGUAGE plpgsql;

-- EJEMPLO DE USO
SELECT * FROM ventas('2024-05-01', '2024-05-05');


-- VISTAS
-- Para el producto con mas ventas
CREATE VIEW vistaProdMasVendido AS 
SELECT * FROM "PRODUCTO" 
WHERE "numVentas" = (SELECT MAX("numVentas") FROM "PRODUCTO");


SELECT * FROM vistaProdMasVendido; -- Validando la vista

-- VISTA DE FACTURA
CREATE OR REPLACE VIEW vistaFactura AS 
SELECT 
    o.folio, 
    o."cantTotPag", 
    o."fechaOrd", 
    op."idProducto", 
    p."nomProd", 
    op."detalleCnt", 
    op."detallePrc", 
    f."idFac", 
    f."rfcClt", 
    f."nomPilaClt", 
    f."apPatClt", 
    f."apMatClt", 
    f."fechaNacClt", 
    f."emailClt", 
    f."rznSocial", 
    f."calleClt", 
    f."codPosClt", 
    f."colClt", 
    f."numExtClt", 
    f."numIntClt"
FROM 
    "ORDEN" o
JOIN 
    "ORDPROD" op ON o.folio = op.folio 
JOIN 
    "PRODUCTO" p ON p."idProducto" = op."idProducto" Total rows: 1 of 1
Query complete 00:00:00.067

RIGHT JOIN 
    "FACTURA" f ON f."idFac" = o."idFac";
	
	SELECT * FROM vistaFactura WHERE "folio" = 'ORD-0001';

