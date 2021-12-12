---- =========================================================
---- ====================== BD Viti ==========================
---- =========================================================

---- =========================================================
---- =============== Consultas =======================
---- =========================================================

---- =========================================================
---- =============== Consulta 1 =======================
---- =========================================================
SELECT PRECIO_VENTA - PRECIO_COMPRA FROM ARTICULO

---- =========================================================
---- =============== Consulta 2 =======================
---- =========================================================
CREATE TRIGGER DECREMENTO_STOCK FOR ARTICULO
       ACTIVE BEFORE INSERT
       POSITION 0
AS
BEGIN
   if (Select stock from ARTICULO where NUM_PRODUCTO=@NUM_PRODUCTO) >= @Cantidad begin
   UPDATE ARTICULO
   SET stock = stock - @cantidad
   WHERE  NUM_PRODUCTO = @NUM_PRODUCTO    
end 
else
      Select 'La cantidad supera el stock actual' AS Mensaje
END


---- =========================================================
---- =============== Consulta 3 =======================
---- =========================================================
select (aa.precio_venta*sum(cantidad))-(aa.precio_compra*sum(cantidad)) as ganancia
from venta_almacen ar
inner join articulo aa
on aa.num_producto=ar.num_producto
inner join venta v
on v.num_venta=ar.num_venta
where fecha_venta between '25-10-2021' and '30-10-2021'
group by aa.num_producto;

---- =========================================================
---- =============== Consulta 4 =======================
---- =========================================================

SELECT DESCRIPCION FROM ARTICULO WHERE STOCK > 3 
---- =========================================================
---- =============== Consulta 5 =======================
---- =========================================================
CREATE VIEW TICKET AS
SELECT VE.RFC, VE.FECHA_VENTA, AR.DESCRIPCION, VEN.PRECIO_UNITARIO, VEN.CANTIDAD, VEN.PRECIO_CANTIDAD, VE.CANTIDAD_TOTAL, VE.PRECIO_TOTAL
FROM VENTA VE, VENTA_ALMACEN VEN, ARTICULO AR
WHERE VEN.NUM_VENTA = VE.NUM_VENTA
 AND VEN.NUM_PRODUCTO = AR.NUM_PRODUCTO
