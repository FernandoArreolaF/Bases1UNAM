CREATE OR REPLACE FUNCTION verificar_email()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT *
        FROM empleado
        WHERE email = NEW.email
    ) THEN
        RAISE EXCEPTION 'El email ya existe en la tabla empleado.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER cliente_verificar_email
BEFORE INSERT OR UPDATE
ON cliente
FOR EACH ROW
EXECUTE FUNCTION verificar_email();

CREATE OR REPLACE FUNCTION verificar_email_empleado()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM cliente
        WHERE email = NEW.email
    ) THEN
        RAISE EXCEPTION 'El email ya existe en la tabla cliente.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER empleado_verificar_email
BEFORE INSERT OR UPDATE
ON empleado
FOR EACH ROW
EXECUTE FUNCTION verificar_email_empleado();

CREATE OR REPLACE FUNCTION validar_alimento_disponible()
RETURNS TRIGGER AS $$
BEGIN
  IF (SELECT disponible FROM alimento WHERE alimento_id = NEW.alimento_id) <> true THEN
    RAISE EXCEPTION 'El alimento seleccionado no está disponible';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_validar_alimento
BEFORE INSERT ON orden_detalle
FOR EACH ROW
EXECUTE FUNCTION validar_alimento_disponible();


CREATE OR REPLACE FUNCTION actualizar_total_orden_general()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE orden_general
    SET total = (
        SELECT SUM(subtotal)
        FROM orden_detalle
        WHERE orden_detalle.orden_general_id = NEW.orden_general_id
    )
    WHERE orden_general.orden_general_id = NEW.orden_general_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER actualizar_total_orden_detalle
AFTER INSERT OR UPDATE OR DELETE
ON orden_detalle
FOR EACH ROW
EXECUTE FUNCTION actualizar_total_orden_general();

CREATE OR REPLACE FUNCTION generar_folio()
RETURNS TRIGGER AS $$
BEGIN
    NEW.folio := 'ORD-' || NEW.orden_general_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER autogenerar_folio
BEFORE INSERT ON orden_general
FOR EACH ROW
EXECUTE FUNCTION generar_folio();
