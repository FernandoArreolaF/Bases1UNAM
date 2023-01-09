-- Model Authors: ---
-- Carranza Ochoa José David,
-- Casique Corona Luis Enrique,
-- Sanchez de Santiago Julián,
-- Salgado Miranda Jorge,


-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE codders_muebleria;
-- ddl-end --
\c codders_muebleria

-- object: public."ARTICULO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ARTICULO" CASCADE;
CREATE TABLE public.ARTICULO (
	codigo_barras bigint NOT NULL,
	nombre varchar(50) NOT NULL,
	precio_compra numeric(8,2) NOT NULL,
	precio_venta numeric(8,2) NOT NULL,
	stock smallint NOT NULL,
	fotografia text NOT NULL,
	"id_categoria" integer NOT NULL,
	CONSTRAINT "ARTICULO_pk" PRIMARY KEY (codigo_barras)
);

-- object: public."CATEGORIA" | type: TABLE --
-- DROP TABLE IF EXISTS public."CATEGORIA" CASCADE;
CREATE TABLE public.CATEGORIA (
	id_categoria integer NOT NULL,
	nombre varchar(50) NOT NULL,
	descripcion text NOT NULL,
	CONSTRAINT "CATEGORIA_pk" PRIMARY KEY (id_categoria)
);

-- object: public."PROVEEDOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROVEEDOR" CASCADE;
CREATE TABLE public.PROVEEDOR (
	rfc char(13) NOT NULL,
	telefono bigint NOT NULL,
	razon_social varchar(50) UNIQUE NOT NULL,
	cuenta_pago bigint NOT NULL,
	numero_exterior smallint NOT NULL,
	estado varchar(40) NOT NULL,
	numero_interior smallint NOT NULL,
	codigo_postal bigint NOT NULL,
	calle varchar(50) NOT NULL,
	CONSTRAINT "PROVEEDOR_pk" PRIMARY KEY (rfc)
);

-- object: public."VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."VENTA" CASCADE;
CREATE TABLE public.VENTA (
	folio char(7) NOT NULL,
	fecha timestamp NOT NULL,
	monto_total numeric(8,2)  NULL,
	cantidad_total smallint  NULL,
	"rfc_CLIENTE" char(13) NULL,
	"id_empleado" integer NOT NULL,
	"id_empleado1" integer NOT NULL,
	CONSTRAINT "VENTA_pk" PRIMARY KEY (folio)
);

-- object: public."CLIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."CLIENTE" CASCADE;
CREATE TABLE public.CLIENTE (
	rfc char(13) NOT NULL,
	email varchar(100) NOT NULL,
	nombre varchar(60) NOT NULL,
	apellido_paterno varchar(40) NOT NULL,
	apellido_materno varchar(40),
	codigo_postal bigint NOT NULL,
	calle varchar(50) NOT NULL,
	numero_interior smallint NOT NULL,
	numero_exterior smallint NOT NULL,
	estado varchar(50) NOT NULL,
	razon_social varchar(150) UNIQUE NULL,
	CONSTRAINT "CLIENTE_pk" PRIMARY KEY (rfc)
);


-- object: public."EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMPLEADO" CASCADE;
CREATE TABLE public.EMPLEADO(
	id_empleado integer NOT NULL,
	curp char(18) UNIQUE NOT NULL,
	rfc char(13) UNIQUE NOT NULL,
	nombre varchar(60) NOT NULL,
	apellido_paterno varchar(40) NOT NULL,
	apellido_materno varchar(40),
	fecha_ingreso date NOT NULL,
	tipo char(1) NOT NULL,
	email varchar(100) NOT NULL,
	numero_exterior smallint NOT NULL,
	numero_interior smallint NOT NULL,
	estado varchar(50) NOT NULL,
	codigo_postal bigint NOT NULL,
	calle varchar(50) NOT NULL,
	"id_sucursal" integer NOT NULL,
	"id_empleado1" integer NOT NULL,
	CONSTRAINT "EMPLEADO_pk" PRIMARY KEY (id_empleado)
);
-- ddl-end --

