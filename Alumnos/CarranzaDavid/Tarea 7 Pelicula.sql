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


-- object: "SALA" | type: SCHEMA --
-- DROP SCHEMA IF EXISTS "SALA" CASCADE;
CREATE SCHEMA "SALA";
-- ddl-end --
ALTER SCHEMA "SALA" OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,"SALA";
-- ddl-end --

-- object: public."SALA" | type: TABLE --
-- DROP TABLE IF EXISTS public."SALA" CASCADE;
CREATE TABLE public."SALA" (
	sala_id int4 NOT NULL,
	domicilio varchar(200) NOT NULL,
	nombre varchar(80) NOT NULL,
	CONSTRAINT "SALA_pk" PRIMARY KEY (sala_id)
);
-- ddl-end --
ALTER TABLE public."SALA" OWNER TO postgres;
-- ddl-end --

-- object: public."PRODUCTORA" | type: TABLE --
-- DROP TABLE IF EXISTS public."PRODUCTORA" CASCADE;
CREATE TABLE public."PRODUCTORA" (
	productora_id int4 NOT NULL,
	fecha_fundacion date NOT NULL,
	razon_social varchar(80) NOT NULL,
	CONSTRAINT "PRODUCTORA_pk" PRIMARY KEY (productora_id)
);
-- ddl-end --
ALTER TABLE public."PRODUCTORA" OWNER TO postgres;
-- ddl-end --

-- object: public."DIRECTOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."DIRECTOR" CASCADE;
CREATE TABLE public."DIRECTOR" (
	directo_id int4 NOT NULL,
	nombre varchar(250) NOT NULL,
	pais_origen varchar(80) NOT NULL,
	CONSTRAINT "DIRECTOR_pk" PRIMARY KEY (directo_id)
);
-- ddl-end --
ALTER TABLE public."DIRECTOR" OWNER TO postgres;
-- ddl-end --

-- object: public."PELICULA" | type: TABLE --
-- DROP TABLE IF EXISTS public."PELICULA" CASCADE;
CREATE TABLE public."PELICULA" (
	pelicula_id int4 NOT NULL,
	titulo varchar(100) NOT NULL,
	clasificacion char NOT NULL,
	genero varchar(80) NOT NULL,
	"productora_id_PRODUCTORA" int4,
	CONSTRAINT "PELICULA_pk" PRIMARY KEY (pelicula_id)
);
-- ddl-end --
ALTER TABLE public."PELICULA" OWNER TO postgres;
-- ddl-end --

-- object: public."ACTOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."ACTOR" CASCADE;
CREATE TABLE public."ACTOR" (
	actor_id int4 NOT NULL,
	nombre varchar(250) NOT NULL,
	sexo varchar(25) NOT NULL,
	nacionalidad varchar(50) NOT NULL,
	fecha_nacimiento date NOT NULL,
	CONSTRAINT "ACTOR_pk" PRIMARY KEY (actor_id)
);
-- ddl-end --
ALTER TABLE public."ACTOR" OWNER TO postgres;
-- ddl-end --

-- object: public."many_SALA_has_many_PELICULA" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_SALA_has_many_PELICULA" CASCADE;
CREATE TABLE public."many_SALA_has_many_PELICULA" (
	"sala_id_SALA" int4 NOT NULL,
	"pelicula_id_PELICULA" int4 NOT NULL,
	CONSTRAINT "many_SALA_has_many_PELICULA_pk" PRIMARY KEY ("sala_id_SALA","pelicula_id_PELICULA")
);
-- ddl-end --

-- object: "SALA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_SALA_has_many_PELICULA" DROP CONSTRAINT IF EXISTS "SALA_fk" CASCADE;
ALTER TABLE public."many_SALA_has_many_PELICULA" ADD CONSTRAINT "SALA_fk" FOREIGN KEY ("sala_id_SALA")
REFERENCES public."SALA" (sala_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PELICULA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_SALA_has_many_PELICULA" DROP CONSTRAINT IF EXISTS "PELICULA_fk" CASCADE;
ALTER TABLE public."many_SALA_has_many_PELICULA" ADD CONSTRAINT "PELICULA_fk" FOREIGN KEY ("pelicula_id_PELICULA")
REFERENCES public."PELICULA" (pelicula_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."many_ACTOR_has_many_PELICULA" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_ACTOR_has_many_PELICULA" CASCADE;
CREATE TABLE public."many_ACTOR_has_many_PELICULA" (
	"actor_id_ACTOR" int4 NOT NULL,
	"pelicula_id_PELICULA" int4 NOT NULL,
	honorarios decimal NOT NULL,
	actor_principal boolean NOT NULL,
	CONSTRAINT "many_ACTOR_has_many_PELICULA_pk" PRIMARY KEY ("actor_id_ACTOR","pelicula_id_PELICULA")
);
-- ddl-end --

-- object: "ACTOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_ACTOR_has_many_PELICULA" DROP CONSTRAINT IF EXISTS "ACTOR_fk" CASCADE;
ALTER TABLE public."many_ACTOR_has_many_PELICULA" ADD CONSTRAINT "ACTOR_fk" FOREIGN KEY ("actor_id_ACTOR")
REFERENCES public."ACTOR" (actor_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PELICULA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_ACTOR_has_many_PELICULA" DROP CONSTRAINT IF EXISTS "PELICULA_fk" CASCADE;
ALTER TABLE public."many_ACTOR_has_many_PELICULA" ADD CONSTRAINT "PELICULA_fk" FOREIGN KEY ("pelicula_id_PELICULA")
REFERENCES public."PELICULA" (pelicula_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."many_PELICULA_has_many_DIRECTOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_PELICULA_has_many_DIRECTOR" CASCADE;
CREATE TABLE public."many_PELICULA_has_many_DIRECTOR" (
	"pelicula_id_PELICULA" int4 NOT NULL,
	"directo_id_DIRECTOR" int4 NOT NULL,
	director_principal boolean NOT NULL,
	CONSTRAINT "many_PELICULA_has_many_DIRECTOR_pk" PRIMARY KEY ("pelicula_id_PELICULA","directo_id_DIRECTOR")
);
-- ddl-end --

-- object: "PELICULA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_PELICULA_has_many_DIRECTOR" DROP CONSTRAINT IF EXISTS "PELICULA_fk" CASCADE;
ALTER TABLE public."many_PELICULA_has_many_DIRECTOR" ADD CONSTRAINT "PELICULA_fk" FOREIGN KEY ("pelicula_id_PELICULA")
REFERENCES public."PELICULA" (pelicula_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "DIRECTOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_PELICULA_has_many_DIRECTOR" DROP CONSTRAINT IF EXISTS "DIRECTOR_fk" CASCADE;
ALTER TABLE public."many_PELICULA_has_many_DIRECTOR" ADD CONSTRAINT "DIRECTOR_fk" FOREIGN KEY ("directo_id_DIRECTOR")
REFERENCES public."DIRECTOR" (directo_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PRODUCTORA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PELICULA" DROP CONSTRAINT IF EXISTS "PRODUCTORA_fk" CASCADE;
ALTER TABLE public."PELICULA" ADD CONSTRAINT "PRODUCTORA_fk" FOREIGN KEY ("productora_id_PRODUCTORA")
REFERENCES public."PRODUCTORA" (productora_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


