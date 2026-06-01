create user admin_res with
  password 'admin_res'
  connection limit 2;

grant all privileges on database restaurante_dia to admin_res;
grant all privileges on schema public to admin_res;
grant all privileges on all tables in schema public to admin_res;
grant all privileges on all sequences in schema public to admin_res;
grant all privileges on all functions in schema public to admin_res;

create user administrativo with
  password 'administrativo'
  connection limit 3;

grant connect on database restaurante_dia to administrativo;
grant usage, create on schema public to administrativo;
grant select, insert, update, delete on all tables in schema public to administrativo;
grant usage on all sequences in schema public to administrativo;
grant execute on all functions in schema public to administrativo;
grant execute on all procedures in schema public to administrativo;

create user mesero with
  password 'mesero'
  connection limit 4;

grant connect on database restaurante_dia to mesero;
grant usage on schema public to mesero;
grant usage on all sequences in schema public to mesero;

grant select, insert, update on public.orden to mesero;
grant select, insert, update on public.orden_producto to mesero;
grant select, insert, update on public.factura to mesero;
grant select, insert, update on public.cliente to mesero;
grant select on public.estado to mesero;
grant select on public.producto to mesero;

