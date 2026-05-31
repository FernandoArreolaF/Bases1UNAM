begin;

truncate table
  public.factura,
  public.orden_producto,
  public.orden,
  public.telefono_empleado,
  public.dependiente,
  public.administrativo,
  public.cocinero,
  public.mesero,
  public.producto,
  public.cliente,
  public.empleado,
  public.categoria,
  public.estado
restart identity cascade;

\copy public.estado from '/home/javi/restaurante_airflow/data/estado.csv' with (format csv, header true, delimiter ',')
\copy public.categoria from '/home/javi/restaurante_airflow/data/categoria.csv' with (format csv, header true, delimiter ',')
\copy public.empleado from '/home/javi/restaurante_airflow/data/empleado.csv' with (format csv, header true, delimiter ',')
\copy public.cliente from '/home/javi/restaurante_airflow/data/cliente.csv' with (format csv, header true, delimiter ',')
\copy public.producto from '/home/javi/restaurante_airflow/data/producto.csv' with (format csv, header true, delimiter ',')
\copy public.administrativo from '/home/javi/restaurante_airflow/data/administrativo.csv' with (format csv, header true, delimiter ',')
\copy public.cocinero from '/home/javi/restaurante_airflow/data/cocinero.csv' with (format csv, header true, delimiter ',')
\copy public.dependiente from '/home/javi/restaurante_airflow/data/dependiente.csv' with (format csv, header true, delimiter ',')
\copy public.mesero from '/home/javi/restaurante_airflow/data/mesero.csv' with (format csv, header true, delimiter ',')
\copy public.telefono_empleado from '/home/javi/restaurante_airflow/data/telefono_empleado.csv' with (format csv, header true, delimiter ',')
\copy public.orden from '/home/javi/restaurante_airflow/data/orden.csv' with (format csv, header true, delimiter ',')
\copy public.orden_producto from '/home/javi/restaurante_airflow/data/orden_producto.csv' with (format csv, header true, delimiter ',')
\copy public.factura from '/home/javi/restaurante_airflow/data/factura.csv' with (format csv, header true, delimiter ',')

do $$
declare
  v_valor bigint;
begin
  select max(estado_id) into v_valor from estado;
  if v_valor is not null then
    perform setval('estado_id_seq', v_valor, true);
  end if;

  select max(categoria_id) into v_valor from categoria;
  if v_valor is not null then
    perform setval('categoria_id_seq', v_valor, true);
  end if;

  select max(empleado_id) into v_valor from empleado;
  if v_valor is not null then
    perform setval('empleado_id_seq', v_valor, true);
  end if;

  select max(cliente_id) into v_valor from cliente;
  if v_valor is not null then
    perform setval('cliente_id_seq', v_valor, true);
  end if;

  select max(producto_id) into v_valor from producto;
  if v_valor is not null then
    perform setval('producto_id_seq', v_valor, true);
  end if;

  select max(telefono_empleado_id) into v_valor from telefono_empleado;
  if v_valor is not null then
    perform setval('telefono_empleado_id_seq', v_valor, true);
  end if;

  select max(dependiente_id) into v_valor from dependiente;
  if v_valor is not null then
    perform setval('dependiente_id_seq', v_valor, true);
  end if;

  select max(orden_id) into v_valor from orden;
  if v_valor is not null then
    perform setval('orden_id_seq', v_valor, true);
  end if;

  select max(orden_producto_id) into v_valor from orden_producto;
  if v_valor is not null then
    perform setval('orden_producto_id_seq', v_valor, true);
  end if;

  select max(factura_id) into v_valor from factura;
  if v_valor is not null then
    perform setval('factura_id_seq', v_valor, true);
  end if;

  select max(substring(folio from 'ORD-([0-9]+)')::bigint)
  into v_valor
  from orden
  where folio ~ '^ORD-[0-9]+$';

  if v_valor is not null then
    perform setval('factura_folio_seq', v_valor, true);
  end if;
end $$;

commit;