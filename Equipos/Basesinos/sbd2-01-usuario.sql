-- usuario admin_res
create user admin_res_final with
  password 'admin_res_final'
  connection limit 2;

-- otorgar privilegios sobre la base de datos
grant all privileges on database restaurante_final to admin_res_final;
grant all privileges on schema public to admin_res_final;
grant all privileges on all tables in schema public to admin_res_final;
grant all privileges on all sequences in schema public to admin_res_final;
grant all privileges on all functions in schema public to admin_res_final;

-- usuario administrativo
create user administrativo_final with
  password 'administrativo_final'
  connection limit 3;

grant connect on database restaurante_final to administrativo_final;
grant usage, create on schema public to administrativo_final;               
grant select on all tables in schema public to administrativo_fina; 
grant usage on all sequences in schema public to administrativo_final;
grant execute on all functions in schema public to administrativo_final;
grant execute on all procedures in schema public to administrativo_final;
