\c papeleria_PF;

-------- PROGRAMACION DB --------


ALTER TABLE contener RENAME COLUMN cons_monto_parcial TO cont_monto_parcial;

--VALIDADORES MAYUSCULAS:
CREATE OR REPLACE FUNCTION uppercase_function()
RETURNS TRIGGER AS $$
BEGIN
  NEW.cli_rfc := UPPER(NEW.cli_rfc);
  NEW.cli_nombre := UPPER(NEW.cli_nombre);
  NEW.cli_ap_Pat := UPPER(NEW.cli_ap_Pat);
  NEW.cli_ap_Mat := UPPER(NEW.cli_ap_Mat);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER uppercase_cli_rfc
BEFORE INSERT ON cliente
FOR EACH ROW
EXECUTE FUNCTION uppercase_function();



---VALIDACION STOCK SUFICIENTE

CREATE OR REPLACE FUNCTION actualizar_stock()
RETURNS TRIGGER AS $$
declare stock smallint;
BEGIN
	SELECT i.inv_stock INTO stock FROM 
	inventario i
	where i.inv_codigo_barras = (select p.prod_codigo_barras from producto p
	where p.prod_id_producto = new.prod_id_producto);
	if (stock - new.cont_cantidad_producto) > 0 then
		UPDATE inventario 
		SET inv_stock = stock - NEW.cont_cantidad_producto,
		inv_modificacion_stock = now()
		WHERE inv_codigo_barras = (select p.prod_codigo_barras from producto p
		where p.prod_id_producto = new.prod_id_producto);
	else
		raise notice 'No se puede generar compra';
		return null;
	end if;
	return new;
END;
$$ LANGUAGE plpgsql;


create or replace  TRIGGER insercion_contener
BEFORE INSERT ON contener
FOR EACH ROW
EXECUTE FUNCTION actualizar_stock();

--insert into contener values ('VENT-0007', 2, 3)
--select * from contener 


--Validación del minimo stock

CREATE OR REPLACE FUNCTION revisar_stock_suficiente()
RETURNS TRIGGER AS $$
BEGIN
	if new.inv_stock < 3 then
		raise notice 'Queda poco inventario del producto con codigo de barras: %', new.inv_codigo_barras;
	end if;
	return new;
END;
$$ LANGUAGE plpgsql;


create or replace  TRIGGER actualizacion_stock
after update  ON inventario
FOR EACH ROW
EXECUTE FUNCTION revisar_stock_suficiente();

--select * from inventario i 


--- Aumento de Stock ---

CREATE OR REPLACE FUNCTION calcular_aumento_stock()
RETURNS TRIGGER AS $$
declare stock smallint;
BEGIN
	SELECT i.inv_stock INTO stock 
	from inventario i
	where i.inv_codigo_barras = new.inv_codigo_barras;
	update inventario 
	set inv_stock = stock + new.cantidad
	where inv_codigo_barras = new.inv_codigo_barras;
	return new;
END;
$$ LANGUAGE plpgsql;


create or replace TRIGGER reabastecimiento_stock
after insert ON proveer
FOR EACH ROW
EXECUTE FUNCTION calcular_aumento_stock();

--select * from inventario i 
--insert into proveer values ('cartones 5', 715150864290, 30)
--select * from proveer p  
--select * from inventario i 


--- Calculo de total parcial ---

CREATE OR REPLACE FUNCTION calcular_monto_parcial()
RETURNS TRIGGER AS $$
declare precio money;
begin
	select p.prod_precio_venta into precio from producto p
	where p.prod_id_producto = new.prod_id_producto;
	update contener 
	set cont_monto_parcial = new.cont_cantidad_producto * precio 
	where prod_id_producto = new.prod_id_producto and ven_num_venta = new.ven_num_venta;
	return new;
END;
$$ LANGUAGE plpgsql;

create or replace TRIGGER calculo_insercion_contener
after insert ON contener
FOR EACH ROW
EXECUTE FUNCTION calcular_monto_parcial();

--insert into contener values ('VENT-0007', 1, 3)
--select * from contener 
--select * from producto 


--- Calculo de total venta ---

CREATE OR REPLACE FUNCTION calcular_monto_total()
RETURNS TRIGGER AS $$
declare monto_total money;
begin
	select sum(c.cont_monto_parcial) into monto_total from contener c
	where c.ven_num_venta = new.ven_num_venta;

	update venta 
	set ven_monto_total = monto_total 
	where ven_num_venta = new.ven_num_venta;
	return new;
END;
$$ LANGUAGE plpgsql;

create or replace TRIGGER calculo_monto_total_venta
after insert ON contener
FOR EACH ROW
EXECUTE FUNCTION calcular_monto_total();


--insert into venta (ven_fecha_venta, ven_rfc_cliente) values ('2023-05-30', 'GAA900227RU9 ')
--select * from venta 

