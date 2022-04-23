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


-- object: public."TITULAR" | type: TABLE --
-- DROP TABLE IF EXISTS public."TITULAR" CASCADE;
CREATE TABLE public."TITULAR" (
	clave smallint NOT NULL,
	CONSTRAINT "TITULAR_pk" PRIMARY KEY (clave)
);
-- ddl-end --
ALTER TABLE public."TITULAR" OWNER TO postgres;
-- ddl-end --

-- object: public."TUTOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."TUTOR" CASCADE;
CREATE TABLE public."TUTOR" (
	clave smallint NOT NULL,
	CONSTRAINT "TUTOR_pk" PRIMARY KEY (clave)
);
-- ddl-end --
ALTER TABLE public."TUTOR" OWNER TO postgres;
-- ddl-end --

-- object: public."PROFESOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROFESOR" CASCADE;
CREATE TABLE public."PROFESOR" (
	clave smallint NOT NULL,
	nombre varchar(60) NOT NULL,
	"apellido_Paterno" varchar(60) NOT NULL,
	"apellido_Materno" varchar(60),
	"teléfono" smallint NOT NULL,
	calle varchar(60) NOT NULL,
	"número" smallint NOT NULL,
	colonia varchar(60) NOT NULL,
	ciudad varchar(60) NOT NULL,
	"código_Postal" smallint NOT NULL,
	CONSTRAINT "PROFESOR_pk" PRIMARY KEY (clave)
)
 INHERITS(public."TITULAR",public."TUTOR");
-- ddl-end --
ALTER TABLE public."PROFESOR" OWNER TO postgres;
-- ddl-end --

-- object: public."ALUMNO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ALUMNO" CASCADE;
CREATE TABLE public."ALUMNO" (
	"número_Cuenta" smallint NOT NULL,
	nombre varchar(60) NOT NULL,
	"apellido_Paterno" varchar(60) NOT NULL,
	"apellido_Materno" varchar(60),
	calle varchar(60) NOT NULL,
	"número" smallint NOT NULL,
	colonia varchar(60) NOT NULL,
	ciudad varchar(60) NOT NULL,
	"código_Postal" smallint NOT NULL,
	"clave_TUTOR" smallint NOT NULL,
	CONSTRAINT "ALUMNO_pk" PRIMARY KEY ("número_Cuenta")
);
-- ddl-end --
ALTER TABLE public."ALUMNO" OWNER TO postgres;
-- ddl-end --

-- object: "TUTOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ALUMNO" DROP CONSTRAINT IF EXISTS "TUTOR_fk" CASCADE;
ALTER TABLE public."ALUMNO" ADD CONSTRAINT "TUTOR_fk" FOREIGN KEY ("clave_TUTOR")
REFERENCES public."TUTOR" (clave) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."ASIGNATURA" | type: TABLE --
-- DROP TABLE IF EXISTS public."ASIGNATURA" CASCADE;
CREATE TABLE public."ASIGNATURA" (
	clave smallint NOT NULL,
	nombre varchar(60) NOT NULL,
	"número_Créditos" smallint NOT NULL,
	"número_Cuenta_ALUMNO" smallint NOT NULL,
	CONSTRAINT "ASIGNATURA_pk" PRIMARY KEY (clave)
);
-- ddl-end --
ALTER TABLE public."ASIGNATURA" OWNER TO postgres;
-- ddl-end --

-- object: "ALUMNO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ASIGNATURA" DROP CONSTRAINT IF EXISTS "ALUMNO_fk" CASCADE;
ALTER TABLE public."ASIGNATURA" ADD CONSTRAINT "ALUMNO_fk" FOREIGN KEY ("número_Cuenta_ALUMNO")
REFERENCES public."ALUMNO" ("número_Cuenta") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."GRUPO" | type: TABLE --
-- DROP TABLE IF EXISTS public."GRUPO" CASCADE;
CREATE TABLE public."GRUPO" (
	"número_Grupo" smallint NOT NULL,
	"salón" varchar(10) NOT NULL,
	horario tinterval NOT NULL,
	cupo smallint NOT NULL,
	"clave_ASIGNATURA" smallint NOT NULL,
	"número_Cuenta_ALUMNO" smallint NOT NULL,
	CONSTRAINT "GRUPO_pk" PRIMARY KEY ("número_Grupo")
);
-- ddl-end --
ALTER TABLE public."GRUPO" OWNER TO postgres;
-- ddl-end --

