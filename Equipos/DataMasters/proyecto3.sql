-------Parte 2.1

SELECT *
FROM v_invoice_lines
WHERE sale_number = 'VENT-008'
ORDER BY id_product;

-------Parte 2.2

-- Un día 2
SELECT * FROM sales_summary_qty('2025-10-03');

-- Rango 2
SELECT * FROM sales_summary_qty('2025-10-03','2025-12-01');

--------Parte 2.3

SELECT id_product, stock
FROM inventory
WHERE id_product = 5;

INSERT INTO sale (sale_number, sale_date, total_amount, id_client)
VALUES ('VENT-689', '2025-12-10', 0, 4);

INSERT INTO is_sold (sale_number, id_product, quantity, unit_price, total_product)
VALUES ('VENT-689', 3, 1, 95.00, 0);

SELECT sale_number, id_product, quantity, unit_price, total_product
FROM is_sold
WHERE sale_number = 'VENT-999';

---------Parte 2.4

SELECT * FROM v_low_stock;

---------Parte 2.5

SELECT barcode_utility('751000000004');


------Servicios Y Fisicos

-- Debe ser TRUE (impresión)
SELECT is_service(13) AS is_service;



  
  INSERT INTO inventory (id_product, barcode, purchase_price, purchase_date, stock, photo_url)
  VALUES (9,'999TEST0009',10.00,CURRENT_DATE,50,'https://example.com/svc.jpg');



