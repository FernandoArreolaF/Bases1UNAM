-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.3
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public."PRODUCTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."PRODUCTO" CASCADE;
CREATE TABLE public."PRODUCTO" (
	codigo_barras bigint NOT NULL,
	precio_venta numeric(8) NOT NULL,
	precio_compra numeric(8) NOT NULL,
	fotografia bytea NOT NULL,
	stock smallint NOT NULL,
	"id_categoria_CATEGORIA" integer NOT NULL,
	nombre character varying(40) NOT NULL,
	CONSTRAINT "PRODUCTO_pk" PRIMARY KEY (codigo_barras)
);
-- ddl-end --
ALTER TABLE public."PRODUCTO" OWNER TO postgres;
-- ddl-end --

-- object: public."CATEGORIA" | type: TABLE --
-- DROP TABLE IF EXISTS public."CATEGORIA" CASCADE;
CREATE TABLE public."CATEGORIA" (
	id_categoria integer NOT NULL,
	marca character varying(50) NOT NULL,
	descripcion text NOT NULL,
	CONSTRAINT "CATEGORIA_pk" PRIMARY KEY (id_categoria)
);
-- ddl-end --
ALTER TABLE public."CATEGORIA" OWNER TO postgres;
-- ddl-end --

-- object: public."PROVEEDOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROVEEDOR" CASCADE;
CREATE TABLE public."PROVEEDOR" (
	rfc_provedor character(13) NOT NULL,
	nombre character varying(60) NOT NULL,
	ap_paterno character varying(60) NOT NULL,
	ap_materno character varying(60),
	CONSTRAINT "PROVEEDOR_pk" PRIMARY KEY (rfc_provedor)
);
-- ddl-end --
ALTER TABLE public."PROVEEDOR" OWNER TO postgres;
-- ddl-end --

-- object: public."CLIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."CLIENTE" CASCADE;
CREATE TABLE public."CLIENTE" (
	rfc_cliente character(13) NOT NULL,
	nombre varchar(60) NOT NULL,
	ap_paterno varchar(60) NOT NULL,
	ap_materno varchar(60),
	calle varchar(70) NOT NULL,
	numero smallint NOT NULL,
	estado varchar(60) NOT NULL,
	colonia varchar(60) NOT NULL,
	cp integer NOT NULL,
	CONSTRAINT "CLIENTE_pk" PRIMARY KEY (rfc_cliente)
);
-- ddl-end --
ALTER TABLE public."CLIENTE" OWNER TO postgres;
-- ddl-end --

-- object: public."SUCURSAL" | type: TABLE --
-- DROP TABLE IF EXISTS public."SUCURSAL" CASCADE;
CREATE TABLE public."SUCURSAL" (
	id_sucursal character varying(10) NOT NULL,
	razon_social character varying(100) NOT NULL,
	calle character varying(70) NOT NULL,
	numero smallint NOT NULL,
	estado character varying(60) NOT NULL,
	colonia character varying(60) NOT NULL,
	cp smallint NOT NULL,
	CONSTRAINT "SUCURSAL_pk" PRIMARY KEY (id_sucursal),
	CONSTRAINT razon_social UNIQUE (id_sucursal,razon_social)
);
-- ddl-end --
ALTER TABLE public."SUCURSAL" OWNER TO postgres;
-- ddl-end --

-- object: public."VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."VENTA" CASCADE;
CREATE TABLE public."VENTA" (
	id_venta character varying(10) NOT NULL,
	fecha date NOT NULL,
	monto_final double precision NOT NULL,
	"rfc_cliente_CLIENTE" character(13) NOT NULL,
	"id_sucursal_SUCURSAL" character varying(10) NOT NULL,
	CONSTRAINT "VENTA_pk" PRIMARY KEY (id_venta)
);
-- ddl-end --
ALTER TABLE public."VENTA" OWNER TO postgres;
-- ddl-end --

