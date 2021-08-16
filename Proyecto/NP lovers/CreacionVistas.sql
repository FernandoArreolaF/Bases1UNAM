create view utilidadVista as 
select codigoProd, (precDeventaProd - precDeComprProd)::Money as utilidad from PRODUCTO;

select * from utilidadVista;

create view periodoDeVentasVista as 
SELECT	fechaVenta, COUNT (fechaVenta) FROM Venta GROUP BY fechaVenta;

select * from periodoDeVentasVista;

create view stockBajoVista as 
SELECT	codigoProd, descProd,stock_Prod FROM PRODUCTO where stock_Prod<3 order by stock_Prod asc;

select * from stockBajoVista;

CREATE OR REPLACE FUNCTION Existencia(stockProd int) returns int As $$
begin 
if stockProd<3 THEN
	raise warning 'Quedan pocos productos.';
	ELSIF stockProd <1 THEN
		raise EXCEPTION 'No hay stock' USING HINT ='Contactar a bodega';
	ELSE raise notice 'operación realizada';
end if;
end;
$$ LANGUAGE plpgsql;

select * from PRODUCTO;

select * from CLIENTE;



