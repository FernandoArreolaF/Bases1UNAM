-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.1.6
-- PostgreSQL version: 17.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: muebleria | type: DATABASE --
-- DROP DATABASE IF EXISTS muebleria;
CREATE DATABASE muebleria;
-- ddl-end --


-- object: public."ARTICULO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ARTICULO" CASCADE;
CREATE TABLE public."ARTICULO" (
	codigo_de_barras varchar(20) NOT NULL,
	nombre_articulo varchar(100) NOT NULL,
	fotografia text,
	precio_de_venta numeric(10,2) NOT NULL,
	precio_de_compra numeric(10,2) NOT NULL,
	stock integer NOT NULL DEFAULT 0,
	"id_categoria_CATEGORIA" integer,
	CONSTRAINT "ARTICULO_pk" PRIMARY KEY (codigo_de_barras)
);
-- ddl-end --
ALTER TABLE public."ARTICULO" OWNER TO postgres;
-- ddl-end --

-- object: public."CATEGORIA" | type: TABLE --
-- DROP TABLE IF EXISTS public."CATEGORIA" CASCADE;
CREATE TABLE public."CATEGORIA" (
	id_categoria serial NOT NULL,
	nombre_categoria varchar(100) NOT NULL,
	CONSTRAINT "CATEGORIA_pk" PRIMARY KEY (id_categoria)
);
-- ddl-end --
ALTER TABLE public."CATEGORIA" OWNER TO postgres;
-- ddl-end --

-- object: public."VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."VENTA" CASCADE;
CREATE TABLE public."VENTA" (
	folio varchar(40) NOT NULL,
	fecha_venta timestamp NOT NULL DEFAULT now(),
	monto_total numeric(10,2) NOT NULL,
	cantidad_total_articulo integer NOT NULL,
	"id_sucursal_SUCURSAL" integer,
	"rfc_cliente_CLIENTE" char(13),
	"numero_empleado_VENDEDOR" integer,
	"numero_empleado_CAJERO" integer,
	CONSTRAINT "VENTA_pk" PRIMARY KEY (folio)
);
-- ddl-end --
ALTER TABLE public."VENTA" OWNER TO postgres;
-- ddl-end --

-- object: public."EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMPLEADO" CASCADE;
CREATE TABLE public."EMPLEADO" (
	numero_empleado serial NOT NULL,
	rfc_empleado char(13) NOT NULL,
	curp char(18) NOT NULL,
	email_empleado varchar(100) NOT NULL,
	fecha_ingreso date NOT NULL,
	codigo_postal char(5) NOT NULL,
	estado varchar(50) NOT NULL,
	calle varchar(50) NOT NULL,
	colonia varchar(50) NOT NULL,
	numero varchar(10) NOT NULL,
	"id_sucursal_SUCURSAL" integer,
	numero_supervisor integer,
	nombre varchar(100),
	apellido_paterno varchar(100),
	apellido_materno varchar(100),
	CONSTRAINT "EMPLEADO_pk" PRIMARY KEY (numero_empleado)
);
-- ddl-end --
ALTER TABLE public."EMPLEADO" OWNER TO postgres;
-- ddl-end --

-- object: public."PROVEEDOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROVEEDOR" CASCADE;
CREATE TABLE public."PROVEEDOR" (
	rfc char(30) NOT NULL,
	razon_social varchar(100) NOT NULL,
	telefono varchar(10) NOT NULL,
	cuenta_pago varchar(50) NOT NULL,
	colonia varchar(50) NOT NULL,
	codigo_postal varchar(5) NOT NULL,
	estado varchar(50) NOT NULL,
	calle varchar(50) NOT NULL,
	numero varchar(10) NOT NULL,
	CONSTRAINT "PROVEEDOR_pk" PRIMARY KEY (rfc)
);
-- ddl-end --
ALTER TABLE public."PROVEEDOR" OWNER TO postgres;
-- ddl-end --

-- object: public."ES_SURTIDO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ES_SURTIDO" CASCADE;
CREATE TABLE public."ES_SURTIDO" (
	fecha_surtido_cada_articulo date NOT NULL,
	"codigo_de_barras_ARTICULO" varchar(20) NOT NULL,
	"rfc_PROVEEDOR" char(30) NOT NULL,
	CONSTRAINT "ES_SURTIDO_pk" PRIMARY KEY ("codigo_de_barras_ARTICULO","rfc_PROVEEDOR")
);
-- ddl-end --

