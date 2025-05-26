CREATE TABLE IF NOT EXISTS public.categoria
(
    n_clave_cat numeric(5,0) NOT NULL,
    v_nombre_cat character varying(20) COLLATE pg_catalog."default" NOT NULL,
    v_tipo_cat character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categoria_pk PRIMARY KEY (n_clave_cat)
)

CREATE TABLE IF NOT EXISTS public.cod_p
(
    v_estado character varying(50) COLLATE pg_catalog."default" NOT NULL,
    n_cod_postal numeric(5,0) NOT NULL,
    CONSTRAINT cod_p_pk PRIMARY KEY (n_cod_postal)
)

CREATE TABLE IF NOT EXISTS public.articulo
(
    v_cod_barras character varying(20) COLLATE pg_catalog."default" NOT NULL,
    v_nombre_art character varying(50) COLLATE pg_catalog."default" NOT NULL,
    n_precio_compra numeric(8,2) NOT NULL,
    n_precio_venta numeric(8,2) NOT NULL,
    n_stock numeric(7,0) NOT NULL,
    b_fotografia bytea NOT NULL,
    n_categoria_clave_cat numeric(5,0) NOT NULL,
    CONSTRAINT articulo_pk PRIMARY KEY (v_cod_barras),
    CONSTRAINT clave_cat_fk FOREIGN KEY (n_categoria_clave_cat)
        REFERENCES public.categoria (n_clave_cat) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.direccion
(
    v_colonia character varying(50) COLLATE pg_catalog."default" NOT NULL,
    v_calle character varying(50) COLLATE pg_catalog."default" NOT NULL,
    n_numero numeric(3,0) NOT NULL,
    n_id_direccion numeric(10,0) NOT NULL,
    n_cod_p_cod_postal numeric(5,0) NOT NULL,
    CONSTRAINT direccionv1_pk PRIMARY KEY (n_id_direccion),
    CONSTRAINT direccion_cod_p_fk FOREIGN KEY (n_cod_p_cod_postal)
        REFERENCES public.cod_p (n_cod_postal) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)


CREATE TABLE IF NOT EXISTS public.sucursal
(
    v_clave_suc character varying(20) COLLATE pg_catalog."default" NOT NULL,
    n_telefono numeric(12,0) NOT NULL,
    "n_año_fundacion" numeric(4,0) NOT NULL,
    n_direccion_id_direccion numeric(10,0) NOT NULL,
    CONSTRAINT sucursal_pk PRIMARY KEY (v_clave_suc),
    CONSTRAINT sucursal_direccion_fk FOREIGN KEY (n_direccion_id_direccion)
        REFERENCES public.direccion (n_id_direccion) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.empleado
(
    n_clave_emp numeric(5,0) NOT NULL,
    v_rfc_emp character varying(13) COLLATE pg_catalog."default" NOT NULL,
    d_fecha_ing date NOT NULL,
    v_curp character varying(18) COLLATE pg_catalog."default" NOT NULL,
    v_email_emp character varying(70) COLLATE pg_catalog."default" NOT NULL,
    v_nombre character varying(50) COLLATE pg_catalog."default" NOT NULL,
    v_ap_paterno character varying(50) COLLATE pg_catalog."default" NOT NULL,
    v_ap_mat character varying(50) COLLATE pg_catalog."default" NOT NULL,
    n_empleado_clave_emp numeric(5,0),
    v_sucursal_clave_suc character varying(20) COLLATE pg_catalog."default" NOT NULL,
    v_tipo character varying(15) COLLATE pg_catalog."default" NOT NULL,
    n_direccion_id_direccion numeric(10,0) NOT NULL,
    "t_contraseña" text COLLATE pg_catalog."default",
    CONSTRAINT empleado_pk PRIMARY KEY (n_clave_emp),
    CONSTRAINT empleado_direccion_fk FOREIGN KEY (n_direccion_id_direccion)
        REFERENCES public.direccion (n_id_direccion) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT empleado_empleado_fk FOREIGN KEY (n_empleado_clave_emp)
        REFERENCES public.empleado (n_clave_emp) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT empleado_sucursal_fk FOREIGN KEY (v_sucursal_clave_suc)
        REFERENCES public.sucursal (v_clave_suc) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.telefonos
(
    n_num_tel numeric(12,0) NOT NULL,
    n_empleado_clave_emp numeric(5,0) NOT NULL,
    CONSTRAINT telefonos_pk PRIMARY KEY (n_num_tel, n_empleado_clave_emp),
    CONSTRAINT telefonos_empleado_fk FOREIGN KEY (n_empleado_clave_emp)
        REFERENCES public.empleado (n_clave_emp) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.cliente
(
    v_rfc_client character varying(13) COLLATE pg_catalog."default" NOT NULL,
    v_razon_social character varying(150) COLLATE pg_catalog."default",
    v_nombre character varying(50) COLLATE pg_catalog."default",
    v_ap_paterno character varying(50) COLLATE pg_catalog."default",
    v_ap_materno character varying(50) COLLATE pg_catalog."default",
    n_telefono numeric(12,0),
    v_email character varying(70) COLLATE pg_catalog."default",
    n_direccion_id_direccion numeric(10,0),
    "t_contraseña" text COLLATE pg_catalog."default",
    CONSTRAINT cliente_pk PRIMARY KEY (v_rfc_client),
    CONSTRAINT cliente_direccion_fk FOREIGN KEY (n_direccion_id_direccion)
        REFERENCES public.direccion (n_id_direccion) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.venta
(
    d_fecha date NOT NULL,
    v_folio character varying(20) COLLATE pg_catalog."default" NOT NULL,
    n_monto_total numeric(8,2) NOT NULL,
    n_cant_totalart numeric(6,0) NOT NULL,
    v_cliente_rfc_client character varying(13) COLLATE pg_catalog."default" NOT NULL,
    v_folio_facturacion character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT venta_pk PRIMARY KEY (v_folio),
    CONSTRAINT venta_cliente_fk FOREIGN KEY (v_cliente_rfc_client)
        REFERENCES public.cliente (v_rfc_client) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.venta_empleado
(
    v_venta_folio character varying(20) COLLATE pg_catalog."default" NOT NULL,
    n_empleado_clave_emp numeric(5,0) NOT NULL,
    CONSTRAINT venta_empleado_pk PRIMARY KEY (v_venta_folio, n_empleado_clave_emp),
    CONSTRAINT venta_empleado_empleado_fk FOREIGN KEY (n_empleado_clave_emp)
        REFERENCES public.empleado (n_clave_emp) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT venta_empleado_venta_fk FOREIGN KEY (v_venta_folio)
        REFERENCES public.venta (v_folio) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

CREATE TABLE IF NOT EXISTS public.articulo_venta
(
    v_articulo_cod_barras character varying(20) COLLATE pg_catalog."default" NOT NULL,
    v_venta_folio character varying(20) COLLATE pg_catalog."default" NOT NULL,
    n_cantidad numeric(6,0) NOT NULL,
    CONSTRAINT tiene_articulo_fk FOREIGN KEY (v_articulo_cod_barras)
        REFERENCES public.articulo (v_cod_barras) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT tiene_venta_fk FOREIGN KEY (v_venta_folio)
        REFERENCES public.venta (v_folio) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)


CREATE TABLE IF NOT EXISTS public.provedor
(
    v_rfc_prov character varying(13) COLLATE pg_catalog."default" NOT NULL,
    v_razon_socialpv character varying(150) COLLATE pg_catalog."default" NOT NULL,
    n_telefono_prov numeric(12,0) NOT NULL,
    n_cuenta_pago numeric(10,0) NOT NULL,
    n_direccion_id_direccion numeric(10,0) NOT NULL,
    "t_contraseña" text COLLATE pg_catalog."default",
    CONSTRAINT provedor_pk PRIMARY KEY (v_rfc_prov),
    CONSTRAINT provedor_direccion_fk FOREIGN KEY (n_direccion_id_direccion)
        REFERENCES public.direccion (n_id_direccion) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.articulo_provedor
(
    v_articulo_cod_barras character varying(20) COLLATE pg_catalog."default" NOT NULL,
    v_provedor_rfc_prov character varying(13) COLLATE pg_catalog."default" NOT NULL,
    d_f_inicio_surtido date NOT NULL,
    CONSTRAINT articulo_provedor_pk PRIMARY KEY (v_articulo_cod_barras, v_provedor_rfc_prov),
    CONSTRAINT provedor_articulo_fk FOREIGN KEY (v_articulo_cod_barras)
        REFERENCES public.articulo (v_cod_barras) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT provedor_provedor_fk FOREIGN KEY (v_provedor_rfc_prov)
        REFERENCES public.provedor (v_rfc_prov) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
