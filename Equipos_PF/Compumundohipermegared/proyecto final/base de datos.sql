--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 12.2 (Ubuntu 12.2-4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: actualiza_stock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualiza_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (select stock < new.cantidad from producto where codigo_Barras = new.codigo_Barras) THEN
		RAISE EXCEPTION 'No hay existencias suficientes';
	ELSEIF(select stock >= new.cantidad from producto where codigo_Barras = new.codigo_Barras) THEN
			UPDATE PRODUCTO
			SET stock = stock - new.cantidad
			where codigo_Barras = new.codigo_Barras;
			if (select stock < 3 from producto where codigo_Barras = new.codigo_Barras) THEN
				RAISE NOTICE 'Quedan menos de 3 existencias en stock';
			end if;
			return new;
	END IF;
END;
$$;


ALTER FUNCTION public.actualiza_stock() OWNER TO postgres;

--
-- Name: poco_stock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.poco_stock() RETURNS TABLE(descripcion character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT pd.descripcion FROM producto pd WHERE stock < 3;
END;
$$;


ALTER FUNCTION public.poco_stock() OWNER TO postgres;

--
-- Name: total_vendido(date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.total_vendido(fecini date, fecfin date) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT SUM(pago_total) FROM venta WHERE fecha_venta BETWEEN fecini AND fecfin);
END;
$$;


ALTER FUNCTION public.total_vendido(fecini date, fecfin date) OWNER TO postgres;

--
-- Name: utilidad(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.utilidad(cod_bar integer) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN precio_venta-precio_adq FROM producto WHERE codigo_barras=cod_bar;
END;
$$;


ALTER FUNCTION public.utilidad(cod_bar integer) OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    email character varying(30) NOT NULL,
    id_persona integer NOT NULL,
    ap_pat character varying(25) NOT NULL,
    ap_mat character varying(25)
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: detalle_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_venta (
    codigo_barras integer NOT NULL,
    numero_venta character varying(10) NOT NULL,
    pago_producto double precision NOT NULL,
    cantidad integer NOT NULL,
    CONSTRAINT ck_pago CHECK ((pago_producto > (0)::double precision))
);


ALTER TABLE public.detalle_venta OWNER TO postgres;

--
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    id_persona integer NOT NULL,
    razon_social character varying(30) NOT NULL,
    nombre character varying(20) NOT NULL,
    calle character varying(20) NOT NULL,
    numero integer NOT NULL,
    colonia character varying(20) NOT NULL,
    codigo_postal integer NOT NULL,
    estado character varying(20) NOT NULL,
    tipo character varying(1) NOT NULL,
    CONSTRAINT persona_tipo_check CHECK ((((tipo)::text = 'c'::text) OR ((tipo)::text = 'p'::text)))
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    codigo_barras integer NOT NULL,
    marca character varying(20) NOT NULL,
    precio_adq double precision NOT NULL,
    precio_venta double precision NOT NULL,
    fecha_compra date NOT NULL,
    stock integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    telefono bigint NOT NULL,
    id_persona integer NOT NULL,
    CONSTRAINT ck_precioadq CHECK ((precio_adq > (0)::double precision)),
    CONSTRAINT ck_precioventa CHECK ((precio_venta > (0)::double precision))
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- Name: secuencia_pkventa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia_pkventa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia_pkventa OWNER TO postgres;

--
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta (
    numero_venta character varying(10) DEFAULT ('VENT-'::text || nextval('public.secuencia_pkventa'::regclass)) NOT NULL,
    fecha_venta date NOT NULL,
    pago_total double precision NOT NULL,
    email character varying(30) NOT NULL,
    id_persona integer NOT NULL,
    CONSTRAINT ck_pagototal CHECK ((pago_total > (0)::double precision))
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- Name: factura; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.factura AS
 SELECT dv.numero_venta,
    dv.codigo_barras,
    p.descripcion,
    dv.cantidad,
    dv.pago_producto,
    v.pago_total,
    v.fecha_venta,
    v.id_persona,
    per.nombre,
    v.email
   FROM (((public.detalle_venta dv
     JOIN public.venta v ON (((dv.numero_venta)::text = (v.numero_venta)::text)))
     JOIN public.producto p ON ((dv.codigo_barras = p.codigo_barras)))
     JOIN public.persona per ON ((per.id_persona = v.id_persona)));


ALTER TABLE public.factura OWNER TO postgres;

--
-- Name: proveedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedor (
    telefono bigint NOT NULL,
    id_persona integer NOT NULL
);


ALTER TABLE public.proveedor OWNER TO postgres;

--
-- Name: secuencia_idpersona; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia_idpersona
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia_idpersona OWNER TO postgres;

--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido character varying(20),
    usuario character varying(15) NOT NULL,
    "contraseña" character varying(15) NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (email, id_persona, ap_pat, ap_mat) FROM stdin;
cesarhotline@hotmail.com	4	Gutierrez	\N
cesar@hotmail.com	4	Gutierrez	\N
alfredo@hotmail.com	5	Nava	\N
alfred_nava@hotmail.com	5	Nava	\N
miguel@hotmail.com	6	Guzmán	\N
mguzmang@hotmail.com	6	Guzmán	\N
fer.arreola@gmail.com	7	Arreola	\N
jose.23@gmail.com	9	Perez	Suarez
\.


--
-- Data for Name: detalle_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_venta (codigo_barras, numero_venta, pago_producto, cantidad) FROM stdin;
96814	VENT-2	7	1
96816	VENT-2	7	1
96817	VENT-2	7	1
591242	VENT-2	9.5	1
96815	VENT-3	7	3
639120	VENT-4	15	1
96815	VENT-5	7	1
\.


--
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona (id_persona, razon_social, nombre, calle, numero, colonia, codigo_postal, estado, tipo) FROM stdin;
1	Barrilito S.A.	Barrilito	65	74	Del Valle	59687	CDMX	p
2	Mirado S.A de C.V.	Mirado	Chinampa	4	El Rosario	1434	CDMX	p
3	Papelera S.A.	Bristol	Cuahutemoc	640	Copilco El Alto	47532	Hidalgo	p
4		Cesar	Petroleos	72	Villada	57800	Estado de México	c
5		Alfredo	Cuamiagua	97	Santo Domingo	4369	CDMX	c
6		Miguel	Calle 33	23	Estado de México	57210	Estado de México	c
7	UNAM	Fernando	5 de mayo	56	Del valle	686868	CDMX	c
8	Bic. S.A.	Bic	Hidalgo	56	Santo Domingo	4369	CDMX	p
9	IPN	Jose	Morelos	56	Centro	56502312	CDMX	c
10	PaperMate S.A. de C.V.	PaperMate	Del Moral	56	Doctores	56535251	CDMX	p
\.


--
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto (codigo_barras, marca, precio_adq, precio_venta, fecha_compra, stock, descripcion, telefono, id_persona) FROM stdin;
659363	Barrilito	4.5	10	2020-05-16	50	TIJERAS	5573857234	1
920832	Mirado	2	6	2020-02-03	50	LAPÍZ	5578254510	2
96813	Mirado	2.60000000000000009	7	2020-02-03	50	PLUMA NEGRA PUNTO MEDIO	5578254510	2
96818	Mirado	2.60000000000000009	7	2020-02-03	50	PLUMA AZUL PUNTO MEDIO	5578254510	2
945562	Bristol	1.19999999999999996	5	2020-01-23	50	CARTULINA	8764659213	3
945563	Bristol	1.19999999999999996	5	2020-01-23	50	CARTULINA DE COLOR	8764659213	3
96814	Mirado	2.60000000000000009	7	2020-02-03	49	PLUMA NEGRA PUNTO FINO	5578254510	2
96816	Mirado	2.60000000000000009	7	2020-02-03	49	PLUMA ROJA PUNTO FINO	5578254510	2
96817	Mirado	2.60000000000000009	7	2020-02-03	49	PLUMA AZUL PUNTO FINO	5578254510	2
591242	Barrilito	3.5	9.5	2020-01-20	49	CRAYONES	5573857234	1
639120	Barrilito	5.5	15	2020-01-20	49	JUEGO DE GEOMETRÍA	5573857234	1
96815	Mirado	2.60000000000000009	7	2020-02-03	46	PLUMA ROJA PUNTO MEDIO	5578254510	2
47261	Berol	19.9899999999999984	28	2020-05-10	50	CAJA DE 12 COLORES	5573857234	1
123654	Factis	3.5	5	2020-05-18	30	GOMA	4098672543	3
\.


--
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedor (telefono, id_persona) FROM stdin;
5573857234	1
5578254510	2
8764659213	3
5510945756	1
5538972734	2
4098672543	3
5569362412	8
5522412389	8
5533669988	10
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, nombre, apellido, usuario, "contraseña") FROM stdin;
3	Alfredo	Nava	anava1	P4p3l3r14
1	Cesar	Gutierrez	cgutierrez1	P4p3l3r14
2	Miguel	Guzmán	mguzman1	P4p3l3r14
\.


--
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venta (numero_venta, fecha_venta, pago_total, email, id_persona) FROM stdin;
VENT-2	2020-05-16	30.5	cesarhotline@hotmail.com	4
VENT-3	2020-05-16	28	cesarhotline@hotmail.com	4
VENT-4	2020-05-16	15	alfred_nava@hotmail.com	5
VENT-5	2020-05-16	7	miguel@hotmail.com	6
\.


--
-- Name: secuencia_idpersona; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia_idpersona', 1, false);


--
-- Name: secuencia_pkventa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia_pkventa', 1, false);


--
-- Name: persona persona_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pk PRIMARY KEY (id_persona);


--
-- Name: cliente pk_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (email, id_persona);


--
-- Name: detalle_venta pk_detalleventa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT pk_detalleventa PRIMARY KEY (codigo_barras, numero_venta);


--
-- Name: proveedor pk_proveedor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT pk_proveedor PRIMARY KEY (telefono, id_persona);


--
-- Name: venta pk_venta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT pk_venta PRIMARY KEY (numero_venta);


--
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (codigo_barras);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- Name: idx_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_name ON public.persona USING hash (nombre);


--
-- Name: detalle_venta trigger_actualiza_stock; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_actualiza_stock BEFORE INSERT ON public.detalle_venta FOR EACH ROW EXECUTE PROCEDURE public.actualiza_stock();


--
-- Name: venta fk_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_cliente FOREIGN KEY (email, id_persona) REFERENCES public.cliente(email, id_persona);


--
-- Name: detalle_venta fk_codigobarras; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_codigobarras FOREIGN KEY (codigo_barras) REFERENCES public.producto(codigo_barras);


--
-- Name: proveedor fk_idpersona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT fk_idpersona FOREIGN KEY (id_persona) REFERENCES public.persona(id_persona);


--
-- Name: cliente fk_idpersona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_idpersona FOREIGN KEY (id_persona) REFERENCES public.persona(id_persona);


--
-- Name: detalle_venta fk_numeroventa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_numeroventa FOREIGN KEY (numero_venta) REFERENCES public.venta(numero_venta);


--
-- Name: producto fk_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_proveedor FOREIGN KEY (telefono, id_persona) REFERENCES public.proveedor(telefono, id_persona);


--
-- PostgreSQL database dump complete
--

