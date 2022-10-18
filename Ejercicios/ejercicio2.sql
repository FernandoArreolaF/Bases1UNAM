-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public.venta | type: TABLE --
-- DROP TABLE IF EXISTS public.venta CASCADE;
CREATE TABLE public.venta (
	id_venta int4 NOT NULL,
	fecha_venta int4 NOT NULL,
	monto_final int4 NOT NULL,
	CONSTRAINT venta_pk PRIMARY KEY (id_venta)

);
-- ddl-end --
COMMENT ON COLUMN public.venta.monto_final IS E'atributo calculado';
-- ddl-end --
ALTER TABLE public.venta OWNER TO postgres;
-- ddl-end --

-- object: public.producto | type: TABLE --
-- DROP TABLE IF EXISTS public.producto CASCADE;
CREATE TABLE public.producto (
	id_producto int4 NOT NULL,
	foto bytea NOT NULL,
	stock int4,
	CONSTRAINT producto_pk PRIMARY KEY (id_producto)

);
-- ddl-end --
ALTER TABLE public.producto OWNER TO postgres;
-- ddl-end --

-- object: public.many_venta_has_many_producto | type: TABLE --
-- DROP TABLE IF EXISTS public.many_venta_has_many_producto CASCADE;
CREATE TABLE public.many_venta_has_many_producto (
	id_venta_venta int4 NOT NULL,
	id_producto_producto int4 NOT NULL,
	cantidad smallint NOT NULL,
	CONSTRAINT many_venta_has_many_producto_pk PRIMARY KEY (id_venta_venta,id_producto_producto)

);
-- ddl-end --

-- object: venta_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_venta_has_many_producto DROP CONSTRAINT IF EXISTS venta_fk CASCADE;
ALTER TABLE public.many_venta_has_many_producto ADD CONSTRAINT venta_fk FOREIGN KEY (id_venta_venta)
REFERENCES public.venta (id_venta) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_venta_has_many_producto DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.many_venta_has_many_producto ADD CONSTRAINT producto_fk FOREIGN KEY (id_producto_producto)
REFERENCES public.producto (id_producto) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