-- object: public.telefono | type: TABLE --
-- DROP TABLE IF EXISTS public.telefono CASCADE;
CREATE TABLE public.telefono (
	num_telefono bigint NOT NULL,
	"rfc_provedor_PROVEEDOR" character(13) NOT NULL,
	CONSTRAINT telefono_pk PRIMARY KEY (num_telefono)
);
-- ddl-end --
ALTER TABLE public.telefono OWNER TO postgres;
-- ddl-end --

-- object: public."GUARDA" | type: TABLE --
-- DROP TABLE IF EXISTS public."GUARDA" CASCADE;
CREATE TABLE public."GUARDA" (
	"codigo_barras_PRODUCTO" bigint NOT NULL,
	"id_venta_VENTA" character varying(10) NOT NULL,
	cantidad_producto smallint NOT NULL,
	monto_producto float NOT NULL,
	CONSTRAINT "GUARDA_pk" PRIMARY KEY ("codigo_barras_PRODUCTO","id_venta_VENTA")
);
-- ddl-end --

-- object: "PRODUCTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."GUARDA" DROP CONSTRAINT IF EXISTS "PRODUCTO_fk" CASCADE;
ALTER TABLE public."GUARDA" ADD CONSTRAINT "PRODUCTO_fk" FOREIGN KEY ("codigo_barras_PRODUCTO")
REFERENCES public."PRODUCTO" (codigo_barras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "VENTA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."GUARDA" DROP CONSTRAINT IF EXISTS "VENTA_fk" CASCADE;
ALTER TABLE public."GUARDA" ADD CONSTRAINT "VENTA_fk" FOREIGN KEY ("id_venta_VENTA")
REFERENCES public."VENTA" (id_venta) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."SURTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."SURTE" CASCADE;
CREATE TABLE public."SURTE" (
	"rfc_provedor_PROVEEDOR" character(13) NOT NULL,
	"codigo_barras_PRODUCTO" bigint NOT NULL,
	fecha_surte date NOT NULL,
	CONSTRAINT "SURTE_pk" PRIMARY KEY ("rfc_provedor_PROVEEDOR","codigo_barras_PRODUCTO")
);
-- ddl-end --

-- object: "PROVEEDOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."SURTE" DROP CONSTRAINT IF EXISTS "PROVEEDOR_fk" CASCADE;
ALTER TABLE public."SURTE" ADD CONSTRAINT "PROVEEDOR_fk" FOREIGN KEY ("rfc_provedor_PROVEEDOR")
REFERENCES public."PROVEEDOR" (rfc_provedor) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PRODUCTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."SURTE" DROP CONSTRAINT IF EXISTS "PRODUCTO_fk" CASCADE;
ALTER TABLE public."SURTE" ADD CONSTRAINT "PRODUCTO_fk" FOREIGN KEY ("codigo_barras_PRODUCTO")
REFERENCES public."PRODUCTO" (codigo_barras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CATEGORIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCTO" DROP CONSTRAINT IF EXISTS "CATEGORIA_fk" CASCADE;
ALTER TABLE public."PRODUCTO" ADD CONSTRAINT "CATEGORIA_fk" FOREIGN KEY ("id_categoria_CATEGORIA")
REFERENCES public."CATEGORIA" (id_categoria) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PROVEEDOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public.telefono DROP CONSTRAINT IF EXISTS "PROVEEDOR_fk" CASCADE;
ALTER TABLE public.telefono ADD CONSTRAINT "PROVEEDOR_fk" FOREIGN KEY ("rfc_provedor_PROVEEDOR")
REFERENCES public."PROVEEDOR" (rfc_provedor) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("rfc_cliente_CLIENTE")
REFERENCES public."CLIENTE" (rfc_cliente) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "SUCURSAL_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "SUCURSAL_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "SUCURSAL_fk" FOREIGN KEY ("id_sucursal_SUCURSAL")
REFERENCES public."SUCURSAL" (id_sucursal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


