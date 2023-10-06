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


-- object: public."DIRECTOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."DIRECTOR" CASCADE;
CREATE TABLE public."DIRECTOR" (
	ced_prof int4 NOT NULL,
	nombre varchar(120) NOT NULL,
	telefono int4 NOT NULL,
	"clave_FACULTAD" smallint NOT NULL,
	CONSTRAINT "DIRECTOR_pk" PRIMARY KEY (ced_prof)

);
-- ddl-end --
ALTER TABLE public."DIRECTOR" OWNER TO postgres;
-- ddl-end --

-- object: public."PROFESOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROFESOR" CASCADE;
CREATE TABLE public."PROFESOR" (
	nombre varchar(120) NOT NULL,
	ced_prof int4 NOT NULL,
	salario float4 NOT NULL,
	grado varchar(25) NOT NULL,
	email varchar(100) NOT NULL,
	"clave_FACULTAD" smallint NOT NULL,
	CONSTRAINT "PROFESOR_pk" PRIMARY KEY (ced_prof)

);
-- ddl-end --
ALTER TABLE public."PROFESOR" OWNER TO postgres;
-- ddl-end --

-- object: public."FACULTAD" | type: TABLE --
-- DROP TABLE IF EXISTS public."FACULTAD" CASCADE;
CREATE TABLE public."FACULTAD" (
	clave smallint NOT NULL,
	ubicacion text NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT "FACULTAD_pk" PRIMARY KEY (clave)

);
-- ddl-end --
ALTER TABLE public."FACULTAD" OWNER TO postgres;
-- ddl-end --

-- object: public."ALUMNO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ALUMNO" CASCADE;
CREATE TABLE public."ALUMNO" (
	curp varchar(18) NOT NULL,
	nombre varchar(100) NOT NULL,
	direccion text NOT NULL,
	edad smallint NOT NULL,
	CONSTRAINT "ALUMNO_pk" PRIMARY KEY (curp)

);
-- ddl-end --
ALTER TABLE public."ALUMNO" OWNER TO postgres;
-- ddl-end --

-- object: public."MATERIA" | type: TABLE --
-- DROP TABLE IF EXISTS public."MATERIA" CASCADE;
CREATE TABLE public."MATERIA" (
	clave_materia smallint NOT NULL,
	nombre varchar(80) NOT NULL,
	CONSTRAINT "MATERIA_pk" PRIMARY KEY (clave_materia)

);
-- ddl-end --
ALTER TABLE public."MATERIA" OWNER TO postgres;
-- ddl-end --

-- object: "FACULTAD_fk" | type: CONSTRAINT --
-- ALTER TABLE public."DIRECTOR" DROP CONSTRAINT IF EXISTS "FACULTAD_fk" CASCADE;
ALTER TABLE public."DIRECTOR" ADD CONSTRAINT "FACULTAD_fk" FOREIGN KEY ("clave_FACULTAD")
REFERENCES public."FACULTAD" (clave) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "DIRECTOR_uq" | type: CONSTRAINT --
-- ALTER TABLE public."DIRECTOR" DROP CONSTRAINT IF EXISTS "DIRECTOR_uq" CASCADE;
ALTER TABLE public."DIRECTOR" ADD CONSTRAINT "DIRECTOR_uq" UNIQUE ("clave_FACULTAD");
-- ddl-end --

-- object: "FACULTAD_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PROFESOR" DROP CONSTRAINT IF EXISTS "FACULTAD_fk" CASCADE;
ALTER TABLE public."PROFESOR" ADD CONSTRAINT "FACULTAD_fk" FOREIGN KEY ("clave_FACULTAD")
REFERENCES public."FACULTAD" (clave) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.imparte | type: TABLE --
-- DROP TABLE IF EXISTS public.imparte CASCADE;
CREATE TABLE public.imparte (
	"ced_prof_PROFESOR" int4 NOT NULL,
	"clave_materia_MATERIA" smallint NOT NULL,
	id serial NOT NULL,
	CONSTRAINT imparte_pk PRIMARY KEY (id)

);
-- ddl-end --

-- object: "PROFESOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public.imparte DROP CONSTRAINT IF EXISTS "PROFESOR_fk" CASCADE;
ALTER TABLE public.imparte ADD CONSTRAINT "PROFESOR_fk" FOREIGN KEY ("ced_prof_PROFESOR")
REFERENCES public."PROFESOR" (ced_prof) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "MATERIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public.imparte DROP CONSTRAINT IF EXISTS "MATERIA_fk" CASCADE;
ALTER TABLE public.imparte ADD CONSTRAINT "MATERIA_fk" FOREIGN KEY ("clave_materia_MATERIA")
REFERENCES public."MATERIA" (clave_materia) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.inscribe | type: TABLE --
-- DROP TABLE IF EXISTS public.inscribe CASCADE;
CREATE TABLE public.inscribe (
	"curp_ALUMNO" varchar(18) NOT NULL,
	"clave_materia_MATERIA" smallint NOT NULL,
	CONSTRAINT inscribe_pk PRIMARY KEY ("curp_ALUMNO","clave_materia_MATERIA")

);
-- ddl-end --

-- object: "ALUMNO_fk" | type: CONSTRAINT --
-- ALTER TABLE public.inscribe DROP CONSTRAINT IF EXISTS "ALUMNO_fk" CASCADE;
ALTER TABLE public.inscribe ADD CONSTRAINT "ALUMNO_fk" FOREIGN KEY ("curp_ALUMNO")
REFERENCES public."ALUMNO" (curp) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "MATERIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public.inscribe DROP CONSTRAINT IF EXISTS "MATERIA_fk" CASCADE;
ALTER TABLE public.inscribe ADD CONSTRAINT "MATERIA_fk" FOREIGN KEY ("clave_materia_MATERIA")
REFERENCES public."MATERIA" (clave_materia) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