-- object: "ARTICULO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ES_SURTIDO" DROP CONSTRAINT IF EXISTS "ARTICULO_fk" CASCADE;
ALTER TABLE public."ES_SURTIDO" ADD CONSTRAINT "ARTICULO_fk" FOREIGN KEY ("codigo_de_barras_ARTICULO")
REFERENCES public."ARTICULO" (codigo_de_barras) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "PROVEEDOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ES_SURTIDO" DROP CONSTRAINT IF EXISTS "PROVEEDOR_fk" CASCADE;
ALTER TABLE public."ES_SURTIDO" ADD CONSTRAINT "PROVEEDOR_fk" FOREIGN KEY ("rfc_PROVEEDOR")
REFERENCES public."PROVEEDOR" (rfc) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "CATEGORIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ARTICULO" DROP CONSTRAINT IF EXISTS "CATEGORIA_fk" CASCADE;
ALTER TABLE public."ARTICULO" ADD CONSTRAINT "CATEGORIA_fk" FOREIGN KEY ("id_categoria_CATEGORIA")
REFERENCES public."CATEGORIA" (id_categoria) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."DETALLE_VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."DETALLE_VENTA" CASCADE;
CREATE TABLE public."DETALLE_VENTA" (
	cantidad_por_articulo integer NOT NULL,
	monto_por_articulo numeric(10,2) NOT NULL,
	"codigo_de_barras_ARTICULO" varchar(20) NOT NULL,
	"folio_VENTA" varchar(40) NOT NULL,
	CONSTRAINT "DETALLE_VENTA_pk" PRIMARY KEY ("codigo_de_barras_ARTICULO","folio_VENTA")
);
-- ddl-end --

-- object: "ARTICULO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."DETALLE_VENTA" DROP CONSTRAINT IF EXISTS "ARTICULO_fk" CASCADE;
ALTER TABLE public."DETALLE_VENTA" ADD CONSTRAINT "ARTICULO_fk" FOREIGN KEY ("codigo_de_barras_ARTICULO")
REFERENCES public."ARTICULO" (codigo_de_barras) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "VENTA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."DETALLE_VENTA" DROP CONSTRAINT IF EXISTS "VENTA_fk" CASCADE;
ALTER TABLE public."DETALLE_VENTA" ADD CONSTRAINT "VENTA_fk" FOREIGN KEY ("folio_VENTA")
REFERENCES public."VENTA" (folio) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public."SUCURSAL" | type: TABLE --
-- DROP TABLE IF EXISTS public."SUCURSAL" CASCADE;
CREATE TABLE public."SUCURSAL" (
	id_sucursal serial NOT NULL,
	estado varchar(50) NOT NULL,
	numero varchar(10) NOT NULL,
	codigo_postal char(5) NOT NULL,
	colonia varchar(50) NOT NULL,
	calle varchar(50) NOT NULL,
	telefono_sucursal varchar(10) NOT NULL,
	anio_fundacion smallint NOT NULL,
	CONSTRAINT "SUCURSAL_pk" PRIMARY KEY (id_sucursal)
);
-- ddl-end --
ALTER TABLE public."SUCURSAL" OWNER TO postgres;
-- ddl-end --

-- object: "SUCURSAL_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "SUCURSAL_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "SUCURSAL_fk" FOREIGN KEY ("id_sucursal_SUCURSAL")
REFERENCES public."SUCURSAL" (id_sucursal) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."CLIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."CLIENTE" CASCADE;
CREATE TABLE public."CLIENTE" (
	rfc_cliente char(13) NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido_paterno varchar(50) NOT NULL,
	apellido_materno varchar(50),
	razon_social_cliente varchar(150) NOT NULL,
	email_cliente varchar(100) NOT NULL,
	telefono_cliente varchar(10) NOT NULL,
	estado varchar(50) NOT NULL,
	calle varchar(50) NOT NULL,
	codigo_postal char(5) NOT NULL,
	numero varchar(10),
	colonia varchar(50) NOT NULL,
	CONSTRAINT "CLIENTE_pk" PRIMARY KEY (rfc_cliente)
);
-- ddl-end --
ALTER TABLE public."CLIENTE" OWNER TO postgres;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("rfc_cliente_CLIENTE")
REFERENCES public."CLIENTE" (rfc_cliente) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."FACTURA" | type: TABLE --
-- DROP TABLE IF EXISTS public."FACTURA" CASCADE;
CREATE TABLE public."FACTURA" (
	id_factura serial NOT NULL,
	"folio_VENTA" varchar(40),
	"rfc_cliente_CLIENTE" char(13),
	fecha_emision date NOT NULL,
	forma_pago varchar(50) NOT NULL,
	impuestos decimal(10,2) NOT NULL,
	descuento decimal(10,2) NOT NULL DEFAULT 0,
	CONSTRAINT "Facturazion_pk" PRIMARY KEY (id_factura)
);
-- ddl-end --
ALTER TABLE public."FACTURA" OWNER TO postgres;
-- ddl-end --