--insert into contener values ('VENT-0008', 18, 4)
--select * from contener 
--select * from producto 



--- OBTENCION UTILIDAD DE PRODUCTO ------


CREATE OR REPLACE FUNCTION obtener_utilidad_por_codigo_de_barras(codigo_barras bigint)
RETURNS money 
AS $$
DECLARE
costo_producto money;
precio_venta_producto money;
utilidad money;

BEGIN 
	SELECT i.inv_precio_compra into costo_producto FROM inventario i WHERE i.inv_codigo_barras =codigo_barras;
	SELECT p.prod_precio_venta into precio_venta_producto FROM producto p where p.prod_codigo_barras = codigo_barras;
	RAISE NOTICE 'Costo Producto: %',costo_producto;
	RAISE NOTICE 'Precio a la Venta Producto: %',precio_venta_producto;
	utilidad = precio_venta_producto-costo_producto;
	RAISE NOTICE 'Utilidad resultante: %', precio_venta_producto-costo_producto;
	
RETURN utilidad;
END;
$$
LANGUAGE PLPGSQL;


--select obtener_utilidad_por_codigo_de_barras(600724784868)


---- VALIDACION EXISTA UTILIDAD ------

CREATE OR REPLACE FUNCTION comprobar_utilidad()
RETURNS TRIGGER AS $$
declare costo_producto money;
begin
	SELECT i.inv_precio_compra into costo_producto FROM inventario i 
	WHERE i.inv_codigo_barras = new.prod_codigo_barras;
	if new.prod_precio_venta > costo_producto then
		raise notice 'Existe una utilidad de: %', new.prod_precio_venta - costo_producto;
	else
		raise notice 'NO Existe una utilidad para el producto con codigo de barras: %', new.prod_codigo_barras;
	end if;
	return new;
END;
$$ LANGUAGE plpgsql;

create or replace TRIGGER comprobar_utilidad_producto
before insert ON producto
FOR EACH ROW
EXECUTE FUNCTION comprobar_utilidad();


--- Obtención factura ---

begin;
	--select p.prov_razon_social, t.tel_codigo, t.tel_telefono, c2.cli_rfc, now(), v.ven_num_venta, c.prod_id_producto, pr.prod_codigo_barras, i.inv_codigo_barras 
	select p.prov_razon_social, t.tel_codigotel, t.tel_telefono, c2.cli_rfc, now(), v.ven_num_venta, c.prod_id_producto, pr.prod_codigo_barras, i.inv_codigo_barras 
	from proveedor p
	inner join telefono t on p.prov_razon_social = t.tel_proveedor
	inner join proveer p2 on p.prov_razon_social = p2.prov_razon_social 
	inner join inventario i on p2.inv_codigo_barras = i.inv_codigo_barras 
	inner join producto pr on i.inv_codigo_barras = pr.prod_codigo_barras
	inner join contener c on pr.prod_id_producto = c.prod_id_producto 
	inner join venta v on c.ven_num_venta = v.ven_num_venta 
	inner join cliente c2 on v.ven_rfc_cliente = c2.cli_rfc 
	where v.ven_num_venta = 'VENT-0007';
rollback


CREATE FUNCTION obtener_factura_cursor(num_venta varchar(15)) RETURNS setof refcursor AS
$$
DECLARE c_cliente_info refcursor;
DECLARE c_producto refcursor;
declare c_venta_info refcursor;
BEGIN
    OPEN c_cliente_info FOR
        select * from cliente c 
		inner join venta v on c.cli_rfc = v.ven_rfc_cliente 
		where v.ven_num_venta = num_venta ;
    RETURN NEXT c_cliente_info;
    OPEN c_producto FOR
        select i.inv_codigo_barras as codigo_barras, pr.prod_descripcion, c.cont_cantidad_producto, pr.prod_precio_venta , c.cont_monto_parcial 
		from contener c
		inner join producto pr on c.prod_id_producto  = pr.prod_id_producto 
		inner join inventario i on pr.prod_codigo_barras  = i.inv_codigo_barras; 
		where c.ven_num_venta = num_venta;
    RETURN NEXT c_producto;
   OPEN c_venta_info FOR
        select v.ven_monto_total, (v.ven_monto_total * .16) as iva, (v.ven_monto_total +(v.ven_monto_total * .16)) as monto_final
		from venta v 
		where v.ven_num_venta = num_venta;
    RETURN NEXT c_venta_info;
END;
$$ LANGUAGE plpgsql;


BEGIN;
SELECT obtener_factura_cursor('VENT-0007');
FETCH ALL IN "<unnamed portal 1>";
FETCH ALL IN "<unnamed portal 2>";
FETCH ALL IN "<unnamed portal 3>";
COMMIT;


