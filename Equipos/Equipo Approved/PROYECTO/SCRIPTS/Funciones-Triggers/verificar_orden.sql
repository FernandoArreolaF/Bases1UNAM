-- FUNCTION: public.verificar_orden()

-- DROP FUNCTION public.verificar_orden();

CREATE FUNCTION public.verificar_orden()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
declare maxid int;
begin
if((select Unidades_stock -(select cantidad_articulo
                            from ORDEN_DETALLE
                            where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                                                    having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE )))
    from INVENTARIO where codigo_barras=(select codigo_barras from PRODUCTO P where id_producto=
                                         (select id_producto
                                          from ORDEN_DETALLE
                                          where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                                                                  having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE )))))< 0) then
raise notice 'No se registrar la venta no hay inventario suficiente';
delete from ORDEN_DETALLE where No_orden_detalle=(select (max(No_orden_detalle)) from ORDEN_DETALLE);
return null;
else
UPDATE ORDEN_DETALLE
set precio_venta_producto=
(select precio_venta from PRODUCTO P where id_producto=
 (select id_producto
  from ORDEN_DETALLE
  where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                          having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE ))))
where No_orden_detalle=(select max(No_orden_detalle) from ORDEN_DETALLE);

UPDATE ORDEN_DETALLE
set total_pagar=
(select cantidad_articulo*     (select precio_venta_producto from ORDEN_DETALLE
                                where No_orden_detalle=(select No_orden_detalle
                                                        from ORDEN_DETALLE  group by No_orden_detalle having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE )))
 from ORDEN_DETALLE
 where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                         having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE )))
where No_orden_detalle=(select max(No_orden_detalle) from ORDEN_DETALLE );

UPDATE INVENTARIO
set unidades_stock=
(select Unidades_stock -(select cantidad_articulo
                         from ORDEN_DETALLE
                         where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                                                 having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE )))
 from INVENTARIO where codigo_barras=(select codigo_barras from PRODUCTO P where id_producto=
                                      (select id_producto
                                       from ORDEN_DETALLE
                                       where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                                                               having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE )))))
where codigo_barras=(select codigo_barras from PRODUCTO P where id_producto=
                     (select id_producto
                      from ORDEN_DETALLE
                      where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                                              having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE ))));

if((select Unidades_stock -(select cantidad_articulo
                            from ORDEN_DETALLE
                            where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                                                    having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE )))
    from INVENTARIO where codigo_barras=(select codigo_barras from PRODUCTO P where id_producto=
                                         (select id_producto
                                          from ORDEN_DETALLE
                                          where No_orden_detalle=(select No_orden_detalle from ORDEN_DETALLE  group by No_orden_detalle
                                                                  having max(No_orden_detalle)=(select max(No_orden_detalle) from ORDEN_DETALLE )))))<=3) then
raise notice 'El stock de tu producto es menor a 3';
end if;
raise notice 'se inserto correctamente';
return new;
end if;
END;
$BODY$;

ALTER FUNCTION public.verificar_orden()
    OWNER TO papeleria;
