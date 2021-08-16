create view utilidadVista as 
select codigoProd, (precDeventaProd - precDeComprProd)::Money as utilidad from PRODUCTO;

select * from utilidadVista;

create view periodoDeVentasVista as 
SELECT	fechaVenta, COUNT (fechaVenta) FROM Venta GROUP BY fechaVenta;

select * from periodoDeVentasVista;

create view stockBajoVista as 
SELECT	codigoProd, descProd,stock_Prod FROM PRODUCTO where stock_Prod<207 order by stock_Prod asc;

select * from stockBajoVista;

create view facturaVista as 
SELECT numVenta