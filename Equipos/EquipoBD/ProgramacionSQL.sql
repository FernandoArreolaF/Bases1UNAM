--Triggers que identifican un insert y hacen un update.
--Cada que se agregue un producto a la orden, debe actualizarse los totales(por producto y venta), 
--asi como validar que el producto este disponible.

--Funcion para actualizar disponibilidad y el total
create or replace function fn_act_disp_total() returns trigger as $$
begin
	--REALIZA EL UPDATE DE DISPONIBILAD EN PLATILLO_BEBIDA
	update platillo_bebida
	set disponibilidad = platillo_bebida.disponibilidad-NEW.cantidad_platillobebida 
	where nombre_platillobebida=NEW.nombre_platillobebida;
	--REALIZA EL UPDATE DE TOTAL EN LA ORDEN
	update orden
	set total = total+NEW.precio_platillobebida
	where folio = NEW.folio;
	return NEW;
end;
$$
language plpgsql;

--Funcion que verifica disponibilidad
create or replace function fn_verificar_disp_producto() returns trigger
as $$
declare
--declaracion de variables y/o constantes
v_disponibilidad platillo_bebida.disponibilidad%type;
v_folio_insertado numeric;
v_folio char(7);
begin
	--REVISA SI HAY ORDENES CON EL FOLIO INSERTADO
	select count(*) into v_folio_insertado from orden 
	where folio=NEW.folio;
	
	--REVISA LA DISPONIBILIDAD DEL PLATILLO O BEBIDA
	select disponibilidad into v_disponibilidad from platillo_bebida 
	where nombre_platillobebida=NEW.nombre_platillobebida;
	
	--VERIFICA SI LA DISPONIBILAD ES MENOR A LA CANTIDAD Y SI EL FOLIO EXISTE EN LA TABLA ORDEN
	if	 v_folio_insertado = 0 then
		RAISE EXCEPTION 'La orden % no existe', NEW.folio;
	elsif v_disponibilidad < NEW.cantidad_platillobebida then
		RAISE EXCEPTION 'La cantidad es mayor a la disponibilidad del producto.';
	else
		RAISE NOTICE 'Se ha verificado la disponibilidad.';
	end if;
	return NEW;
end;
$$
language plpgsql;

--Trigger encargado de actualizar datos despues de la insercion
create or replace trigger trg_act_disp_total 
after insert on enlista
for each row
execute procedure fn_act_disp_total();

--Trigger que evalua si el producto esta disponible, asi como si la orden existe
create or replace trigger trg_verificar_disp_producto 
before insert on enlista
for each row
execute procedure fn_verificar_disp_producto();

--Crea un indice en el atributo disponibilidad de la tabla platillo_bebida
create index dispo on platillo_bebida(disponibilidad);

--Dado un número de empleado, mostrar la cantidad de órdenes que ha registrado
--en el dia asi como el total que se ha pagado por dichas ordenes.
create or replace function fn_ordenes_empleado(p_num_empleado in numeric) 
returns table (num_empleado integer,cant_ordenes bigint,total money) as $$
declare
--declaracion de variables
v_cant_ordenes numeric;
v_total_dia numeric; 
v_es_mesero numeric;
begin

	--VERIFICA SI HAY REGISTROS EN MESERO CON EL NUMERO DE EMPLEADO PROPORCIONADO
	select count(*) into v_es_mesero from empleado e join mesero m on e.num_empleado=m.num_empleado
	where e.num_empleado=p_num_empleado;
	
	if v_es_mesero != 0 then
		--VERIFICA LAS ORDENES QUE HA HECHO ESE EMPLEADO EN ESE DIA
		select  count(*) into v_cant_ordenes 
		from empleado e join orden o on e.num_empleado=o.num_empleado
		where e.num_empleado=p_num_empleado and o.fecha=current_date;
		
		select  sum(o.total) into v_total_dia 
		from empleado e join orden o on e.num_empleado=o.num_empleado
		where e.num_empleado=p_num_empleado and o.fecha=current_date;
		--VERIFICA SI NO HA HECHO ALGUNA ORDEN ESE DIA
		if v_cant_ordenes = 0 then
			RAISE NOTICE 'El empleado con el numero % ha registrado 0 ordenes hoy.',
			p_num_empleado;
		else
			return query select e.num_empleado,count(*),sb.tot
			from empleado e join orden o on e.num_empleado=o.num_empleado join (select e.num_empleado as nm,sum(o.total) as tot
			from empleado e join orden o on e.num_empleado=o.num_empleado where e.num_empleado=p_num_empleado and o.fecha=current_date 
			group by e.num_empleado 
			) sb on sb.nm=e.num_empleado
			where e.num_empleado=p_num_empleado and o.fecha=current_date
			group by e.num_empleado,sb.tot;
			RAISE NOTICE 'El empleado con el numero % ha registrado % orden(es) hoy y su total es %.',
			p_num_empleado,v_cant_ordenes,v_total_dia;
		end if;
	else
		RAISE EXCEPTION 'El empleado con el numero % no es un mesero.', p_num_empleado;
	end if;
