CREATE OR REPLACE FUNCTION public.sp_set_razon_social()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    -- Solo si razon_social está vacío o NULL
    IF NEW.v_razon_social IS NULL OR trim(NEW.v_razon_social) = '' THEN
        NEW.v_razon_social := trim(concat_ws(' ', NEW.v_nombre, NEW.v_ap_paterno, NEW.v_ap_materno));
    END IF;
    RETURN NEW;
END;
$BODY$;

CREATE OR REPLACE TRIGGER tr_set_razon_social
    BEFORE INSERT OR UPDATE 
    ON public.cliente
    FOR EACH ROW
    EXECUTE FUNCTION public.sp_set_razon_social();


CREATE OR REPLACE FUNCTION public.sp_validar_y_actualizar_stock()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    stock_actual numeric;
BEGIN
    SELECT n_stock INTO stock_actual
    FROM articulo
    WHERE v_cod_barras = NEW.v_articulo_cod_barras;

    IF stock_actual IS NULL THEN
        RAISE EXCEPTION 'Artículo % no existe', NEW.v_articulo_cod_barras;
    END IF;

    IF stock_actual < NEW.n_cantidad THEN
        RAISE EXCEPTION 'Stock insuficiente para el artículo % (Stock: %, Solicitado: %)',
            NEW.v_articulo_cod_barras, stock_actual, NEW.n_cantidad;
    END IF;

    -- Descontar del stock
    UPDATE articulo
    SET n_stock = n_stock - NEW.n_cantidad
    WHERE v_cod_barras = NEW.v_articulo_cod_barras;

    RETURN NEW;
END;
$BODY$;


CREATE OR REPLACE TRIGGER tr_validar_stock
    BEFORE INSERT
    ON public.articulo_venta
    FOR EACH ROW
    EXECUTE FUNCTION public.sp_validar_y_actualizar_stock();
