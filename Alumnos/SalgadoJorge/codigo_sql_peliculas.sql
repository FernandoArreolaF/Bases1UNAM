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


-- object: public."PELICULA" | type: TABLE --
-- DROP TABLE IF EXISTS public."PELICULA" CASCADE;
CREATE TABLE public."PELICULA" (
	pelicula_id integer NOT NULL,
	"productora_id_PRODUCTORA" integer NOT NULL,
	titulo varchar(100) NOT NULL,
	clasificacion varchar(10) NOT NULL,
	genero varchar(50) NOT NULL,
	CONSTRAINT "PELICULA_pk" PRIMARY KEY (pelicula_id)
);
-- ddl-end --
ALTER TABLE public."PELICULA" OWNER TO postgres;
-- ddl-end --

-- object: public."ACTOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."ACTOR" CASCADE;
CREATE TABLE public."ACTOR" (
	actor_id integer NOT NULL,
	sexo varchar(50) NOT NULL,
	nacionalidad varchar(50) NOT NULL,
	fecha_nacimiento timestamp NOT NULL,
	nombre varchar(100) NOT NULL,
	apellido_paterno varchar(50) NOT NULL,
	apellido_materno varchar(50) NOT NULL,
	CONSTRAINT "ACTOR_pk" PRIMARY KEY (actor_id)
);
-- ddl-end --
ALTER TABLE public."ACTOR" OWNER TO postgres;
-- ddl-end --

-- object: public."DIRECTOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."DIRECTOR" CASCADE;
CREATE TABLE public."DIRECTOR" (
	director_id integer NOT NULL,
	nombre varchar(100) NOT NULL,
	apellido_paterno varchar(50) NOT NULL,
	apellido_materno varchar(50) NOT NULL,
	pais_origen varchar(100) NOT NULL,
	CONSTRAINT "DIRECTOR_pk" PRIMARY KEY (director_id)
);
-- ddl-end --
ALTER TABLE public."DIRECTOR" OWNER TO postgres;
-- ddl-end --

-- object: public."PRODUCTORA" | type: TABLE --
-- DROP TABLE IF EXISTS public."PRODUCTORA" CASCADE;
CREATE TABLE public."PRODUCTORA" (
	productora_id integer NOT NULL,
	razon_social varchar(100) NOT NULL,
	fecha_fundacion timestamp with time zone NOT NULL,
	CONSTRAINT "PRODUCTORA_pk" PRIMARY KEY (productora_id)
);
-- ddl-end --
ALTER TABLE public."PRODUCTORA" OWNER TO postgres;
-- ddl-end --

-- object: public."SALA" | type: TABLE --
-- DROP TABLE IF EXISTS public."SALA" CASCADE;
CREATE TABLE public."SALA" (
	sala_id integer NOT NULL,
	domicilio varchar(100) NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT "SALA_pk" PRIMARY KEY (sala_id)
);
-- ddl-end --
ALTER TABLE public."SALA" OWNER TO postgres;
-- ddl-end --

-- object: "ACTOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public.participa DROP CONSTRAINT IF EXISTS "ACTOR_fk" CASCADE;
ALTER TABLE public.participa ADD CONSTRAINT "ACTOR_fk" FOREIGN KEY ("actor_id_ACTOR")
REFERENCES public."ACTOR" (actor_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "PELICULA_fk" | type: CONSTRAINT --
-- ALTER TABLE public.participa DROP CONSTRAINT IF EXISTS "PELICULA_fk" CASCADE;
ALTER TABLE public.participa ADD CONSTRAINT "PELICULA_fk" FOREIGN KEY ("pelicula_id_PELICULA")
REFERENCES public."PELICULA" (pelicula_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.es_dirigida | type: TABLE --
-- DROP TABLE IF EXISTS public.es_dirigida CASCADE;
CREATE TABLE public.es_dirigida (
	"director_id_DIRECTOR" integer NOT NULL,
	"pelicula_id_PELICULA" integer NOT NULL,
	director_principal boolean NOT NULL,
	CONSTRAINT es_dirigida_pk PRIMARY KEY ("pelicula_id_PELICULA","director_id_DIRECTOR")
);
-- ddl-end --
ALTER TABLE public.es_dirigida OWNER TO postgres;
-- ddl-end --

-- object: "PELICULA_fk" | type: CONSTRAINT --
-- ALTER TABLE public.es_dirigida DROP CONSTRAINT IF EXISTS "PELICULA_fk" CASCADE;
ALTER TABLE public.es_dirigida ADD CONSTRAINT "PELICULA_fk" FOREIGN KEY ("pelicula_id_PELICULA")
REFERENCES public."PELICULA" (pelicula_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "DIRECTOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public.es_dirigida DROP CONSTRAINT IF EXISTS "DIRECTOR_fk" CASCADE;
ALTER TABLE public.es_dirigida ADD CONSTRAINT "DIRECTOR_fk" FOREIGN KEY ("director_id_DIRECTOR")
REFERENCES public."DIRECTOR" (director_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.se_exhibe | type: TABLE --
-- DROP TABLE IF EXISTS public.se_exhibe CASCADE;
CREATE TABLE public.se_exhibe (
	"sala_id_SALA" integer NOT NULL,
	"pelicula_id_PELICULA" integer NOT NULL,
	CONSTRAINT se_exhibe_pk PRIMARY KEY ("sala_id_SALA","pelicula_id_PELICULA")
);
-- ddl-end --
ALTER TABLE public.se_exhibe OWNER TO postgres;
-- ddl-end --

-- object: "SALA_fk" | type: CONSTRAINT --
-- ALTER TABLE public.se_exhibe DROP CONSTRAINT IF EXISTS "SALA_fk" CASCADE;
ALTER TABLE public.se_exhibe ADD CONSTRAINT "SALA_fk" FOREIGN KEY ("sala_id_SALA")
REFERENCES public."SALA" (sala_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "PELICULA_fk" | type: CONSTRAINT --
-- ALTER TABLE public.se_exhibe DROP CONSTRAINT IF EXISTS "PELICULA_fk" CASCADE;
ALTER TABLE public.se_exhibe ADD CONSTRAINT "PELICULA_fk" FOREIGN KEY ("pelicula_id_PELICULA")
REFERENCES public."PELICULA" (pelicula_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "PRODUCTORA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PELICULA" DROP CONSTRAINT IF EXISTS "PRODUCTORA_fk" CASCADE;
ALTER TABLE public."PELICULA" ADD CONSTRAINT "PRODUCTORA_fk" FOREIGN KEY ("productora_id_PRODUCTORA")
REFERENCES public."PRODUCTORA" (productora_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