-- object: "SUCURSAL_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "SUCURSAL_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "SUCURSAL_fk" FOREIGN KEY ("id_sucursal_SUCURSAL")
REFERENCES public."SUCURSAL" (id_sucursal) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."LIMPIEZA" | type: TABLE --
-- DROP TABLE IF EXISTS public."LIMPIEZA" CASCADE;
CREATE TABLE public."LIMPIEZA" (
-- 	numero_empleado integer NOT NULL,
-- 	rfc_empleado char(13) NOT NULL,
-- 	curp char(18) NOT NULL,
-- 	email_empleado varchar(100) NOT NULL,
-- 	fecha_ingreso date NOT NULL,
-- 	codigo_postal char(5) NOT NULL,
-- 	estado varchar(50) NOT NULL,
-- 	calle varchar(50) NOT NULL,
-- 	colonia varchar(50) NOT NULL,
-- 	numero varchar(10) NOT NULL,
-- 	numero_supervisor integer,
-- 	nombre varchar(100),
-- 	apellido_paterno varchar(100),
-- 	apellido_materno varchar(100),
-- 	"id_sucursal_SUCURSAL" integer,
	CONSTRAINT "LIMPIEZA_pk" PRIMARY KEY (numero_empleado)
)
 INHERITS(public."EMPLEADO");
-- ddl-end --
ALTER TABLE public."LIMPIEZA" OWNER TO postgres;
-- ddl-end --

-- object: public."CAJERO" | type: TABLE --
-- DROP TABLE IF EXISTS public."CAJERO" CASCADE;
CREATE TABLE public."CAJERO" (
-- 	numero_empleado integer NOT NULL,
-- 	rfc_empleado char(13) NOT NULL,
-- 	curp char(18) NOT NULL,
-- 	email_empleado varchar(100) NOT NULL,
-- 	fecha_ingreso date NOT NULL,
-- 	codigo_postal char(5) NOT NULL,
-- 	estado varchar(50) NOT NULL,
-- 	calle varchar(50) NOT NULL,
-- 	colonia varchar(50) NOT NULL,
-- 	numero varchar(10) NOT NULL,
-- 	numero_supervisor integer,
-- 	nombre varchar(100),
-- 	apellido_paterno varchar(100),
-- 	apellido_materno varchar(100),
-- 	"id_sucursal_SUCURSAL" integer,
	CONSTRAINT "CAJERO_pk" PRIMARY KEY (numero_empleado)
)
 INHERITS(public."EMPLEADO");
-- ddl-end --
ALTER TABLE public."CAJERO" OWNER TO postgres;
-- ddl-end --

-- object: public."VENDEDOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."VENDEDOR" CASCADE;
CREATE TABLE public."VENDEDOR" (
-- 	numero_empleado integer NOT NULL,
-- 	rfc_empleado char(13) NOT NULL,
-- 	curp char(18) NOT NULL,
-- 	email_empleado varchar(100) NOT NULL,
-- 	fecha_ingreso date NOT NULL,
-- 	codigo_postal char(5) NOT NULL,
-- 	estado varchar(50) NOT NULL,
-- 	calle varchar(50) NOT NULL,
-- 	colonia varchar(50) NOT NULL,
-- 	numero varchar(10) NOT NULL,
-- 	numero_supervisor integer,
-- 	nombre varchar(100),
-- 	apellido_paterno varchar(100),
-- 	apellido_materno varchar(100),
-- 	"id_sucursal_SUCURSAL" integer,
	CONSTRAINT "VENDEDOR_pk" PRIMARY KEY (numero_empleado)
)
 INHERITS(public."EMPLEADO");
-- ddl-end --
ALTER TABLE public."VENDEDOR" OWNER TO postgres;
-- ddl-end --