-- object: public."TELEFONO" | type: TABLE --
-- DROP TABLE IF EXISTS public."TELEFONO" CASCADE;
CREATE TABLE public.TELEFONO (
	num_tel serial NOT NULL,
	telefono_empleado bigint NOT NULL,
	"id_empleado" integer NOT NULL,
	CONSTRAINT "TELEFONO_pk" PRIMARY KEY (num_tel,id_empleado)
);

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."TELEFONO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public.TELEFONO ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("id_empleado")
REFERENCES public.EMPLEADO (id_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."SUCURSAL" | type: TABLE --
-- DROP TABLE IF EXISTS public."SUCURSAL" CASCADE;
CREATE TABLE public.SUCURSAL (
	id_sucursal integer NOT NULL,
	anio_fundacion date NOT NULL,
	telefono bigint NOT NULL,
	numero_exterior smallint NOT NULL,
	numero_interior smallint NOT NULL,
	estado varchar(50) NOT NULL,
	codigo_postal bigint NOT NULL,
	calle varchar(50) NOT NULL,
	CONSTRAINT "SUCURSAL_pk" PRIMARY KEY (id_sucursal)
);
-- ddl-end --
ALTER TABLE public.SUCURSAL OWNER TO mdthlconjlitvq;
-- ddl-end --

-- object: public."PROVEE" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROVEE" CASCADE;
CREATE TABLE public.PROVEE (
	"rfc" varchar(13) NOT NULL,
	"codigo_barras" bigint NOT NULL,
	fecha_comienzo date NOT NULL,
	CONSTRAINT "PROVEE_pk" PRIMARY KEY ("rfc","codigo_barras")
);
-- ddl-end --

-- object: public."ES_VENDIDO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ES_VENDIDO" CASCADE;
CREATE TABLE public.ES_VENDIDO (
	"folio" char(7) NOT NULL,
	"codigo_barras" bigint NOT NULL,
	monto numeric(8,2) NULL,
	cantidad smallint NOT NULL,
	finish boolean NOT NULL,
	CONSTRAINT "ES_VENDIDO_pk" PRIMARY KEY ("folio","codigo_barras")
);
-- ddl-end --

create table EMPLEADO_ESTADO(
	codigo_postal bigint NOT NULL,
	estado varchar(40) NOT NULL,
	CONSTRAINT "empleado_cp_pk" PRIMARY KEY (codigo_postal)
);

create table PROVEEDOR_ESTADO(
	codigo_postal bigint NOT NULL,
	estado varchar(40) NOT NULL,
	CONSTRAINT "proveedor_cp_pk" PRIMARY KEY (codigo_postal)
);

create table CLIENTE_ESTADO(
	codigo_postal bigint NOT NULL,
	estado varchar(40) NOT NULL,
	CONSTRAINT "cliente_cp_pk" PRIMARY KEY (codigo_postal)
);

create table SUCURSAL_ESTADO(
	codigo_postal bigint NOT NULL,
	estado varchar(40) NOT NULL,
	CONSTRAINT "sucursal_cp_pk" PRIMARY KEY (codigo_postal)
);

CREATE VIEW vis_articulos_cat_prov AS
	select a.nombre,a.precio_venta,a.fotografia,c.nombre categoria,c.descripcion,p.razon_social empresa FROM articulo a
	LEFT JOIN categoria c ON a.id_categoria=c.id_categoria
	LEFT JOIN provee pe ON a.codigo_barras=pe.codigo_barras
	LEFT JOIN proveedor p ON p.rfc=pe.rfc;
	

-- object: "Verificadores de valores positivos" | type: CONSTRAINT --
ALTER TABLE public.ARTICULO ADD CONSTRAINT "verifica_Stock" CHECK(stock>=0);
ALTER TABLE public.ARTICULO ADD CONSTRAINT "verifica_PreV" CHECK(precio_venta>=0.00);
ALTER TABLE public.ARTICULO ADD CONSTRAINT "verifica_PreC" CHECK(precio_compra>=0.00);
ALTER TABLE public.ES_VENDIDO ADD CONSTRAINT "verifica_MonArt" CHECK(monto>=0.00);
ALTER TABLE public.ES_VENDIDO ADD CONSTRAINT "verifica_CantArt" CHECK(cantidad>=0);
ALTER TABLE public.VENTA ADD CONSTRAINT "verifica_CantTot" CHECK(cantidad_total>=0);
ALTER TABLE public.VENTA ADD CONSTRAINT "verifica_MontTot" CHECK(monto_total>=0.00);
-- ddl-end --

-- object: "PROVEEDOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PROVEE" DROP CONSTRAINT IF EXISTS "PROVEEDOR_fk" CASCADE;
ALTER TABLE public.PROVEE ADD CONSTRAINT "PROVEEDOR_fk" FOREIGN KEY ("rfc")
REFERENCES public.PROVEEDOR (rfc) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "ARTICULO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PROVEE" DROP CONSTRAINT IF EXISTS "ARTIC ULO_fk" CASCADE;
ALTER TABLE public.PROVEE ADD CONSTRAINT "ARTICULO_fk" FOREIGN KEY ("codigo_barras")
REFERENCES public.ARTICULO (codigo_barras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CATEGORIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ARTICULO" DROP CONSTRAINT IF EXISTS "CATEGORIA_fk" CASCADE;
ALTER TABLE public.ARTICULO ADD CONSTRAINT "CATEGORIA_fk" FOREIGN KEY ("id_categoria")
REFERENCES public.CATEGORIA (id_categoria) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "VENTA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ES_VENDIDO" DROP CONSTRAINT IF EXISTS "VENTA_fk" CASCADE;
ALTER TABLE public.ES_VENDIDO ADD CONSTRAINT "VENTA_fk" FOREIGN KEY ("folio")
REFERENCES public.VENTA (folio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "ARTICULO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ES_VENDIDO" DROP CONSTRAINT IF EXISTS "ARTIC ULO_fk" CASCADE;
ALTER TABLE public.ES_VENDIDO ADD CONSTRAINT "ARTICULO_fk" FOREIGN KEY ("codigo_barras")
REFERENCES public.ARTICULO (codigo_barras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public.VENTA ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("rfc_CLIENTE")
REFERENCES public.CLIENTE (rfc) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public.VENTA ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("id_empleado")
REFERENCES public.EMPLEADO (id_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk1" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk1" CASCADE;
ALTER TABLE public.VENTA ADD CONSTRAINT "EMPLEADO_fk1" FOREIGN KEY ("id_empleado1")
REFERENCES public.EMPLEADO (id_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "SUCURSAL_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "SUCURSAL_fk" CASCADE;
ALTER TABLE public.EMPLEADO ADD CONSTRAINT "SUCURSAL_fk" FOREIGN KEY ("id_sucursal")
REFERENCES public.SUCURSAL (id_sucursal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public.EMPLEADO ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("id_empleado")
REFERENCES public.EMPLEADO (id_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


ALTER TABLE public.EMPLEADO ADD CONSTRAINT "empleado_cp__fk" FOREIGN KEY ("codigo_postal")
REFERENCES public.EMPLEADO_ESTADO (codigo_postal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;


ALTER TABLE public.PROVEEDOR ADD CONSTRAINT "proveedor_cp__fk" FOREIGN KEY ("codigo_postal")
REFERENCES public.PROVEEDOR_ESTADO (codigo_postal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE public.CLIENTE ADD CONSTRAINT "cliente_cp__fk" FOREIGN KEY ("codigo_postal")
REFERENCES public.CLIENTE_ESTADO (codigo_postal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE public.SUCURSAL ADD CONSTRAINT "sucursal_cp__fk" FOREIGN KEY ("codigo_postal")
REFERENCES public.SUCURSAL_ESTADO (codigo_postal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;