-- object: public."many_TITULAR_has_many_ASIGNATURA" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_TITULAR_has_many_ASIGNATURA" CASCADE;
CREATE TABLE public."many_TITULAR_has_many_ASIGNATURA" (
	"clave_TITULAR" smallint NOT NULL,
	"clave_ASIGNATURA" smallint NOT NULL,
	CONSTRAINT "many_TITULAR_has_many_ASIGNATURA_pk" PRIMARY KEY ("clave_TITULAR","clave_ASIGNATURA")
);
-- ddl-end --

-- object: "TITULAR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_TITULAR_has_many_ASIGNATURA" DROP CONSTRAINT IF EXISTS "TITULAR_fk" CASCADE;
ALTER TABLE public."many_TITULAR_has_many_ASIGNATURA" ADD CONSTRAINT "TITULAR_fk" FOREIGN KEY ("clave_TITULAR")
REFERENCES public."TITULAR" (clave) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "ASIGNATURA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_TITULAR_has_many_ASIGNATURA" DROP CONSTRAINT IF EXISTS "ASIGNATURA_fk" CASCADE;
ALTER TABLE public."many_TITULAR_has_many_ASIGNATURA" ADD CONSTRAINT "ASIGNATURA_fk" FOREIGN KEY ("clave_ASIGNATURA")
REFERENCES public."ASIGNATURA" (clave) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "ASIGNATURA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."GRUPO" DROP CONSTRAINT IF EXISTS "ASIGNATURA_fk" CASCADE;
ALTER TABLE public."GRUPO" ADD CONSTRAINT "ASIGNATURA_fk" FOREIGN KEY ("clave_ASIGNATURA")
REFERENCES public."ASIGNATURA" (clave) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."ASESORÍA" | type: TABLE --
-- DROP TABLE IF EXISTS public."ASESORÍA" CASCADE;
CREATE TABLE public."ASESORÍA" (
	folio smallint NOT NULL,
	fecha date NOT NULL,
	hora time NOT NULL,
	"duración" tinterval NOT NULL,
	"número_Cuenta_ALUMNO" smallint NOT NULL,
	"clave_TUTOR" smallint NOT NULL,
	CONSTRAINT "ASESORÍA_pk" PRIMARY KEY (folio)
);
-- ddl-end --
ALTER TABLE public."ASESORÍA" OWNER TO postgres;
-- ddl-end --

-- object: "ALUMNO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ASESORÍA" DROP CONSTRAINT IF EXISTS "ALUMNO_fk" CASCADE;
ALTER TABLE public."ASESORÍA" ADD CONSTRAINT "ALUMNO_fk" FOREIGN KEY ("número_Cuenta_ALUMNO")
REFERENCES public."ALUMNO" ("número_Cuenta") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "TUTOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ASESORÍA" DROP CONSTRAINT IF EXISTS "TUTOR_fk" CASCADE;
ALTER TABLE public."ASESORÍA" ADD CONSTRAINT "TUTOR_fk" FOREIGN KEY ("clave_TUTOR")
REFERENCES public."TUTOR" (clave) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."email_Profesor" | type: TABLE --
-- DROP TABLE IF EXISTS public."email_Profesor" CASCADE;
CREATE TABLE public."email_Profesor" (
	LIKE public."PROFESOR",
	"correo_Profesor" smallint NOT NULL,
	CONSTRAINT "correo_Profesor_pk" PRIMARY KEY ("correo_Profesor")
);
-- ddl-end --
ALTER TABLE public."email_Profesor" OWNER TO postgres;
-- ddl-end --

-- object: "ALUMNO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."GRUPO" DROP CONSTRAINT IF EXISTS "ALUMNO_fk" CASCADE;
ALTER TABLE public."GRUPO" ADD CONSTRAINT "ALUMNO_fk" FOREIGN KEY ("número_Cuenta_ALUMNO")
REFERENCES public."ALUMNO" ("número_Cuenta") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