-- object: public."SEGURIDAD" | type: TABLE --
-- DROP TABLE IF EXISTS public."SEGURIDAD" CASCADE;
CREATE TABLE public."SEGURIDAD" (
-- 	numero_empleado integer NOT NULL,
-- 	rfc_empleado char(13) NOT NULL,
-- 	curp char(18) NOT NULL,
-- 	email_empleado varchar(100) NOT NULL,
-- 	fecha_ingreso date NOT NULL,
-- 	codigo_postal char(5) NOT NULL,
-- 	estado varchar(50) NOT NULL,
-- 	calle varchar(50) NOT NULL,
-- 	colonia varchar(50) NOT NULL,
-- 	numero varchar(10) NOT NULL,
-- 	numero_supervisor integer,
-- 	nombre varchar(100),
-- 	apellido_paterno varchar(100),
-- 	apellido_materno varchar(100),
-- 	"id_sucursal_SUCURSAL" integer,
	CONSTRAINT "SEGURIDAD_pk" PRIMARY KEY (numero_empleado)
)
 INHERITS(public."EMPLEADO");
-- ddl-end --
ALTER TABLE public."SEGURIDAD" OWNER TO postgres;
-- ddl-end --

-- object: public."ADMINISTRATIVO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ADMINISTRATIVO" CASCADE;
CREATE TABLE public."ADMINISTRATIVO" (
-- 	numero_empleado integer NOT NULL,
-- 	rfc_empleado char(13) NOT NULL,
-- 	curp char(18) NOT NULL,
-- 	email_empleado varchar(100) NOT NULL,
-- 	fecha_ingreso date NOT NULL,
-- 	codigo_postal char(5) NOT NULL,
-- 	estado varchar(50) NOT NULL,
-- 	calle varchar(50) NOT NULL,
-- 	colonia varchar(50) NOT NULL,
-- 	numero varchar(10) NOT NULL,
-- 	numero_supervisor integer,
-- 	nombre varchar(100),
-- 	apellido_paterno varchar(100),
-- 	apellido_materno varchar(100),
-- 	"id_sucursal_SUCURSAL" integer,
	CONSTRAINT "ADMINISTRATIVO_pk" PRIMARY KEY (numero_empleado)
)
 INHERITS(public."EMPLEADO");
-- ddl-end --
ALTER TABLE public."ADMINISTRATIVO" OWNER TO postgres;
-- ddl-end --

-- object: "VENDEDOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "VENDEDOR_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "VENDEDOR_fk" FOREIGN KEY ("numero_empleado_VENDEDOR")
REFERENCES public."VENDEDOR" (numero_empleado) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "CAJERO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "CAJERO_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "CAJERO_fk" FOREIGN KEY ("numero_empleado_CAJERO")
REFERENCES public."CAJERO" (numero_empleado) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "VENTA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."FACTURA" DROP CONSTRAINT IF EXISTS "VENTA_fk" CASCADE;
ALTER TABLE public."FACTURA" ADD CONSTRAINT "VENTA_fk" FOREIGN KEY ("folio_VENTA")
REFERENCES public."VENTA" (folio) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "FACTURA_uq" | type: CONSTRAINT --
-- ALTER TABLE public."FACTURA" DROP CONSTRAINT IF EXISTS "FACTURA_uq" CASCADE;
ALTER TABLE public."FACTURA" ADD CONSTRAINT "FACTURA_uq" UNIQUE ("folio_VENTA");
-- ddl-end --

-- object: public."TELEFONO_EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."TELEFONO_EMPLEADO" CASCADE;
CREATE TABLE public."TELEFONO_EMPLEADO" (
	id_telefono serial NOT NULL,
	telefono_empleado varchar(10) NOT NULL,
	"numero_empleado_EMPLEADO" integer,
	CONSTRAINT "TELEFONO_EMPLEADO_pk" PRIMARY KEY (id_telefono)
);
-- ddl-end --
ALTER TABLE public."TELEFONO_EMPLEADO" OWNER TO postgres;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."TELEFONO_EMPLEADO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."TELEFONO_EMPLEADO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("numero_empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (numero_empleado) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."FACTURA" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public."FACTURA" ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("rfc_cliente_CLIENTE")
REFERENCES public."CLIENTE" (rfc_cliente) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_empleado_supervisor | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS fk_empleado_supervisor CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT fk_empleado_supervisor FOREIGN KEY (numero_supervisor)
REFERENCES public."EMPLEADO" (numero_empleado) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


