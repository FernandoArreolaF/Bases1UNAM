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


-- object: public."ARTICULO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ARTICULO" CASCADE;
CREATE TABLE public."ARTICULO" (
	"codBarras" varchar(12) NOT NULL,
	"fotografía" bytea NOT NULL,
	"nombreArt" varchar(15) NOT NULL,
	"precioVenta" float NOT NULL,
	"precioCompra" float NOT NULL,
	stock smallint NOT NULL,
	"idCat_CATEGORIA" smallint,
	CONSTRAINT "ARTICULO_pk" PRIMARY KEY ("codBarras")
);
-- ddl-end --
ALTER TABLE public."ARTICULO" OWNER TO postgres;
-- ddl-end --

-- object: public."CATEGORIA" | type: TABLE --
-- DROP TABLE IF EXISTS public."CATEGORIA" CASCADE;
CREATE TABLE public."CATEGORIA" (
	"idCat" smallint NOT NULL,
	"categoría" varchar(15) NOT NULL,
	CONSTRAINT "CATEGORIA_pk" PRIMARY KEY ("idCat")
);
-- ddl-end --
ALTER TABLE public."CATEGORIA" OWNER TO postgres;
-- ddl-end --

-- object: "CATEGORIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ARTICULO" DROP CONSTRAINT IF EXISTS "CATEGORIA_fk" CASCADE;
ALTER TABLE public."ARTICULO" ADD CONSTRAINT "CATEGORIA_fk" FOREIGN KEY ("idCat_CATEGORIA")
REFERENCES public."CATEGORIA" ("idCat") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."PROVEEDOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROVEEDOR" CASCADE;
CREATE TABLE public."PROVEEDOR" (
	"rfcProv" varchar(13) NOT NULL,
	"razSocialProv" varchar(150) NOT NULL,
	calle varchar(50) NOT NULL,
	colonia varchar(50) NOT NULL,
	"número" smallint NOT NULL,
	"codPostal" varchar(5) NOT NULL,
	"teléfono" varchar(10) NOT NULL,
	"ctaPago" varchar(20) NOT NULL,
	"idEdo_ESTADO" smallint,
	CONSTRAINT "PROVEEDOR_pk" PRIMARY KEY ("rfcProv")
);
-- ddl-end --
ALTER TABLE public."PROVEEDOR" OWNER TO postgres;
-- ddl-end --

-- object: public."ESTADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ESTADO" CASCADE;
CREATE TABLE public."ESTADO" (
	"idEdo" smallint NOT NULL,
	estado varchar(50) NOT NULL,
	CONSTRAINT "ESTADO_pk" PRIMARY KEY ("idEdo")
);
-- ddl-end --
ALTER TABLE public."ESTADO" OWNER TO postgres;
-- ddl-end --

