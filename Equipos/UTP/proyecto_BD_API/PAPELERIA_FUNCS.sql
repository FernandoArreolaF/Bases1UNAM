--
--1
--Al recibir el código de barras de un producto, regrese la utilidad.
--
CREATE FUNCTION utilidad(varchar(20)) RETURNS TABLE(utilidad money) AS 
$$
SELECT precio_venta - precio_compra as utilidad 
FROM producto 
JOIN provee 
ON producto.codigo_barras = provee.codigo_barras 
WHERE producto.codigo_barras = $1
$$
LANGUAGE SQL;
--2 Se debe hacer con un Trigger
--Cada que haya la venta de un artı́culo, deberá decrementarse el stock por
--la cantidad vendida de ese artı́culo. Si el valor llega a cero, abortar la
--transacción. Si hay menos de 3, emitir un mensaje.

--CREATE OR REPLACE PROCEDURE DECREMENTAR(id_Inventario int,cantidad smallint)
--AS
--BEGIN
--	FOR NEW_QUANT IN(SELECT cantidad FROM INVENTARIO_PRODUCTO WHERE id_Inventario=id_Inventario)
--	WHILE (NEW_QUANT=>1)
--		BEGIN
--		SET NEW_QUANT-1
--	END WHILE;
--	select upper('NO HAY ARTICULOS DISPONIBLES');
--END;
--

CREATE FUNCTION validar_compra() RETURNS TRIGGER AS $validar_compra$
    DECLARE 
    precio_art money ARRAY = ARRAY(SELECT precio_Venta FROM producto WHERE producto.codigo_barras = NEW.codigo_barras LIMIT 1);
    BEGIN
        IF EXISTS(SELECT * FROM inventario_producto WHERE inventario_producto.codigo_barras = NEW.codigo_barras AND inventario_producto.cantidad = 0) THEN
            RAISE EXCEPTION 'NO HAY EN EXISTENCIA %', NEW.codigo_barras;
        ELSIF EXISTS (SELECT * FROM productos_casi_agotados() AS prod_ago JOIN producto ON producto.codigo_barras = NEW.codigo_barras WHERE prod_ago.nombre = producto.nombre) THEN
            RAISE NOTICE 'LOS PRODUCTOS YA CASI SE AGOTAN';
        END IF;
        
        UPDATE inventario_producto
        SET cantidad = cantidad - NEW.cant_art
        WHERE inventario_producto.codigo_barras = NEW.codigo_barras; 
        UPDATE venta
        SET cant_Art_Total = cant_Art_Total + NEW.cant_art,
        precio_Total = precio_Total + (precio_art[1]*NEW.cant_art),
        fecha_venta = NOW()
        WHERE venta.id_Venta = NEW.id_Venta; 
        RETURN NEW;
    END;
$validar_compra$ LANGUAGE plpgsql;

CREATE TRIGGER validar_compra BEFORE INSERT OR UPDATE ON compra
    FOR EACH ROW EXECUTE PROCEDURE validar_compra();

--3
--Dada una fecha, o una fecha de inicio y fecha de fin, regresar la cantidad
--total que se vendió en esa fecha/periodo.

--3 solo un dia
CREATE FUNCTION venta_total_diaria(date) RETURNS TABLE(venta_total_diaria money) AS 
$$
WITH ventas_diarias(venta_total_diaria, fecha_venta) 
AS 
(
    SELECT SUM(precio_total),fecha_venta 
    FROM venta 
    GROUP BY fecha_venta
) 
SELECT venta_total_diaria 
FROM ventas_diarias 
WHERE ventas_diarias.fecha_venta = $1;
$$
LANGUAGE SQL;

--3 periodo '2021-01-14' AND '2021-01-18'
CREATE FUNCTION venta_total_periodo(date, date) RETURNS TABLE(venta_total_periodo money) AS 
$$
WITH ventas_diarias(venta_total_diaria, fecha_venta) 
AS 
(
    SELECT SUM(precio_total),fecha_venta 
    FROM venta 
    GROUP BY fecha_venta
) 
SELECT SUM(venta_total_diaria) venta_total_periodo  
FROM ventas_diarias 
WHERE ventas_diarias.fecha_venta 
BETWEEN $1 AND $2
$$
LANGUAGE SQL;

--4 
--Permitir obtener el nombre de aquellos productos de los cuales hay menos
--de 3 en stock.
CREATE FUNCTION productos_casi_agotados() RETURNS TABLE(nombre varchar(40)) AS 
$$
SELECT producto.nombre 
FROM producto 
JOIN inventario_producto 
ON producto.codigo_barras = inventario_producto.codigo_barras 
WHERE inventario_producto.cantidad < 3;
$$
LANGUAGE SQL;
--5
--De manera automática se genere una vista que contenga información ne-
--cesaria para asemejarse a una factura de una compra.
--SELECT * FROM compra JOIN venta ON venta.id_venta = compra.id_venta JOIN producto ON compra.codigo_barras = producto.codigo_barras WHERE compra.id_venta = 'VENT-1';
CREATE FUNCTION factura(text) RETURNS 
TABLE(nombre varchar(40), tipo_articulo varchar(5), cant_art smallint, precio_venta money, precio_total_compra money, cant_art_total smallint, precio_total money, nombre_cliente varchar(40)) 
AS 
$$
SELECT 
producto.nombre, 
producto.tipo_articulo, 
compra.cant_art, 
producto.precio_venta,
producto.precio_venta * compra.cant_art,
venta.cant_art_total, 
venta.precio_total,
CONCAT(cliente.nombre, ' ', cliente.ap_pat, ' ', cliente.ap_mat)
FROM compra 
JOIN venta 
ON venta.id_venta = compra.id_venta 
JOIN producto 
ON compra.codigo_barras = producto.codigo_barras
JOIN cliente
ON venta.id_cliente = cliente.id_cliente
WHERE compra.id_venta = $1;
$$
LANGUAGE SQL;
--
--6
--Crear al menos, un ı́ndice, del tipo que se prefiera y donde se prefiera.
--Justificar el porqué de la elección en ambos aspectos.
--Se creo este indice para poder acceder de una forma muy eficiente a los registros de los productos.
CREATE UNIQUE INDEX producto_index ON producto(codigo_barras ASC);
