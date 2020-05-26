--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: getlowstock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getlowstock() RETURNS TABLE(codigobarras integer, nombreproducto character varying)
    LANGUAGE plpgsql
    AS $$ 

BEGIN

RETURN QUERY SELECT p.codigoBarras as codigoBarras, p.nombreProducto as nombreProducto 

FROM producto p

WHERE p.stock < 3;

END; $$;


ALTER FUNCTION public.getlowstock() OWNER TO postgres;

--
-- Name: insertorden(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insertorden() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE _auxString varchar(3);

BEGIN

SELECT to_char(NEXTVAL('serializacion'),'fm000') into _auxString;

NEW.numVenta := CONCAT('VENT-',_auxString);

RETURN NEW;

END; $$;


ALTER FUNCTION public.insertorden() OWNER TO postgres;

--
-- Name: stockdec(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.stockdec() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE _dispA integer;

DECLARE _price decimal(6,2);

BEGIN 

SELECT stock p INTO _dispA from producto p WHERE p.codigoBarras = new.codigoBarras;

SELECT precioVenta p INTO _price from producto p WHERE p.codigoBarras = new.codigoBarras;

--SELECT new.cantidadArticulos INTO _dispB from NEW;

IF (_dispA >= new.cantidadArticulos) THEN

if(_dispA < 3) THEN

RAISE NOTICE 'Advertencia: Queda(n) % articulo(s) en stock!',_dispA-new.cantidadArticulos;

end if;

UPDATE producto 

SET stock = _dispA - new.cantidadArticulos 

WHERE producto.codigoBarras = new.codigoBarras;



new.subtotal := new.cantidadArticulos*_price;

--new.numVenta := (SELECT numVenta from orden ORDER BY numVenta DESC LIMIT 1);

UPDATE orden

SET total=total+(new.cantidadArticulos*_price)

WHERE orden.numVenta = new.numVenta;

RETURN NEW;

else

RAISE EXCEPTION 'No hay suficiente stock, queda(n) % pieza(s) en stock',  _dispA ;

END IF;

END;

$$;


ALTER FUNCTION public.stockdec() OWNER TO postgres;

--
-- Name: stockplus(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.stockplus() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE _dispA integer;

DECLARE _price decimal(6,2);

BEGIN 

SELECT stock p INTO _dispA from producto p WHERE p.codigoBarras = old.codigoBarras;

SELECT precioVenta p INTO _price from producto p WHERE p.codigoBarras = old.codigoBarras;

--SELECT new.cantidadArticulos INTO _dispB from NEW;

UPDATE producto 

SET stock = _dispA + old.cantidadArticulos 

WHERE producto.codigoBarras = old.codigoBarras;



--old.numVenta := (SELECT numVenta from orden ORDER BY numVenta DESC LIMIT 1);



UPDATE orden

SET total=total-(old.cantidadArticulos*_price)

WHERE orden.numVenta = old.numVenta;

RETURN OLD;

END;

$$;


ALTER FUNCTION public.stockplus() OWNER TO postgres;

--
-- Name: ultimaventa(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ultimaventa(cd integer, qty integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

BEGIN

INSERT INTO detalle_orden(codigoBarras,numventa,cantidadArticulos) VALUES(cd,(SELECT numventa from orden ORDER BY numventa DESC LIMIT 1),qty);

RETURN 1;

END;$$;


ALTER FUNCTION public.ultimaventa(cd integer, qty integer) OWNER TO postgres;

--
-- Name: utilidadproducto(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.utilidadproducto(inpt integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
utilidad decimal(6,2);
BEGIN
SELECT p.precioVenta-p.precio_adquirido INTO utilidad
FROM producto p
WHERE p.codigoBarras = inpt;
RETURN utilidad;
END; $$;


ALTER FUNCTION public.utilidadproducto(inpt integer) OWNER TO postgres;

--
-- Name: ventasfecha(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ventasfecha(fechai date) RETURNS TABLE(codigobarras integer, uvendidas integer, montototal numeric)
    LANGUAGE plpgsql
    AS $$

BEGIN

RETURN QUERY SELECT detalle_orden.codigoBarras, COUNT(detalle_orden.cantidadArticulos), SUM(detalle_orden.subtotal)

FROM

detalle_orden , orden

WHERE

detalle_orden.numVenta = orden.numVenta and orden.fechaVenta = fechaI

GROUP BY detalle_orden.codigoBarras;

END; $$;


ALTER FUNCTION public.ventasfecha(fechai date) OWNER TO postgres;

--
-- Name: ventasfecha(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ventasfecha(fechai character varying) RETURNS TABLE(codigobarras integer, uvendidas bigint, montototal numeric)
    LANGUAGE plpgsql
    AS $$

BEGIN

RETURN QUERY SELECT detalle_orden.codigoBarras, (sum(detalle_orden.cantidadArticulos)) X, SUM(detalle_orden.subtotal)

FROM

detalle_orden , orden

WHERE

detalle_orden.numVenta = orden.numVenta and orden.fechaVenta = fechaI

GROUP BY detalle_orden.codigoBarras;

END; $$;


ALTER FUNCTION public.ventasfecha(fechai character varying) OWNER TO postgres;

--
-- Name: ventasfechas(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ventasfechas(fechai character varying, fechaf character varying) RETURNS TABLE(codigobarras integer, uvendidas bigint, montototal numeric)
    LANGUAGE plpgsql
    AS $$

BEGIN


RETURN QUERY SELECT detalle_orden.codigoBarras, (sum (detalle_orden.cantidadArticulos)) X , SUM(detalle_orden.subtotal)

FROM

detalle_orden, orden 

WHERE

detalle_orden.numVenta =orden.numVenta and orden.fechaVenta between fechaI and fechaF

GROUP BY detalle_orden.codigoBarras;

END; $$;


ALTER FUNCTION public.ventasfechas(fechai character varying, fechaf character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.categoria (
    idcategoria integer NOT NULL,
    nombrecategoria character varying(30) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.cliente (
    idcliente integer NOT NULL,
    razonsocc character varying(50) NOT NULL,
    estadoc character varying(25) NOT NULL,
    cpc integer,
    coloniac character varying(40),
    callec character varying(40),
    numeroc character varying(15),
    nombrec character varying(40)
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: cliente_idcliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_idcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_idcliente_seq OWNER TO postgres;

--
-- Name: cliente_idcliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_idcliente_seq OWNED BY public.cliente.idcliente;


--
-- Name: detalle_orden; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.detalle_orden (
    codigobarras integer NOT NULL,
    numventa character varying(10),
    cantidadarticulos integer NOT NULL,
    subtotal numeric(7,2) NOT NULL
);


ALTER TABLE public.detalle_orden OWNER TO postgres;

--
-- Name: email_cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.email_cliente (
    idcliente integer NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE public.email_cliente OWNER TO postgres;

--
-- Name: orden; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.orden (
    numventa character varying(10) NOT NULL,
    total numeric(7,2) DEFAULT 0 NOT NULL,
    idcliente integer NOT NULL,
    fechaventa character varying(10)
);


ALTER TABLE public.orden OWNER TO postgres;

--
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.producto (
    codigobarras integer,
    nombreproducto character varying(30) NOT NULL,
    fechacompra date NOT NULL,
    stock integer NOT NULL,
    precio_adquirido numeric(6,2) NOT NULL,
    precioventa numeric(6,2) NOT NULL,
    idcategoria integer NOT NULL,
    marca character varying(30) NOT NULL,
    CONSTRAINT producto_precio_adquirido_check CHECK ((precio_adquirido > (0)::numeric)),
    CONSTRAINT producto_precioventa_check CHECK ((precioventa > (0)::numeric)),
    CONSTRAINT stock_posi CHECK ((stock >= 0))
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- Name: facturacion; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.facturacion AS
 SELECT o.numventa,
    c.razonsocc,
    c.nombrec,
    p.nombreproducto,
    deto.cantidadarticulos,
    deto.subtotal,
    o.total
   FROM (((public.orden o
     JOIN public.cliente c USING (idcliente))
     JOIN public.detalle_orden deto USING (numventa))
     JOIN public.producto p USING (codigobarras));


ALTER TABLE public.facturacion OWNER TO postgres;

--
-- Name: proveedor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.proveedor (
    idprov integer NOT NULL,
    razonsocp character varying(50) NOT NULL,
    estadop character varying(25) NOT NULL,
    cpp integer,
    coloniap character varying(40),
    callep character varying(40),
    numerop character varying(15),
    nombrep character varying(40)
);


ALTER TABLE public.proveedor OWNER TO postgres;

--
-- Name: proveedor_idprov_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proveedor_idprov_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proveedor_idprov_seq OWNER TO postgres;

--
-- Name: proveedor_idprov_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proveedor_idprov_seq OWNED BY public.proveedor.idprov;


--
-- Name: reparte; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.reparte (
    idprov integer NOT NULL,
    codigobarras integer NOT NULL
);


ALTER TABLE public.reparte OWNER TO postgres;

--
-- Name: serializacion; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serializacion
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 999
    CACHE 1
    CYCLE;


ALTER TABLE public.serializacion OWNER TO postgres;

--
-- Name: telefono_prov; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.telefono_prov (
    idprov integer NOT NULL,
    telefono integer NOT NULL
);


ALTER TABLE public.telefono_prov OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.users (
    id integer NOT NULL,
    usuario text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: idcliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN idcliente SET DEFAULT nextval('public.cliente_idcliente_seq'::regclass);


--
-- Name: idprov; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor ALTER COLUMN idprov SET DEFAULT nextval('public.proveedor_idprov_seq'::regclass);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categoria VALUES (1, 'recargas');
INSERT INTO public.categoria VALUES (2, 'regalos');
INSERT INTO public.categoria VALUES (3, 'papeleria');
INSERT INTO public.categoria VALUES (4, 'impresiones');


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cliente VALUES (15, 'unam', 'mexico', 12345, 'av iman 123', 'iman', '1', 'luis');
INSERT INTO public.cliente VALUES (16, 'IPN', 'mexico', 19876, 'doctores', 'enfermeras ', '666', 'josé');
INSERT INTO public.cliente VALUES (17, 'unam', 'mexico', 56432, 'los patos', 'iman ', '89321', 'fernando');
INSERT INTO public.cliente VALUES (18, 'abarrotes', 'chalco', 4235, 'canal de chalco', 'los charcos', '231223', 'mario');
INSERT INTO public.cliente VALUES (20, 'vendedor', 'mexico', 9870, 'lomas altas', 'cerrada', '123', 'raul');


--
-- Name: cliente_idcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_idcliente_seq', 20, true);


--
-- Data for Name: detalle_orden; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.detalle_orden VALUES (98765, 'VENT-014', 5, 5.00);
INSERT INTO public.detalle_orden VALUES (12346, 'VENT-014', 3, 60.00);
INSERT INTO public.detalle_orden VALUES (12346, 'VENT-015', 3, 60.00);
INSERT INTO public.detalle_orden VALUES (98765, 'VENT-016', 12, 12.00);
INSERT INTO public.detalle_orden VALUES (98765, 'VENT-016', 1, 1.00);
INSERT INTO public.detalle_orden VALUES (98765, 'VENT-017', 1, 1.00);
INSERT INTO public.detalle_orden VALUES (12347, 'VENT-017', 3, 1500.00);
INSERT INTO public.detalle_orden VALUES (98765, 'VENT-019', 22, 22.00);
INSERT INTO public.detalle_orden VALUES (12346, 'VENT-019', 2, 40.00);
INSERT INTO public.detalle_orden VALUES (98765, 'VENT-020', 3, 3.00);
INSERT INTO public.detalle_orden VALUES (98765, 'VENT-020', 2, 2.00);


--
-- Data for Name: email_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.email_cliente VALUES (15, 'fernando@unam.mx');
INSERT INTO public.email_cliente VALUES (16, 'profesor@poli.mx');
INSERT INTO public.email_cliente VALUES (17, 'patito@comunidad.unam.mx');
INSERT INTO public.email_cliente VALUES (18, 'ratota_chalco666@yahoo.com.mx');
INSERT INTO public.email_cliente VALUES (15, 'unamProfe@unam.mx');
INSERT INTO public.email_cliente VALUES (20, 'raul@gmail.com');


--
-- Data for Name: orden; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orden VALUES ('VENT-014', 65.00, 16, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-015', 60.00, 19, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-011', 0.00, 16, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-016', 13.00, 15, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-012', 0.00, 20, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-013', 0.00, 15, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-017', 1501.00, 15, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-018', 0.00, 20, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-019', 62.00, 18, '2020-05-23');
INSERT INTO public.orden VALUES ('VENT-020', 5.00, 15, '2020-05-23');


--
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.producto VALUES (23456, 'pelota', '2010-01-01', 10, 40.00, 70.00, 2, 'wilson');
INSERT INTO public.producto VALUES (12345, 'recarga 50', '2020-01-05', 30, 50.00, 100.00, 1, 'movi');
INSERT INTO public.producto VALUES (12347, 'recarga 500', '2020-04-01', 47, 250.00, 500.00, 1, 'att');
INSERT INTO public.producto VALUES (12346, 'recarga 20', '2020-02-01', 92, 10.00, 20.00, 1, 'telcel');
INSERT INTO public.producto VALUES (98765, 'impresion B/N', '2020-01-08', 1054, 0.25, 1.00, 4, 'pato');
INSERT INTO public.producto VALUES (2347, 'juego de mesa', '2015-05-04', 4, 250.00, 300.00, 3, 'metal');
INSERT INTO public.producto VALUES (34567, 'impresion Color', '2014-09-18', 1, 0.80, 5.00, 4, 'canon');


--
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.proveedor VALUES (1, 'movi', 'mexico', 12112, 'chapultepec', 'los pinos', '12', 'santiago');
INSERT INTO public.proveedor VALUES (2, 'telcel', 'mexico', 32543, 'ajusco', 'lomas altas', '13', 'marcos');
INSERT INTO public.proveedor VALUES (3, 'att', 'mexico', 45321, 'pedregal', 'las palomas', '14', 'francisco');
INSERT INTO public.proveedor VALUES (4, 'plasticos buenos', 'toluca', 65746, 'aztecas', 'malas vibras', '17', 'eduardo');
INSERT INTO public.proveedor VALUES (5, 'juegos didacticos', 'morelos', 87872, 'cuatro arboles', 'altamirano', '18', 'ebenezer');
INSERT INTO public.proveedor VALUES (6, 'canon', 'toluca', 43435, 'palo alto', 'barrio 3', '19', 'Luisa');


--
-- Name: proveedor_idprov_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedor_idprov_seq', 6, true);


--
-- Data for Name: reparte; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reparte VALUES (1, 12345);
INSERT INTO public.reparte VALUES (2, 12346);
INSERT INTO public.reparte VALUES (3, 12347);
INSERT INTO public.reparte VALUES (4, 23456);
INSERT INTO public.reparte VALUES (5, 2347);
INSERT INTO public.reparte VALUES (6, 98765);
INSERT INTO public.reparte VALUES (6, 34567);


--
-- Name: serializacion; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serializacion', 20, true);


--
-- Data for Name: telefono_prov; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.telefono_prov VALUES (1, 1478526);
INSERT INTO public.telefono_prov VALUES (2, 852369);
INSERT INTO public.telefono_prov VALUES (3, 789456);
INSERT INTO public.telefono_prov VALUES (4, 742589);
INSERT INTO public.telefono_prov VALUES (5, 56581111);
INSERT INTO public.telefono_prov VALUES (6, 954782);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'gerente', 'gerente');
INSERT INTO public.users VALUES (2, 'vendedor', 'vendedor');


--
-- Name: categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (idcategoria);


--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (idcliente);


--
-- Name: email_c_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.email_cliente
    ADD CONSTRAINT email_c_pk PRIMARY KEY (idcliente, email);


--
-- Name: orden_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT orden_pk PRIMARY KEY (numventa);


--
-- Name: proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (idprov);


--
-- Name: telefono_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.telefono_prov
    ADD CONSTRAINT telefono_pk PRIMARY KEY (idprov, telefono);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: indice_productos; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX indice_productos ON public.producto USING btree (codigobarras);


--
-- Name: insertorden; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insertorden BEFORE INSERT ON public.orden FOR EACH ROW EXECUTE PROCEDURE public.insertorden();


--
-- Name: stockdec; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER stockdec BEFORE INSERT OR UPDATE ON public.detalle_orden FOR EACH ROW EXECUTE PROCEDURE public.stockdec();


--
-- Name: stockplus; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER stockplus BEFORE DELETE ON public.detalle_orden FOR EACH ROW EXECUTE PROCEDURE public.stockplus();


--
-- Name: detalle_nv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_orden
    ADD CONSTRAINT detalle_nv_fk FOREIGN KEY (numventa) REFERENCES public.orden(numventa);


--
-- Name: email_c_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_cliente
    ADD CONSTRAINT email_c_fk FOREIGN KEY (idcliente) REFERENCES public.cliente(idcliente);


--
-- Name: producto_idcategoria_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_idcategoria_fk FOREIGN KEY (idcategoria) REFERENCES public.categoria(idcategoria) ON DELETE CASCADE;


--
-- Name: telefono_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_prov
    ADD CONSTRAINT telefono_fk FOREIGN KEY (idprov) REFERENCES public.proveedor(idprov) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

