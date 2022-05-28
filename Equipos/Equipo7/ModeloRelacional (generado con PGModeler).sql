-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 14.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: "proyectoFinal" | type: DATABASE --
-- DROP DATABASE IF EXISTS "proyectoFinal";
CREATE DATABASE "proyectoFinal"
	OWNER = postgres;
-- ddl-end --


-- object: public."EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMPLEADO" CASCADE;
CREATE TABLE public."EMPLEADO" (
	num_empleado int4 NOT NULL,
	ap_paterno varchar(30) NOT NULL,
	ap_mateno varchar(30) NOT NULL,
	nombre varchar(30) NOT NULL,
	edad smallint NOT NULL,
	rfc varchar(13) NOT NULL,
	fecha_nac date NOT NULL,
	sueldo int4 NOT NULL,
	foto varchar(100),
	estado varchar(30) NOT NULL,
	colonia varchar(60) NOT NULL,
	calle varchar(60) NOT NULL,
	numero smallint NOT NULL,
	cp int4 NOT NULL,
	admin_rol varchar(50),
	cocin_especialidad varchar(50),
	mesero_hora_inicio time,
	mesero_hora_fin time,
	CONSTRAINT "EMPLEADO_pk" PRIMARY KEY (num_empleado)
);
-- ddl-end --
ALTER TABLE public."EMPLEADO" OWNER TO postgres;
-- ddl-end --

-- object: public."CLIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."CLIENTE" CASCADE;
CREATE TABLE public."CLIENTE" (
	rfc varchar(13) NOT NULL,
	ap_paterno varchar(30) NOT NULL,
	ap_mateno varchar(30) NOT NULL,
	nombre varchar(30) NOT NULL,
	estado varchar(30) NOT NULL,
	colonia varchar(60) NOT NULL,
	calle varchar(60) NOT NULL,
	numero smallint NOT NULL,
	cp int4 NOT NULL,
	fecha_nac date NOT NULL,
	razon_social varchar(10),
	email varchar(50) NOT NULL,
	CONSTRAINT "CLIENTE_pk" PRIMARY KEY (rfc)
);
-- ddl-end --
ALTER TABLE public."CLIENTE" OWNER TO postgres;
-- ddl-end --

-- object: public."DEPENDIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."DEPENDIENTE" CASCADE;
CREATE TABLE public."DEPENDIENTE" (
	curp char(18) NOT NULL,
	ap_paterno varchar(30) NOT NULL,
	ap_mateno varchar(30) NOT NULL,
	nombre varchar(30) NOT NULL,
	parentesco varchar(30) NOT NULL,
	"num_empleado_EMPLEADO" int4 NOT NULL,
	CONSTRAINT "DEPENDIENTE_pk" PRIMARY KEY (curp)
);
-- ddl-end --
ALTER TABLE public."DEPENDIENTE" OWNER TO postgres;
-- ddl-end --

-- object: public."CATEGORIA" | type: TABLE --
-- DROP TABLE IF EXISTS public."CATEGORIA" CASCADE;
CREATE TABLE public."CATEGORIA" (
	nombre varchar(20) NOT NULL,
	descripcion varchar(150) NOT NULL,
	CONSTRAINT "CATEGORIA_pk" PRIMARY KEY (nombre)
);
-- ddl-end --
ALTER TABLE public."CATEGORIA" OWNER TO postgres;
-- ddl-end --

-- object: public."PRODUCTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."PRODUCTO" CASCADE;
CREATE TABLE public."PRODUCTO" (
	nombre varchar(30) NOT NULL,
	descripcion varchar(200) NOT NULL,
	precio float NOT NULL,
	disponibilidad boolean NOT NULL,
	receta varchar(5000),
	tipo char(1) NOT NULL,
	"num_empleado_EMPLEADO" int4 NOT NULL,
	"nombre_CATEGORIA" varchar(20) NOT NULL,
	CONSTRAINT "PRODUCTO_pk" PRIMARY KEY (nombre)
);
-- ddl-end --
ALTER TABLE public."PRODUCTO" OWNER TO postgres;
-- ddl-end --

-- object: public."ORDEN" | type: TABLE --
-- DROP TABLE IF EXISTS public."ORDEN" CASCADE;
CREATE TABLE public."ORDEN" (
	folio char(7) NOT NULL,
	total float NOT NULL,
	fecha date NOT NULL,
	"num_empleado_EMPLEADO" int4 NOT NULL,
	"rfc_CLIENTE" varchar(13),
	CONSTRAINT "ORDEN_pk" PRIMARY KEY (folio)
);
-- ddl-end --
ALTER TABLE public."ORDEN" OWNER TO postgres;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCTO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."PRODUCTO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("num_empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CATEGORIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCTO" DROP CONSTRAINT IF EXISTS "CATEGORIA_fk" CASCADE;
ALTER TABLE public."PRODUCTO" ADD CONSTRAINT "CATEGORIA_fk" FOREIGN KEY ("nombre_CATEGORIA")
REFERENCES public."CATEGORIA" (nombre) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."DEPENDIENTE" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."DEPENDIENTE" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("num_empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."TELEFONO" | type: TABLE --
-- DROP TABLE IF EXISTS public."TELEFONO" CASCADE;
CREATE TABLE public."TELEFONO" (
	telefono int8 NOT NULL,
	"num_empleado_EMPLEADO" int4 NOT NULL,
	CONSTRAINT "TELEFONO_pk" PRIMARY KEY (telefono)
);
-- ddl-end --
ALTER TABLE public."TELEFONO" OWNER TO postgres;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."TELEFONO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."TELEFONO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("num_empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ORDEN" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."ORDEN" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("num_empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."many_PRODUCTO_has_many_ORDEN" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_PRODUCTO_has_many_ORDEN" CASCADE;
CREATE TABLE public."many_PRODUCTO_has_many_ORDEN" (
	"nombre_PRODUCTO" varchar(30) NOT NULL,
	"folio_ORDEN" char(7) NOT NULL,
	total_por_producto float NOT NULL,
	cantidad smallint NOT NULL,
	CONSTRAINT "many_PRODUCTO_has_many_ORDEN_pk" PRIMARY KEY ("nombre_PRODUCTO","folio_ORDEN")
);
-- ddl-end --

-- object: "PRODUCTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_PRODUCTO_has_many_ORDEN" DROP CONSTRAINT IF EXISTS "PRODUCTO_fk" CASCADE;
ALTER TABLE public."many_PRODUCTO_has_many_ORDEN" ADD CONSTRAINT "PRODUCTO_fk" FOREIGN KEY ("nombre_PRODUCTO")
REFERENCES public."PRODUCTO" (nombre) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "ORDEN_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_PRODUCTO_has_many_ORDEN" DROP CONSTRAINT IF EXISTS "ORDEN_fk" CASCADE;
ALTER TABLE public."many_PRODUCTO_has_many_ORDEN" ADD CONSTRAINT "ORDEN_fk" FOREIGN KEY ("folio_ORDEN")
REFERENCES public."ORDEN" (folio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ORDEN" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public."ORDEN" ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("rfc_CLIENTE")
REFERENCES public."CLIENTE" (rfc) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: postgis | type: EXTENSION --
-- DROP EXTENSION IF EXISTS postgis CASCADE;
CREATE EXTENSION postgis
WITH SCHEMA public;
-- ddl-end --


