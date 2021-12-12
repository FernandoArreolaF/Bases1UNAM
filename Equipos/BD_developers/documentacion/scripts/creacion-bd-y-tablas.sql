--@Autor: 	Carolina Rodriguez
--@Fecha:
--@Descripcion: Creacion de la base de datos y tablas

-------------------------------------------------------------------------------------------------------------------
-- Creacion BD 
-------------------------------------------------------------------------------------------------------------------
CREATE DATABASE papeleria
	WITH
	OWNER = postgres
	ENCODING = 'UTF-8'
	TABLESPACE = pg_default
	CONNECTION LIMIT -1;

-------------------------------------------------------------------------------------------------------------------
--Conexion a BD
-------------------------------------------------------------------------------------------------------------------
\c papeleria

-------------------------------------------------------------------------------------------------------------------
--Creacion de tablas
-------------------------------------------------------------------------------------------------------------------

--proveedor
CREATE TABLE proveedor
(
    id_proveedor serial NOT NULL,
    razon_social character varying(30) NOT NULL,
    nombre character varying(40) NOT NULL,
    ap_paterno character varying(40) NOT NULL,
    ap_materno character varying(40),
    estado character varying(20) NOT NULL,
    cp int NOT NULL,
    colonia character varying(30) NOT NULL,
    calle character varying(40) NOT NULL,
    numero bigint NOT NULL,
    constraint proveedor_pk PRIMARY KEY (id_proveedor),
    constraint proveedor_razon_social_uk UNIQUE (razon_social)
);

--tel_provedor
CREATE TABLE tel_proveedor
(
    id_tel_proveedor serial NOT NULL,
    telefono bigint NOT NULL,
    id_proveedor bigint NOT NULL,
    constraint tel_proveedor_pk PRIMARY KEY (id_tel_proveedor),
    constraint tel_proveedor_id_proveedor_fk FOREIGN KEY (id_proveedor)
    references proveedor(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE
);

--cliente
CREATE TABLE cliente
(
    rfc character varying(13) NOT NULL,
    nombre character varying(40) NOT NULL,
    ap_paterno character varying(40) NOT NULL,
    ap_materno character varying(40),
    estado character varying(20) NOT NULL,
    cp int NOT NULL,
    colonia character varying(30) NOT NULL,
    calle character varying(40) NOT NULL,
    numero bigint NOT NULL,
    constraint cliente_pk PRIMARY KEY (rfc)
);

--cliente_correo
CREATE TABLE cliente_correo
(
    id_cliente_correo serial NOT NULL,
    correo character varying(30) NOT NULL,
    rfc character varying(13) NOT NULL,
    constraint cliente_correo_pk PRIMARY KEY (id_cliente_correo),
    constraint cli_correo_rfc_fk FOREIGN KEY (rfc)
    references cliente(rfc) ON DELETE CASCADE ON UPDATE CASCADE
);

--categoria
CREATE TABLE categoria
(
    id_categoria serial NOT NULL,
    tipo character varying(20) NOT NULL,
    constraint categoria_pk PRIMARY KEY (id_categoria)
);

--articulo
CREATE TABLE articulo
(
    id_articulo serial NOT NULL,
    cod_barras character varying(13) NOT NULL,
    descripcion character varying(30) NOT NULL,
    marca character varying(20) NOT NULL,
    stock int NOT NULL,
    utilidad numeric(10,2) NOT NULL,
    costo_compra numeric(10,2) NOT NULL,
    precio_venta numeric(10,2) NOT NULL,
    fecha_compra date NOT NULL,
    id_categoria bigint NOT NULL,
    id_proveedor bigint NOT NULL,
    constraint articulo_pk PRIMARY KEY (id_articulo),
    constraint art_cod_barras_uk UNIQUE (cod_barras),
    constraint art_id_categoria_fk FOREIGN KEY (id_categoria)
    references categoria(id_categoria) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint art_id_proveedor_fk FOREIGN KEY (id_proveedor)
    references proveedor(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE
);

--venta
CREATE SEQUENCE venta_id_venta_seq
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE venta
(
    num_venta text NOT NULL DEFAULT 'VENT-'||nextval('venta_id_venta_seq'::regclass)::text,
    fecha_venta date NOT NULL,
    monto_total numeric(10,2) NOT NULL,
    rfc character varying(13) NOT NULL,
    constraint venta_pk PRIMARY KEY (num_venta),
    constraint venta_rfc_fk FOREIGN KEY (rfc)
    references cliente(rfc) ON DELETE CASCADE ON UPDATE CASCADE
);


--participa
CREATE TABLE participa
(
    id_articulo bigint NOT NULL,
    num_venta text NOT NULL,
    cantidad_articulo bigint NOT NULL,
    precio_tot_dart numeric(10,2) NOT NULL,
    constraint participa_id_articulo_fk FOREIGN KEY (id_articulo)
    references articulo(id_articulo) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint participa_num_venta_fk FOREIGN KEY (num_venta)
    references venta(num_venta) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint participa_av_pk PRIMARY KEY (id_articulo,num_venta)
);
-------------------------------------------------------------------------------------------------------------------