CREATE FUNCTION obtener_factura_cursor(num_venta varchar(15)) RETURNS setof refcursor AS
$$
DECLARE c_cliente_info refcursor;
DECLARE c_producto refcursor;
declare c_venta_info refcursor;
BEGIN
    OPEN c_cliente_info FOR
        select * from cliente c 
		inner join venta v on c.cli_rfc = v.ven_rfc_cliente 
		where v.ven_num_venta = num_venta ;
    RETURN NEXT c_cliente_info;
    OPEN c_producto FOR
        select i.inv_codigo_barras as codigo_barras, pr.prod_descripcion, c.cont_cantidad_producto, pr.prod_precio_venta , c.cont_monto_parcial 
		from contener c
		inner join producto pr on c.prod_id_producto  = pr.prod_id_producto 
		inner join inventario i on pr.prod_codigo_barras  = i.inv_codigo_barras 
		where c.ven_num_venta = num_venta;
    RETURN NEXT c_producto;
   OPEN c_venta_info FOR
        select v.ven_monto_total, (v.ven_monto_total * .16) as iva, (v.ven_monto_total +(v.ven_monto_total * .16)) as monto_final
		from venta v 
		where v.ven_num_venta = num_venta;
    RETURN NEXT c_venta_info;
END;
$$ LANGUAGE plpgsql;


BEGIN;
SELECT obtener_factura_cursor('VENT-0007');
FETCH ALL IN "<unnamed portal 1>";
FETCH ALL IN "<unnamed portal 2>";
FETCH ALL IN "<unnamed portal 3>";
COMMIT;




--- obtener ganancias en ventas 
--- realizadas a partir de la fecha ingresada

CREATE OR REPLACE FUNCTION ganancias_a_partir_de(fecha date)
RETURNS money AS $$
declare ganancia money;
BEGIN
 	select sum(g.ganancia) into ganancia
	 from (
			select c_info.id_producto, c_info.suma_cant, c_info.suma_vendida, i.inv_precio_compra, (c_info.suma_cant*i.inv_precio_compra) as suma_precop_venta, 
			c_info.suma_vendida - (c_info.suma_cant*i.inv_precio_compra) as ganancia
			from producto p 
			inner join (
				select c.prod_id_producto as id_producto, sum(c.cont_cantidad_producto) as suma_cant, sum(c.cont_monto_parcial) as suma_vendida
				from contener c 
				inner join venta v on c.ven_num_venta = v.ven_num_venta
				where v.ven_fecha_venta >= fecha
				group by c.prod_id_producto
			) c_info on p.prod_id_producto = c_info.id_producto
			inner join inventario i on p.prod_codigo_barras  = i.inv_codigo_barras 
	) g;
	return ganancia;
END;
$$ LANGUAGE plpgsql;

select ganancias_a_partir_de('2023-05-27')


--- obtener ganancias en ventas 
--- realizadas dentro del rango de fechas ingresado


CREATE OR REPLACE FUNCTION ganancias_por_rango_fechas(fecha_inicio date, fecha_fin date)
RETURNS money AS $$
declare ganancia money;
BEGIN
 	select sum(g.ganancia) into ganancia
	 from (
			select c_info.id_producto, c_info.suma_cant, c_info.suma_vendida, i.inv_precio_compra, (c_info.suma_cant*i.inv_precio_compra) as suma_precop_venta, 
			c_info.suma_vendida - (c_info.suma_cant*i.inv_precio_compra) as ganancia
			from producto p 
			inner join (
				select c.prod_id_producto as id_producto, sum(c.cont_cantidad_producto) as suma_cant, sum(c.cont_monto_parcial) as suma_vendida
				from contener c 
				inner join venta v on c.ven_num_venta = v.ven_num_venta
				where v.ven_fecha_venta between fecha_inicio and fecha_fin
				group by c.prod_id_producto
			) c_info on p.prod_id_producto = c_info.id_producto
			inner join inventario i on p.prod_codigo_barras  = i.inv_codigo_barras 
	) g;
	return ganancia;
END;
$$ LANGUAGE plpgsql;

select ganancias_por_rango_fechas('2023-05-27', '2023-06-01')




--VISTA de stocks menores a 3
CREATE OR REPLACE VIEW min_stock as
SELECT p.prod_descripcion , i.inv_stock  FROM producto p 
INNER JOIN inventario i ON p.prod_codigo_barras = i.inv_codigo_barras  
WHERE i.inv_stock<3;

--INDICE en codigo_barras
CREATE INDEX idx_producto ON PRODUCTO("prod_codigo_barras");





ALTER SEQUENCE numventa_seq RESTART WITH 001;
ALTER SEQUENCE numventac_seq RESTART WITH 001;


INSERT INTO producto VALUES(DEFAULT,456986321457,'Impresion',10.00);
INSERT INTO inventario VALUES(456986321457, 5.00, 'https://s3.amazonaws.com/productos.papeleria/IMP.jpg'', now(), 50, now());