--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

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
-- Name: billinfo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.billinfo(id_sale character varying) RETURNS TABLE(id_sale_bill character varying, barcode_bill character varying, description_bill character varying, quantityp_bill integer, price_vendor_bill double precision, total_bill double precision)
    LANGUAGE plpgsql
    AS $$
DECLARE
total_p FLOAT;
price_prod FLOAT;
quant INTEGER;
idd_sale VARCHAR;
name_bill VARCHAR;
last_name_bill VARCHAR;
rfc_bill VARCHAR;
street_bill VARCHAR;
house_bill VARCHAR;
colonia_bill VARCHAR;
postal_code_bill VARCHAR;
state_bill VARCHAR;
BEGIN
    SELECT c.name INTO name_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.lastname INTO last_name_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.rfc INTO rfc_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.street INTO street_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.housenumber INTO house_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.colonia INTO colonia_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.postalcode INTO postal_code_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;
    SELECT c.state INTO state_bill FROM client c INNER JOIN sale s ON c.rfc=s.rfc WHERE idsale=id_sale;

    RAISE NOTICE 'GEANT S. de R.L. de C.V.';
    RAISE NOTICE 'www.geantcommerce.com.mx';
    RAISE NOTICE 'Telephone: 26-45-78-41';
    RAISE NOTICE 'Alvaro Obregón, Ciudad de México.';
    RAISE NOTICE 'Bill to % %',name_bill,last_name_bill;
    RAISE NOTICE 'RFC: %',rfc_bill;
    RAISE NOTICE 'Address: %, %, %, %, %',street_bill, house_bill, colonia_bill, postal_code_bill, state_bill;
    SELECT pricevendor INTO price_prod FROM product INNER JOIN sale ON barcode=idproduct WHERE idsale=id_sale;
    SELECT quantityproduct INTO quant FROM product INNER JOIN sale ON barcode=idproduct WHERE idsale=id_sale;
    total_p=quant*price_prod;
    idd_sale=id_sale;
    RETURN QUERY SELECT
        idd_sale,
        barcode,
        description,
        quant,
        price_prod,
        total_p
        FROM
        product INNER JOIN sale ON barcode=idproduct
        WHERE
        idsale=id_sale;
END; $$;


ALTER FUNCTION public.billinfo(id_sale character varying) OWNER TO postgres;

