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


-- object: public."PERSONAL" | type: TABLE --
-- DROP TABLE IF EXISTS public."PERSONAL" CASCADE;
CREATE TABLE public."PERSONAL" (
	puesto varchar(60) NOT NULL

);
-- ddl-end --
ALTER TABLE public."PERSONAL" OWNER TO postgres;
-- ddl-end --

-- object: public."EGRESADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EGRESADO" CASCADE;
CREATE TABLE public."EGRESADO" (
	"nombre_Grado" varchar(60) NOT NULL,
	"fecha_Obtención_Grado" date NOT NULL

);
-- ddl-end --
ALTER TABLE public."EGRESADO" OWNER TO postgres;
-- ddl-end --

-- object: public."PROFESOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROFESOR" CASCADE;
CREATE TABLE public."PROFESOR" (
	tipo varchar(60) NOT NULL

);
-- ddl-end --
ALTER TABLE public."PROFESOR" OWNER TO postgres;
-- ddl-end --

-- object: public."AYUDANTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."AYUDANTE" CASCADE;
CREATE TABLE public."AYUDANTE" (
	tipo varchar(60) NOT NULL,
	"proyecto/materia" varchar(60) NOT NULL,
	"horas_Asignadas" tinterval NOT NULL

);
-- ddl-end --
ALTER TABLE public."AYUDANTE" OWNER TO postgres;
-- ddl-end --

-- object: public."EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMPLEADO" CASCADE;
CREATE TABLE public."EMPLEADO" (
	salario float NOT NULL
-- 	puesto varchar(60) NOT NULL,
-- 	tipo varchar(60) NOT NULL,
-- 	"proyecto/materia" varchar(60) NOT NULL,
-- 	"horas_Asignadas" tinterval NOT NULL,

)
 INHERITS(public."PERSONAL",public."PROFESOR",public."AYUDANTE");
-- ddl-end --
ALTER TABLE public."EMPLEADO" OWNER TO postgres;
-- ddl-end --

-- object: public."ESTUDIANTE_LICENCIATURA" | type: TABLE --
-- DROP TABLE IF EXISTS public."ESTUDIANTE_LICENCIATURA" CASCADE;
CREATE TABLE public."ESTUDIANTE_LICENCIATURA" (
	"avance_Créditos" float NOT NULL

);
-- ddl-end --
ALTER TABLE public."ESTUDIANTE_LICENCIATURA" OWNER TO postgres;
-- ddl-end --

-- object: public."ESTUDIANTE_POSGRADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ESTUDIANTE_POSGRADO" CASCADE;
CREATE TABLE public."ESTUDIANTE_POSGRADO" (

);
-- ddl-end --
ALTER TABLE public."ESTUDIANTE_POSGRADO" OWNER TO postgres;
-- ddl-end --

-- object: public."ESTUDIANTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."ESTUDIANTE" CASCADE;
CREATE TABLE public."ESTUDIANTE" (
	departamento varchar(60) NOT NULL
-- 	"avance_Créditos" float NOT NULL,

)
 INHERITS(public."ESTUDIANTE_LICENCIATURA",public."ESTUDIANTE_POSGRADO");
-- ddl-end --
ALTER TABLE public."ESTUDIANTE" OWNER TO postgres;
-- ddl-end --

-- object: public."ALUMNO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ALUMNO" CASCADE;
CREATE TABLE public."ALUMNO" (
-- 	departamento varchar(60) NOT NULL,
-- 	"avance_Créditos" float NOT NULL,

)
 INHERITS(public."ESTUDIANTE");
-- ddl-end --
ALTER TABLE public."ALUMNO" OWNER TO postgres;
-- ddl-end --

-- object: public."PERSONA" | type: TABLE --
-- DROP TABLE IF EXISTS public."PERSONA" CASCADE;
CREATE TABLE public."PERSONA" (
	"número_Seguro_Social" smallint NOT NULL,
	sexo char(1) NOT NULL,
	calle varchar(60) NOT NULL,
	"número" smallint NOT NULL,
	colonia smallint NOT NULL,
	"código_Postal" smallint NOT NULL,
	ciudad smallint NOT NULL,
	"fecha_Nacimiento" date NOT NULL,
-- 	"nombre_Grado" varchar(60) NOT NULL,
-- 	"fecha_Obtención_Grado" date NOT NULL,
-- 	salario float NOT NULL,
-- 	puesto varchar(60) NOT NULL,
-- 	tipo varchar(60) NOT NULL,
-- 	"proyecto/materia" varchar(60) NOT NULL,
-- 	"horas_Asignadas" tinterval NOT NULL,
	CONSTRAINT "PERSONA_pk" PRIMARY KEY ("número_Seguro_Social")
)
 INHERITS(public."EGRESADO",public."ALUMNO",public."EMPLEADO");
-- ddl-end --
ALTER TABLE public."PERSONA" OWNER TO postgres;
-- ddl-end --


