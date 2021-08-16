CREATE VIEW vwProductosPorAgotarse
AS
SELECT nom_producto FROM PRODUCTO PR
INNER JOIN INVENTARIO I ON I.codigo_barras= PR.codigo_barras
WHERE I.stock <= 2;
--DROP VIEW vwProductosPorAgotarse;--NO USAR
SELECT * FROM vwProductosPorAgotarse
