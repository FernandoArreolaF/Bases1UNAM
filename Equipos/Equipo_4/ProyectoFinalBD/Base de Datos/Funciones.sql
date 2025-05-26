CREATE OR REPLACE FUNCTION public.sp_filtrar_articulos_insuficientes(
	)
    RETURNS TABLE(v_cod_barras character varying, v_nombre_art character varying, n_precio_compra numeric, n_precio_venta numeric, n_stock numeric, estado_stock text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        a.v_cod_barras,
        a.v_nombre_art,
        a.n_precio_compra,
        a.n_precio_venta,
        a.n_stock,
        CASE
            WHEN a.n_stock = 0 THEN 'Artículo no disponible'
            ELSE 'Artículo poco disponible'
        END AS estado_stock
    FROM public.articulo a
    WHERE a.n_stock < 3;
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sp_insertar_venta_completa(
	p_cliente_rfc character varying,
	p_vendedor_clave numeric,
	p_cajero_clave numeric,
	p_articulos json)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    articulo JSON;
    cod_barras VARCHAR;
    cantidad NUMERIC;
    precio_unitario NUMERIC;
    total_venta NUMERIC := 0;
    total_cantidad NUMERIC := 0;
    ultimo_folio VARCHAR;
    ultimo_numero INT;
    nuevo_numero INT;
    nuevo_folio VARCHAR;
    folio_facturacion VARCHAR;
    validacion_result RECORD;
    articulos_agrupados JSON;
BEGIN
    -- Agrupar artículos duplicados del JSON de entrada
    SELECT json_agg(
        json_build_object(
            'cod_barras', sub.cb,
            'cantidad', sub.sum_cant
        )
    )
    INTO articulos_agrupados
    FROM (
        SELECT 
            (art->>'cod_barras') AS cb,
            SUM((art->>'cantidad')::NUMERIC) AS sum_cant
        FROM json_array_elements(p_articulos) AS art
        GROUP BY (art->>'cod_barras')
    ) AS sub;

    -- Validar que vendedor y cajero pertenecen a la misma sucursal
    SELECT * INTO validacion_result
    FROM sp_validar_vendedor_cajero_misma_sucursal(p_vendedor_clave, p_cajero_clave);

    IF validacion_result.validacion = 0 THEN
        RAISE EXCEPTION '%', validacion_result.mensaje;
    END IF;

    -- Obtener el nuevo folio para la venta
    SELECT v_folio INTO ultimo_folio
    FROM venta
    WHERE v_folio LIKE 'MBL-%'
    ORDER BY v_folio DESC
    LIMIT 1;

    IF ultimo_folio IS NULL THEN
        nuevo_numero := 1;
    ELSE
        ultimo_numero := CAST(SUBSTRING(ultimo_folio FROM 5) AS INTEGER);
        nuevo_numero := ultimo_numero + 1;
    END IF;

    nuevo_folio := 'MBL-' || LPAD(nuevo_numero::TEXT, 3, '0');
    folio_facturacion := 'FAC-' || UPPER(SUBSTRING(md5(random()::text) FROM 1 FOR 6));

    -- Validar existencia del cliente y empleados
    IF NOT EXISTS (SELECT 1 FROM cliente WHERE v_rfc_client = p_cliente_rfc) THEN
        RAISE EXCEPTION 'El cliente con RFC % no existe', p_cliente_rfc;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM empleado WHERE n_clave_emp = p_vendedor_clave) THEN
        RAISE EXCEPTION 'El empleado (vendedor) con clave % no existe', p_vendedor_clave;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM empleado WHERE n_clave_emp = p_cajero_clave) THEN
        RAISE EXCEPTION 'El empleado (cajero) con clave % no existe', p_cajero_clave;
    END IF;

    -- Calcular totales de la venta
    FOR articulo IN SELECT * FROM json_array_elements(articulos_agrupados)
    LOOP
        cod_barras := articulo->>'cod_barras';
        cantidad := (articulo->>'cantidad')::NUMERIC;

        SELECT n_precio_venta
        INTO precio_unitario
        FROM articulo
        WHERE v_cod_barras = cod_barras;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'El artículo con código de barras % no existe', cod_barras;
        END IF;

        total_venta := total_venta + (precio_unitario * cantidad);
        total_cantidad := total_cantidad + cantidad;
    END LOOP;

    -- Insertar en tabla venta
    INSERT INTO venta (
        d_fecha, v_folio, n_monto_total, n_cant_totalart, 
        v_cliente_rfc_client, v_folio_facturacion
    )
    VALUES (
        CURRENT_DATE, nuevo_folio, total_venta, total_cantidad,
        p_cliente_rfc, folio_facturacion
    );

    -- Insertar relación con empleados
    INSERT INTO venta_empleado (v_venta_folio, n_empleado_clave_emp)
    VALUES 
        (nuevo_folio, p_vendedor_clave),
        (nuevo_folio, p_cajero_clave);

    -- Insertar los artículos agrupados a la venta
    FOR articulo IN SELECT * FROM json_array_elements(articulos_agrupados)
    LOOP
        cod_barras := articulo->>'cod_barras';
        cantidad := (articulo->>'cantidad')::NUMERIC;

        INSERT INTO articulo_venta (
            v_venta_folio, v_articulo_cod_barras, n_cantidad
        )
        VALUES (
            nuevo_folio, cod_barras, cantidad
        );
    END LOOP;

    RETURN total_venta;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error al insertar la venta: %', SQLERRM;
        RAISE;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.sp_obtener_detalle_venta(
	p_folio_venta character varying)
    RETURNS TABLE(folio_venta character varying, empleado_nombre text, cliente_nombre text, total_articulos numeric, monto_total numeric, folio_facturacion character varying, clave_sucursal character varying, articulos text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        v.v_folio,
        CONCAT(emp.v_nombre, ' ', emp.v_ap_paterno, ' ', emp.v_ap_mat),
        CONCAT(cli.v_nombre, ' ', cli.v_ap_paterno, ' ', cli.v_ap_materno),
        v.n_cant_totalart,
        v.n_monto_total,
        v.v_folio_facturacion,
        emp.v_sucursal_clave_suc,
        string_agg(
            CONCAT(
                '(', art.v_cod_barras, ') ',
                art.v_nombre_art, ' x', av.n_cantidad, 
                ' $', art.n_precio_venta
            ),
            ' | '
        )
    FROM venta v
    JOIN venta_empleado ve ON ve.v_venta_folio = v.v_folio
    JOIN empleado emp ON emp.n_clave_emp = ve.n_empleado_clave_emp
    JOIN cliente cli ON cli.v_rfc_client = v.v_cliente_rfc_client
    JOIN articulo_venta av ON av.v_venta_folio = v.v_folio
    JOIN articulo art ON art.v_cod_barras = av.v_articulo_cod_barras
    WHERE v.v_folio = p_folio_venta AND emp.v_tipo = 'Vendedor'
    GROUP BY v.v_folio, emp.v_nombre, emp.v_ap_paterno, emp.v_ap_mat,
             cli.v_nombre, cli.v_ap_paterno, cli.v_ap_materno,
             v.n_cant_totalart, v.n_monto_total, v.v_folio_facturacion,
             emp.v_sucursal_clave_suc;
END;
$BODY$;


CREATE OR REPLACE FUNCTION public.sp_obtener_jerarquia(
	in_clave_emp numeric)
    RETURNS TABLE(clave numeric, nombre character varying, nivel integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    WITH RECURSIVE jerarquia AS (
        SELECT 
            e.n_clave_emp,
            e.v_nombre,
            1 AS nivel
        FROM empleado e
        WHERE e.n_clave_emp = in_clave_emp

        UNION ALL

        SELECT 
            jefe.n_clave_emp,
            jefe.v_nombre,
            j.nivel + 1
        FROM empleado jefe
        JOIN jerarquia j ON jefe.n_clave_emp = (
            SELECT e.n_empleado_clave_emp
            FROM empleado e
            WHERE e.n_clave_emp = j.n_clave_emp
        )
        WHERE jefe.n_clave_emp IS NOT NULL
    )
    SELECT 
        j.n_clave_emp,
        j.v_nombre,
        j.nivel
    FROM jerarquia j
    ORDER BY j.nivel DESC;
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sp_inicio_sesion(
	p_n_clave_emp numeric,
	"p_contraseña" text)
    RETURNS TABLE(validacion integer, n_clave_emp numeric, v_rfc_emp character varying, d_fecha_ing date, v_curp character varying, v_email_emp character varying, v_nombre character varying, v_ap_paterno character varying, v_ap_mat character varying, n_empleado_clave_emp numeric, v_sucursal_clave_suc character varying, v_tipo character varying, colonia character varying, calle character varying, numero numeric, cod_postal numeric, estado character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        1 AS validacion,
        e.n_clave_emp,
        e.v_rfc_emp,
        e.d_fecha_ing,
        e.v_curp,
        e.v_email_emp,
        e.v_nombre,
        e.v_ap_paterno,
        e.v_ap_mat,
        e.n_empleado_clave_emp,
        e.v_sucursal_clave_suc,
        e.v_tipo,
        d.v_colonia,
        d.v_calle,
        d.n_numero,
        d.n_cod_p_cod_postal,
        cp.v_estado
    FROM empleado e
    JOIN direccion d ON e.n_direccion_id_direccion = d.n_id_direccion
    JOIN cod_p cp ON d.n_cod_p_cod_postal = cp.n_cod_postal
    WHERE e.n_clave_emp = p_n_clave_emp
      AND e.t_contraseña = p_contraseña
      AND LOWER(e.v_tipo) IN ('vendedor', 'cajero');

    IF NOT FOUND THEN
        RETURN QUERY
        SELECT
            0,
            NULL, NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL, NULL, NULL;
    END IF;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.sp_validar_vendedor_cajero_misma_sucursal(
	p_emp1 numeric,
	p_emp2 numeric)
    RETURNS TABLE(validacion integer, mensaje text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    emp1 RECORD;
    emp2 RECORD;
BEGIN
    SELECT v_tipo, v_sucursal_clave_suc INTO emp1
    FROM empleado
    WHERE n_clave_emp = p_emp1;

    IF NOT FOUND THEN
        RETURN QUERY SELECT 0, format('Empleado %s no existe', p_emp1);
        RETURN;
    END IF;

    SELECT v_tipo, v_sucursal_clave_suc INTO emp2
    FROM empleado
    WHERE n_clave_emp = p_emp2;

    IF NOT FOUND THEN
        RETURN QUERY SELECT 0, format('Empleado %s no existe', p_emp2);
        RETURN;
    END IF;

    IF (
        (LOWER(emp1.v_tipo) = 'vendedor' AND LOWER(emp2.v_tipo) = 'cajero') OR
        (LOWER(emp1.v_tipo) = 'cajero' AND LOWER(emp2.v_tipo) = 'vendedor')
    ) THEN
	IF emp1.v_sucursal_clave_suc = emp2.v_sucursal_clave_suc THEN
            RETURN QUERY SELECT 1, 'Validación exitosa: vendedor y cajero en la misma sucursal';
        ELSE
            RETURN QUERY SELECT 0, 'Error: los empleados no pertenecen a la misma sucursal';
        END IF;
    ELSE
        RETURN QUERY SELECT 0, 'Error: los empleados no son vendedor y cajero de forma excluyente';
    END IF;
END;
$BODY$;

DROP FUNCTION sp_obtener_articulos;
CREATE OR REPLACE FUNCTION sp_obtener_articulos()
RETURNS TABLE (
    cod_barras VARCHAR(20),
    nombre_art VARCHAR(50),
    precio_compra numeric(8,2),
    precio_venta numeric(8,2),
    stock numeric(7,0),
    fotografia BYTEA,
    categoria_clave_cat numeric(5,0),
    nombre_cat VARCHAR(20),
    tipo_cat VARCHAR(20)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.v_cod_barras,
        a.v_nombre_art,
        a.n_precio_compra,
        a.n_precio_venta,
        a.n_stock,
        a.b_fotografia,
        a.n_categoria_clave_cat,
        c.v_nombre_cat,
        c.v_tipo_cat
    FROM 
        articulo a
    JOIN 
        categoria c ON a.n_categoria_clave_cat = c.n_clave_cat;
END;
$$ LANGUAGE plpgsql;
