CREATE VIEW vwProductosPorAgotarse
AS
SELECT descripcion_producto
FROM PRODUCTO PR
INNER JOIN INVENTARIO IO ON IO.id_producto=PR.id_producto
WHERE IO.stock <= 2;
--DROP VIEW vwProductosPorAgotarse;--NO USAR
SELECT * FROM vwProductosPorAgotarse