--
-- Name: checkstock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.checkstock() RETURNS TABLE(barcode_checks character varying, priceprovider_check double precision, stock_checks integer, trade_checks character varying, description_checks character varying, pricevendor_check double precision, product_type character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
        barcode,
        priceprovider,
        stock,
        trade,
        description,
        pricevendor,
        producttype
        FROM
            product
        WHERE
            stock<3;
END; $$;


ALTER FUNCTION public.checkstock() OWNER TO postgres;

--
-- Name: inventario(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.inventario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 stock2 INTEGER;
 stock1 INTEGER;
BEGIN
    select stock INTO stock2 FROM product WHERE barcode=new.idproduct;
    stock1=new.quantityproduct;
    RAISE NOTICE 'new idsale: %',new.idsale;
    RAISE NOTICE 'stock1=quantityproduct: %',stock1;
    CASE
        WHEN stock2=1 or stock2<=0 THEN
            RAISE EXCEPTION USING MESSAGE = 'No hay productos en stock.';
        WHEN stock2<=3 THEN
            RAISE WARNING 'Quedan 3 o menos piezas en Stock, stock % pz. - %',stock2, NOW();
            UPDATE product
            SET stock=stock2-stock1
            WHERE barcode=new.idproduct;
        WHEN stock2>3 THEN
            UPDATE product
            SET stock=stock2-stock1
            WHERE barcode=new.idproduct;
            RAISE NOTICE 'Se realizo correctamente la actualizaci¢n del stock %. stock2 %, stock1 %', now(), stock2, stock1;
        ELSE
            RAISE NOTICE 'Error en actualizar stock';
    END CASE;
    RETURN NEW;
END; $$;


ALTER FUNCTION public.inventario() OWNER TO postgres;

--
-- Name: salesbydate(date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.salesbydate(datestart date, dateend date) RETURNS TABLE(sale_identifier character varying, sale_date date, sale_amount double precision, rfc_sale character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (dateend is null) THEN
        RETURN QUERY SELECT
            idsale,
            datesale,
            totalamountproduct,
            rfc
        FROM
            sale
        WHERE
            datesale=datestart;
    ELSE
        RETURN QUERY SELECT
                idsale,
                datesale,
                totalamountproduct,
                rfc
            FROM
                sale
            WHERE
                datesale BETWEEN datestart and dateend
            ORDER BY datesale;
    END IF;
END; $$;


ALTER FUNCTION public.salesbydate(datestart date, dateend date) OWNER TO postgres;

--
-- Name: updatestock(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updatestock(id_sale character varying, barcode_product character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
DECLARE 
    stock2 INTEGER; 
    stock1 INTEGER; 
    newstock INTEGER;
BEGIN
    SELECT stock INTO stock2 FROM product WHERE barcode=barcode_product;
    SELECT quantityproduct INTO stock1 from sale where idsale=id_sale;
    newstock=stock2-stock1;
    UPDATE product
    SET stock=newstock
    WHERE barcode=barcode_product;
    RETURN newstock;
END; $$;


ALTER FUNCTION public.updatestock(id_sale character varying, barcode_product character varying) OWNER TO postgres;

--
-- Name: updatestock2(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updatestock2(id_sale character varying, barcode_product character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
DECLARE 
    stock2 INTEGER; 
    stock1 INTEGER; 
    newstock INTEGER;
BEGIN
    SELECT stock INTO stock2 FROM product WHERE barcode=barcode_product;
    SELECT quantityproduct INTO stock1 from sale where idsale=id_sale;
    CASE
        WHEN stock2=1 or stock2<=0 THEN
            RAISE NOTICE  'No hay productos en stock. %', NOW();
            DELETE 
            FROM sale
            WHERE idsale=id_sale;
        
        WHEN stock2<=3 THEN
            RAISE WARNING 'Quedan 3 o menos piezas en Stock, stock % pz. - %', newstock, NOW();
            newstock=stock2-stock1;
            UPDATE product
            SET stock=newstock
            WHERE barcode=barcode_product;

        WHEN stock2>3 THEN
            newstock=stock2-stock1;
            UPDATE product
            SET stock=newstock
            WHERE barcode=barcode_product;
            RAISE NOTICE 'Se realizo correctamente la actualización del stock %', now();

        ELSE
            RAISE NOTICE 'Error en actualizar stock';
    END CASE;
    RETURN newstock;
END; $$;


ALTER FUNCTION public.updatestock2(id_sale character varying, barcode_product character varying) OWNER TO postgres;

--
-- Name: utility(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.utility(barcode_chose character varying) RETURNS TABLE(barcode_product character varying, trade_product character varying, description_product character varying, utility_product double precision)
    LANGUAGE plpgsql
    AS $$
DECLARE
    price_prov FLOAT;
    price_ven FLOAT;
    utility_net FLOAT;
BEGIN
    SELECT priceprovider INTO price_prov FROM product WHERE barcode=barcode_chose;
    SELECT pricevendor INTO price_ven FROM product WHERE barcode=barcode_chose;
    utility_net= price_ven-price_prov;
    RETURN QUERY SELECT
        barcode,
        trade,
        description,
        utility_net
        FROM 
            product
        WHERE
            barcode=barcode_chose;
END; $$;


ALTER FUNCTION public.utility(barcode_chose character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    rfc character varying(50) NOT NULL,
    name character varying(30) NOT NULL,
    lastname character varying(30) NOT NULL,
    middlename character varying(30),
    street character varying(30) NOT NULL,
    housenumber integer NOT NULL,
    colonia character varying(30) NOT NULL,
    postalcode integer NOT NULL,
    state character varying(30) NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: contain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contain (
    idsale character varying(30) NOT NULL,
    barcode character varying(30) NOT NULL
);


ALTER TABLE public.contain OWNER TO postgres;

--
-- Name: emailc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emailc (
    rfc character varying(50) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE public.emailc OWNER TO postgres;

--
-- Name: idsaleformat; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.idsaleformat
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 20
    CACHE 1
    CYCLE;


ALTER TABLE public.idsaleformat OWNER TO postgres;

--
-- Name: phone_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phone_provider (
    tradename character varying(50) NOT NULL,
    phone integer NOT NULL
);


ALTER TABLE public.phone_provider OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    barcode character varying(30) NOT NULL,
    priceprovider double precision NOT NULL,
    stock integer NOT NULL,
    trade character varying(30) NOT NULL,
    description character varying(50) NOT NULL,
    pricevendor double precision NOT NULL,
    producttype character varying(30) NOT NULL,
    CONSTRAINT chk_producttype CHECK (((producttype)::text = ANY (ARRAY[('gift'::character varying)::text, ('stationery'::character varying)::text, ('print'::character varying)::text, ('recharges'::character varying)::text])))
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: provide; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provide (
    tradename character varying(50) NOT NULL,
    barcode character varying(30) NOT NULL
);


ALTER TABLE public.provide OWNER TO postgres;

--
-- Name: provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider (
    tradename character varying(50) NOT NULL,
    name character varying(30) NOT NULL,
    lastname character varying(30) NOT NULL,
    middlename character varying(30),
    street character varying(30) NOT NULL,
    housenumber integer NOT NULL,
    colonia character varying(30) NOT NULL,
    postalcode integer NOT NULL,
    state character varying(30) NOT NULL
);


ALTER TABLE public.provider OWNER TO postgres;

--
-- Name: sale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale (
    idsale character varying(30) DEFAULT to_char(nextval('public.idsaleformat'::regclass), '"VENT-"fm000'::text) NOT NULL,
    datesale date NOT NULL,
    totalamountproduct double precision NOT NULL,
    rfc character varying(50) NOT NULL,
    quantityproduct integer,
    idproduct character varying(30)
);


ALTER TABLE public.sale OWNER TO postgres;

--
-- Name: utility_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utility_product (
    barcode character varying(30) NOT NULL,
    utility double precision NOT NULL
);


ALTER TABLE public.utility_product OWNER TO postgres;

--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (rfc, name, lastname, middlename, street, housenumber, colonia, postalcode, state) FROM stdin;
MCAC860212	Marco	Castilleja	Antonio	Blvd. Manuel µvila Camacho	138	Lomas de Chapultepec	11650	Ciudad de M‚xico
WLES801306	Wilfrido	Espinoza		Paseo de la Reforma	1000	Pe¤a Blanca Santa Fe	1210	Ciudad de M‚xico
JRAR820602	Jorge	Arias		Av. San Antonio	461	San Pedro de los Pinos	1180	Ciudad de M‚xico
ZAMD980124	Daniel	Zarco		Fuego	125	Jardines del Pedregal	125	01900
APEV970116	Adrian	P‚rez		Fuentes de aire	854	Los Reyes la Paz	2145	Estado de M‚xico
\.


--
-- Data for Name: contain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contain (idsale, barcode) FROM stdin;
\.


--
-- Data for Name: emailc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emailc (rfc, email) FROM stdin;
APEV970116	adiranp@gmail.com
JRAR820602	jorgearias@gmail.com
WLES801306	wilfre@hotmaail.com
ZAMD980124	danielRT@outlook.com
MCAC860212	marcocas@gmail.com
\.


--
-- Data for Name: phone_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phone_provider (tradename, phone) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (barcode, priceprovider, stock, trade, description, pricevendor, producttype) FROM stdin;
9 820145 658784	80	15	HP Original	Paquete Papel Bond Carta Hp Original 500 Hojas	159.650000000000006	stationery
9 587632 502058	84.7000000000000028	20	HP Papers	Paquete Papel Bond Carta HP Multi 500 Hojas 	190.349999999999994	stationery
6 458712 562387	28.3999999999999986	10	BIC Crystal	Boligrafo Bic Med C/12 Pza Azul	45.6199999999999974	stationery
7 452136 748510	575.899999999999977	5	M¢naco	Mochila M¢naco 12prom Serig t‚rmica	864.850000000000023	gift
4 051236 498771	50	10	Telc‚l	Recarga de $50 C/paquete de datos vig. 3 d¡a	50	recharges
4 051236 657841	50	10	AT&T	Recarga de $50 C/paquete de datos vig. 3 d¡a	50	recharges
4 051236 253610	50	10	UNEFON	Recarga de $50 C/paquete de datos vig. 3 d¡a	50	recharges
\.


--
-- Data for Name: provide; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provide (tradename, barcode) FROM stdin;
\.


--
-- Data for Name: provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider (tradename, name, lastname, middlename, street, housenumber, colonia, postalcode, state) FROM stdin;
H.P. M‚xico S.A. de C.V.	Raul	Ribeiro	Montes	Paseo de la Reforma	700	Santa Fe	1210	Ciudad de M‚xico
BicWorld S.A. de C.V.	Diana	Montero	Franco	V¡a Gustavo Baz	113	Industrial Barrientos	54015	Tlalnepantla
Yamacue promoarticulos S.A. de C.V.	Fernanda	Pe¤a Blanca	De Oca	Leandro Valle	604	Miraval	62270	Morelos
TRANSBOX S.A. de C.V.	Joseline Valeria	R mirez	Cortes	Shakespeare	39	Anzures	11590	Ciudad de M‚xico
\.


--
-- Data for Name: sale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sale (idsale, datesale, totalamountproduct, rfc, quantityproduct, idproduct) FROM stdin;
\.


--
-- Data for Name: utility_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utility_product (barcode, utility) FROM stdin;
\.


--
-- Name: idsaleformat; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.idsaleformat', 15, true);


--
-- Name: client pk_client; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT pk_client PRIMARY KEY (rfc);


--
-- Name: contain pk_contain; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contain
    ADD CONSTRAINT pk_contain PRIMARY KEY (idsale, barcode);


--
-- Name: emailc pk_emailc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emailc
    ADD CONSTRAINT pk_emailc PRIMARY KEY (rfc);


--
-- Name: product pk_product; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product PRIMARY KEY (barcode);


--
-- Name: provide pk_provide; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provide
    ADD CONSTRAINT pk_provide PRIMARY KEY (tradename, barcode);


--
-- Name: provider pk_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT pk_provider PRIMARY KEY (tradename);


--
-- Name: sale pk_sale; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT pk_sale PRIMARY KEY (idsale);


--
-- Name: utility_product pk_utilityp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utility_product
    ADD CONSTRAINT pk_utilityp PRIMARY KEY (barcode);


--
-- Name: indiceventa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indiceventa ON public.sale USING btree (idsale);


--
-- Name: sale trstock; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trstock BEFORE INSERT ON public.sale FOR EACH ROW EXECUTE PROCEDURE public.inventario();


--
-- Name: contain fk_barcode_contain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contain
    ADD CONSTRAINT fk_barcode_contain FOREIGN KEY (barcode) REFERENCES public.product(barcode) ON DELETE CASCADE;


--
-- Name: provide fk_barcode_provide; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provide
    ADD CONSTRAINT fk_barcode_provide FOREIGN KEY (barcode) REFERENCES public.product(barcode) ON DELETE CASCADE;


--
-- Name: utility_product fk_barcode_utilityp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utility_product
    ADD CONSTRAINT fk_barcode_utilityp FOREIGN KEY (barcode) REFERENCES public.product(barcode) ON DELETE CASCADE;


--
-- Name: contain fk_idsale_contain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contain
    ADD CONSTRAINT fk_idsale_contain FOREIGN KEY (idsale) REFERENCES public.sale(idsale) ON DELETE CASCADE;


--
-- Name: emailc fk_rfc_emailc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emailc
    ADD CONSTRAINT fk_rfc_emailc FOREIGN KEY (rfc) REFERENCES public.client(rfc) ON DELETE CASCADE;


--
-- Name: sale fk_rfc_sale; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT fk_rfc_sale FOREIGN KEY (rfc) REFERENCES public.client(rfc) ON DELETE CASCADE;


--
-- Name: phone_provider fk_tradename_phoneprovider; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone_provider
    ADD CONSTRAINT fk_tradename_phoneprovider FOREIGN KEY (tradename) REFERENCES public.provider(tradename) ON DELETE CASCADE;


--
-- Name: provide fk_tradename_provide; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provide
    ADD CONSTRAINT fk_tradename_provide FOREIGN KEY (tradename) REFERENCES public.provider(tradename) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

