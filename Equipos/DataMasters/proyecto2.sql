--------PARTE 1.1

CREATE VIEW v_invoice_lines AS
SELECT
  s.sale_number,
  s.sale_date,
  
  c.id_client,
  c.client_name,
  c.client_last_name,
  c.client_last_name_mom,
  c.rfc,
  c.street_c, c.out_num_c, c.int_num_c, c.neighborhood_c, c.state_c, c.municipality_c,
  
  p.id_product,
  p.brand,
  p.description,
  
  d.quantity,
  d.unit_price,
  d.total_product AS line_total
FROM sale s
JOIN client c        ON c.id_client = s.id_client
JOIN is_sold d       ON d.sale_number = s.sale_number
JOIN product p       ON p.id_product = d.id_product;

----------PARTE 1.2
CREATE OR REPLACE FUNCTION sales_summary_qty(
  p_start DATE,
  p_end   DATE DEFAULT NULL
)
RETURNS TABLE (
  period_start   DATE,
  period_end     DATE,
  total_items    BIGINT,
  total_profit   NUMERIC(12,2),
  total_tickets  BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
  
  IF p_end IS NULL THEN
    RETURN QUERY
    SELECT
      p_start,
      p_start,
      SUM(d.quantity)                                   AS total_items,
      SUM((d.unit_price - i.purchase_price) * d.quantity)::numeric(12,2) AS total_profit,
      COUNT(DISTINCT s.sale_number)                     AS total_tickets
    FROM sale s
    JOIN is_sold d   ON d.sale_number = s.sale_number
    LEFT JOIN inventory i ON i.id_product = d.id_product   -- ← permite servicios
    WHERE s.sale_date = p_start;

  ELSE
    RETURN QUERY
    SELECT
      p_start,
      p_end,
      SUM(d.quantity)                                   AS total_items,
      SUM((d.unit_price - i.purchase_price) * d.quantity)::numeric(12,2) AS total_profit,
      COUNT(DISTINCT s.sale_number)                     AS total_tickets
    FROM sale s
    JOIN is_sold d   ON d.sale_number = s.sale_number
    LEFT JOIN inventory i ON i.id_product = d.id_product   
    WHERE s.sale_date BETWEEN p_start AND p_end;
  END IF;

END;
$$;


--------------PARTE 1.3
-------TRIGGER 1

CREATE OR REPLACE FUNCTION trg_is_sold_bi()
RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  v_stock integer;
  v_after integer;
BEGIN
  IF is_service(NEW.id_product) THEN
    NEW.total_product := (NEW.unit_price * NEW.quantity)::numeric(10,2);
    RETURN NEW;
  END IF;

  SELECT stock INTO v_stock
    FROM inventory
   WHERE id_product = NEW.id_product
   FOR UPDATE;

  IF v_stock IS NULL THEN
    RAISE EXCEPTION 'Inventory record not found for product %', NEW.id_product;
  END IF;

  v_after := v_stock - NEW.quantity;
  IF v_after < 0 THEN
    RAISE EXCEPTION 'Insufficient stock: current=%, requested=%, resulting=%',
      v_stock, NEW.quantity, v_after;
  END IF;

  UPDATE inventory SET stock = v_after WHERE id_product = NEW.id_product;
  NEW.total_product := (NEW.unit_price * NEW.quantity)::numeric(10,2);

  IF v_after < 3 THEN
    RAISE NOTICE 'WARNING: Low stock for product % (remaining=%)', NEW.id_product, v_after;
  END IF;

  RETURN NEW;
END; $$;

DROP TRIGGER IF EXISTS trg_is_sold_bi ON is_sold;
CREATE TRIGGER trg_is_sold_bi
BEFORE INSERT ON is_sold
FOR EACH ROW
EXECUTE FUNCTION trg_is_sold_bi();

------TRIGGER 2

CREATE OR REPLACE FUNCTION trg_is_sold_bu()
RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  v_stock integer;
  v_after integer;
  v_delta integer;
BEGIN
  
  IF is_service(NEW.id_product) THEN
    IF NOT is_service(OLD.id_product) THEN
      UPDATE inventory SET stock = stock + OLD.quantity WHERE id_product = OLD.id_product;
    END IF;
    NEW.total_product := (NEW.unit_price * NEW.quantity)::numeric(10,2);
    RETURN NEW;
  END IF;

  
  IF NOT is_service(NEW.id_product) AND is_service(OLD.id_product) THEN
    SELECT stock INTO v_stock FROM inventory WHERE id_product = NEW.id_product FOR UPDATE;
    IF v_stock IS NULL THEN
      RAISE EXCEPTION 'Inventory record not found for product %', NEW.id_product;
    END IF;
    v_after := v_stock - NEW.quantity;
    IF v_after < 0 THEN
      RAISE EXCEPTION 'Insufficient stock (service->physical): current=%, requested=%, resulting=%',
        v_stock, NEW.quantity, v_after;
    END IF;
    UPDATE inventory SET stock = v_after WHERE id_product = NEW.id_product;
    NEW.total_product := (NEW.unit_price * NEW.quantity)::numeric(10,2);
    IF v_after < 3 THEN
      RAISE NOTICE 'WARNING: Low stock for product % (remaining=%)', NEW.id_product, v_after;
    END IF;
    RETURN NEW;
  END IF;

  
  IF NEW.id_product <> OLD.id_product THEN
    
    UPDATE inventory SET stock = stock + OLD.quantity WHERE id_product = OLD.id_product;

    
    SELECT stock INTO v_stock FROM inventory WHERE id_product = NEW.id_product FOR UPDATE;
    IF v_stock IS NULL THEN
      RAISE EXCEPTION 'Inventory record not found for product %', NEW.id_product;
    END IF;

    v_after := v_stock - NEW.quantity;
    IF v_after < 0 THEN
      RAISE EXCEPTION 'Insufficient stock (product change): current=%, requested=%, resulting=%',
        v_stock, NEW.quantity, v_after;
    END IF;

    UPDATE inventory SET stock = v_after WHERE id_product = NEW.id_product;

    IF v_after < 3 THEN
      RAISE NOTICE 'WARNING: Low stock for product % (remaining=%)', NEW.id_product, v_after;
    END IF;

    NEW.total_product := (NEW.unit_price * NEW.quantity)::numeric(10,2);
    RETURN NEW;
  END IF;

  
  v_delta := NEW.quantity - OLD.quantity;
  IF v_delta <> 0 THEN
    SELECT stock INTO v_stock FROM inventory WHERE id_product = NEW.id_product FOR UPDATE;
    v_after := v_stock - v_delta;
    IF v_after < 0 THEN
      RAISE EXCEPTION 'Insufficient stock (quantity update): current=%, delta=%, resulting=%',
        v_stock, v_delta, v_after;
    END IF;
    UPDATE inventory SET stock = v_after WHERE id_product = NEW.id_product;

    IF v_after < 3 THEN
      RAISE NOTICE 'WARNING: Low stock for product % (remaining=%)', NEW.id_product, v_after;
    END IF;
  END IF;

  NEW.total_product := (NEW.unit_price * NEW.quantity)::numeric(10,2);
  RETURN NEW;
END; $$;

DROP TRIGGER IF EXISTS trg_is_sold_bu ON is_sold;
CREATE TRIGGER trg_is_sold_bu
BEFORE UPDATE ON is_sold
FOR EACH ROW
EXECUTE FUNCTION trg_is_sold_bu();

--------TRIGGER 3

CREATE OR REPLACE FUNCTION trg_is_sold_bd()
RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF NOT is_service(OLD.id_product) THEN
    UPDATE inventory SET stock = stock + OLD.quantity WHERE id_product = OLD.id_product;
  END IF;
  RETURN OLD;
END; $$;

DROP TRIGGER IF EXISTS trg_is_sold_bd ON is_sold;
CREATE TRIGGER trg_is_sold_bd
BEFORE DELETE ON is_sold
FOR EACH ROW
EXECUTE FUNCTION trg_is_sold_bd();

------TRIGGER 4

CREATE FUNCTION trg_is_sold_after_sum()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  v_sale  varchar(20);
  v_total numeric(10,2);
BEGIN
  
  IF TG_OP = 'DELETE' THEN
    v_sale := OLD.sale_number;
  ELSE
    v_sale := NEW.sale_number;
  END IF;

  SELECT SUM(total_product)::numeric(10,2)
    INTO v_total
    FROM is_sold
   WHERE sale_number = v_sale;

  IF v_total IS NULL THEN
    v_total := 0;
  END IF;

  UPDATE sale
     SET total_amount = v_total
   WHERE sale_number = v_sale;

  RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_is_sold_aiud ON is_sold;
CREATE TRIGGER trg_is_sold_aiud
AFTER INSERT OR UPDATE OR DELETE ON is_sold
FOR EACH ROW
EXECUTE FUNCTION trg_is_sold_after_sum();


--------------




-------PARTE 1.4

CREATE VIEW v_low_stock AS
SELECT p.id_product, p.brand, p.description, i.stock
FROM product p
JOIN inventory i ON i.id_product = p.id_product
WHERE i.stock < 3;

--------PARTE 1.5

CREATE FUNCTION barcode_utility(
  p_barcode VARCHAR
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
DECLARE
  v_sale_price     NUMERIC(10,2);
  v_purchase_price NUMERIC(10,2);
  v_profit         NUMERIC(12,2);
BEGIN
  
  SELECT p.sale_price, i.purchase_price
    INTO v_sale_price, v_purchase_price
    FROM product p
    JOIN inventory i ON i.id_product = p.id_product
    WHERE i.barcode = p_barcode;

  
  IF v_sale_price IS NULL THEN
    RAISE EXCEPTION 'There is no product with the barcode %', p_barcode;
  END IF;

  
  v_profit := v_sale_price - v_purchase_price;

  RETURN v_profit;
END;
$$;




--------SERVICIOS Y FISICOS


CREATE FUNCTION is_service(p_product integer)
RETURNS boolean
LANGUAGE sql AS $$
  SELECT EXISTS (SELECT 1 FROM print          WHERE id_product = p_product)
      OR EXISTS (SELECT 1 FROM phone_recharge WHERE id_product = p_product);
$$;


CREATE FUNCTION trg_inventory_only_physical()
RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF is_service(NEW.id_product) THEN
    RAISE EXCEPTION 'Services (print/phone_recharge) must not have inventory. Product %', NEW.id_product;
  END IF;
  RETURN NEW;
END; $$;

DROP TRIGGER IF EXISTS trg_inventory_only_physical_bi ON inventory;
CREATE TRIGGER trg_inventory_only_physical_bi
BEFORE INSERT OR UPDATE ON inventory
FOR EACH ROW
EXECUTE FUNCTION trg_inventory_only_physical();
