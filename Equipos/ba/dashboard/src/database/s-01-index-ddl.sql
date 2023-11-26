-- ORDEN_DETALLE

-- Buscar todos los artículos de una orden

create index
    orden_detalle_orden_general_id_ix on orden_detalle(orden_general_id);

-- CLIENTE

-- Inicio rápido de sesión

create index cliente_email_ix on cliente(email);

-- EMPLEADO

-- Inicio rápido de sesión

create index empleado_email_ix on empleado(email);

-- ________________________________PROCEDURES___________________________________
-- -- Crear una función que verifica la existencia del correo en la tabla empleado
-- CREATE OR REPLACE FUNCTION verificar_email_existente()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- Verificar si el correo ya existe en la tabla empleado
--     IF EXISTS (SELECT 1 FROM empleado WHERE email = NEW.email) THEN
--         -- Si existe, lanzar un error y abortar la operación
--         RAISE EXCEPTION 'El correo ya existe en la tabla empleado';
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Crear el trigger que se dispara antes del INSERT o UPDATE en la tabla cliente
-- CREATE TRIGGER before_insert_update_cliente
-- BEFORE INSERT OR UPDATE
-- ON cliente
-- FOR EACH ROW
-- EXECUTE FUNCTION verificar_email_existente();


-- -- Crear una función que verifica la existencia del correo en la tabla cliente
-- CREATE OR REPLACE FUNCTION verificar_email_en_cliente()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- Verificar si el correo ya existe en la tabla cliente
--     IF EXISTS (SELECT 1 FROM cliente WHERE email = NEW.email) THEN
--         -- Si existe, lanzar un error y abortar la operación
--         RAISE EXCEPTION 'El correo ya existe en la tabla cliente';
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Crear el trigger que se dispara antes del INSERT o UPDATE en la tabla empleado
-- CREATE TRIGGER before_insert_update_empleado
-- BEFORE INSERT OR UPDATE
-- ON empleado
-- FOR EACH ROW
-- EXECUTE FUNCTION verificar_email_en_cliente();


-- -- Verificar que no se insert ordenes mientras aun no se cierra la actual
-- CREATE OR REPLACE FUNCTION validar_la_orden_actual()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- Verificar si ya existe un registro con 'REGISTRADA' o 'EN PROGRESO'
--     IF EXISTS (
--         SELECT 1
--         FROM orden_general
--         WHERE cliente_id = NEW.cliente_id
--           AND estatus IN ('REGISTRADA', 'EN PROGRESO')
--     ) THEN
--         -- Cancelar la inserción
--         RAISE EXCEPTION 'No se permite insertar para este cliente con estatus REGISTRADA o EN PROGRESO';
--     END IF;

--     -- Si no hay conflictos, permitir la inserción
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Crear el trigger
-- CREATE TRIGGER before_insert_check
-- BEFORE INSERT ON orden_general
-- FOR EACH ROW
-- EXECUTE FUNCTION validar_la_orden_actual();


-- -- Dar formato al folio
-- -- Crear una función que se ejecutará antes de la inserción
-- CREATE OR REPLACE FUNCTION definir_folio_antes_de_insertar()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- Asignar el valor 'ORD-' seguido del orden_general_id al campo folio
--     NEW.folio := 'ORD-' || NEW.orden_general_id;

--     -- Continuar con la inserción
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Crear el trigger que llama a la función antes de la inserción
-- CREATE TRIGGER set_folio_trigger
-- BEFORE INSERT ON orden_general
-- FOR EACH ROW
-- EXECUTE FUNCTION definir_folio_antes_de_insertar();





-- CREATE OR REPLACE FUNCTION actualizar_total()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- Actualizar el campo total en orden_general después de un INSERT, UPDATE o DELETE en orden_detalle
--     UPDATE orden_general
--     SET total = (
--         SELECT COALESCE(SUM(subtotal), 0)
--         FROM orden_detalle
--         WHERE orden_general_id = NEW.orden_general_id
--     )
--     WHERE orden_general_id = NEW.orden_general_id;

--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Crear el trigger
-- CREATE TRIGGER trigger_actualizar_total
-- BEFORE INSERT OR UPDATE OR DELETE
-- ON orden_detalle
-- FOR EACH ROW
-- EXECUTE FUNCTION actualizar_total();
