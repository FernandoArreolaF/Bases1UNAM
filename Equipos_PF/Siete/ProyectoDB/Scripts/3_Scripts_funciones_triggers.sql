

/*---------------------------------------
-----------------------------------------
----------------------------------------
------	BLOQUE de Requerimientos--
--------------------------------------------
-------------------------------------------
------------------------------------------
---------------------------------------------
-------------------------------------------*/


/* requerimiento 1 UTILIDAD*/
create or replace function utilidad(cod integer) returns float AS $$
		declare compra float = 0;
		declare venta float = 0;
		declare utility float = 0;
		begin
			select e.precio_compra from inventario e where e.cod_barras = $1 into compra;
			select e.precio_venta from producto_detalles e where e.cod_barras = $1 into venta;
			utility = venta - compra;
			return utility;
		end;
$$ language plpgsql;

/*requerimiento 2. EL PROCESO DE ESTE REQUERIMIENTO SE COMPLETA CON LA INTERFAZ WEB*/

create or replace function crear_venta(cliente int) returns boolean as $$
		begin
					insert into venta (id_cliente, fecha_venta, pago_total) values ($1,current_date,0);
					return true;
		end;
$$ language plpgsql;

create or replace function crear_venta() returns boolean as $$
		declare max_cliente int;
		begin
					insert into cliente(cp) values (0);
					select max(id_cliente) from cliente into max_cliente;
					insert into venta (id_cliente,fecha_venta, pago_total) values (max_cliente,current_date,0);
					return true;
		end;
$$ language plpgsql;

/*trigger para generar la numeracion secuencial del formato del nombre de la venta*/
create or replace function numeracion_venta() returns trigger as $$
		declare nombre varchar;
		declare numero int;
		begin
				select max(A::int) from (select substring(e.id_venta,6) as A from venta e) as B into numero;
				numero=numero+1;
				nombre =numero::varchar;
				new.id_venta = 'Vent-'||nombre;
				return new;
		end;
$$ language plpgsql;

create trigger numeracion_venta_trigger before insert on venta for each row execute procedure numeracion_venta();

	/*trigger para generar la numeracion secuencial del id de cliente y agregar autmaticamente los nuevos codigos postales*/
create or replace function numeracion_cliente() returns trigger as $$
			declare numero int;
			begin
					select max(e.id_cliente) from cliente e into numero;
					numero=numero+1;
					new.id_cliente = numero;
					if not exists(select e.cp from regiones e where e.cp = new.cp)then
						insert into regiones (cp) values (new.cp);
					end if;
					return new;
			end;
	$$ language plpgsql;

create trigger numeracion_cliente_trigger before insert on cliente for each row execute procedure numeracion_cliente();



/*El objetivo de esta funcion es que se ejecute n veces desde la interfaz web una vez que se acepte la venta y se halla verificado que existe elstock correspondiente*/

create or replace function agregar_prod(registro varchar, codigo int, cantidad int) returns boolean as $$
		declare subtotal float=0;
		begin
				select e.precio_venta from producto_detalles e where e.cod_barras = codigo into subtotal;
				subtotal = subtotal *$3;
				insert into venta_detalles (id_venta, cod_barras, cant_articulos, precio_articulos) values ($1,$2,$3,subtotal);
				return true;
		end;
$$ language plpgsql;

/* trigger para chechar si hay stock, decrementar stock y actualizar subtotal y total de la compra*/

create or replace function check_stock() returns trigger as $$
    declare subtotal float=0;
    declare new_stock int=0;
    declare precio_anterior float=0;

    begin
		  if (select e.stock from inventario e where e.cod_barras=new.cod_barras)<=3 then
				raise notice 'stock bajo';
			end if;
    if (select e.stock from inventario e where e.cod_barras=new.cod_barras)<=0 then
        return null;
    end if;
    if ((select e.stock from inventario e where e.cod_barras=new.cod_barras)-new.cant_articulos)<0 then
            return null;
    else

        select e.stock from inventario e where e.cod_barras=new.cod_barras into new_stock;
        select e.pago_total from venta e where e.id_venta=new.id_venta into precio_anterior;
        select e.precio_venta from producto_detalles e where e.cod_barras = new.cod_barras into subtotal;

        subtotal = subtotal *new.cant_articulos;
        new_stock = new_stock - new.cant_articulos;
        precio_anterior = precio_anterior + subtotal;

        update inventario set stock = new_stock where cod_barras = new.cod_barras;
        update venta set pago_total = precio_anterior where id_venta = new.id_venta;
        return new;
    end if;
    end;
$$ language plpgsql;

create trigger stock_price_trigger before insert on venta_detalles for each row execute procedure check_stock();



/*requerimiento 3 registros entre fechas
formato de utlizacion = select * from periodo_venta('2020-11-12','2022-11-12')
formato de utlizacion = select * from periodo_venta('2020-11-12');
;

*/
create or replace function periodo_venta(varchar, varchar) returns TABLE (cod_barras int, cantidad_articulos bigint)as $$
		declare ini date;
		declare fin date;
		begin
			ini=date($1);
			fin=date($2);
			return query Select c.cod_barras, sum(c.cant_articulos) from (Select * from venta_detalles as B join (select e.id_venta from venta e where e.fecha_venta > ini and e.fecha_venta < fin)as A on B.id_venta=A.id_venta) c group by c.cod_barras;
		end;
$$ language plpgsql;

create or replace function periodo_venta(varchar) returns TABLE (cod_barras int, cantidad_articulos bigint)as $$
		declare ini date;
		begin
			ini=date($1);
			return query Select c.cod_barras, sum(c.cant_articulos) from (Select * from venta_detalles as B join (select e.id_venta from venta e where e.fecha_venta = ini)as A on B.id_venta=A.id_venta) c group by c.cod_barras;
		end;
$$ language plpgsql;

/*requerimiento 4 obtener productos de los que haya menos de 3*/

create or replace function productos_escasos() returns TABLE (cod_barras int, cantidad_articulos int)as $$
		begin
			return query Select c.cod_barras, c.stock from inventario c where c.stock < 3;
		end;
$$ language plpgsql;

/*requerimiento 5 generar la informacion para la factura, Se completa este requerimiento con la interfaz web*/
create or replace function info_factura(vent varchar) returns table (id_cliente int, razon_social varchar, nombre varchar, cp int, venta varchar, fecha date, codigo_producto int, producto varchar, precio_individual float, cantidad int, subtotal float, total float) as $$

		begin
			return query select H.id_cliente, H.rs_cliente as razon_social, H.nombre_cliente as nombre, H.cp, H.venta, H.fecha_venta as fecha, H.cod_barras as codigo_producto, H.descripcion as producto, H.precio_venta as precio_individual, H.cant_articulos as cantidad, H.precio_articulos as subtotal, H.pago_total as total from (select * from cliente D join(select A.id_venta as venta, A.id_cliente as id_cliente2, A.fecha_venta, A.pago_total, B.* from venta A join (select * from  venta_detalles E join(Select precio_venta, cod_barras as cod_barras2, descripcion from producto_detalles) as F on E.cod_barras = F.cod_barras2) as B on A.id_venta=B.id_venta where A.id_venta = $1) as C on D.id_cliente = C.id_cliente2) H;
		end;
$$ language plpgsql;

/*requerimiento 6 indice , se eligio considerando que cod_barras es uno de los atributos más utilizados y compartidos entre otras tablas, ademas es de los que más datos contiene*/

create index cod_index on inventario (cod_barras);
