-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public."CLIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."CLIENTE" CASCADE;
CREATE TABLE public."CLIENTE" (
	"idCliente" int4 NOT NULL,
	"apPat" varchar(50) NOT NULL,
	"apMat" varchar(50),
	nombre varchar(50) NOT NULL,
	cp int4 NOT NULL,
	numero int4 NOT NULL,
	calle varchar(80) NOT NULL,
	CONSTRAINT "CLIENTE_pk" PRIMARY KEY ("idCliente")
);
-- ddl-end --
ALTER TABLE public."CLIENTE" OWNER TO postgres;
-- ddl-end --

-- object: public."TELEFONO_CLIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."TELEFONO_CLIENTE" CASCADE;
CREATE TABLE public."TELEFONO_CLIENTE" (
	telefono int4 NOT NULL,
	"idCliente_CLIENTE" int4,
	CONSTRAINT "TELEFONO_CLIENTE_pk" PRIMARY KEY (telefono)
);
-- ddl-end --
ALTER TABLE public."TELEFONO_CLIENTE" OWNER TO postgres;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."TELEFONO_CLIENTE" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public."TELEFONO_CLIENTE" ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("idCliente_CLIENTE")
REFERENCES public."CLIENTE" ("idCliente") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."VENTA" CASCADE;
CREATE TABLE public."VENTA" (
	"idVenta" int4 NOT NULL,
	fecha date NOT NULL,
	"montoFinal" int4 NOT NULL,
	"idCliente_CLIENTE" int4,
	CONSTRAINT "VENTA_pk" PRIMARY KEY ("idVenta")
);
-- ddl-end --
ALTER TABLE public."VENTA" OWNER TO postgres;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("idCliente_CLIENTE")
REFERENCES public."CLIENTE" ("idCliente") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."PROVEEDOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROVEEDOR" CASCADE;
CREATE TABLE public."PROVEEDOR" (
	"idProv" int4 NOT NULL,
	"pagWeb" varchar(150) NOT NULL,
	nombre varchar(200) NOT NULL,
	cp smallint NOT NULL,
	calle varchar(80) NOT NULL,
	numero smallint NOT NULL,
	ciudad varchar(50) NOT NULL,
	telefono int4 NOT NULL,
	CONSTRAINT "PROVEEDOR_pk" PRIMARY KEY ("idProv")
);
-- ddl-end --
ALTER TABLE public."PROVEEDOR" OWNER TO postgres;
-- ddl-end --

-- object: public."CATEGORIA" | type: TABLE --
-- DROP TABLE IF EXISTS public."CATEGORIA" CASCADE;
CREATE TABLE public."CATEGORIA" (
	"idCat" int4 NOT NULL,
	nombre varchar(50) NOT NULL,
	descripcion text NOT NULL,
	CONSTRAINT "CATEGORIA_pk" PRIMARY KEY ("idCat")
);
-- ddl-end --
ALTER TABLE public."CATEGORIA" OWNER TO postgres;
-- ddl-end --

-- object: public."PRODUCTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."PRODUCTO" CASCADE;
CREATE TABLE public."PRODUCTO" (
	"idProd" int4 NOT NULL,
	foto bytea NOT NULL,
	"precioActual" int4 NOT NULL,
	stock int4 NOT NULL,
	nombre varchar(80) NOT NULL,
	"idCat_CATEGORIA" int4,
	"idProv_PROVEEDOR" int4,
	CONSTRAINT "PRODUCTO_pk" PRIMARY KEY ("idProd")
);
-- ddl-end --
ALTER TABLE public."PRODUCTO" OWNER TO postgres;
-- ddl-end --

-- object: public.guardar | type: TABLE --
-- DROP TABLE IF EXISTS public.guardar CASCADE;
CREATE TABLE public.guardar (
	"idVenta_VENTA" int4 NOT NULL,
	"idProd_PRODUCTO" int4 NOT NULL,
	"montoXProducto" float NOT NULL,
	cantidad smallint NOT NULL,
	CONSTRAINT guardar_pk PRIMARY KEY ("idVenta_VENTA","idProd_PRODUCTO")
);
-- ddl-end --

-- object: "VENTA_fk" | type: CONSTRAINT --
-- ALTER TABLE public.guardar DROP CONSTRAINT IF EXISTS "VENTA_fk" CASCADE;
ALTER TABLE public.guardar ADD CONSTRAINT "VENTA_fk" FOREIGN KEY ("idVenta_VENTA")
REFERENCES public."VENTA" ("idVenta") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PRODUCTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public.guardar DROP CONSTRAINT IF EXISTS "PRODUCTO_fk" CASCADE;
ALTER TABLE public.guardar ADD CONSTRAINT "PRODUCTO_fk" FOREIGN KEY ("idProd_PRODUCTO")
REFERENCES public."PRODUCTO" ("idProd") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CATEGORIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCTO" DROP CONSTRAINT IF EXISTS "CATEGORIA_fk" CASCADE;
ALTER TABLE public."PRODUCTO" ADD CONSTRAINT "CATEGORIA_fk" FOREIGN KEY ("idCat_CATEGORIA")
REFERENCES public."CATEGORIA" ("idCat") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "PROVEEDOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCTO" DROP CONSTRAINT IF EXISTS "PROVEEDOR_fk" CASCADE;
ALTER TABLE public."PRODUCTO" ADD CONSTRAINT "PROVEEDOR_fk" FOREIGN KEY ("idProv_PROVEEDOR")
REFERENCES public."PROVEEDOR" ("idProv") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


