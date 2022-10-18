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


-- object: public."DEPARTAMENTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."DEPARTAMENTO" CASCADE;
CREATE TABLE public."DEPARTAMENTO" (
	fech_inici date NOT NULL,
	num_dep int4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT "DEPARTAMENTO_pk" PRIMARY KEY (num_dep)
);
-- ddl-end --
ALTER TABLE public."DEPARTAMENTO" OWNER TO postgres;
-- ddl-end --

-- object: public."DEPENDIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."DEPENDIENTE" CASCADE;
CREATE TABLE public."DEPENDIENTE" (
	curp_dep char(16) NOT NULL,
	sexo varchar(30) NOT NULL,
	parentesco varchar(50) NOT NULL,
	fech_nac date NOT NULL,
	nombre varchar(250) NOT NULL,
	CONSTRAINT "DEPENDIENTE_pk" PRIMARY KEY (curp_dep)
);
-- ddl-end --
ALTER TABLE public."DEPENDIENTE" OWNER TO postgres;
-- ddl-end --

-- object: public."EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMPLEADO" CASCADE;
CREATE TABLE public."EMPLEADO" (
	curp_emp char(16) NOT NULL,
	nombre varchar(250) NOT NULL,
	sueldo float NOT NULL,
	sexo varchar(30) NOT NULL,
	fech_nac date NOT NULL,
	"curp_dep_DEPENDIENTE" char(16),
	"num_dep_DEPARTAMENTO" int4,
	"num_dep_DEPARTAMENTO1" int4,
	CONSTRAINT "EMPLEADO_pk" PRIMARY KEY (curp_emp)
);
-- ddl-end --
ALTER TABLE public."EMPLEADO" OWNER TO postgres;
-- ddl-end --

-- object: public."PROYECTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROYECTO" CASCADE;
CREATE TABLE public."PROYECTO" (
	num_proy int4 NOT NULL,
	nombre varchar(150) NOT NULL,
	ubicacion varchar(150) NOT NULL,
	CONSTRAINT "PROYECTO_pk" PRIMARY KEY (num_proy)
);
-- ddl-end --
ALTER TABLE public."PROYECTO" OWNER TO postgres;
-- ddl-end --

-- object: public."UBICACION_DEPTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."UBICACION_DEPTO" CASCADE;
CREATE TABLE public."UBICACION_DEPTO" (
	ubicacion varchar(250) NOT NULL,
	"num_dep_DEPARTAMENTO" int4,
	CONSTRAINT "UBICACION_DEPTO_pk" PRIMARY KEY (ubicacion)
);
-- ddl-end --
ALTER TABLE public."UBICACION_DEPTO" OWNER TO postgres;
-- ddl-end --

-- object: "DEPARTAMENTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."UBICACION_DEPTO" DROP CONSTRAINT IF EXISTS "DEPARTAMENTO_fk" CASCADE;
ALTER TABLE public."UBICACION_DEPTO" ADD CONSTRAINT "DEPARTAMENTO_fk" FOREIGN KEY ("num_dep_DEPARTAMENTO")
REFERENCES public."DEPARTAMENTO" (num_dep) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.controla | type: TABLE --
-- DROP TABLE IF EXISTS public.controla CASCADE;
CREATE TABLE public.controla (
	"num_dep_DEPARTAMENTO" int4 NOT NULL,
	"num_proy_PROYECTO" int4 NOT NULL,
	CONSTRAINT controla_pk PRIMARY KEY ("num_dep_DEPARTAMENTO","num_proy_PROYECTO")
);
-- ddl-end --

-- object: "DEPARTAMENTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public.controla DROP CONSTRAINT IF EXISTS "DEPARTAMENTO_fk" CASCADE;
ALTER TABLE public.controla ADD CONSTRAINT "DEPARTAMENTO_fk" FOREIGN KEY ("num_dep_DEPARTAMENTO")
REFERENCES public."DEPARTAMENTO" (num_dep) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PROYECTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public.controla DROP CONSTRAINT IF EXISTS "PROYECTO_fk" CASCADE;
ALTER TABLE public.controla ADD CONSTRAINT "PROYECTO_fk" FOREIGN KEY ("num_proy_PROYECTO")
REFERENCES public."PROYECTO" (num_proy) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.trabaja | type: TABLE --
-- DROP TABLE IF EXISTS public.trabaja CASCADE;
CREATE TABLE public.trabaja (
	"num_proy_PROYECTO" int4 NOT NULL,
	"curp_emp_EMPLEADO" char(16) NOT NULL,
	horas smallint NOT NULL,
	CONSTRAINT trabaja_pk PRIMARY KEY ("num_proy_PROYECTO","curp_emp_EMPLEADO")
);
-- ddl-end --

-- object: "PROYECTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public.trabaja DROP CONSTRAINT IF EXISTS "PROYECTO_fk" CASCADE;
ALTER TABLE public.trabaja ADD CONSTRAINT "PROYECTO_fk" FOREIGN KEY ("num_proy_PROYECTO")
REFERENCES public."PROYECTO" (num_proy) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public.trabaja DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public.trabaja ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("curp_emp_EMPLEADO")
REFERENCES public."EMPLEADO" (curp_emp) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "DEPENDIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "DEPENDIENTE_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "DEPENDIENTE_fk" FOREIGN KEY ("curp_dep_DEPENDIENTE")
REFERENCES public."DEPENDIENTE" (curp_dep) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "DEPARTAMENTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "DEPARTAMENTO_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "DEPARTAMENTO_fk" FOREIGN KEY ("num_dep_DEPARTAMENTO")
REFERENCES public."DEPARTAMENTO" (num_dep) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_uq" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "EMPLEADO_uq" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "EMPLEADO_uq" UNIQUE ("num_dep_DEPARTAMENTO");
-- ddl-end --

-- object: "DEPARTAMENTO_fk1" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "DEPARTAMENTO_fk1" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "DEPARTAMENTO_fk1" FOREIGN KEY ("num_dep_DEPARTAMENTO1")
REFERENCES public."DEPARTAMENTO" (num_dep) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: curp_emp_super | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS curp_emp_super CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT curp_emp_super FOREIGN KEY (curp_emp,nombre,sueldo,sexo,fech_nac,"curp_dep_DEPENDIENTE","num_dep_DEPARTAMENTO","num_dep_DEPARTAMENTO1")
REFERENCES public."EMPLEADO" (curp_emp,nombre,sueldo,sexo,fech_nac,"curp_dep_DEPENDIENTE","num_dep_DEPARTAMENTO","num_dep_DEPARTAMENTO1") MATCH SIMPLE
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


