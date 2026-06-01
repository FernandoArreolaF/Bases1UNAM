reate or replace function s_08_function_actualizar_fecha_administrativo() 
returns trigger as $$
begin
    update administrativo 
    set fecha_registro = current_date 
    where administrativo_id = new.administrativo_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_categoria() 
returns trigger as $$
begin
    update categoria 
    set fecha_registro = current_date 
    where categoria_id = new.categoria_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_cliente() 
returns trigger as $$
begin
    update cliente 
    set fecha_registro = current_date 
    where cliente_id = new.cliente_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_cocinero() 
returns trigger as $$
begin
    update cocinero 
    set fecha_registro = current_date 
    where cocinero_id = new.cocinero_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_dependiente() 
returns trigger as $$
begin
    update dependiente 
    set fecha_registro = current_date 
    where dependiente_id = new.dependiente_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_empleado() 
returns trigger as $$
begin
    update empleado 
    set fecha_registro = current_date 
    where empleado_id = new.empleado_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_estado() 
returns trigger as $$
begin
    update estado 
    set fecha_registro = current_date 
    where estado_id = new.estado_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_factura() 
returns trigger as $$
begin
    update factura 
    set fecha_registro = current_date 
    where factura_id = new.factura_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_mesero() 
returns trigger as $$
begin
    update mesero 
    set fecha_registro = current_date 
    where mesero_id = new.mesero_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_orden() 
returns trigger as $$
begin
    update orden 
    set fecha_registro = current_date 
    where orden_id = new.orden_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_orden_producto() 
returns trigger as $$
begin
    update orden_producto 
    set fecha_registro = current_date 
    where orden_producto_id = new.orden_producto_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_producto() 
returns trigger as $$
begin
    update producto 
    set fecha_registro = current_date 
    where producto_id = new.producto_id;
    return null;
end;
$$ language plpgsql;

create or replace function s_08_function_actualizar_fecha_telefono_empleado() 
returns trigger as $$
begin
    update telefono_empleado 
    set fecha_registro = current_date 
    where telefono_empleado_id = new.telefono_empleado_id;
    return null;
end;
$$ language plpgsql;

create or replace trigger s_08_trigger_actualizacion_fecha_reg_administrativo 
		before update on administrativo for each row 
			execute function s_08_function_actualizar_fecha_administrativo();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_categoria 
		before update on categoria for each row 
			execute function s_08_function_actualizar_fecha_categoria();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_cliente 
		before update on cliente for each row 
			execute function s_08_function_actualizar_fecha_cliente();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_cocinero 
		before update on cocinero for each row 
			execute function s_08_function_actualizar_fecha_cocinero();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_dependiente 
		before update on dependiente for each row 
			execute function s_08_function_actualizar_fecha_dependiente();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_empleado 
		before update on empleado for each row 
			execute function s_08_function_actualizar_fecha_empleado();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_estado 
		before update on estado for each row 
			execute function s_08_function_actualizar_fecha_estado();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_factura 
		before update on factura for each row 
			execute function s_08_function_actualizar_fecha_factura();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_mesero 
		before update on mesero for each row 
			execute function s_08_function_actualizar_fecha_mesero();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_orden 
		before update on orden for each row 
			execute function s_08_function_actualizar_fecha_orden();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_orden_producto 
		before update on orden_producto for each row 
			execute function s_08_function_actualizar_fecha_orden_producto();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_producto 
		before update on producto for each row 
			execute function s_08_function_actualizar_fecha_producto();

create or replace trigger s_08_trigger_actualizacion_fecha_reg_telefono_empleado 
		before update on telefono_empleado for each row 
			execute function s_08_function_actualizar_fecha_telefono_empleado();