-- object: "ESTADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PROVEEDOR" DROP CONSTRAINT IF EXISTS "ESTADO_fk" CASCADE;
ALTER TABLE public."PROVEEDOR" ADD CONSTRAINT "ESTADO_fk" FOREIGN KEY ("idEdo_ESTADO")
REFERENCES public."ESTADO" ("idEdo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."many_ARTICULO_has_many_PROVEEDOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_ARTICULO_has_many_PROVEEDOR" CASCADE;
CREATE TABLE public."many_ARTICULO_has_many_PROVEEDOR" (
	"codBarras_ARTICULO" varchar(12) NOT NULL,
	"rfcProv_PROVEEDOR" varchar(13) NOT NULL,
	CONSTRAINT "many_ARTICULO_has_many_PROVEEDOR_pk" PRIMARY KEY ("codBarras_ARTICULO","rfcProv_PROVEEDOR")
);
-- ddl-end --

-- object: "ARTICULO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_ARTICULO_has_many_PROVEEDOR" DROP CONSTRAINT IF EXISTS "ARTICULO_fk" CASCADE;
ALTER TABLE public."many_ARTICULO_has_many_PROVEEDOR" ADD CONSTRAINT "ARTICULO_fk" FOREIGN KEY ("codBarras_ARTICULO")
REFERENCES public."ARTICULO" ("codBarras") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "PROVEEDOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_ARTICULO_has_many_PROVEEDOR" DROP CONSTRAINT IF EXISTS "PROVEEDOR_fk" CASCADE;
ALTER TABLE public."many_ARTICULO_has_many_PROVEEDOR" ADD CONSTRAINT "PROVEEDOR_fk" FOREIGN KEY ("rfcProv_PROVEEDOR")
REFERENCES public."PROVEEDOR" ("rfcProv") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."VENTA" CASCADE;
CREATE TABLE public."VENTA" (
	folio varchar(7) NOT NULL,
	fecha timestamp NOT NULL,
	"cantTotalArt" smallint NOT NULL,
	"montoTotal" float NOT NULL,
	"rfcCliente_CLIENTE" varchar(13),
	CONSTRAINT "VENTA_pk" PRIMARY KEY (folio)
);
-- ddl-end --
ALTER TABLE public."VENTA" OWNER TO postgres;
-- ddl-end --

-- object: public."CLIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."CLIENTE" CASCADE;
CREATE TABLE public."CLIENTE" (
	"rfcCliente" varchar(13) NOT NULL,
	nombres varchar(100) NOT NULL,
	"apPat" varchar(50) NOT NULL,
	"apMat" varchar(50),
	email varchar(100) NOT NULL,
	"razSocialCliente" varchar(150) NOT NULL,
	"teléfonoCliente" varchar(10) NOT NULL,
	calle varchar(50) NOT NULL,
	colonia varchar(50) NOT NULL,
	"número" smallint NOT NULL,
	"codPostal" varchar(5) NOT NULL,
	"idEdo_ESTADO" smallint,
	CONSTRAINT "CLIENTE_pk" PRIMARY KEY ("rfcCliente")
);
-- ddl-end --
ALTER TABLE public."CLIENTE" OWNER TO postgres;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("rfcCliente_CLIENTE")
REFERENCES public."CLIENTE" ("rfcCliente") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."many_ARTICULO_has_many_VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_ARTICULO_has_many_VENTA" CASCADE;
CREATE TABLE public."many_ARTICULO_has_many_VENTA" (
	"codBarras_ARTICULO" varchar(12) NOT NULL,
	"folio_VENTA" varchar(7) NOT NULL,
	"cantXArt" smallint NOT NULL,
	"montoXArt" float NOT NULL,
	CONSTRAINT "many_ARTICULO_has_many_VENTA_pk" PRIMARY KEY ("codBarras_ARTICULO","folio_VENTA")
);
-- ddl-end --

-- object: "ARTICULO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_ARTICULO_has_many_VENTA" DROP CONSTRAINT IF EXISTS "ARTICULO_fk" CASCADE;
ALTER TABLE public."many_ARTICULO_has_many_VENTA" ADD CONSTRAINT "ARTICULO_fk" FOREIGN KEY ("codBarras_ARTICULO")
REFERENCES public."ARTICULO" ("codBarras") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "VENTA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_ARTICULO_has_many_VENTA" DROP CONSTRAINT IF EXISTS "VENTA_fk" CASCADE;
ALTER TABLE public."many_ARTICULO_has_many_VENTA" ADD CONSTRAINT "VENTA_fk" FOREIGN KEY ("folio_VENTA")
REFERENCES public."VENTA" (folio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "ESTADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."CLIENTE" DROP CONSTRAINT IF EXISTS "ESTADO_fk" CASCADE;
ALTER TABLE public."CLIENTE" ADD CONSTRAINT "ESTADO_fk" FOREIGN KEY ("idEdo_ESTADO")
REFERENCES public."ESTADO" ("idEdo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMPLEADO" CASCADE;
CREATE TABLE public."EMPLEADO" (
	"numEmp" varchar(5) NOT NULL,
	"fechaIng" date NOT NULL,
	"rfcEmp" varchar(13) NOT NULL,
	curp varchar(18) NOT NULL,
	email varchar(100) NOT NULL,
	nombres varchar(100) NOT NULL,
	"apPat" varchar(50) NOT NULL,
	"apMat" varchar(50),
	calle varchar(50) NOT NULL,
	colonia varchar(50) NOT NULL,
	"número" smallint NOT NULL,
	"codPostal" varchar(5) NOT NULL,
	"idTipo_TIPO" smallint,
	"idEdo_ESTADO" smallint,
	"teléfonoSuc_SUCURSAL" varchar(10),
	"numEmp_EMPLEADO" varchar(5),
	CONSTRAINT "EMPLEADO_pk" PRIMARY KEY ("numEmp")
);
-- ddl-end --
ALTER TABLE public."EMPLEADO" OWNER TO postgres;
-- ddl-end --

-- object: public."TIPO" | type: TABLE --
-- DROP TABLE IF EXISTS public."TIPO" CASCADE;
CREATE TABLE public."TIPO" (
	"idTipo" smallint NOT NULL,
	tipo varchar(50) NOT NULL,
	CONSTRAINT "TIPO_pk" PRIMARY KEY ("idTipo")
);
-- ddl-end --
ALTER TABLE public."TIPO" OWNER TO postgres;
-- ddl-end --

-- object: "TIPO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "TIPO_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "TIPO_fk" FOREIGN KEY ("idTipo_TIPO")
REFERENCES public."TIPO" ("idTipo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "ESTADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "ESTADO_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "ESTADO_fk" FOREIGN KEY ("idEdo_ESTADO")
REFERENCES public."ESTADO" ("idEdo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."TELEFONO" | type: TABLE --
-- DROP TABLE IF EXISTS public."TELEFONO" CASCADE;
CREATE TABLE public."TELEFONO" (
	"teléfono" varchar(10) NOT NULL,
	"numEmp_EMPLEADO" varchar(5),
	CONSTRAINT "TELEFONO_pk" PRIMARY KEY ("teléfono")
);
-- ddl-end --
ALTER TABLE public."TELEFONO" OWNER TO postgres;
-- ddl-end --

-- object: public."many_EMPLEADO_has_many_VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_EMPLEADO_has_many_VENTA" CASCADE;
CREATE TABLE public."many_EMPLEADO_has_many_VENTA" (
	"numEmp_EMPLEADO" varchar(5) NOT NULL,
	"folio_VENTA" varchar(7) NOT NULL,
	"numEmpCobrador" varchar(5) NOT NULL,
	CONSTRAINT "many_EMPLEADO_has_many_VENTA_pk" PRIMARY KEY ("numEmp_EMPLEADO","folio_VENTA")
);
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_EMPLEADO_has_many_VENTA" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."many_EMPLEADO_has_many_VENTA" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("numEmp_EMPLEADO")
REFERENCES public."EMPLEADO" ("numEmp") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "VENTA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_EMPLEADO_has_many_VENTA" DROP CONSTRAINT IF EXISTS "VENTA_fk" CASCADE;
ALTER TABLE public."many_EMPLEADO_has_many_VENTA" ADD CONSTRAINT "VENTA_fk" FOREIGN KEY ("folio_VENTA")
REFERENCES public."VENTA" (folio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."SUCURSAL" | type: TABLE --
-- DROP TABLE IF EXISTS public."SUCURSAL" CASCADE;
CREATE TABLE public."SUCURSAL" (
	"teléfonoSuc" varchar(10) NOT NULL,
	calle varchar(50) NOT NULL,
	colonia varchar(50) NOT NULL,
	"número" smallint NOT NULL,
	"codPostal" varchar(5) NOT NULL,
	"añoFund" smallint NOT NULL,
	"idEdo_ESTADO" smallint,
	CONSTRAINT "SUCURSAL_pk" PRIMARY KEY ("teléfonoSuc")
);
-- ddl-end --
ALTER TABLE public."SUCURSAL" OWNER TO postgres;
-- ddl-end --

-- object: "ESTADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."SUCURSAL" DROP CONSTRAINT IF EXISTS "ESTADO_fk" CASCADE;
ALTER TABLE public."SUCURSAL" ADD CONSTRAINT "ESTADO_fk" FOREIGN KEY ("idEdo_ESTADO")
REFERENCES public."ESTADO" ("idEdo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "SUCURSAL_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "SUCURSAL_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "SUCURSAL_fk" FOREIGN KEY ("teléfonoSuc_SUCURSAL")
REFERENCES public."SUCURSAL" ("teléfonoSuc") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."TELEFONO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."TELEFONO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("numEmp_EMPLEADO")
REFERENCES public."EMPLEADO" ("numEmp") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("numEmp_EMPLEADO")
REFERENCES public."EMPLEADO" ("numEmp") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


