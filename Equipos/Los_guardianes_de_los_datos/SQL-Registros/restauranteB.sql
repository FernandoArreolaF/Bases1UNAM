--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.3

-- Started on 2022-05-27 20:42:00

--Creación de la base de datos
CREATE DATABASE restaurante;

\c restaurante;


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
-- TOC entry 241 (class 1255 OID 17495)
-- Name: cantidad_monto_ventas_fecha_bdd_function(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cantidad_monto_ventas_fecha_bdd_function(fecha_ingresada date) RETURNS TABLE(fecha date, cantidad_ordenes bigint, cantidad_ventas bigint, monto_total_ventas real)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (EXISTS(SELECT orden.fecha from orden WHERE orden.fecha=fecha_ingresada)) THEN 
        return query
        SELECT DISTINCT orden.fecha,(select count(orden.folio) as cantidad_ordenes from orden WHERE orden.fecha=fecha_ingresada),(select sum(orden.cantidad_total) as cantidad_ventas from orden WHERE orden.fecha=fecha_ingresada),(select sum(orden.precio_total) as monto_total_ventas from orden WHERE orden.fecha=fecha_ingresada) from orden WHERE orden.fecha=fecha_ingresada;
    ELSE
        RAISE EXCEPTION 'No hay ventas en esa fecha';
   END IF;
        
END
$$;


--
-- TOC entry 242 (class 1255 OID 17496)
-- Name: cantidad_monto_ventas_fecha_function(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cantidad_monto_ventas_fecha_function(fecha_ingresada date) RETURNS TABLE(fecha date, cantidad_ordenes bigint, cantidad_ventas bigint, monto_total_ventas real)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (EXISTS(SELECT orden.fecha from orden WHERE orden.fecha=fecha_ingresada)) THEN 
        return query
        SELECT DISTINCT orden.fecha,(select count(orden.folio) as cantidad_ordenes from orden WHERE orden.fecha=fecha_ingresada),(select sum(orden.cantidad_total) as cantidad_ventas from orden WHERE orden.fecha=fecha_ingresada),(select sum(orden.precio_total) as monto_total_ventas from orden WHERE orden.fecha=fecha_ingresada) from orden WHERE orden.fecha=fecha_ingresada;
    
   END IF;
        
END
$$;


--
-- TOC entry 243 (class 1255 OID 17497)
-- Name: cantidad_monto_ventas_fechas_bdd_function(date, date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cantidad_monto_ventas_fechas_bdd_function(fecha_de_inicio date, fecha_de_fin date) RETURNS TABLE(fecha_inicio date, fecha_fin date, cantidad_ordenes bigint, cantidad_ventas bigint, monto_total_ventas real)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (EXISTS(SELECT orden.fecha from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin)) THEN 
        return query
        SELECT DISTINCT fecha_de_inicio,fecha_de_fin,(select count(orden.folio) as cantidad_ordenes from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin),(select sum(orden.cantidad_total) as cantidad_ventas from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin),(select sum(orden.precio_total) as monto_total_ventas from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin) from orden;
    ELSE
        RAISE EXCEPTION 'No hay ventas entre esas fechas';
   END IF;
        
END
$$;


--
-- TOC entry 244 (class 1255 OID 17498)
-- Name: cantidad_monto_ventas_fechas_function(date, date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cantidad_monto_ventas_fechas_function(fecha_de_inicio date, fecha_de_fin date) RETURNS TABLE(fecha_inicio date, fecha_fin date, cantidad_ordenes bigint, cantidad_ventas bigint, monto_total_ventas real)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (EXISTS(SELECT orden.fecha from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin)) THEN 
        return query
        SELECT DISTINCT fecha_de_inicio,fecha_de_fin,(select count(orden.folio) as cantidad_ordenes from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin),(select sum(orden.cantidad_total) as cantidad_ventas from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin),(select sum(orden.precio_total) as monto_total_ventas from orden WHERE orden.fecha BETWEEN fecha_de_inicio AND fecha_de_fin) from orden;
    
   END IF;
        
END
$$;


--
-- TOC entry 224 (class 1255 OID 17474)
-- Name: cantidad_total_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cantidad_total_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
IF (TG_OP ='INSERT') THEN
    UPDATE orden SET cantidad_total=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT folio, sum(cantidad_producto) as cantidad_producto from incluye group by folio) as suma WHERE folio=NEW.folio) as resultado) WHERE orden.folio=NEW.folio;
ELSEIF (TG_OP ='UPDATE') THEN
    UPDATE orden SET cantidad_total=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT folio, sum(cantidad_producto) as cantidad_producto from incluye group by folio) as suma WHERE folio=NEW.folio) as resultado) WHERE orden.folio=NEW.folio;
ELSEIF (TG_OP ='DELETE') THEN
    UPDATE orden SET cantidad_total=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT folio, sum(cantidad_producto) as cantidad_producto from incluye group by folio) as suma WHERE folio=OLD.folio) as resultado) WHERE orden.folio=OLD.folio;
END IF;
RETURN NULL;
END;
$$;


--
-- TOC entry 235 (class 1255 OID 17484)
-- Name: cantidad_vendida_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cantidad_vendida_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
IF (TG_OP ='INSERT') THEN
    UPDATE producto SET cantidad_vendida=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT id_producto, sum(cantidad_producto) as cantidad_producto from incluye group by id_producto) as suma WHERE id_producto=NEW.id_producto) as resultado) WHERE producto.id_producto=NEW.id_producto;
ELSEIF (TG_OP ='UPDATE') THEN
    UPDATE producto SET cantidad_vendida=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT id_producto, sum(cantidad_producto) as cantidad_producto from incluye group by id_producto) as suma WHERE id_producto=NEW.id_producto) as resultado) WHERE producto.id_producto=NEW.id_producto;
ELSEIF (TG_OP ='DELETE') THEN
    UPDATE producto SET cantidad_vendida=(SELECT cantidad_producto from (SELECT cantidad_producto from (SELECT id_producto, sum(cantidad_producto) as cantidad_producto from incluye group by id_producto) as suma WHERE id_producto=OLD.id_producto) as resultado) WHERE producto.id_producto=OLD.id_producto;
END IF;
RETURN NULL;
END;
$$;


--
-- TOC entry 236 (class 1255 OID 17488)
-- Name: disponibilidad_producto_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.disponibilidad_producto_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF ((SELECT disponibilidad from producto WHERE id_producto=NEW.id_producto)=false) THEN
    RAISE EXCEPTION 'Producto no disponible por el momento';
END IF;
RETURN NEW;
END;
$$;


--
-- TOC entry 220 (class 1255 OID 17472)
-- Name: edad_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.edad_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
NEW.edad=date_part('year',age(now(),NEW.fecha_nacimiento));
RETURN NEW;
END;
$$;


