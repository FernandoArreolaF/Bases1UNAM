drop trigger if exists trg_validar_y_calcular_total_producto on orden_producto;
drop trigger if exists trg_actualizar_total_orden on orden_producto;
drop function if exists fn_validar_y_calcular_total_producto();
drop function if exists fn_actualizar_total_orden();


create or replace function fn_validar_y_calcular_total_producto()
returns trigger as $$
declare
    v_disponibilidad_producto producto.disponibilidad%type;
    v_precio_producto producto.precio%type;
begin 
    select p.disponibilidad, p.precio
    into v_disponibilidad_producto, v_precio_producto
    from producto p 
    where p.producto_id = new.producto_id;

    if v_disponibilidad_producto is false then
        raise exception 'no hay disponibilidad de producto, por lo que no se puede agregar.'
        using errcode = 'E0001';
    end if;

    new.total_producto := new.cantidad_producto * v_precio_producto;

    return new;
end;
$$ language plpgsql;

create trigger trg_validar_y_calcular_total_producto
before insert or update of producto_id, cantidad_producto
on orden_producto
for each row
execute function fn_validar_y_calcular_total_producto();

create or replace function fn_actualizar_total_orden()
returns trigger as $$
begin
    update orden
    set total = (
        select sum(op.total_producto)
        from orden_producto op
        where op.orden_id = new.orden_id
    )
    where orden_id = new.orden_id;

    return new;
end;
$$ language plpgsql;

create trigger trg_actualizar_total_orden
after insert or update of total_producto, cantidad_producto, producto_id
on orden_producto
for each row
execute function fn_actualizar_total_orden();


create or replace function fn_reporte_ordenes_mesero_dia(
    p_numero_empleado empleado.numero_empleado%type
)
returns void as $$
declare 
    v_empleado_id empleado.empleado_id%type;
    v_is_mesero numeric(1,0);
    v_numero_ordenes numeric(3,0);
    v_total numeric(9,2);
begin
    select e.empleado_id
    into v_empleado_id
    from empleado e
    where e.numero_empleado = p_numero_empleado;

    select count(m.empleado_id)
    into v_is_mesero
    from empleado e 
    left join mesero m 
        on e.empleado_id = m.empleado_id
    where e.numero_empleado = p_numero_empleado;

    if v_is_mesero = 0 then 
        raise exception 'el numero de empleado dado no es de un mesero.'
        using errcode = 'P0002';
    end if;

    select count(*)
    into v_numero_ordenes
    from orden o
    where o.empleado_id = v_empleado_id
      and o.fecha_orden::date = current_date;

    select sum(o.total)
    into v_total
    from orden o
    where o.empleado_id = v_empleado_id
      and o.fecha_orden::date = current_date;

    raise notice 'cantidad de ordenes: %, total pagado: %', 
        v_numero_ordenes, v_total;        
end;
$$ language plpgsql;

create or replace function ventas_en_intervalo(
    p_fecha_ini date, 
    p_fecha_fin date,
    out total_ventas numeric, 
    out monto_total numeric
)
returns record as $$
begin
    select count(*), sum(total) 
    into total_ventas, monto_total
    from orden
    where fecha_orden >= p_fecha_ini 
      and fecha_orden < p_fecha_fin + 1; 
end;
$$ language plpgsql;

create or replace function ventas_en_intervalo(
    p_fecha date,
    out total_ventas numeric,
    out monto_total numeric
)
returns record as $$
begin
    select count(*), sum(total) 
    into total_ventas, monto_total
    from orden
    where fecha_orden >= p_fecha 
      and fecha_orden < p_fecha + 1;
end;
$$ language plpgsql;

create or replace procedure factura_orden (p_orden_id numeric)
language plpgsql as $$
declare
    v_orden_datos record;
    cur_factura cursor for
      select op.total_producto, op.cantidad_producto,
        p.nombre as nombre_producto, p.precio, p.es_platillo, p.es_bebida
      from orden o
      join orden_producto op
        on o.orden_id = op.orden_id
      join producto p
        on op.producto_id = p.producto_id
      where o.orden_id = p_orden_id
      order by p.es_platillo desc, p.es_bebida desc;
    v_orden_cliente record;
begin
    select o.folio, o.fecha_orden, o.total,
      f.fecha_factura,
      c.nombre, c.ap_paterno, c.ap_materno, c.rfc
      into v_orden_cliente
    from orden o
    join factura f
      on o.orden_id = f.orden_id
    join cliente c
      on f.cliente_id = c.cliente_id
    where o.orden_id = p_orden_id;
    if not found then
      raise notice 'No existe la orden o no tiene factura';
      return;
    end if;
    raise notice '==========================================';
    raise notice '              Factura orden               ';
    raise notice '==========================================';
    raise notice '%',v_orden_cliente.folio;
    raise notice 'Fecha orden: %', v_orden_cliente.fecha_orden;
    open cur_factura;
    loop
     fetch cur_factura into v_orden_datos;
     exit when not found;
      raise notice 'Producto $%, Precio Unitario: %',
        v_orden_datos.nombre_producto, v_orden_datos.precio;
      raise notice 'Cantidad %, Total por producto $%',
        v_orden_datos.cantidad_producto, v_orden_datos.total_producto;
    end loop;
    close cur_factura;
    raise notice 'Total de la orden: $%', v_orden_cliente.total;
    raise notice 'Factura generada el %', v_orden_cliente.fecha_factura;
    raise notice '==========================================';
    raise notice '              Datos del cliente';
    raise notice '==========================================';
    raise notice 'Nombre: % % %', v_orden_cliente.nombre,
      v_orden_cliente.ap_paterno, v_orden_cliente.ap_materno;
    raise notice 'RFC: %', v_orden_cliente.rfc;
end;
$$;
