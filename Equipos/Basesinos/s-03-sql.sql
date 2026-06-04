create or replace view platillo_mas_vendido as
  with cantidades as (
    select p.producto_id, 
      sum(op.cantidad_producto) as cantidad_vendida_producto 
    from orden_producto op
    join producto p
      on p.producto_id = op.producto_id
    where p.es_platillo = true
    group by p.producto_id
  )
  select p.producto_id, p.nombre, p.descripcion, p.precio, p.disponibilidad
  from cantidades c  
  join producto p
  on p.producto_id = c.producto_id
  where c.cantidad_vendida_producto = (select max(cantidad_vendida_producto)
    from cantidades);

create or replace view productos_no_disponibles as
  select nombre
  from producto
  where disponibilidad = false;