end;
$$
language plpgsql;

--Vista que muestre todos los detalles del platillo mas vendido
create or replace view vista_platillo_mas_vendido(nombre,precio,descripcion,receta,
disponibilidad,categoria) as
	select pb.nombre_platillobebida,pb.precio,pb.descripcion,pb.receta,
	pb.disponibilidad,pb.nombre_categoria from platillo_bebida pb
	join enlista e on pb.nombre_platillobebida=e.nombre_platillobebida
	natural join (
		select max(sb.suma) as maximo from platillo_bebida pb 
		join enlista e on pb.nombre_platillobebida=e.nombre_platillobebida 
		join (select sum(cantidad_platillobebida) as suma,
		pb.nombre_platillobebida as nm from platillo_bebida pb 
		join enlista e on pb.nombre_platillobebida=e.nombre_platillobebida
		group by pb.nombre_platillobebida) sb on sb.nm=pb.nombre_platillobebida
	) sbn
	group by pb.nombre_platillobebida,sbn.maximo
	having sum(e.cantidad_platillobebida)=sbn.maximo;
	
--Permitir obtener el nombre de aquellos productos que no esten disponibles.
create or replace function fn_prod_no_disp(producto_no_disponible out varchar)
returns setof character varying as $$
--declaracion de variables
declare
	reg record;
begin
	--REVISA LOS PRODUCTOS CUYA DISPONIBILIDAD ESTA EN 0 Y LOS VA REGISTRANDO
	for reg in select nombre_platillobebida from platillo_bebida 
	where disponibilidad = 0 loop
		producto_no_disponible := reg.nombre_platillobebida;
		return next;
	end loop;
	return;
end;
$$
language plpgsql;

--De manera automatica se genere una vista que contenga 
--información necesaria para asemejarse a una factura de una orden
--Funcion que devuelve lo que devolveria una vista, dada una orden.
create or replace function fn_vista_factura_orden(p_folio in char(7)) returns table(
	folio char(7),fecha date,rfc_cliente char(13),producto varchar,precio money,
	cantidad integer,total money
) as $$
begin
	return query
	select o.folio,o.fecha,o.rfc_cliente,e.nombre_platillobebida,
	pb.precio,e.cantidad_platillobebida,o.total 
	from orden o join enlista e on o.folio=e.folio 
	join platillo_bebida pb on pb.nombre_platillobebida=e.nombre_platillobebida
	where o.folio=p_folio;
end;
$$
language plpgsql;

--Dada una fecha, o una fecha de inicio y fecha de fin, regresar el total del
--número de ventas y el monto total por las ventas en ese periodo de tiempo.

create or replace function fn_ventas_intervalo(
	p_fecha_inicial in varchar,
	p_fecha_final in varchar
) returns table(cantidad bigint, total money) as $$
declare
--declaracion de variables
v_cantidad numeric;
v_total numeric;
begin
	--CUENTA LAS ORDENES Y EL TOTAL QUE SE GENERARON EN ESAS FECHAS
	select count(*) into v_cantidad from orden
	where fecha between to_date(p_fecha_inicial,'dd-mm-yyyy') 
	and to_date(p_fecha_final,'dd-mm-yyyy');  
	
	select sum(orden.total) into v_total from orden
	where fecha between to_date(p_fecha_inicial,'dd-mm-yyyy') 
	and to_date(p_fecha_final,'dd-mm-yyyy');  
	--IMPRIME LOS VALORES OBTENIDOS
	if v_cantidad = 0 then
		RAISE NOTICE 'No se realizaron ordenes en el intervalo % / % .',
		to_date(p_fecha_inicial,'dd-mm-yyyy'),to_date(p_fecha_final,'dd-mm-yyyy');
	else
		return query select count(*), sum(orden.total) from orden
		where fecha between to_date(p_fecha_inicial,'dd-mm-yyyy') 
		and to_date(p_fecha_final,'dd-mm-yyyy'); 
		RAISE NOTICE 'La cantidad de ordenes en ese intervalo % / % es % y el total es % .',
		to_date(p_fecha_inicial,'dd-mm-yyyy'),to_date(p_fecha_final,'dd-mm-yyyy'),v_cantidad,v_total;
	end if;
end;
$$
language plpgsql;
