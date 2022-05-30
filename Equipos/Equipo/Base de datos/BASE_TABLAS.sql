CREATE DATABASE "Proyecto"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Mexico.1252'
    LC_CTYPE = 'Spanish_Mexico.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


CREATE TABLE IF NOT EXISTS public.categoria
(
    id_categoria integer NOT NULL,
    nombre_categoria character varying(8) COLLATE pg_catalog."default" NOT NULL,
    descripcion character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria)
);

CREATE TABLE IF NOT EXISTS public.cliente
(
    rfc character varying(13) COLLATE pg_catalog."default" NOT NULL,
    razon_social character varying(55) COLLATE pg_catalog."default" NOT NULL,
    nombre character varying(50) COLLATE pg_catalog."default",
    ap_paterno character varying(30) COLLATE pg_catalog."default",
    ap_materno character varying(30) COLLATE pg_catalog."default",
    calle character varying(45) COLLATE pg_catalog."default",
    no_exterior character varying(10) COLLATE pg_catalog."default",
    colonia character varying(45) COLLATE pg_catalog."default",
    estado character varying(18) COLLATE pg_catalog."default",
    cp character varying(5) COLLATE pg_catalog."default",
    fecha_nacimiento date,
    email character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT cliente_pkey PRIMARY KEY (rfc)
);

CREATE TABLE IF NOT EXISTS public.dependiente
(
    curp character varying(18) COLLATE pg_catalog."default" NOT NULL,
    no_empleado text COLLATE pg_catalog."default" NOT NULL,
    nombre character varying(30) COLLATE pg_catalog."default" NOT NULL,
    ap_paterno character varying(25) COLLATE pg_catalog."default" NOT NULL,
    ap_materno character varying(25) COLLATE pg_catalog."default",
    parentesco character varying(14) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "dependiente_PK" PRIMARY KEY (curp, no_empleado)
);

CREATE TABLE IF NOT EXISTS public.empleado
(
    no_empleado text COLLATE pg_catalog."default" NOT NULL DEFAULT ('EMP-'::text || lpad((nextval('emp_seq'::regclass))::text, 3, '0'::text)),
    rfc character varying(13) COLLATE pg_catalog."default" NOT NULL,
    nombre character varying(20) COLLATE pg_catalog."default" NOT NULL,
    ap_paterno character varying(25) COLLATE pg_catalog."default" NOT NULL,
    ap_materno character varying(25) COLLATE pg_catalog."default",
    calle character varying(30) COLLATE pg_catalog."default" NOT NULL,
    no_exterior character varying(9) COLLATE pg_catalog."default" NOT NULL,
    colonia character varying(30) COLLATE pg_catalog."default" NOT NULL,
    estado character varying(20) COLLATE pg_catalog."default" NOT NULL,
    cp character varying(5) COLLATE pg_catalog."default" NOT NULL,
    fecha_nacimiento date NOT NULL,
    edad integer,
    sueldo integer NOT NULL,
    especialidad character varying(25) COLLATE pg_catalog."default",
    rol character varying(25) COLLATE pg_catalog."default",
    horario character varying(12) COLLATE pg_catalog."default",
    foto character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_No_Empleado" PRIMARY KEY (no_empleado)
);

CREATE TABLE IF NOT EXISTS public.orden
(
    folio text COLLATE pg_catalog."default" NOT NULL DEFAULT ('ORD-'::text || lpad((nextval('folio_seq'::regclass))::text, 3, '0'::text)),
    fecha date NOT NULL DEFAULT (now())::date,
    monto_final integer DEFAULT 0,
    no_empleado text COLLATE pg_catalog."default" NOT NULL,
    rfc_cte character varying(13) COLLATE pg_catalog."default",
    CONSTRAINT orden_pkey PRIMARY KEY (folio)
);

CREATE TABLE IF NOT EXISTS public.orden_producto
(
    id_producto integer NOT NULL,
    folio text COLLATE pg_catalog."default" NOT NULL,
    cantidad smallint NOT NULL,
    precio_total_por_producto integer DEFAULT 0,
    CONSTRAINT "orden_producto_PK" PRIMARY KEY (id_producto, folio)
);

CREATE TABLE IF NOT EXISTS public.producto
(
    id_producto integer NOT NULL DEFAULT nextval('producto_id_producto_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default" NOT NULL,
    descripcion character varying(350) COLLATE pg_catalog."default" NOT NULL,
    receta character varying(350) COLLATE pg_catalog."default" NOT NULL,
    disponibilidad boolean NOT NULL,
    id_categoria integer NOT NULL,
    precio integer NOT NULL,
    ventas integer DEFAULT 0,
    CONSTRAINT producto_pkey PRIMARY KEY (id_producto)
);

CREATE TABLE IF NOT EXISTS public.telefono
(
    telefono character varying(18) COLLATE pg_catalog."default" NOT NULL,
    no_empleado text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT telefono_pkey PRIMARY KEY (telefono)
);

ALTER TABLE IF EXISTS public.dependiente
    ADD CONSTRAINT "Empleado_Dependiente_no_empleado_FK" FOREIGN KEY (no_empleado)
    REFERENCES public.empleado (no_empleado) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
CREATE INDEX IF NOT EXISTS "fki_Empleado_Dependiente_no_empleado_FK"
    ON public.dependiente(no_empleado);


ALTER TABLE IF EXISTS public.orden
    ADD CONSTRAINT "orden_cliente_rfc_FK" FOREIGN KEY (rfc_cte)
    REFERENCES public.cliente (rfc) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
CREATE INDEX IF NOT EXISTS "fki_orden_cliente_rfc_FK"
    ON public.orden(rfc_cte);


ALTER TABLE IF EXISTS public.orden
    ADD CONSTRAINT "orden_empleado_no_empleado_FK" FOREIGN KEY (no_empleado)
    REFERENCES public.empleado (no_empleado) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
CREATE INDEX IF NOT EXISTS "fki_orden_empleado_no_empleado_FK"
    ON public.orden(no_empleado);


ALTER TABLE IF EXISTS public.orden_producto
    ADD CONSTRAINT "orden_orden_prod_folio_FK" FOREIGN KEY (folio)
    REFERENCES public.orden (folio) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
CREATE INDEX IF NOT EXISTS "fki_orden_orden_prod_folio_FK"
    ON public.orden_producto(folio);


ALTER TABLE IF EXISTS public.orden_producto
    ADD CONSTRAINT "producto_orden_prod_id_prod_FK" FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.producto
    ADD CONSTRAINT "producto_categoria_id_categoria_FK" FOREIGN KEY (id_categoria)
    REFERENCES public.categoria (id_categoria) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.telefono
    ADD CONSTRAINT "telefono_emp_no_emp_FK" FOREIGN KEY (no_empleado)
    REFERENCES public.empleado (no_empleado) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE RESTRICT
    NOT VALID;
CREATE INDEX IF NOT EXISTS "fki_telefono_emp_no_emp_FK"
    ON public.telefono(no_empleado);