--
-- TOC entry 245 (class 1255 OID 17499)
-- Name: factura(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.factura(folio_orden character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	registro RECORD;
	registro2 RECORD;
	cur_producto CURSOR FOR
	SELECT 
		orden.folio AS Folio,
    	incluye.id_producto AS idProducto,
  	 	producto.nombre AS Producto,
		producto.precio AS Precio,
    	incluye.cantidad_producto AS Cantidad,
    	incluye.precio_total_por_producto AS PrecioPorProducto
   FROM cliente
     JOIN orden ON cliente.rfc::text = orden.rfc::text
     JOIN incluye ON orden.folio::text = incluye.folio::text
     JOIN producto ON incluye.id_producto = producto.id_producto
WHERE folio_Orden = orden.folio;

BEGIN
	SELECT UPPER(cliente.razon_social) AS RazonSocial,
    cliente.rfc AS RFC,
    concat(cliente.calle, ' ', cliente.numero, ' ', cliente.colonia, ' ', cliente.cp, ' ', cliente.estado, ' ') AS Direccion,
    concat(cliente.nombre, ' ', cliente.ap_paterno, ' ', cliente.ap_materno, ' ') AS Nombre,
    cliente.email AS Email,
    cliente.fecha_nacimiento AS FechaNacimiento,
    orden.folio AS Folio,
    orden.fecha AS Fecha,
    orden.cantidad_total AS CantidadTotal,
    orden.precio_total AS PrecioTotal
   INTO registro
   FROM cliente
     JOIN orden ON cliente.rfc::text = orden.rfc::text
     JOIN incluye ON orden.folio::text = incluye.folio::text
     JOIN producto ON incluye.id_producto = producto.id_producto
WHERE folio_Orden = orden.folio
GROUP BY cliente.rfc, orden.folio;

-- Encabezado de la factura
	RAISE NOTICE '- - -  % - - -', registro.RazonSocial;
	RAISE NOTICE '';
	RAISE NOTICE 'Folio de la orden: %', registro.Folio;
	RAISE NOTICE 'Fecha: %', registro.Fecha;
 	RAISE NOTICE 'FACTURAR A %', registro.Nombre;
	RAISE NOTICE 'DirecciÃ³n: %', registro.Direccion;
	RAISE NOTICE 'RFC: %', registro.RFC;
	RAISE NOTICE 'Email: %', registro.Email;


-- Cuerpo de la factura
	OPEN cur_producto;
	FETCH cur_producto INTO registro2;
	
	RAISE NOTICE '';
	RAISE NOTICE 'Cantidad|Descripcion    |Precio    |Importe';
	
	WHILE(registro2.Folio = folio_Orden) LOOP
		RAISE NOTICE '  %     | %         | %     | %', registro2.Cantidad, registro2.Producto, registro2.Precio, registro2.PrecioPorProducto;
		FETCH cur_producto INTO registro2;
	END LOOP;
	
	CLOSE cur_producto;
	
-- Fin de la factura
	RAISE NOTICE '';
	RAISE NOTICE 'Cantidad total de productos: %', registro.CantidadTotal;
	RAISE NOTICE 'Importe total: %', registro.PrecioTotal;
END
$$;


--
-- TOC entry 238 (class 1255 OID 17492)
-- Name: folio_orden(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.folio_orden() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE identificador varchar(8);
BEGIN
identificador:=CONCAT('ORD-',CAST((SELECT nextval('folio')) AS VARCHAR));
RETURN identificador;
END;
$$;


--
-- TOC entry 237 (class 1255 OID 17490)
-- Name: mesero_a_orden_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.mesero_a_orden_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF ((SELECT es_mesero from empleado WHERE numero_empleado=NEW.numero_empleado)=false) THEN
    RAISE EXCEPTION 'El empleado que se intenta asociar a la orden no es mesero';
ELSEIF (NOT EXISTS(SELECT numero_empleado from empleado WHERE numero_empleado=NEW.numero_empleado)) THEN
    RAISE EXCEPTION 'El empleado que se intenta asociar a la orden no existe en la base de datos';
END IF;
RETURN NEW;
END;
$$;


--
-- TOC entry 239 (class 1255 OID 17493)
-- Name: mesero_ordenes_al_dia_bdd_function(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.mesero_ordenes_al_dia_bdd_function(num_empleado integer) RETURNS TABLE(numero_empleado integer, numero_ordenes bigint, precio_total_ordenes real)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF((SELECT es_Mesero from empleado WHERE empleado.numero_empleado=num_empleado)=FALSE) THEN
        RAISE EXCEPTION 'No es mesero';
    ELSEIF (EXISTS(SELECT empleado.numero_empleado from empleado WHERE empleado.numero_empleado=num_empleado)) THEN 
        return query
        SELECT DISTINCT empleado.numero_empleado,(select count(orden.numero_empleado) as numero_ordenes from orden WHERE orden.numero_empleado=num_empleado and extract(year from fecha)=extract(year from now()) and extract(month from fecha)=extract(month from now()) and extract(day from fecha)=extract(day from now())),(select sum(orden.precio_total) as precio_total_ordenes from orden WHERE orden.numero_empleado=num_empleado and extract(year from fecha)=extract(year from now()) and extract(month from fecha)=extract(month from now()) and extract(day from fecha)=extract(day from now())) from empleado WHERE es_mesero=TRUE AND empleado.numero_empleado=num_empleado;
    ELSE
        RAISE EXCEPTION 'No existe el empleado';
   END IF;
END
$$;


--
-- TOC entry 240 (class 1255 OID 17494)
-- Name: mesero_ordenes_al_dia_function(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.mesero_ordenes_al_dia_function(num_empleado integer) RETURNS TABLE(numero_empleado integer, numero_ordenes bigint, precio_total_ordenes real)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (EXISTS(SELECT empleado.numero_empleado from empleado WHERE empleado.numero_empleado=num_empleado) AND (SELECT es_Mesero from empleado WHERE empleado.numero_empleado=num_empleado)=TRUE) THEN
        return query
        SELECT DISTINCT empleado.numero_empleado,(select count(orden.numero_empleado) as numero_ordenes from orden WHERE orden.numero_empleado=num_empleado and extract(year from fecha)=extract(year from now()) and extract(month from fecha)=extract(month from now()) and extract(day from fecha)=extract(day from now())),(select sum(orden.precio_total) as precio_total_ordenes from orden WHERE orden.numero_empleado=num_empleado and extract(year from fecha)=extract(year from now()) and extract(month from fecha)=extract(month from now()) and extract(day from fecha)=extract(day from now())) from empleado WHERE es_mesero=TRUE AND empleado.numero_empleado=num_empleado;
    END IF;
        
END
$$;


--
-- TOC entry 225 (class 1255 OID 17478)
-- Name: precio_total_por_producto_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.precio_total_por_producto_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
NEW.precio_total_por_producto=(NEW.cantidad_producto)*(SELECT precio from producto WHERE id_producto=NEW.id_producto);
RETURN NEW;
END;
$$;


--
-- TOC entry 234 (class 1255 OID 17480)
-- Name: precio_total_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.precio_total_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
IF (TG_OP ='INSERT') THEN
    UPDATE orden SET precio_total=(SELECT precio_total_por_producto from (SELECT precio_total_por_producto from (SELECT folio, sum(precio_total_por_producto) as precio_total_por_producto from incluye group by folio) as suma WHERE folio=NEW.folio) as resultado) WHERE orden.folio=NEW.folio;
ELSEIF (TG_OP ='UPDATE') THEN
    UPDATE orden SET precio_total=(SELECT precio_total_por_producto from (SELECT precio_total_por_producto from (SELECT folio, sum(precio_total_por_producto) as precio_total_por_producto from incluye group by folio) as suma WHERE folio=NEW.folio) as resultado) WHERE orden.folio=NEW.folio;
ELSEIF (TG_OP ='DELETE') THEN
    UPDATE orden SET precio_total=(SELECT precio_total_por_producto from (SELECT precio_total_por_producto from (SELECT folio, sum(precio_total_por_producto) as precio_total_por_producto from incluye group by folio) as suma WHERE folio=OLD.folio) as resultado) WHERE orden.folio=OLD.folio;

END IF;
RETURN NULL;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 17434)
-- Name: categoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(500) NOT NULL
);


--
-- TOC entry 212 (class 1259 OID 17411)
-- Name: cliente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cliente (
    rfc character varying(13) NOT NULL,
    email character varying(200) NOT NULL,
    nombre character varying(60) NOT NULL,
    ap_paterno character varying(60) NOT NULL,
    ap_materno character varying(60),
    fecha_nacimiento date NOT NULL,
    razon_social character varying(150) NOT NULL,
    cp integer NOT NULL,
    estado character varying(60) NOT NULL,
    numero smallint NOT NULL,
    calle character varying(80) NOT NULL,
    colonia character varying(100) NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 17401)
-- Name: dependiente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dependiente (
    curp character varying(18) NOT NULL,
    nombre character varying(60) NOT NULL,
    ap_paterno character varying(60) NOT NULL,
    ap_materno character varying(60),
    parentesco character varying(30) NOT NULL,
    numero_empleado integer NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 17379)
-- Name: empleado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.empleado (
    numero_empleado integer NOT NULL,
    foto character varying(500) NOT NULL,
    rfc character varying(13) NOT NULL,
    nombre character varying(60) NOT NULL,
    ap_paterno character varying(60) NOT NULL,
    ap_materno character varying(60),
    edad smallint,
    sueldo double precision NOT NULL,
    calle character varying(80) NOT NULL,
    numero smallint NOT NULL,
    cp integer NOT NULL,
    estado character varying(60) NOT NULL,
    colonia character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    es_mesero boolean NOT NULL,
    es_administrativo boolean NOT NULL,
    es_cocinero boolean NOT NULL,
    horario character varying(60) DEFAULT 'No aplica'::character varying,
    rol character varying(60) DEFAULT 'No aplica'::character varying,
    especialidad character varying(60) DEFAULT 'No aplica'::character varying
);


--
-- TOC entry 217 (class 1259 OID 17471)
-- Name: folio; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.folio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    CACHE 1;


--
-- TOC entry 216 (class 1259 OID 17454)
-- Name: incluye; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.incluye (
    folio character varying(20) NOT NULL,
    id_producto integer NOT NULL,
    cantidad_producto integer NOT NULL,
    precio_total_por_producto double precision,
    CONSTRAINT ck_cantidad_producto CHECK ((cantidad_producto > 0))
);


--
-- TOC entry 213 (class 1259 OID 17418)
-- Name: orden; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orden (
    folio character varying(20) NOT NULL,
    fecha date DEFAULT now() NOT NULL,
    precio_total real,
    cantidad_total smallint,
    numero_empleado integer,
    rfc character varying(13)
);


--
-- TOC entry 215 (class 1259 OID 17441)
-- Name: producto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.producto (
    id_producto integer NOT NULL,
    nombre character varying(150) NOT NULL,
    receta character varying(2000) NOT NULL,
    precio real NOT NULL,
    descripcion character varying(400) NOT NULL,
    disponibilidad boolean NOT NULL,
    tipo_producto character varying(8) NOT NULL,
    con_alcohol boolean,
    platillo_del_dia boolean,
    id_categoria integer,
    cantidad_vendida integer,
    CONSTRAINT ck_precio CHECK ((precio > (0)::double precision))
);


--
-- TOC entry 218 (class 1259 OID 17500)
-- Name: platillo_mas_vendido_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.platillo_mas_vendido_view AS
 SELECT producto.id_producto,
    producto.nombre,
    producto.receta,
    producto.precio,
    producto.descripcion,
    producto.disponibilidad,
    producto.tipo_producto,
    producto.con_alcohol,
    producto.platillo_del_dia,
    producto.id_categoria,
    producto.cantidad_vendida
   FROM public.producto
  WHERE ((producto.cantidad_vendida = ( SELECT max(producto_1.cantidad_vendida) AS max
           FROM public.producto producto_1
          WHERE ((producto_1.tipo_producto)::text = 'Platillo'::text))) AND ((producto.tipo_producto)::text = 'Platillo'::text));


--
-- TOC entry 219 (class 1259 OID 17505)
-- Name: productos_no_disponibles_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.productos_no_disponibles_view AS
 SELECT producto.nombre AS "Productos no disponibles"
   FROM public.producto
  WHERE (producto.disponibilidad = false);


--
-- TOC entry 210 (class 1259 OID 17391)
-- Name: telefono; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telefono (
    telefono bigint NOT NULL,
    numero_empleado integer NOT NULL
);


--
-- TOC entry 3406 (class 0 OID 17434)
-- Dependencies: 214
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categoria (id_categoria, nombre, descripcion) FROM stdin;
1	Guisados	Comida preparada con salsa después de haberla rehogado y que suele incluir ingredientes como trozos de carne, papas y diversas especias.
2	Pastas 	Alimento preparado a base de haria y que puede cocinarse con diversas especias y salsas. 
3	Ensaladas 	Preparación constituida por generalmente por vegetales, frutas o semillas mezcladas, cortadas en trozos y aderezadas con sal, aceite, vinagre y otros ingredientes.
4	Postres	Preparacion dulce o agridulce
5	Ponches 	Mezcla de varios jugos de fruta y especias, puede contener alcohol o no. 
6	Cocteles 	Combinacon de diferentes bebidas como jugos de fruta, gaseosas, fermentadas y/o destiladas
7	Batidos	Bebida elaborada a base de leche o helado, que puede llevar frutas, chocolate, turrón o también helado.
8	Jugos y aguas frescas	Bebida a base de agua, frutas o granos, y azúcar,
9	Bebidas con alcohol 	Bebidas que contienen alcohol etílico en su composición.
\.


--
-- TOC entry 3404 (class 0 OID 17411)
-- Dependencies: 212
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cliente (rfc, email, nombre, ap_paterno, ap_materno, fecha_nacimiento, razon_social, cp, estado, numero, calle, colonia) FROM stdin;
HELJ690221	Jorge.Hern@correo.com	Jorge	Hernandez	Lara	1969-02-21	Restaurantes Copacabana	15630	Aguascalientes	72	Revolucion	Coracol
GARF941010	Fernando.Garc@correo.com	Fernando	Garcia	Rios	1994-10-10	Restaurantes Copacabana	4970	Durango	59	Eje Central	Haciendas De Coyoacan
MAAM020408	MarcoAntonio.Mart@correo.com	Marco Antonio	Martinez	Avila	2002-04-08	Restaurantes Copacabana	1710	Guanajuato	71	Paseo de la reforma	Las Aguilas
LOAM800620	Miguel.Lope@correo.com	Miguel	Lopez	Alvarado	1980-06-20	Restaurantes Copacabana	2400	Guerrero	56	Alfareros	San Juan Tlihuaca
GODM660826	MariaElena.Gonz@correo.com	Maria Elena	Gonzalez	De La Cruz	1966-08-26	Restaurantes Copacabana	14240	Hidalgo	28	Eje 3 Norte	Lomas De Padierna
ROSY901214	Yolanda.Rodr@correo.com	Yolanda	Rodriguez	Silva	1990-12-14	Restaurantes Copacabana	9810	Jalisco	164	Lopez Portillo	Granjas Esmeralda
PEDF960102	FranciscoJavier.Pere@correo.com	Francisco Javier	Perez	Delgado	1996-01-02	Restaurantes Copacabana	9690	Ciudad de mexico	49	Heriberto Jara	Iztlahuacan
SACR840708	Roberto.Sanc@correo.com	Roberto	Sanchez	Carrillo	1984-07-08	Restaurantes Copacabana	7230	Michoacan	200	Rio Churubusco	Zona Escolar
RASA890424	Alejandra.Rami@correo.com	Alejandra	Ramirez	Solis	1989-04-24	Restaurantes Copacabana	13093	Morelos	155	Carretera Picacho Ajusco	San Sebastian
FLSJ821125	JoseLuis.Flor@correo.com	Jose Luis	Flores	Soto	1982-11-25	Restaurantes Copacabana	8700	Nayarit	62	Calle 11	Juventino Rosas
CRLS701017	Silvia.Cruz@correo.com	Silvia	Cruz	Leon	1970-10-17	Restaurantes Copacabana	7979	Nuevo Leon	121	Av. Heroes	San Juan De Aragon V Seccion
GOFA970630	Arturo.Gome@correo.com	Arturo	Gomez	Fernandez	1997-06-30	Restaurantes Copacabana	2700	Baja California	181	Calle 7	San Miguel Amantla
MOCS630404	Sergio.Mora@correo.com	Sergio	Morales	Cervantes	1963-04-04	Restaurantes Copacabana	7020	Oaxaca	62	Eje 10 Sur	Tepeyac Insurgentes
VAMJ691227	Javier.Vazq@correo.com	Javier	Vazquez	Marquez	1969-12-27	Restaurantes Copacabana	16320	Puebla	167	La Brecha	San Lucas Oriente
JIEM700801	MariaGuadalupe.Jime@correo.com	Maria Guadalupe	Jimenez	Espinosa	1970-08-01	Restaurantes Copacabana	16090	Queretaro	107	Av. Hidalgo 	Caltongo
REMR640722	Rafael.Reye@correo.com	Rafael	Reyes	Mejia	1964-07-22	Restaurantes Copacabana	5200	Quintana Roo	27	Av. Insurgentes Sur	San Jose De Los Cedros
DIVM641019	MiguelAngel.Diaz@correo.com	Miguel Angel	Diaz	Vega	1964-10-19	Restaurantes Copacabana	9290	San Luis Potosi	105	Av. Paseo de la Reforma 	Santa Cruz Meyehualco
TOSM741120	Martha.Torr@correo.com	Martha	Torres	Sandoval	1974-11-20	Restaurantes Copacabana	3410	Sinaloa	91	San Borja	Postal
GUCR660420	Ricardo.Guti@correo.com	Ricardo	Gutierrez	Campos	1966-04-20	Restaurantes Copacabana	7420	Sonora	115	Prologacion Division del Norte	Nueva Atzacoalco
RUNJ620619	Jesus.Ruiz@correo.com	Jesus	Ruiz	Nava	1962-06-19	Restaurantes Copacabana	9180	Tabasco	114	Juan Crisostomo Bonilla	Ermita Zaragoza
AGCJ031219	JuanCarlos.Agui@correo.com	Juan Carlos	Aguilar	Cabrera	2003-12-19	Restaurantes Copacabana	7230	Tamaulipas	26	Enrique Rebsamen	Zona Escolar
MEIA650510	Antonio.Mend@correo.com	Antonio	Mendoza	Ibarra	1965-05-10	Restaurantes Copacabana	9000	Tlaxcala	156	Calzada de Tlalpan	San Pedro
CAEJ870604	Juana.Cast@correo.com	Juana	Castillo	Espinoza	1987-06-04	Restaurantes Copacabana	2710	Baja California Sur	177	Eje 5 Norte 	San Pedro Xalpa
ORSG991123	Gabriela.Orti@correo.com	Gabriela	Ortiz	Santos	1999-11-23	Restaurantes Copacabana	13363	Veracruz 	183	Boulevard Emiliano Zapata 	Tempiluli
MOAV770620	Veronica.More@correo.com	Veronica	Moreno	Acosta	1977-06-20	Restaurantes Copacabana	9319	Yucatan	67	Benito Juarez	Cuchilla Del Moral
RICP891009	Pedro.Rive@correo.com	Pedro	Rivera	Camacho	1989-10-09	Restaurantes Copacabana	9400	Zacatecas	188	Eje 5 Oriente	El Sifon
RAVA620308	Adriana.Ramo@correo.com	Adriana	Ramos	Valdez	1962-03-08	Restaurantes Copacabana	9300	Campeche	102	 Benjamiin Franklin 	Guadalupe Del Moral
ROFJ810322	Juan.Rome@correo.com	Juan	Romero	Fuentes	1981-03-22	Restaurantes Copacabana	9910	Coahuila	34	Eje 10 Sur	Los Mirasoles
JUMM910528	Martin.Juar@correo.com	Martin	Juarez	Muñoz	1991-05-28	Restaurantes Copacabana	5219	Colima	190	Av. Insurgentes Sur	Granjas Navidad
ALMA640201	AnaMaria.Alva@correo.com	Ana Maria	Alvarez	Miranda	1964-02-01	Restaurantes Copacabana	3540	Chiapas	77	Universidad	Del Carmen
MEMF660308	Francisco.Mend@correo.com	Francisco	Mendez	Maldonado	1966-03-08	Restaurantes Copacabana	3640	Chihuahua	91	Calzada Tlahuac Chalco	Del Lago
CHRM740404	Margarita.Chav@correo.com	Margarita	Chavez	Robles	1974-04-04	Restaurantes Copacabana	2680	Ciudad de Mexico	165	Av. Gobernadores	Potrero Del Llano
HERR001225	Raul.Herr@correo.com	Raul	Herrera	Rosas	2000-12-25	Restaurantes Copacabana	9310	Queretaro	46	Av. Ojo de Agua	Leyes De Reforma 3A Seccion
MEMP900810	Patricia.Medi@correo.com	Patricia	Medina	Meza	1990-08-10	Restaurantes Copacabana	9000	Quintana Roo	98	Av. Hangares 	Santa Barbara
DOMC031215	Carlos.Domi@correo.com	Carlos	Dominguez	Molina	2003-12-15	Restaurantes Copacabana	9708	San Luis Potosi	93	Eje 8 Sur	Mixcoatl
CATM791112	Maribel.Cast@correo.com	Maribel	Castro	Trejo	1979-11-12	Restaurantes Copacabana	9600	Sinaloa	190	Prolongación Morelos	Santiago Acahualtepec
GURI990110	Irma.Guzm@correo.com	Irma	Guzman	Rosales	1999-01-10	Restaurantes Copacabana	10600	Sonora	197	Poniente 128	El Rosal
VAPE681216	Elizabeth.Varg@correo.com	Elizabeth	Vargas	Pacheco	1968-12-16	Restaurantes Copacabana	10926	Tabasco	132	Eje 6 Sur	Tierra Colorada
VENM881025	Manuel.Vela@correo.com	Manuel	Velazquez	Navarro	1988-10-25	Restaurantes Copacabana	4330	Tamaulipas	78	Acueducto	El Rosedal
SASG770522	Guadalupe.Sala@correo.com	Guadalupe	Salazar	Salgado	1977-05-22	Restaurantes Copacabana	10926	Tlaxcala	200	Av. Vasco de Quiroga	Tierra Colorada
ROAC851025	Claudia.Roja@correo.com	Claudia	Rojas	Aguirre	1985-10-25	Restaurantes Copacabana	15510	Baja California Sur	117	Boulevard Lazaro Cardenas	Pensador Mexicano
ORSA671130	Alicia.Orte@correo.com	Alicia	Ortega	Salas	1967-11-30	Restaurantes Copacabana	11320	Veracruz 	133	Dr. Morones Prieto	Anahuac I Seccion
COVM990205	MariaDelCarmen.Cort@correo.com	Maria Del Carmen	Cortes	Velasco	1999-02-05	Restaurantes Copacabana	6800	Yucatan	150	Av. Insurgentes Sur	Obrera
SACM680717	MariaIsabel.Sant@correo.com	Maria Isabel	Santiago	Cardenas	1968-07-17	Restaurantes Copacabana	16070	Zacatecas	28	Calz. Ignacio Zaragoza	Barrio Belen
GUPA850710	Alejandro.Guer@correo.com	Alejandro	Guerrero	Pineda	1985-07-10	Restaurantes Copacabana	9630	Campeche	121	Prolongación Morelos 	San Miguel Teotongo Seccion Torres
COOL730825	Laura.Cont@correo.com	Laura	Contreras	Orozco	1973-08-25	Restaurantes Copacabana	11270	Coahuila	168	Av. Adolfo Lopez Mateos 	Argentina Antigua
BASL820207	Leticia.Baut@correo.com	Leticia	Bautista	Serrano	1982-02-07	Restaurantes Copacabana	9870	Colima	182	 Circuito Interior Churubusco	Santa Maria Tomatlan
ESRA750922	Araceli.Estr@correo.com	Araceli	Estrada	Rangel	1975-09-22	Restaurantes Copacabana	14260	Chiapas	45	Av. Insurgentes Sur 	Miguel Hidalgo 1A Seccion
LUVJ851208	Jose.Luna@correo.com	Jose	Luna	Valencia	1985-12-08	Restaurantes Copacabana	10320	Chihuahua	174	Av. Chapultepec 	El Tanque
GUER851209	RosaMaria.Guer@correo.com	Rosa Maria	Guerra	Escobedo	1985-12-09	Restaurantes Copacabana	6800	Ciudad de Mexico	47	Prolongacion Cuba	Obrera
\.


--
-- TOC entry 3403 (class 0 OID 17401)
-- Dependencies: 211
-- Data for Name: dependiente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dependiente (curp, nombre, ap_paterno, ap_materno, parentesco, numero_empleado) FROM stdin;
SATR941102FGOAAN16	Rodrigo	Saavedra	Teran	Padre	2
CAVL161026FUEAAS44	Luis Enrique	Castaneda	Venegas	Primo(a)	5
PAPC060712MNAZDO55	Catalina	Paz	Pulido	Conyuge 	42
ARCH950310MTOSAS23	Heriberto	Arcos	Casas	Conyuge 	19
HERL870613FIAASO58	Lilia	Heredia	Reynoso	Tio(a)	39
BUGE970713FZAENA29	Esperanza	Bustamante	Galeana	Abuelo(a)	40
VICO120830FIAENA09	Olivia	Vite	Cadena	Madre	48
BUGJ830808FINSLO87	Joaquin	Bustos	Gordillo	Hermano(a)	16
SECA901218FAMALO45	Abraham	Serna	Cedillo	Hijo(a)	21
DESA031222FFOAOR88	Adolfo	De La	Salvador	Hijo(a)	7
BASI180723MANAÑA55	Ivan	Bahena	Saldaña	Conyuge 	4
MOPJ920415FANNÑA64	Jose Juan	Mondragon	Piña	Hermano(a)	1
ALAG021105FLONCA82	Gonzalo	Aleman	Abarca	Hijo(a)	6
MELB200816FTOAMA06	Benito	Mena	Lima	Padre	17
MEMM010617MIAONO28	Martha Patricia	Merino	Manzano	Conyuge 	49
CAAM060209FONSLA79	Maria Concepcion	Casillas	Alcala	Conyuge 	43
PEOL050301MZOAAZ98	Lorenzo	Pena	Ordaz	Tio(a)	9
VEOJ980301FIOAOS99	Julio	Vergara	Ontiveros	Conyuge 	11
ADMI030101MELEUS47	Isabel	Adame	Matus	Madre	33
MALM820202FROLON75	Maria Del Socorro	Madrigal	Limon	Padre	44
LIRI100613FROADA78	Isidro	Lira	Rueda	Madre	15
RIBR190723MBANES43	Rosalba	Rincon	Briones	Conyuge 	28
JAMR920108MELOTA53	Raquel	Jasso	Mota	Conyuge 	34
CAHS830321MIANSA17	Sonia	Carreon	Hinojosa	Madre	30
CARJ150630FCOLAN18	Juan Francisco	Canul	Roldan	Primo(a)	20
CODF981027FIXOLO69	Felix	Cordero	Delgadillo	Abuelo(a)	10
CAYF090823MLASEZ24	Fabiola	Cazares	Yañez	Padre	32
HULM040405MOSORO66	Marcos	Hurtado	Lazaro	Hijo(a)	8
CHPM190723MUZNES71	Maria De La Luz	Chacon	Perales	Hijo(a)	38
COBJ000629FANATO39	Julian	Correa	Brito	Hijo(a)	23
ALNS830824FRARRI93	Sara	Alcocer	Neri	Madre	45
ZATM890423FVAAÑO89	Minerva	Zaragoza	Treviño	Padre	47
BECL160723MDOLIA75	Leonardo	Becerril	Chavarria	Conyuge 	13
BADC030810FNARES58	Carolina	Baltazar	Dorantes	Abuelo(a)	25
VACL860721MIOZNA26	Luis Antonio	Valadez	Cardona	Tio(a)	24
ROPC170219FONODO70	Concepcion	Rosado	Prado	Primo(a)	50
FOVF120211MELATE53	Fidel	Fonseca	Vicente	Conyuge 	12
ZANG841026MANOGA11	German	Zamudio	Noriega	Madre	18
URTB030513MLAADA63	Blanca Estela	Urbina	Tejeda	Hijo(a)	36
SAAC941230FNANLO81	Cristina	Santillan	Angulo	Conyuge 	27
MIFA180623FIANCO33	Alma Delia	Millan	Francisco	Primo(a)	35
NUMF121210FUSZVO75	Felipe De Jesus	Nunez	Montalvo	Padre	14
COMM951223MERNEL14	Maria Esther	Colin	Miguel	Conyuge 	41
DEGM201001MESSDO79	Maria Dolores	De Los Santos	Garrido	Hijo(a)	37
QUSM990126MNAANZ12	Maria Magdalena	Quintana	Saenz	Conyuge 	26
BADG000911MNAORE24	Guillermina	Badillo	De La Torre	Hermano(a)	31
VEAO000606MIOZAZ29	Octavio	Velez	Alcaraz	Madre	3
PENM861029MPEACO81	Ma. Guadalupe	Pedraza	Nolasco	Hermano(a)	46
LUPK020803MNASTE15	Karina	Luis	Puente	Padre	29
OSRE990326FIOAON94	Emilio	Osuna	Ramon	Hijo(a)	22
\.


--
-- TOC entry 3401 (class 0 OID 17379)
-- Dependencies: 209
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.empleado (numero_empleado, foto, rfc, nombre, ap_paterno, ap_materno, edad, sueldo, calle, numero, cp, estado, colonia, fecha_nacimiento, es_mesero, es_administrativo, es_cocinero, horario, rol, especialidad) FROM stdin;
1	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/1.png	VAAM841027	Maria	Vasquez	Arias	37	1290	Avenida de la Convencion Norte	60	7140	Chiapas	Arboledas	1984-10-27	f	t	f	\N	Promotor de ventas	\N
2	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/2.png	VABE870327	Enrique	Valenzuela	Bravo	35	1284	Melchor Ocampo 	103	9720	Colima	Francisco Villa	1987-03-27	t	f	t	07:00 -14:00 hrs	\N	Rottiseur (Asados)
3	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/3.png	TAMA821215	Alberto	Tapia	Mata	39	1276	Calle Durango	152	1160	Tamaulipas	Bosque	1982-12-15	f	t	t	\N	Capitan de meseros 	Saucier (Salsas)
4	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/4.png	BAPV890721	Victor Manuel	Barrera	Parra	32	3464	Heroes de Nacozari	93	1259	Morelos	La Mexicana 2A Ampliacion	1989-07-21	f	t	t	\N	Supervisor de atención al cliente	Entremetier (Pastas)
5	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/5.png	ARCS840117	Sandra	Arellano	Castañeda	38	2742	Tuxtla Gutierrez Chicoasen	118	2600	Aguascalientes	Pro-Hogar	1984-01-17	t	f	f	07:00 -14:00 hrs	\N	\N
6	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/6.png	FIAA831127	Alfredo	Figueroa	Antonio	38	3686	Juan Pablo II 	109	9210	Durango	Tepalcates	1983-11-27	t	f	f	12:00 - 17:00 hrs	\N	\N
7	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/7.png	PAEH940126	Hector	Padilla	Enriquez	28	3856	Central 57	42	7080	Zacatecas	Gabriel Hernandez	1994-01-26	t	f	t	07:00 -14:00 hrs	\N	Friturier (Fritos)
8	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/8.png	AYVE930511	Edith	Ayala	Vera	29	3095	Medellin 	186	11200	San Luis Potosi	Lomas Hermosa	1993-05-11	f	t	t	\N	Chef ejecutivo	Saucier (Salsas)
9	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/9.png	HUCN900213	Norma	Huerta	Cisneros	32	2995	Francisco Villa 	76	13120	Michoacan	Ampliacion Santa Catarina	1990-02-13	t	t	t	07:00 -14:00 hrs	Gerente	Tournant
10	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/10.png	DURM940212	Maria Teresa	Duran	Rivas	28	2969	Irrigacion 	51	10369	Nuevo Leon	Tierra Unida	1994-02-12	f	t	f	\N	Administrador del restaurante	\N
11	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/11.png	SAMB870920	Beatriz	Salinas	Montoya	34	3979	Miguel Aleman 	65	9637	Jalisco	Campestre Potrero	1987-09-20	t	t	f	14:00 - 22:00 hrs	Gerente	\N
12	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/12.png	MOOJ910725	Julio Cesar	Montes	Olivares	30	1341	5 de Febrero 	97	14640	Ciudad de mexico	Ejidos De San Pedro Martir	1991-07-25	t	t	t	14:00 - 22:00 hrs	Coordinador del servicio al cliente	Entremetier (Pastas)
13	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/13.png	MORG900406	Gustavo	Mora	Rocha	32	2017	Emiliano Zapata	108	10369	Guanajuato	Tierra Unida	1990-04-06	f	f	t	\N	\N	Grillardin (Parrilla)
14	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/14.png	CACF841019	Felipe	Calderon	Castellanos	37	1582	Calzada Ibarra	148	1410	Queretaro	Palmas	1984-10-19	f	f	t	\N	\N	Grillardin (Parrilla)
15	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/15.png	MAZG820426	Gloria	Marin	Zuñiga	40	2236	Avenida Ventura 	180	10360	Puebla	Huayatla	1982-04-26	f	t	f	\N	Capitan de meseros 	\N
16	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/16.png	CUAS920616	Susana	Cuevas	Arroyo	29	2563	Avenida Universidad Planta Baja 	195	16620	Tlaxcala	Barrio San Jose	1992-06-16	t	f	t	14:00 - 22:00 hrs	\N	Grillardin (Parrilla)
17	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/17.png	VIEO821128	Oscar	Villanueva	Esquivel	39	4144	Insurgentes Oriente 	92	14640	Campeche	Ejidos De San Pedro Martir	1982-11-28	f	t	f	\N	Chef ejecutivo	\N
18	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/18.png	PAQA890802	Armando	Palacios	Quiroz	32	3376	Calzada Acoxpa 	76	4369	Baja California Sur	Pedregal De Santo Domingo	1989-08-02	t	t	f	14:00 - 22:00 hrs	Promotor de ventas	\N
19	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/19.png	OLNT921221	Teresa	Olvera	Navarrete	29	2873	Juan De Dios Batiz 	171	2810	Oaxaca	Victoria De Las Democracias	1992-12-21	t	t	f	12:00 - 17:00 hrs	Promotor de ventas	\N
20	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/20.png	ESVL971214	Lorena	Escobar	Villalobos	24	1303	26 Norte 	106	9410	Chiapas	Aculco	1997-12-14	t	f	t	07:00 -14:00 hrs	\N	Rottiseur (Asados)
21	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/21.png	SUVJ960506	Jaime	Suarez	Villa	26	1985	Constituyentes	47	7979	Sinaloa	San Juan De Aragon Iv Seccion	1996-05-06	f	f	t	\N	\N	Grillardin (Parrilla)
22	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/22.png	BEGD951228	David	Benitez	Guevara	26	4112	Francisco I Madero	67	8100	Yucatan	Agricola Pantitlan	1995-12-28	f	f	t	\N	\N	Patisseur (Postres)
23	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/23.png	GAAJ980524	Juan Manuel	Gallegos	Angeles	24	2774	Jesus Goytortua 	74	2100	Colima	El Rosario	1998-05-24	f	t	t	\N	Gerente	Tournant
24	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/24.png	FRTM931015	Marisol	Franco	Tovar	28	2808	Prologación Marina Nacional 	48	7880	Sinaloa	Martires De Rio Blanco	1993-10-15	f	f	t	\N	\N	Poissoner (Pescados)
25	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/25.png	OCCJ910523	Jose Manuel	Ochoa	Cordova	31	4163	Boulevard Luis Encinas Jhonson 	193	15530	Tlaxcala	Moctezuma 2A Seccion	1991-05-23	t	t	f	07:00 -14:00 hrs	Supervisor del area de cocina	\N
26	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/26.png	CAVM900916	Maria Luisa	Cano	Villarreal	31	3588	Teapa	87	5410	Ciudad de Mexico	San Lorenzo Acopilco	1990-09-16	t	t	t	07:00 -14:00 hrs	Capitan de meseros 	Entremetier (Pastas)
27	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/27.png	ZACM950817	Maria De Jesus	Zamora	Carmona	26	1328	Hidalgo 	170	4380	Quintana Roo	Pueblo La Candelaria	1995-08-17	f	f	t	\N	\N	Poissoner (Pescados)
28	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/28.png	BEQS900723	Salvador	Beltran	Quintero	31	2357	Libramiento Poniente 	32	9900	Hidalgo	San Lorenzo	1990-07-23	f	t	f	\N	Supervisor del area de cocina	\N
29	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/29.png	VIGG910411	Guillermo	Villegas	Gallardo	31	3754	5 de Mayo	105	10330	Tabasco	Las Cruces	1991-04-11	t	f	f	14:00 - 22:00 hrs	\N	\N
30	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/30.png	MADA991116	Angel	Macias	De La Rosa	22	4353	Calle 14 	104	7320	San Luis Potosi	Ticoman	1999-11-16	t	f	t	07:00 -14:00 hrs	\N	Rottiseur (Asados)
31	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/31.png	ZAOE990524	Eduardo	Zavala	Ocampo	23	3569	Ruinas de Tulum	200	2250	Tabasco	Santa Catarina	1999-05-24	f	f	t	\N	\N	Poissoner (Pescados)
32	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/32.png	LOTR910816	Rosa	Lozano	Tellez	30	1347	Calzada General Luis Caballero	35	13200	Nayarit	Miguel Hidalgo	1991-08-16	f	f	t	\N	\N	Boucher (Carnes)
33	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/33.png	ALZG840212	Gabriel	Alonso	Zapata	38	2314	Central Poniente 	178	7550	Baja California	Providencia	1984-02-12	f	f	t	\N	\N	Boucher (Carnes)
34	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/34.png	GACD841227	Daniel	Galvan	Caballero	37	1248	Guadalupe Victoria	113	4950	Veracruz 	El Mirador	1984-12-27	f	f	t	\N	\N	Patisseur (Postres)
35	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/35.png	OSEL850827	Lucia	Osorio	Esparza	36	2087	Calzada de la Viga	53	14248	Coahuila	Cruz Del Farol	1985-08-27	t	f	f	14:00 - 22:00 hrs	\N	\N
36	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/36.png	PEMM960112	Mario	Peña	Montiel	26	4486	General Mariano Salas 	147	7130	Ciudad de Mexico	El Tepetatal	1996-01-12	f	t	f	\N	Gerente	\N
37	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/37.png	ROBM841226	Maricela	Roman	Becerra	37	2846	Prolongación centenario	93	7640	Guerrero	Santiago Atepetlac	1984-12-26	f	t	t	\N	Supervisor de atención al cliente	Garde Manger (Ensaladas)
38	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/38.png	TRLG831214	Graciela	Trujillo	Lugo	38	3244	Boulevard Emiliano Zapata	159	2430	Chihuahua	Presidente Madero	1983-12-14	t	t	t	14:00 - 22:00 hrs	Coordinador del servicio al cliente	Garde Manger (Ensaladas)
39	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/39.png	GADL981121	Luis	Garza	Davila	23	1953	Calzada General Luis Caballero	24	9510	Campeche	Santa Martha Acatitla	1998-11-21	f	f	t	\N	\N	Boucher (Carnes)
40	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/40.png	POSR000918	Rocio	Ponce	Santana	21	4472	Calle cuervo 	41	9320	Sonora	Sideral	2000-09-18	f	t	f	\N	Promotor de ventas	\N
41	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/41.png	PEDG900204	Gerardo	Peralta	De Leon	32	1950	Prolongacion Marina Nacional	139	11870	Queretaro	Tacubaya	1990-02-04	f	t	t	\N	Promotor de ventas	Tournant
42	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/42.png	GARR950322	Ruben	Galindo	Reyna	27	3449	Guillerno Prieto 	88	1618	Quintana Roo	Ex-Hacienda De Tarango	1995-03-22	t	f	t	07:00 -14:00 hrs	\N	Saucier (Salsas)
43	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/43.png	LEGL840806	Luz Maria	Leyva	Galicia	37	2374	Constitucion 	74	9310	Coahuila	Leyes De Reforma 3A Seccion	1984-08-06	t	f	f	14:00 - 22:00 hrs	\N	\N
44	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/44.png	NUPJ920521	Josefina	Nuñez	Paredes	30	1624	Marina	81	2040	Yucatan	San Sebastian	1992-05-21	f	f	t	\N	\N	Patisseur (Postres)
45	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/45.png	COMJ870720	Jose Antonio	Corona	Munoz	34	3672	Interoceanica Saltillo Torreon	145	13219	Tamaulipas	Las Arboledas	1987-07-20	f	t	f	\N	Coordinador del servicio al cliente	\N
46	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/46.png	ZAAM900815	Maria Del Rosario	Zarate	Alarcon	31	2115	Gregorio Torres Quintero	119	9870	Sonora	San Andres Tomatlan	1990-08-15	f	t	t	\N	Supervisor de atención al cliente	Entremetier (Pastas)
47	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/47.png	ANNA860722	Angelica	Andrade	Najera	35	2984	Prolongación Eje 6 Sur	161	9700	Baja California Sur	Santa Cruz Meyehualco	1986-07-22	f	f	t	\N	\N	Garde Manger (Ensaladas)
48	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/48.png	BEAM980523	Maria De Los Angeles	Bernal	Acevedo	24	1342	Boulevard Fundadores	80	1377	Chihuahua	Jalalpa El Grande	1998-05-23	f	t	f	\N	Administrador del restaurante	\N
49	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/49.png	TOOV970909	Virginia	Toledo	Ojeda	24	3705	Francisco I Madero	21	14646	Zacatecas	Valle De Tepepan	1997-09-09	t	t	f	14:00 - 22:00 hrs	Supervisor del area de cocina	\N
50	https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/fotos%20empleados%20200x200/50.png	RUMM970910	Maria De Lourdes	Rubio	Mercado	24	4126	Avenida Insurgentes	44	1510	Veracruz 	Los Cedros	1997-09-10	t	f	t	07:00 -14:00 hrs	\N	Patisseur (Postres)
\.


--
-- TOC entry 3408 (class 0 OID 17454)
-- Dependencies: 216
-- Data for Name: incluye; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.incluye (folio, id_producto, cantidad_producto, precio_total_por_producto) FROM stdin;
ORD-1	1	3	189.24000549316406
ORD-2	40	3	261.87000274658203
ORD-3	24	2	60
ORD-4	14	1	129.89999389648438
ORD-5	18	1	108.79000091552734
ORD-6	3	1	37.939998626708984
ORD-7	40	3	261.87000274658203
ORD-8	32	1	52.369998931884766
ORD-9	16	2	230.0800018310547
ORD-10	45	1	31.860000610351562
ORD-11	9	1	41.970001220703125
ORD-12	21	1	23.190000534057617
ORD-13	42	1	88.80999755859375
ORD-14	29	1	28.56999969482422
ORD-15	18	2	217.5800018310547
ORD-16	8	2	104.94000244140625
ORD-17	23	3	135.4199981689453
ORD-18	25	2	53.65999984741211
ORD-19	13	1	95.94999694824219
ORD-20	9	3	125.91000366210938
ORD-21	9	3	125.91000366210938
ORD-22	16	1	115.04000091552734
ORD-23	37	2	114.58000183105469
ORD-24	30	1	41.970001220703125
ORD-25	35	2	134.8800048828125
ORD-26	45	2	63.720001220703125
ORD-27	50	3	100.83000183105469
ORD-28	9	2	83.94000244140625
ORD-29	16	2	230.0800018310547
ORD-30	48	3	135.50999450683594
ORD-31	8	3	157.41000366210938
ORD-32	42	3	266.42999267578125
ORD-33	32	2	104.73999786376953
ORD-34	18	1	108.79000091552734
ORD-35	35	1	67.44000244140625
ORD-36	30	3	125.91000366210938
ORD-37	20	3	382.4100036621094
ORD-38	3	2	75.87999725341797
ORD-39	21	3	69.57000160217285
ORD-40	15	3	335.6100082397461
ORD-41	21	1	23.190000534057617
ORD-42	20	3	382.4100036621094
ORD-43	30	2	83.94000244140625
ORD-44	50	1	33.61000061035156
ORD-45	45	3	95.58000183105469
ORD-46	25	1	26.829999923706055
ORD-47	8	3	157.41000366210938
ORD-48	9	2	83.94000244140625
ORD-49	3	1	37.939998626708984
ORD-50	28	3	107.25
ORD-1	42	3	266.42999267578125
ORD-2	13	2	191.89999389648438
ORD-3	9	3	125.91000366210938
ORD-4	30	1	41.970001220703125
ORD-5	50	1	33.61000061035156
ORD-6	15	1	111.87000274658203
ORD-7	21	3	69.57000160217285
ORD-8	21	3	69.57000160217285
ORD-9	21	3	69.57000160217285
ORD-10	21	2	46.380001068115234
ORD-11	16	3	345.12000274658203
ORD-12	32	2	104.73999786376953
ORD-13	38	1	59.0099983215332
ORD-14	1	1	63.08000183105469
ORD-15	32	1	52.369998931884766
ORD-16	50	3	100.83000183105469
ORD-17	48	3	135.50999450683594
ORD-18	18	3	326.37000274658203
ORD-19	38	1	59.0099983215332
ORD-20	50	3	100.83000183105469
ORD-21	25	2	53.65999984741211
ORD-22	13	3	287.84999084472656
ORD-23	32	2	104.73999786376953
ORD-24	13	2	191.89999389648438
ORD-25	14	1	129.89999389648438
ORD-51	40	2	174.5800018310547
ORD-52	24	2	60
ORD-53	14	3	389.6999816894531
ORD-54	18	2	217.5800018310547
ORD-55	3	2	75.87999725341797
ORD-56	40	3	261.87000274658203
ORD-57	32	3	157.1099967956543
ORD-58	16	3	345.12000274658203
ORD-59	45	2	63.720001220703125
ORD-60	9	1	41.970001220703125
ORD-61	21	1	23.190000534057617
ORD-62	42	3	266.42999267578125
ORD-63	29	3	85.70999908447266
ORD-64	18	2	217.5800018310547
ORD-65	8	3	157.41000366210938
ORD-66	23	3	135.4199981689453
ORD-67	25	1	26.829999923706055
ORD-68	13	3	287.84999084472656
ORD-69	50	2	67.22000122070312
ORD-70	45	1	31.860000610351562
ORD-71	25	3	80.48999977111816
ORD-72	8	1	52.470001220703125
ORD-73	9	3	125.91000366210938
ORD-74	3	2	75.87999725341797
ORD-75	18	1	108.79000091552734
ORD-76	21	2	46.380001068115234
ORD-77	3	3	113.81999588012695
ORD-78	9	1	41.970001220703125
ORD-79	9	5	209.85000610351562
ORD-80	8	6	314.82000732421875
\.


--
-- TOC entry 3405 (class 0 OID 17418)
-- Dependencies: 213
-- Data for Name: orden; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orden (folio, fecha, precio_total, cantidad_total, numero_empleado, rfc) FROM stdin;
ORD-26	2021-05-22	63.72	2	26	RICP891009
ORD-27	2021-01-19	100.83	3	26	RAVA620308
ORD-28	2021-03-01	83.94	2	26	ROFJ810322
ORD-29	2021-05-25	230.08	2	29	JUMM910528
ORD-30	2021-12-26	135.51	3	30	ALMA640201
ORD-31	2022-09-16	157.41	3	30	MEMF660308
ORD-32	2022-04-28	266.43	3	30	CHRM740404
ORD-33	2021-02-06	104.74	2	35	HERR001225
ORD-34	2021-01-06	108.79	1	35	MEMP900810
ORD-35	2021-07-13	67.44	1	35	DOMC031215
ORD-36	2022-08-15	125.91	3	38	CATM791112
ORD-37	2021-04-11	382.41	3	38	GURI990110
ORD-38	2021-11-29	75.88	2	38	VAPE681216
ORD-39	2021-12-14	69.57	3	9	VENM881025
ORD-40	2021-06-09	335.61002	3	2	SASG770522
ORD-41	2022-07-14	23.19	1	2	ROAC851025
ORD-42	2022-07-02	382.41	3	42	ORSA671130
ORD-43	2021-04-18	83.94	2	43	COVM990205
ORD-44	2022-06-07	33.61	1	43	SACM680717
ORD-45	2021-05-20	95.58	3	43	GUPA850710
ORD-46	2021-09-29	26.83	1	9	COOL730825
ORD-47	2022-08-12	157.41	3	5	BASL820207
ORD-48	2022-09-30	83.94	2	5	ESRA750922
ORD-49	2022-03-05	37.94	1	49	LUVJ851208
ORD-50	2021-10-01	107.25	3	50	GUER851209
ORD-1	2021-12-26	455.66998	6	2	HELJ690221
ORD-2	2022-08-13	453.77	5	2	GARF941010
ORD-3	2022-06-18	185.91	5	7	MAAM020408
ORD-4	2022-12-26	171.87	2	7	LOAM800620
ORD-5	2021-01-12	142.4	2	5	GODM660826
ORD-6	2021-08-02	149.81	2	6	ROSY901214
ORD-7	2022-06-12	331.44	6	7	PEDF960102
ORD-8	2021-12-25	121.94	4	2	SACR840708
ORD-9	2021-05-04	299.65	5	9	RASA890424
ORD-10	2021-09-10	78.240005	3	2	FLSJ821125
ORD-11	2022-06-16	387.09	4	11	CRLS701017
ORD-12	2021-06-02	127.93	3	12	GOFA970630
ORD-13	2021-07-15	147.81999	2	12	MOCS630404
ORD-14	2021-06-13	91.65	2	12	VAMJ691227
ORD-15	2021-04-12	269.95	3	12	JIEM700801
ORD-16	2021-05-10	205.77	5	16	REMR640722
ORD-17	2021-06-19	270.93	6	16	DIVM641019
ORD-18	2021-04-07	380.03	5	18	TOSM741120
ORD-19	2022-04-23	154.95999	2	19	GUCR660420
ORD-20	2021-04-12	226.74	6	20	RUNJ620619
ORD-21	2022-08-15	179.57	5	5	AGCJ031219
ORD-22	2021-10-30	402.88998	4	5	MEIA650510
ORD-23	2022-05-05	219.32	4	2	CAEJ870604
ORD-24	2021-08-04	233.87	3	2	ORSG991123
ORD-25	2021-10-12	264.78	3	25	MOAV770620
ORD-51	2021-12-26	174.58	2	2	HELJ690221
ORD-52	2022-08-13	60	2	2	GARF941010
ORD-53	2022-06-18	389.69998	3	9	MAAM020408
ORD-54	2022-12-26	217.58	2	9	LOAM800620
ORD-55	2021-01-12	75.88	2	5	GODM660826
ORD-56	2021-08-02	261.87	3	6	ROSY901214
ORD-57	2022-06-12	157.11	3	7	PEDF960102
ORD-58	2021-12-25	345.12	3	2	SACR840708
ORD-59	2021-05-04	63.72	2	9	RASA890424
ORD-60	2021-09-10	41.97	1	2	FLSJ821125
ORD-61	2022-06-16	23.19	1	11	CRLS701017
ORD-62	2021-06-02	266.43	3	12	GOFA970630
ORD-63	2021-07-15	85.71	3	12	MOCS630404
ORD-64	2021-06-13	217.58	2	12	VAMJ691227
ORD-65	2021-04-12	157.41	3	12	JIEM700801
ORD-66	2021-05-10	135.42	3	16	REMR640722
ORD-67	2021-06-19	26.83	1	16	DIVM641019
ORD-68	2021-04-07	287.84998	3	18	TOSM741120
ORD-69	2022-04-23	67.22	2	19	GUCR660420
ORD-70	2021-04-12	31.86	1	20	RUNJ620619
ORD-71	2022-08-15	80.49	3	2	AGCJ031219
ORD-72	2021-10-30	52.47	1	7	MEIA650510
ORD-73	2022-05-05	125.91	3	7	CAEJ870604
ORD-74	2021-08-04	75.88	2	5	ORSG991123
ORD-75	2021-10-12	108.79	1	25	MOAV770620
ORD-76	2022-06-01	46.38	2	25	MOAV770620
ORD-77	2022-05-31	113.81999	3	6	TOSM741120
ORD-78	2022-06-01	41.97	1	6	AGCJ031219
ORD-79	2022-06-01	209.85	5	12	VAMJ691227
ORD-80	2022-06-01	314.82	6	9	GOFA970630
\.


--
-- TOC entry 3407 (class 0 OID 17441)
-- Dependencies: 215
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.producto (id_producto, nombre, receta, precio, descripcion, disponibilidad, tipo_producto, con_alcohol, platillo_del_dia, id_categoria, cantidad_vendida) FROM stdin;
2	Tacos campechanos	https://www.recetasgratis.net/receta-de-tacos-campechanos-73818.html	42.85	Entrante	f	Platillo	\N	f	1	\N
4	Ceviche de sierra	https://www.recetasgratis.net/receta-de-ceviche-de-sierra-73815.html	31.23	Entrante	f	Platillo	\N	f	1	\N
5	Ceviche de jaiba	https://www.recetasgratis.net/receta-de-ceviche-de-jaiba-73814.html	54.96	Entrante	f	Platillo	\N	f	1	\N
6	Enchiladas mineras	https://www.recetasgratis.net/receta-de-enchiladas-mineras-73006.html	23.3	Entrante	f	Platillo	\N	f	1	\N
7	Muffins de mandarina	https://www.recetasgratis.net/receta-de-muffins-de-mandarina-52216.html	27.99	Merienda	f	Platillo	\N	f	4	\N
10	Pastelitos de membrillo al horno	https://www.recetasgratis.net/receta-de-pastelitos-de-membrillo-al-horno-52198.html	65.06	Merienda	f	Platillo	\N	f	4	\N
11	Cupcakes de zanahoria 	https://www.recetasgratis.net/receta-de-cupcakes-de-zanahoria-facil-52194.html	65.34	Merienda	f	Platillo	\N	f	4	\N
12	ChicharrÃ³n en salsa verde picante	https://www.recetasgratis.net/receta-de-chicharron-en-salsa-verde-picante-52512.html	30.4	Plato principal	f	Platillo	\N	f	1	\N
17	Steak mostaza	https://www.recetasgratis.net/receta-de-steak-mostaza-52328.html	100.78	Plato principal	f	Platillo	\N	f	1	\N
19	Lomo de res stroganoff	https://www.recetasgratis.net/receta-de-lomo-de-res-stroganoff-52325.html	122.21	Plato principal	f	Platillo	\N	t	1	\N
22	Ponche de duraznos	https://www.recetasgratis.net/receta-de-ponche-de-duraznos-48122.html	23.57	Acompaniamiento	f	Bebida	f	\N	5	\N
26	Licor de Majuelo casero	https://www.recetasgratis.net/receta-de-licor-de-majuelo-casero-41281.html	43.91	Acompaniamiento	f	Bebida	t	\N	9	\N
27	Ponche De Naranja con ron	https://www.recetasgratis.net/receta-de-ponche-de-naranja-con-ron-41308.html	36.19	Acompaniamiento	f	Bebida	t	\N	9	\N
31	Naranjada	https://www.recetasgratis.net/receta-de-naranjada-9206.html	45.8	Acompaniamiento	f	Bebida	f	\N	8	\N
33	Fusilli con pollo a la crema	https://www.recetasgratis.net/receta-de-fusilli-con-pollo-a-la-crema-58099.html	72.71	Plato principal	f	Platillo	\N	f	2	\N
34	Tallarines de arroz con verduras	https://www.recetasgratis.net/receta-de-tallarines-de-arroz-con-verduras-57971.html	78.38	Plato principal	f	Platillo	\N	t	2	\N
36	Pasta con espinacas vegetariana	https://www.recetasgratis.net/receta-de-pasta-con-espinacas-vegetariana-58063.html	64.48	Plato principal	f	Platillo	\N	f	2	\N
39	Ensalada Victoria	https://www.recetasgratis.net/receta-de-ensalada-victoria-26386.html	66.8	Entrante	f	Platillo	\N	f	3	\N
41	Ensalada de queso Camembert	https://www.recetasgratis.net/receta-de-ensalada-de-queso-camembert-26378.html	57.1	Entrante	f	Platillo	\N	f	3	\N
43	Ensalada de la huerta	https://www.recetasgratis.net/receta-de-ensalada-de-la-huerta-26373.html	72.49	Entrante	f	Platillo	\N	f	3	\N
44	 Ensalada de espinacas con huevo cocido	https://www.recetasgratis.net/receta-de-ensalada-de-espinacas-con-huevo-cocido-26370.html	66.24	Entrante	f	Platillo	\N	f	3	\N
46	Limonada de moras	https://www.recetasgratis.net/receta-de-limonada-de-moras-59453.html	38.81	Acompaniamiento	f	Bebida	f	\N	8	\N
47	Smoothie verde con plÃ¡tano	https://www.recetasgratis.net/receta-de-smoothie-verde-con-platano-59505.html	49	Acompaniamiento	f	Bebida	f	\N	7	\N
49	Zumo de granada y naranja con zanahoria	https://www.recetasgratis.net/receta-de-zumo-de-granada-y-naranja-con-zanahoria-59706.html	21.3	Acompaniamiento	f	Bebida	f	\N	8	\N
37	Tortellinis rellenos de setas	https://www.recetasgratis.net/receta-de-tortellinis-rellenos-de-setas-58060.html	57.29	Plato principal	t	Platillo	\N	f	2	2
35	Rollitos de pizza de hojaldre	https://www.recetasgratis.net/receta-de-rollitos-de-pizza-de-hojaldre-58079.html	67.44	Plato principal	t	Platillo	\N	f	2	3
20	Lomo de res al vino con crema	https://www.recetasgratis.net/receta-de-lomo-de-res-al-vino-con-crema-52324.html	127.47	Plato principal	t	Platillo	\N	f	1	6
28	Batido de mora y fresa	https://www.recetasgratis.net/receta-de-batido-de-mora-y-fresa-51456.html	35.75	Acompaniamiento	t	Bebida	f	\N	7	3
30	Limonada con frambuesa	https://www.recetasgratis.net/receta-de-limonada-con-frambuesa-8115.html	41.97	Acompaniamiento	t	Bebida	f	\N	8	7
15	Lomo de cerdo acaramelado al horno	https://www.recetasgratis.net/receta-de-lomo-de-cerdo-acaramelado-al-horno-52449.html	111.87	Plato principal	t	Platillo	\N	f	1	4
1	Quesadillas de flor de calabaza	https://www.recetasgratis.net/receta-de-quesadillas-de-flor-de-calabaza-73817.html	63.08	Plato principal	t	Platillo	\N	f	1	4
48	Ponche de frutas con alcohol	https://www.recetasgratis.net/receta-de-ponche-de-frutas-con-alcohol-59964.html	45.17	Acompaniamiento	t	Bebida	t	\N	9	6
38	Espaguetis con salmÃ³n y tomates cherry	https://www.recetasgratis.net/receta-de-espaguetis-con-salmon-y-tomates-cherry-58032.html	59.01	Plato principal	t	Platillo	\N	f	3	2
24	Jugo de fresa con mora	https://www.recetasgratis.net/receta-de-jugo-de-fresa-con-mora-47770.html	30	Acompaniamiento	t	Bebida	f	\N	8	4
14	Chuletas de cerdo a la francesa	https://www.recetasgratis.net/receta-de-chuletas-de-cerdo-a-la-francesa-52471.html	129.9	Plato principal	t	Platillo	\N	f	1	5
40	Ensalada de papas y pollo	https://www.recetasgratis.net/receta-de-ensalada-de-papas-y-pollo-26376.html	87.29	Entrante	t	Platillo	\N	f	3	11
32	Espaguetis a la mantequilla	https://www.recetasgratis.net/receta-de-espaguetis-a-la-mantequilla-58143.html	52.37	Entrante	t	Platillo	\N	f	2	11
16	Carne en adobo con guisantes y zanahorias	https://www.recetasgratis.net/receta-de-carne-en-adobo-con-guisantes-y-zanahorias-52355.html	115.04	Plato principal	t	Platillo	\N	f	1	11
42	Ensalada de lechuga con mostaza	https://www.recetasgratis.net/receta-de-ensalada-de-lechuga-con-mostaza-26375.html	88.81	Entrante	t	Platillo	\N	f	3	10
29	Cerveza con especias casera	https://www.recetasgratis.net/receta-de-cerveza-limena-con-leche-condensada-41261.html	28.57	Acompaniamiento	t	Bebida	t	\N	9	4
23	Coctel de ron con maracuyÃ¡	https://www.recetasgratis.net/receta-de-coctel-de-ron-con-maracuya-47953.html	45.14	Acompaniamiento	t	Bebida	f	\N	6	6
13	Costillas de cerdo agridulce	https://www.recetasgratis.net/receta-de-costillas-de-cerdo-agridulce-52487.html	95.95	Plato principal	t	Platillo	\N	f	1	11
50	Martini de chocolate con Baileys	https://www.recetasgratis.net/receta-de-martini-de-chocolate-con-baileys-59858.html	33.61	Acompaniamiento	t	Bebida	t	\N	9	13
45	Batido de vainilla y pera	https://www.recetasgratis.net/receta-de-batido-de-vainilla-y-pera-59489.html	31.86	Acompaniamiento	t	Bebida	f	\N	7	9
25	Batido de chocolate	https://www.recetasgratis.net/receta-de-batido-de-chocolate-47765.html	26.83	Acompaniamiento	t	Bebida	f	\N	7	9
18	Lomo al vino blanco	https://www.recetasgratis.net/receta-de-lomo-al-vino-blanco-52326.html	108.79	Plato principal	t	Platillo	\N	f	1	12
21	Hamburguesa especial con pure de patatas	https://www.recetasgratis.net/receta-de-hamburguesa-especial-con-pure-de-patatas-52247.html	23.19	Plato principal	t	Platillo	\N	f	1	19
3	Enchiladas potosinas	https://www.recetasgratis.net/receta-de-enchiladas-potosinas-73816.html	37.94	Plato principal	t	Platillo	\N	f	1	11
9	Muffins de vainilla uvas pasas y arÃ¡ndanos secos	https://www.recetasgratis.net/receta-de-muffins-de-vainilla-uvas-pasas-y-arandanos-secos-52209.html	41.97	Merienda	t	Platillo	\N	f	4	24
8	Galletas de Pascua con pepitas de colores	https://www.recetasgratis.net/receta-de-galletas-de-pascua-con-pepitas-de-colores-52210.html	52.47	Merienda	t	Platillo	\N	f	4	18
\.


--
-- TOC entry 3402 (class 0 OID 17391)
-- Dependencies: 210
-- Data for Name: telefono; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telefono (telefono, numero_empleado) FROM stdin;
5507248019	2
5535260228	5
5585747315	42
5559698234	19
5552730126	39
5584441114	40
5545964634	48
5533835040	16
5531943558	21
5592094783	7
5551948760	4
5557251426	1
5513332309	6
5541977325	17
5569704082	49
5516428899	43
5543561361	9
5536335987	11
5579576737	33
5505504664	44
5529631055	15
5588360855	28
5595399641	34
5573831966	30
5593427282	20
5569267886	10
5537968317	32
5513687908	8
5511380368	38
5504934673	23
5530169364	45
5551327564	47
5503738202	13
5530050651	25
5554734776	24
5528976340	50
5542761668	12
5515318214	18
5569725762	36
5529269082	27
5536083492	35
5519564861	14
5544420681	41
5589348295	37
5510413741	26
5528981919	31
5541669523	3
5563833672	46
5577391808	29
5588260416	22
5527804333	2
5545774913	5
5509521463	42
5537459129	19
5593572474	39
5591905681	40
5599541966	48
5564591520	16
5594664586	21
\.


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 217
-- Name: folio; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.folio', 80, true);


--
-- TOC entry 3222 (class 2606 OID 17390)
-- Name: empleado ak_rfc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT ak_rfc UNIQUE (rfc);


--
-- TOC entry 3234 (class 2606 OID 17440)
-- Name: categoria pk_categoria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT pk_categoria PRIMARY KEY (id_categoria);


--
-- TOC entry 3230 (class 2606 OID 17417)
-- Name: cliente pk_cliente; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (rfc);


--
-- TOC entry 3228 (class 2606 OID 17405)
-- Name: dependiente pk_dependiente; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dependiente
    ADD CONSTRAINT pk_dependiente PRIMARY KEY (curp);


--
-- TOC entry 3224 (class 2606 OID 17388)
-- Name: empleado pk_empleado; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT pk_empleado PRIMARY KEY (numero_empleado);


--
-- TOC entry 3239 (class 2606 OID 17459)
-- Name: incluye pk_incluye; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incluye
    ADD CONSTRAINT pk_incluye PRIMARY KEY (folio, id_producto);


--
-- TOC entry 3232 (class 2606 OID 17423)
-- Name: orden pk_orden; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT pk_orden PRIMARY KEY (folio);


--
-- TOC entry 3237 (class 2606 OID 17448)
-- Name: producto pk_producto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT pk_producto PRIMARY KEY (id_producto);


--
-- TOC entry 3226 (class 2606 OID 17395)
-- Name: telefono pk_telefono; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT pk_telefono PRIMARY KEY (telefono);


--
-- TOC entry 3235 (class 1259 OID 17470)
-- Name: ix_nombre_producto; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_nombre_producto ON public.producto USING btree (nombre);


--
-- TOC entry 3257 (class 2620 OID 17477)
-- Name: incluye cantidad_total_del_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER cantidad_total_del_trigger AFTER DELETE ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.cantidad_total_trigger();


--
-- TOC entry 3259 (class 2620 OID 17475)
-- Name: incluye cantidad_total_ins_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER cantidad_total_ins_trigger AFTER INSERT ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.cantidad_total_trigger();


--
-- TOC entry 3258 (class 2620 OID 17476)
-- Name: incluye cantidad_total_upd_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER cantidad_total_upd_trigger AFTER UPDATE ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.cantidad_total_trigger();


--
-- TOC entry 3250 (class 2620 OID 17487)
-- Name: incluye cantidad_vendida_del_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER cantidad_vendida_del_trigger AFTER DELETE ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.cantidad_vendida_trigger();


--
-- TOC entry 3252 (class 2620 OID 17485)
-- Name: incluye cantidad_vendida_ins_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER cantidad_vendida_ins_trigger AFTER INSERT ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.cantidad_vendida_trigger();


--
-- TOC entry 3251 (class 2620 OID 17486)
-- Name: incluye cantidad_vendida_upd_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER cantidad_vendida_upd_trigger AFTER UPDATE ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.cantidad_vendida_trigger();


--
-- TOC entry 3249 (class 2620 OID 17489)
-- Name: incluye disponibilidad_producto_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER disponibilidad_producto_trigger BEFORE INSERT OR UPDATE ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.disponibilidad_producto_trigger();


--
-- TOC entry 3247 (class 2620 OID 17473)
-- Name: empleado edad_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER edad_trigger BEFORE INSERT OR UPDATE ON public.empleado FOR EACH ROW EXECUTE FUNCTION public.edad_trigger();


--
-- TOC entry 3248 (class 2620 OID 17491)
-- Name: orden mesero_a_orden_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER mesero_a_orden_trigger BEFORE INSERT OR UPDATE ON public.orden FOR EACH ROW EXECUTE FUNCTION public.mesero_a_orden_trigger();


--
-- TOC entry 3253 (class 2620 OID 17483)
-- Name: incluye precio_total_del_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER precio_total_del_trigger AFTER DELETE ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.precio_total_trigger();


--
-- TOC entry 3255 (class 2620 OID 17481)
-- Name: incluye precio_total_ins_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER precio_total_ins_trigger AFTER INSERT ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.precio_total_trigger();


--
-- TOC entry 3256 (class 2620 OID 17479)
-- Name: incluye precio_total_por_producto_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER precio_total_por_producto_trigger BEFORE INSERT OR UPDATE ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.precio_total_por_producto_trigger();


--
-- TOC entry 3254 (class 2620 OID 17482)
-- Name: incluye precio_total_upd_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER precio_total_upd_trigger AFTER UPDATE ON public.incluye FOR EACH ROW EXECUTE FUNCTION public.precio_total_trigger();


--
-- TOC entry 3241 (class 2606 OID 17406)
-- Name: dependiente fk_dependiente_empleado; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dependiente
    ADD CONSTRAINT fk_dependiente_empleado FOREIGN KEY (numero_empleado) REFERENCES public.empleado(numero_empleado) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3245 (class 2606 OID 17460)
-- Name: incluye fk_incluye_orden; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incluye
    ADD CONSTRAINT fk_incluye_orden FOREIGN KEY (folio) REFERENCES public.orden(folio) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3246 (class 2606 OID 17465)
-- Name: incluye fk_incluye_producto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incluye
    ADD CONSTRAINT fk_incluye_producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3242 (class 2606 OID 17424)
-- Name: orden fk_orden_cliente; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT fk_orden_cliente FOREIGN KEY (rfc) REFERENCES public.cliente(rfc) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3243 (class 2606 OID 17429)
-- Name: orden fk_orden_empleado; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT fk_orden_empleado FOREIGN KEY (numero_empleado) REFERENCES public.empleado(numero_empleado) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3244 (class 2606 OID 17449)
-- Name: producto fk_producto_categoria; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3240 (class 2606 OID 17396)
-- Name: telefono fk_telefono_empleado; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT fk_telefono_empleado FOREIGN KEY (numero_empleado) REFERENCES public.empleado(numero_empleado) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2022-05-27 20:42:04

--
-- PostgreSQL database dump complete
--

