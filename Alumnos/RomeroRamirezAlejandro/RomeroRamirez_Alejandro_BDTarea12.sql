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


-- object: public."EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMPLEADO" CASCADE;
CREATE TABLE public."EMPLEADO" (
	calle varchar(60),
	"número" smallint,
	colonia varchar(60),
	ciudad varchar(60),
	sueldo float,
	curp varchar(18) NOT NULL,
	"número_Empleado" smallint NOT NULL,
	"número_Empleado_JEFE" smallint NOT NULL,
	"fecha_Inicio" date,
	CONSTRAINT "EMPLEADO_pk" PRIMARY KEY (curp,"número_Empleado")
);
-- ddl-end --
ALTER TABLE public."EMPLEADO" OWNER TO postgres;
-- ddl-end --

-- object: public."FAMILIAR" | type: TABLE --
-- DROP TABLE IF EXISTS public."FAMILIAR" CASCADE;
CREATE TABLE public."FAMILIAR" (
	parentesco varchar(60),
	nombre varchar(60),
	"fecha_Nacimiento" date,
	sexo varchar(1),
	"curp_EMPLEADO" varchar(18) NOT NULL,
	"número_Empleado_EMPLEADO" smallint NOT NULL

);
-- ddl-end --
ALTER TABLE public."FAMILIAR" OWNER TO postgres;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."FAMILIAR" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."FAMILIAR" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("curp_EMPLEADO","número_Empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (curp,"número_Empleado") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."JEFE" | type: TABLE --
-- DROP TABLE IF EXISTS public."JEFE" CASCADE;
CREATE TABLE public."JEFE" (
	"número_Empleado" smallint NOT NULL,
	CONSTRAINT "JEFE_pk" PRIMARY KEY ("número_Empleado")
);
-- ddl-end --
ALTER TABLE public."JEFE" OWNER TO postgres;
-- ddl-end --

-- object: "JEFE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "JEFE_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "JEFE_fk" FOREIGN KEY ("número_Empleado_JEFE")
REFERENCES public."JEFE" ("número_Empleado") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."PROYECTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROYECTO" CASCADE;
CREATE TABLE public."PROYECTO" (
	"número_Proyecto" smallint NOT NULL,
	calle varchar(60),
	colonia varchar(60),
	"número" smallint,
	ciudad varchar(60),
	"número_Departamento_DEPARTAMENTO" smallint NOT NULL,
	CONSTRAINT "PROYECTO_pk" PRIMARY KEY ("número_Proyecto")
);
-- ddl-end --
ALTER TABLE public."PROYECTO" OWNER TO postgres;
-- ddl-end --

-- object: public."many_EMPLEADO_has_many_PROYECTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_EMPLEADO_has_many_PROYECTO" CASCADE;
CREATE TABLE public."many_EMPLEADO_has_many_PROYECTO" (
	"curp_EMPLEADO" varchar(18) NOT NULL,
	"número_Empleado_EMPLEADO" smallint NOT NULL,
	"número_Proyecto_PROYECTO" smallint NOT NULL,
	horas smallint,
	CONSTRAINT "many_EMPLEADO_has_many_PROYECTO_pk" PRIMARY KEY ("curp_EMPLEADO","número_Empleado_EMPLEADO","número_Proyecto_PROYECTO")
);
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_EMPLEADO_has_many_PROYECTO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."many_EMPLEADO_has_many_PROYECTO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("curp_EMPLEADO","número_Empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (curp,"número_Empleado") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PROYECTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_EMPLEADO_has_many_PROYECTO" DROP CONSTRAINT IF EXISTS "PROYECTO_fk" CASCADE;
ALTER TABLE public."many_EMPLEADO_has_many_PROYECTO" ADD CONSTRAINT "PROYECTO_fk" FOREIGN KEY ("número_Proyecto_PROYECTO")
REFERENCES public."PROYECTO" ("número_Proyecto") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."DEPARTAMENTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."DEPARTAMENTO" CASCADE;
CREATE TABLE public."DEPARTAMENTO" (
	"nombre_Departamento" varchar(60),
	calle varchar(60),
	"número" smallint,
	"número_Departamento" smallint NOT NULL,
	colonia varchar(60),
	ciudad varchar(60),
	"número_Empleado_JEFE" smallint,
	CONSTRAINT "DEPARTAMENTO_pk" PRIMARY KEY ("número_Departamento")
);
-- ddl-end --
ALTER TABLE public."DEPARTAMENTO" OWNER TO postgres;
-- ddl-end --

-- object: "JEFE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."DEPARTAMENTO" DROP CONSTRAINT IF EXISTS "JEFE_fk" CASCADE;
ALTER TABLE public."DEPARTAMENTO" ADD CONSTRAINT "JEFE_fk" FOREIGN KEY ("número_Empleado_JEFE")
REFERENCES public."JEFE" ("número_Empleado") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."many_EMPLEADO_has_many_DEPARTAMENTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_EMPLEADO_has_many_DEPARTAMENTO" CASCADE;
CREATE TABLE public."many_EMPLEADO_has_many_DEPARTAMENTO" (
	"curp_EMPLEADO" varchar(18) NOT NULL,
	"número_Empleado_EMPLEADO" smallint NOT NULL,
	"número_Departamento_DEPARTAMENTO" smallint NOT NULL,
	CONSTRAINT "many_EMPLEADO_has_many_DEPARTAMENTO_pk" PRIMARY KEY ("curp_EMPLEADO","número_Empleado_EMPLEADO","número_Departamento_DEPARTAMENTO")
);
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_EMPLEADO_has_many_DEPARTAMENTO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."many_EMPLEADO_has_many_DEPARTAMENTO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("curp_EMPLEADO","número_Empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (curp,"número_Empleado") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "DEPARTAMENTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_EMPLEADO_has_many_DEPARTAMENTO" DROP CONSTRAINT IF EXISTS "DEPARTAMENTO_fk" CASCADE;
ALTER TABLE public."many_EMPLEADO_has_many_DEPARTAMENTO" ADD CONSTRAINT "DEPARTAMENTO_fk" FOREIGN KEY ("número_Departamento_DEPARTAMENTO")
REFERENCES public."DEPARTAMENTO" ("número_Departamento") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "DEPARTAMENTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PROYECTO" DROP CONSTRAINT IF EXISTS "DEPARTAMENTO_fk" CASCADE;
ALTER TABLE public."PROYECTO" ADD CONSTRAINT "DEPARTAMENTO_fk" FOREIGN KEY ("número_Departamento_DEPARTAMENTO")
REFERENCES public."DEPARTAMENTO" ("número_Departamento") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


