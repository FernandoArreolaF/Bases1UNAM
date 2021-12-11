--____________1. Al recibir el código de barras de un producto, regrese la utilidad.____________


CREATE FUNCTION fcodigo_barras_utilidad (varcodigo_barras varchar(20) )
RETURNS int
LANGUAGE plpgsql
AS
$$
DECLARE 
    utilidad integer;
BEGIN
    SELECT (precio-precio_adquisicion) into utilidad
    FROM INVENTARIO, PRODUCTO WHERE INVENTARIO.codigo_barras = PRODUCTO.codigo_barras AND INVENTARIO.codigo_barras=varcodigo_barras;
    RAISE NOTICE 'El codigo de barras % tiene una utilidad de %',varcodigo_barras,utilidad;
    return utilidad;
END;
$$;

SELECT fcodigo_barras_utilidad('3456765');
SELECT fcodigo_barras_utilidad('2345467');

--drop function fcodigo_barras_utilidad; --En caso necesario

--____________2. Cada que haya la venta de un artículo, deberá decrementarse el stock por la cantidad vendida de ese artículo. ______________
--Si el valor llega a cero, abortar la transaccióon. 
--Si el pedido se completa pero quedan menos de 3 en stock, se deberáa emitir una alerta.


CREATE OR REPLACE FUNCTION stock_articulos()
RETURNS TRIGGER AS
$$
DECLARE
    var_codigo_barras varchar;
    varstock integer;
BEGIN

    SELECT codigo_barras INTO var_codigo_barras
    FROM PRODUCTO WHERE id_articulo=NEW.id_articulo;
    RAISE NOTICE 'Codigo de Barras:  %',var_codigo_barras;

    SELECT stock INTO varstock
    FROM INVENTARIO WHERE codigo_barras=var_codigo_barras;
    RAISE NOTICE 'Stock Inicial:  %',varstock;
    
    IF (varstock-NEW.cantidad_articulos)=0 THEN
        RAISE NOTICE 'NO SE PUEDE SEGUIR CON VENTA: El Stock del producto que quiere comprar es %',varstock-NEW.cantidad_articulos;
        RETURN NULL;
    ELSIF ((varstock-NEW.cantidad_articulos)<3) THEN
        RAISE NOTICE 'ALERTA: El Stock restante del producto comprado es de %. Es muy bajo.',varstock-NEW.cantidad_articulos;
        UPDATE INVENTARIO SET stock=varstock-NEW.cantidad_articulos WHERE codigo_barras=var_codigo_barras;
        RETURN NULL;
    ELSE
        UPDATE INVENTARIO SET stock=varstock-NEW.cantidad_articulos WHERE codigo_barras=var_codigo_barras;
        RAISE NOTICE 'Stock Final:  %',varstock-NEW.cantidad_articulos;
        RETURN NULL;
    END IF;

END;
$$
LANGUAGE PLPGSQL;


--drop function stock_articulos; --En caso necesario


CREATE TRIGGER trigger_stock_articulos
BEFORE INSERT ON HABER
FOR EACH ROW
EXECUTE FUNCTION stock_articulos();

--drop trigger trigger_stock_articulos on haber; --En caso necesario

--________Caso cuando no se puede hacer la venta_______
--Primero se deve crear el numero de venta
INSERT INTO VENTA VALUES ('VENT-009','9-10-2019',300,'IDC89786');
--Luego se puede ingresar la venta del articulo
INSERT INTO HABER VALUES(2,'VENT-009',54,35);

--________Caso si se hace venta pero manda alerta de poco stock_______
--Primero se deve crear el numero de venta
INSERT INTO VENTA VALUES ('VENT-010','9-10-2019',300,'IDC89786');
--Luego se puede ingresar la venta del articulo
INSERT INTO HABER VALUES(9,'VENT-010',1,35);

--________Caso de venta normal_______
--Primero se deve crear el numero de venta
INSERT INTO VENTA VALUES ('VENT-011','9-10-2019',400,'IDC24354');
--Luego se puede ingresar la venta del articulo
INSERT INTO HABER VALUES(1,'VENT-011',24,35);



--_________3. Dada una fecha, o una fecha de inicio y fecha de fin, regresar la cantidad total que se vendió______
    --________y la ganacia correspondiente en esa fecha/periodo._______________

--NO SE LOGRÓ :(

UPDATE VENTA SET fecha_venta=TO_DATE(fecha_venta,'DD-MM-YYYY');

select * from venta where fecha_venta between '2019-08-08' and '2020-12-08')


CREATE FUNCTION fecha_intervalo_venta (fecha1 date, fecha2 date)
RETURNS int
LANGUAGE plpgsql
AS
$$
DECLARE 
    utilidad integer;
BEGIN
    --SELECT * from VENTA where fecha_venta between fecha1 and fecha2);
    SELECT (precio-precio_adquisicion) into utilidad
    FROM INVENTARIO, PRODUCTO WHERE INVENTARIO.codigo_barras = PRODUCTO.codigo_barras AND INVENTARIO.codigo_barras=varcodigo_barras;
    RAISE NOTICE 'El codigo de barras % tiene una utilidad de %',varcodigo_barras,utilidad;
    return utilidad;
END;
$$;

--_____________4. Permitir obtener el nombre de aquellos productos de los cuales hay menos de 3 en stock._____________
CREATE VIEW articulos_stock AS
SELECT descripcion as articulo ,stock FROM PRODUCTO, INVENTARIO WHERE PRODUCTO.codigo_barras=INVENTARIO.codigo_barras AND stock<3;

--DROP VIEW articulos_stock; --En caso necesario;

SELECT * FROM articulos_stock;

--_____________5. De manera automática se genere una vista que contenga información necesaria___________________
    --____________para asemejarse a una factura de una compra.__________________
CREATE VIEW factura AS
SELECT venta.numero_venta, id_cliente, fecha_venta, cantidad_total_pagar,id_articulo,cantidad_articulos, precio_por_articulo 
from venta, haber WHERE venta.numero_venta=haber.numero_venta;

--DROP VIEW factura;

SELECT * FROM factura;

--_________6.Crear al menos, un índice, del tipo que se prefiera y donde se prefiera. _______________________
    --________Justificar el porqué de la elección en ambos aspectos. _______________________
CREATE INDEX codigo_barras ON INVENTARIO("codigo_barras");

SELECT * from INVENTARIO WHERE codigo_barras IN ('1239543','2435674','8765431');

--DROP INDEX codigo_barras;--En caso necesario;