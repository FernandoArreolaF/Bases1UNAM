PGDMP  '    	                }            DBMB    17.3    17.3 F    '           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            (           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            )           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            *           1262    16519    DBMB    DATABASE     l   CREATE DATABASE "DBMB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-MX';
    DROP DATABASE "DBMB";
                     postgres    false            �            1255    16778    actualizar_stock()    FUNCTION     <  CREATE FUNCTION public.actualizar_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Restar la cantidad vendida del stock del artículo
    UPDATE articulo
    SET stock = stock - NEW.cantidad
    WHERE codigo_barras = NEW.codigo_barras;

    -- Continuar con la operación
    RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.actualizar_stock();
       public               postgres    false            �            1255    16779    actualizar_totales_venta()    FUNCTION     �  CREATE FUNCTION public.actualizar_totales_venta() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualiza el total y la cantidad de artículos en la tabla venta
    UPDATE venta
    SET 
        monto_total = COALESCE((SELECT SUM(subtotal) FROM ticket WHERE folio_venta = NEW.folio_venta), 0),
        cantidad_total_articulos = COALESCE((SELECT SUM(cantidad) FROM ticket WHERE folio_venta = NEW.folio_venta), 0)
    WHERE folio_venta = NEW.folio_venta;

    RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.actualizar_totales_venta();
       public               postgres    false            �            1255    16773    reporteingresos(integer)    FUNCTION     T  CREATE FUNCTION public.reporteingresos(anio integer) RETURNS TABLE(sucursal character varying, enero numeric, febrero numeric, marzo numeric, abril numeric, mayo numeric, junio numeric, julio numeric, agosto numeric, septiembre numeric, octubre numeric, noviembre numeric, diciembre numeric, total_anual numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.nom_sucursal AS sucursal,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 1 THEN v.monto_total ELSE 0 END) AS enero,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 2 THEN v.monto_total ELSE 0 END) AS febrero,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 3 THEN v.monto_total ELSE 0 END) AS marzo,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 4 THEN v.monto_total ELSE 0 END) AS abril,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 5 THEN v.monto_total ELSE 0 END) AS mayo,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 6 THEN v.monto_total ELSE 0 END) AS junio,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 7 THEN v.monto_total ELSE 0 END) AS julio,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 8 THEN v.monto_total ELSE 0 END) AS agosto,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 9 THEN v.monto_total ELSE 0 END) AS septiembre,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 10 THEN v.monto_total ELSE 0 END) AS octubre,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 11 THEN v.monto_total ELSE 0 END) AS noviembre,
        SUM(CASE WHEN EXTRACT(MONTH FROM v.fecha_venta) = 12 THEN v.monto_total ELSE 0 END) AS diciembre,
        SUM(v.monto_total) AS total_anual
    FROM sucursal s
    LEFT JOIN venta v ON s.id_sucursal = v.id_sucrusal AND EXTRACT(YEAR FROM v.fecha_venta) = anio
    GROUP BY s.nom_sucursal
    ORDER BY total_anual DESC;
END;
$$;
 4   DROP FUNCTION public.reporteingresos(anio integer);
       public               postgres    false            �            1255    16785    reporteinventario()    FUNCTION     �  CREATE FUNCTION public.reporteinventario() RETURNS TABLE(codigo_barras bigint, nom_articulo character varying, nom_categoria character varying, stock integer, estado_stock text, reporteventas bigint, restock text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.codigo_barras,
        a.nom_articulo,
        c.nom_categoria,
        a.stock,
        
        CASE 
            WHEN a.stock = 0 THEN 'AGOTADO'
            WHEN a.stock < 3 THEN 'BAJO'
            WHEN a.stock < 10 THEN 'MEDIO'
            ELSE 'NORMAL'
        END AS estado_stock,
        
        (
            SELECT COALESCE(SUM(t.cantidad), 0)
            FROM ticket t
            JOIN venta v ON t.folio_venta = v.folio_venta
            WHERE t.codigo_barras = a.codigo_barras
              AND v.fecha_venta >= CURRENT_DATE - INTERVAL '30 days'
        ) AS reporteVentas,
        
        CASE 
            WHEN a.stock = 0 THEN 'RESTOCK URGENTE'
            WHEN a.stock < 3 THEN 'PROXIMO RESTOCK'
            WHEN a.stock < 10 THEN 'REVISAR STOCK'
            ELSE 'STOCK DISPONIBLE'
        END AS restock

    FROM articulo a
    JOIN categoria c ON a.id_categoria = c.id_categoria
    ORDER BY a.stock ASC;
END;
$$;
 *   DROP FUNCTION public.reporteinventario();
       public               postgres    false            �            1255    16777    validar_stock_articulo()    FUNCTION     )  CREATE FUNCTION public.validar_stock_articulo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    disponibilidad INTEGER;
BEGIN
    -- Buscar cuántos artículos hay disponibles
    SELECT stock INTO disponibilidad
    FROM articulo
    WHERE codigo_barras = NEW.codigo_barras;

    -- Si no hay suficientes, mostrar un error
    IF disponibilidad < NEW.cantidad THEN
        RAISE EXCEPTION 'No hay suficiente stock. Solo hay % unidades disponibles.', disponibilidad;
    END IF;

    -- Si todo está bien, continuar
    RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.validar_stock_articulo();
       public               postgres    false            �            1255    16775    validar_sucursal_empleados()    FUNCTION     �  CREATE FUNCTION public.validar_sucursal_empleados() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sucursal_vendedor INTEGER;
    sucursal_cajero INTEGER;
BEGIN
    -- Buscar la sucursal del vendedor
    SELECT id_sucursal INTO sucursal_vendedor
    FROM empleado
    WHERE num_empleado = NEW.id_vendedor;
    
    -- Buscar la sucursal del cajero
    SELECT id_sucursal INTO sucursal_cajero
    FROM empleado
    WHERE num_empleado = NEW.id_cajero;
    
    -- Comparar sucursales
    IF sucursal_vendedor <> sucursal_cajero THEN
        RAISE EXCEPTION 'El vendedor y cajero deben pertenecer a la misma sucursal';
    END IF;
    
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.validar_sucursal_empleados();
       public               postgres    false            �            1255    16819 S   venta(character varying, character varying, character varying, bigint[], integer[])    FUNCTION       CREATE FUNCTION public.venta(p_vendedor_id character varying, p_cajero_id character varying, p_cliente_rfc character varying DEFAULT NULL::character varying, p_articulos_codigos bigint[] DEFAULT NULL::bigint[], p_articulos_cantidades integer[] DEFAULT NULL::integer[]) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_folio_venta VARCHAR(10);
    v_sucursal_id INTEGER;
    v_monto_total NUMERIC(10,2) := 0;
    v_cantidad_total INTEGER := 0;
    v_precio_articulo NUMERIC(10,2);
    v_stock_actual INTEGER;
    i INTEGER;
BEGIN
    -- Validación de empleados
    IF NOT EXISTS (SELECT 1 FROM empleado WHERE num_empleado = p_vendedor_id) THEN
        RAISE EXCEPTION 'Vendedor no encontrado';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM empleado WHERE num_empleado = p_cajero_id) THEN
        RAISE EXCEPTION 'Cajero no encontrado';
    END IF;

    -- Obtener sucursal (debe ser la misma para ambos)
    SELECT e1.id_sucursal INTO v_sucursal_id
    FROM empleado e1
    JOIN empleado e2 ON e1.id_sucursal = e2.id_sucursal
    WHERE e1.num_empleado = p_vendedor_id AND e2.num_empleado = p_cajero_id;
    
    IF v_sucursal_id IS NULL THEN
        RAISE EXCEPTION 'Vendedor y cajero deben pertenecer a la misma sucursal';
    END IF;

    -- Validar cliente si se proporcionó
    IF p_cliente_rfc IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cliente WHERE rfc_cliente = p_cliente_rfc) THEN
        RAISE EXCEPTION 'Cliente no registrado';
    END IF;

    -- Procesar artículos si se proporcionaron
    IF p_articulos_codigos IS NOT NULL THEN
        -- Validar coincidencia de arrays
        IF array_length(p_articulos_codigos, 1) != array_length(p_articulos_cantidades, 1) THEN
            RAISE EXCEPTION 'La cantidad de códigos y cantidades no coincide';
        END IF;

        -- Procesar cada artículo
        FOR i IN 1..array_length(p_articulos_codigos, 1) LOOP
            -- Obtener precio y stock del artículo
            SELECT precio_venta, stock INTO v_precio_articulo, v_stock_actual
            FROM articulo
            WHERE codigo_barras = p_articulos_codigos[i];
            
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Artículo con código % no encontrado', p_articulos_codigos[i];
            END IF;
            
            -- Verificar stock suficiente
            IF v_stock_actual < p_articulos_cantidades[i] THEN
                RAISE EXCEPTION 'Stock insuficiente para el artículo % (disponible: %, solicitado: %)', 
                                p_articulos_codigos[i], v_stock_actual, p_articulos_cantidades[i];
            END IF;
            
            -- Acumular totales
            v_monto_total := v_monto_total + (p_articulos_cantidades[i] * v_precio_articulo);
            v_cantidad_total := v_cantidad_total + p_articulos_cantidades[i];
        END LOOP;
    END IF;

    -- Registrar la venta (corregido id_sucrusal con "r")
    INSERT INTO venta (
        monto_total,
        cantidad_total_articulos,
        id_vendedor,
        id_cajero,
        id_sucrusal,  -- Nota: Nombre correcto con "r" según tu tabla
        rfc_cliente
    ) VALUES (
        v_monto_total,
        v_cantidad_total,
        p_vendedor_id,
        p_cajero_id,
        v_sucursal_id,
        p_cliente_rfc
    ) RETURNING folio_venta INTO v_folio_venta;

    -- Registrar detalles del ticket y actualizar stock
    IF p_articulos_codigos IS NOT NULL THEN
        FOR i IN 1..array_length(p_articulos_codigos, 1) LOOP
            -- Obtener precio nuevamente para consistencia
            SELECT precio_venta INTO v_precio_articulo
            FROM articulo
            WHERE codigo_barras = p_articulos_codigos[i];
            
            -- Registrar en ticket (el subtotal se calcula automáticamente)
            INSERT INTO ticket (
                folio_venta,
                codigo_barras,
                cantidad,
                precio_unitario
            ) VALUES (
                v_folio_venta,
                p_articulos_codigos[i],
                p_articulos_cantidades[i],
                v_precio_articulo
            );
            
            -- Actualizar stock
            UPDATE articulo
            SET stock = stock - p_articulos_cantidades[i]
            WHERE codigo_barras = p_articulos_codigos[i];
        END LOOP;
    END IF;

    RETURN v_folio_venta;
END;
$$;
 �   DROP FUNCTION public.venta(p_vendedor_id character varying, p_cajero_id character varying, p_cliente_rfc character varying, p_articulos_codigos bigint[], p_articulos_cantidades integer[]);
       public               postgres    false            �            1259    16707    articulo    TABLE       CREATE TABLE public.articulo (
    codigo_barras bigint NOT NULL,
    nom_articulo character varying(100) NOT NULL,
    precio_venta numeric(10,2) NOT NULL,
    precio_compra numeric(10,2) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    fotografia bytea,
    id_categoria integer
);
    DROP TABLE public.articulo;
       public         heap r       postgres    false            �            1259    16521 	   categoria    TABLE     �   CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nom_categoria character varying(100) NOT NULL,
    descripcion text
);
    DROP TABLE public.categoria;
       public         heap r       postgres    false            �            1259    16520    categoria_id_categoria_seq    SEQUENCE     �   CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.categoria_id_categoria_seq;
       public               postgres    false    218            +           0    0    categoria_id_categoria_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;
          public               postgres    false    217            �            1259    16584    cliente    TABLE     �  CREATE TABLE public.cliente (
    rfc_cliente character varying(13) NOT NULL,
    nombre_pila character varying(50) NOT NULL,
    apellido_paterno character varying(50) NOT NULL,
    apellido_materno character varying(50),
    razon_socialc character varying(150) GENERATED ALWAYS AS ((((((nombre_pila)::text || ' '::text) || (apellido_paterno)::text) || ' '::text) || (COALESCE(apellido_materno, ''::character varying))::text)) STORED,
    estado character varying(50) NOT NULL,
    codigo_postal character varying(5) NOT NULL,
    colonia character varying(100) NOT NULL,
    calle character varying(100) NOT NULL,
    numero character varying(10) NOT NULL,
    email character varying(100),
    telefono character varying(15)
);
    DROP TABLE public.cliente;
       public         heap r       postgres    false            �            1259    16592    empleado    TABLE       CREATE TABLE public.empleado (
    num_empleado character varying(10) NOT NULL,
    rfc_empleado character varying(13) NOT NULL,
    curp_empleado character varying(18) NOT NULL,
    nombre_pila character varying(50) NOT NULL,
    apellido_paterno character varying(50) NOT NULL,
    apellido_materno character varying(50),
    telefono character varying(15) NOT NULL,
    estado character varying(50) NOT NULL,
    codigo_postal character varying(5) NOT NULL,
    colonia character varying(100) NOT NULL,
    calle character varying(100) NOT NULL,
    numero character varying(10) NOT NULL,
    email character varying(100),
    fecha_ingreso date NOT NULL,
    tipo_empleado character varying(20) NOT NULL,
    id_sucursal integer NOT NULL,
    id_supervisor character varying(10),
    CONSTRAINT empleado_tipo_empleado_check CHECK (((tipo_empleado)::text = ANY ((ARRAY['cajero'::character varying, 'vendedor'::character varying, 'administrativo'::character varying, 'seguridad'::character varying, 'limpieza'::character varying])::text[])))
);
    DROP TABLE public.empleado;
       public         heap r       postgres    false            �            1259    16721 	   productos    TABLE     �   CREATE TABLE public.productos (
    codigo_barras bigint NOT NULL,
    rfc_prov character varying(13) NOT NULL,
    finicio_surtido date NOT NULL
);
    DROP TABLE public.productos;
       public         heap r       postgres    false            �            1259    16542 	   proveedor    TABLE     �  CREATE TABLE public.proveedor (
    rfc_prov character varying(13) NOT NULL,
    razon_social character varying(100) NOT NULL,
    estado character varying(50) NOT NULL,
    codigo_postal character varying(5) NOT NULL,
    colonia character varying(100) NOT NULL,
    calle character varying(100) NOT NULL,
    numero character varying(10) NOT NULL,
    telefono character varying(15) NOT NULL,
    clabe_prov character varying(20) NOT NULL
);
    DROP TABLE public.proveedor;
       public         heap r       postgres    false            �            1259    16578    sucursal    TABLE     �  CREATE TABLE public.sucursal (
    id_sucursal integer NOT NULL,
    nom_sucursal character varying(100),
    estado character varying(50) NOT NULL,
    codigo_postal character varying(5) NOT NULL,
    colonia character varying(100) NOT NULL,
    calle character varying(100) NOT NULL,
    numero character varying(10) NOT NULL,
    tel_sucursal character varying(15) NOT NULL,
    "año_fundacion" integer NOT NULL
);
    DROP TABLE public.sucursal;
       public         heap r       postgres    false            �            1259    16577    sucursal_id_sucursal_seq    SEQUENCE     �   CREATE SEQUENCE public.sucursal_id_sucursal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.sucursal_id_sucursal_seq;
       public               postgres    false    221            ,           0    0    sucursal_id_sucursal_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.sucursal_id_sucursal_seq OWNED BY public.sucursal.id_sucursal;
          public               postgres    false    220            �            1259    16742    ticket    TABLE       CREATE TABLE public.ticket (
    folio_venta character varying(10) NOT NULL,
    codigo_barras bigint NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) GENERATED ALWAYS AS (((cantidad)::numeric * precio_unitario)) STORED
);
    DROP TABLE public.ticket;
       public         heap r       postgres    false            �            1259    16620    venta_folio_seq    SEQUENCE     x   CREATE SEQUENCE public.venta_folio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.venta_folio_seq;
       public               postgres    false            �            1259    16621    venta    TABLE     �  CREATE TABLE public.venta (
    folio_venta character varying(10) DEFAULT ('MBL-'::text || lpad((nextval('public.venta_folio_seq'::regclass))::text, 3, '0'::text)) NOT NULL,
    fecha_venta timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    monto_total numeric(10,2) NOT NULL,
    cantidad_total_articulos integer NOT NULL,
    id_vendedor character varying(10) NOT NULL,
    id_cajero character varying(10) NOT NULL,
    id_sucrusal integer,
    rfc_cliente character varying(13)
);
    DROP TABLE public.venta;
       public         heap r       postgres    false    224            �            1259    16811    vw_organigrama    VIEW     �  CREATE VIEW public.vw_organigrama AS
 SELECT e.num_empleado,
    (((e.nombre_pila)::text || ' '::text) || (e.apellido_paterno)::text) AS nombre,
    e.tipo_empleado,
    e.id_supervisor,
    (((s.nombre_pila)::text || ' '::text) || (s.apellido_paterno)::text) AS nombre_supervisor
   FROM (public.empleado e
     LEFT JOIN public.empleado s ON (((e.id_supervisor)::text = (s.num_empleado)::text)))
  ORDER BY e.id_supervisor NULLS FIRST, e.num_empleado;
 !   DROP VIEW public.vw_organigrama;
       public       v       postgres    false    223    223    223    223    223            �            1259    16762    vw_stock_art    VIEW     �  CREATE VIEW public.vw_stock_art AS
 SELECT codigo_barras,
    nom_articulo,
    precio_venta,
    precio_compra,
        CASE
            WHEN (stock = 0) THEN 'No disponible'::text
            WHEN (stock < 3) THEN 'Baja disponibilidad'::text
            ELSE 'Disponible'::text
        END AS disponibilidad,
    stock,
    id_categoria
   FROM public.articulo
  WHERE ((stock < 3) OR (stock = 0))
  ORDER BY stock;
    DROP VIEW public.vw_stock_art;
       public       v       postgres    false    226    226    226    226    226    226            �            1259    16766    vw_ticket_venta    VIEW     �  CREATE VIEW public.vw_ticket_venta AS
 SELECT v.folio_venta,
    v.fecha_venta,
    a.nom_articulo,
    t.cantidad,
    t.precio_unitario,
    t.subtotal,
    v.monto_total,
    concat(emp_vende.nombre_pila, ' ', emp_vende.apellido_paterno) AS vendedor,
    concat(emp_cobra.nombre_pila, ' ', emp_cobra.apellido_paterno) AS cajero,
    s.nom_sucursal,
    COALESCE(c.razon_socialc, 'Cliente no registrado'::character varying) AS cliente
   FROM ((((((public.venta v
     JOIN public.ticket t ON (((v.folio_venta)::text = (t.folio_venta)::text)))
     JOIN public.articulo a ON ((t.codigo_barras = a.codigo_barras)))
     JOIN public.empleado emp_vende ON (((v.id_vendedor)::text = (emp_vende.num_empleado)::text)))
     JOIN public.empleado emp_cobra ON (((v.id_cajero)::text = (emp_cobra.num_empleado)::text)))
     JOIN public.sucursal s ON ((v.id_sucrusal = s.id_sucursal)))
     LEFT JOIN public.cliente c ON (((v.rfc_cliente)::text = (c.rfc_cliente)::text)));
 "   DROP VIEW public.vw_ticket_venta;
       public       v       postgres    false    226    228    228    228    228    228    225    221    221    222    222    225    225    225    225    225    226    223    223    223    225            V           2604    16524    categoria id_categoria    DEFAULT     �   ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);
 E   ALTER TABLE public.categoria ALTER COLUMN id_categoria DROP DEFAULT;
       public               postgres    false    218    217    218            W           2604    16581    sucursal id_sucursal    DEFAULT     |   ALTER TABLE ONLY public.sucursal ALTER COLUMN id_sucursal SET DEFAULT nextval('public.sucursal_id_sucursal_seq'::regclass);
 C   ALTER TABLE public.sucursal ALTER COLUMN id_sucursal DROP DEFAULT;
       public               postgres    false    220    221    221            "          0    16707    articulo 
   TABLE DATA           }   COPY public.articulo (codigo_barras, nom_articulo, precio_venta, precio_compra, stock, fotografia, id_categoria) FROM stdin;
    public               postgres    false    226   Z�                 0    16521 	   categoria 
   TABLE DATA           M   COPY public.categoria (id_categoria, nom_categoria, descripcion) FROM stdin;
    public               postgres    false    218   ��                 0    16584    cliente 
   TABLE DATA           �   COPY public.cliente (rfc_cliente, nombre_pila, apellido_paterno, apellido_materno, estado, codigo_postal, colonia, calle, numero, email, telefono) FROM stdin;
    public               postgres    false    222   ~�                 0    16592    empleado 
   TABLE DATA           �   COPY public.empleado (num_empleado, rfc_empleado, curp_empleado, nombre_pila, apellido_paterno, apellido_materno, telefono, estado, codigo_postal, colonia, calle, numero, email, fecha_ingreso, tipo_empleado, id_sucursal, id_supervisor) FROM stdin;
    public               postgres    false    223   ��       #          0    16721 	   productos 
   TABLE DATA           M   COPY public.productos (codigo_barras, rfc_prov, finicio_surtido) FROM stdin;
    public               postgres    false    227   �                 0    16542 	   proveedor 
   TABLE DATA           �   COPY public.proveedor (rfc_prov, razon_social, estado, codigo_postal, colonia, calle, numero, telefono, clabe_prov) FROM stdin;
    public               postgres    false    219   ۬                 0    16578    sucursal 
   TABLE DATA           �   COPY public.sucursal (id_sucursal, nom_sucursal, estado, codigo_postal, colonia, calle, numero, tel_sucursal, "año_fundacion") FROM stdin;
    public               postgres    false    221   �       $          0    16742    ticket 
   TABLE DATA           W   COPY public.ticket (folio_venta, codigo_barras, cantidad, precio_unitario) FROM stdin;
    public               postgres    false    228   h�       !          0    16621    venta 
   TABLE DATA           �   COPY public.venta (folio_venta, fecha_venta, monto_total, cantidad_total_articulos, id_vendedor, id_cajero, id_sucrusal, rfc_cliente) FROM stdin;
    public               postgres    false    225   �       -           0    0    categoria_id_categoria_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);
          public               postgres    false    217            .           0    0    sucursal_id_sucursal_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.sucursal_id_sucursal_seq', 16, true);
          public               postgres    false    220            /           0    0    venta_folio_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.venta_folio_seq', 10, true);
          public               postgres    false    224            r           2606    16714    articulo articulo_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.articulo
    ADD CONSTRAINT articulo_pkey PRIMARY KEY (codigo_barras);
 @   ALTER TABLE ONLY public.articulo DROP CONSTRAINT articulo_pkey;
       public                 postgres    false    226            _           2606    16528    categoria categoria_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public                 postgres    false    218            e           2606    16591    cliente cliente_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (rfc_cliente);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public                 postgres    false    222            h           2606    16603 #   empleado empleado_curp_empleado_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_curp_empleado_key UNIQUE (curp_empleado);
 M   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_curp_empleado_key;
       public                 postgres    false    223            j           2606    16599    empleado empleado_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (num_empleado);
 @   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_pkey;
       public                 postgres    false    223            l           2606    16601 "   empleado empleado_rfc_empleado_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_rfc_empleado_key UNIQUE (rfc_empleado);
 L   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_rfc_empleado_key;
       public                 postgres    false    223            u           2606    16725    productos productos_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (codigo_barras, rfc_prov);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public                 postgres    false    227    227            a           2606    16546    proveedor proveedor_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (rfc_prov);
 B   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT proveedor_pkey;
       public                 postgres    false    219            c           2606    16583    sucursal sucursal_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (id_sucursal);
 @   ALTER TABLE ONLY public.sucursal DROP CONSTRAINT sucursal_pkey;
       public                 postgres    false    221            w           2606    16747    ticket ticket_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (folio_venta, codigo_barras);
 <   ALTER TABLE ONLY public.ticket DROP CONSTRAINT ticket_pkey;
       public                 postgres    false    228    228            p           2606    16627    venta venta_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (folio_venta);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public                 postgres    false    225            s           1259    16758    idx_articulo_nombre    INDEX     P   CREATE INDEX idx_articulo_nombre ON public.articulo USING btree (nom_articulo);
 '   DROP INDEX public.idx_articulo_nombre;
       public                 postgres    false    226            f           1259    16759    idx_cliente_rfc    INDEX     J   CREATE INDEX idx_cliente_rfc ON public.cliente USING btree (rfc_cliente);
 #   DROP INDEX public.idx_cliente_rfc;
       public                 postgres    false    222            m           1259    16760    idx_empleado_num    INDEX     M   CREATE INDEX idx_empleado_num ON public.empleado USING btree (num_empleado);
 $   DROP INDEX public.idx_empleado_num;
       public                 postgres    false    223            n           1259    16761    idx_venta_fecha    INDEX     H   CREATE INDEX idx_venta_fecha ON public.venta USING btree (fecha_venta);
 #   DROP INDEX public.idx_venta_fecha;
       public                 postgres    false    225            �           2620    16780    ticket tr_actualizar_totales    TRIGGER     �   CREATE TRIGGER tr_actualizar_totales AFTER INSERT OR DELETE OR UPDATE ON public.ticket FOR EACH ROW EXECUTE FUNCTION public.actualizar_totales_venta();
 5   DROP TRIGGER tr_actualizar_totales ON public.ticket;
       public               postgres    false    247    228            �           2620    16776 #   venta tr_validar_sucursal_empleados    TRIGGER     �   CREATE TRIGGER tr_validar_sucursal_empleados BEFORE INSERT OR UPDATE ON public.venta FOR EACH ROW EXECUTE FUNCTION public.validar_sucursal_empleados();
 <   DROP TRIGGER tr_validar_sucursal_empleados ON public.venta;
       public               postgres    false    244    225            ~           2606    16715 #   articulo articulo_id_categoria_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.articulo
    ADD CONSTRAINT articulo_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);
 M   ALTER TABLE ONLY public.articulo DROP CONSTRAINT articulo_id_categoria_fkey;
       public               postgres    false    226    218    4703            x           2606    16604 "   empleado empleado_id_sucursal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_id_sucursal_fkey FOREIGN KEY (id_sucursal) REFERENCES public.sucursal(id_sucursal);
 L   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_id_sucursal_fkey;
       public               postgres    false    221    223    4707            y           2606    16806 $   empleado empleado_id_supervisor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_id_supervisor_fkey FOREIGN KEY (id_supervisor) REFERENCES public.empleado(num_empleado) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_id_supervisor_fkey;
       public               postgres    false    4714    223    223                       2606    16726 &   productos productos_codigo_barras_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_codigo_barras_fkey FOREIGN KEY (codigo_barras) REFERENCES public.articulo(codigo_barras);
 P   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_codigo_barras_fkey;
       public               postgres    false    4722    227    226            �           2606    16731 !   productos productos_rfc_prov_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_rfc_prov_fkey FOREIGN KEY (rfc_prov) REFERENCES public.proveedor(rfc_prov);
 K   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_rfc_prov_fkey;
       public               postgres    false    4705    219    227            �           2606    16753     ticket ticket_codigo_barras_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_codigo_barras_fkey FOREIGN KEY (codigo_barras) REFERENCES public.articulo(codigo_barras);
 J   ALTER TABLE ONLY public.ticket DROP CONSTRAINT ticket_codigo_barras_fkey;
       public               postgres    false    4722    226    228            �           2606    16748    ticket ticket_folio_venta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_folio_venta_fkey FOREIGN KEY (folio_venta) REFERENCES public.venta(folio_venta);
 H   ALTER TABLE ONLY public.ticket DROP CONSTRAINT ticket_folio_venta_fkey;
       public               postgres    false    225    228    4720            z           2606    16633    venta venta_id_cajero_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_id_cajero_fkey FOREIGN KEY (id_cajero) REFERENCES public.empleado(num_empleado);
 D   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_id_cajero_fkey;
       public               postgres    false    4714    225    223            {           2606    16638    venta venta_id_sucrusal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_id_sucrusal_fkey FOREIGN KEY (id_sucrusal) REFERENCES public.sucursal(id_sucursal);
 F   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_id_sucrusal_fkey;
       public               postgres    false    221    4707    225            |           2606    16628    venta venta_id_vendedor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_id_vendedor_fkey FOREIGN KEY (id_vendedor) REFERENCES public.empleado(num_empleado);
 F   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_id_vendedor_fkey;
       public               postgres    false    225    223    4714            }           2606    16643    venta venta_rfc_cliente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_rfc_cliente_fkey FOREIGN KEY (rfc_cliente) REFERENCES public.cliente(rfc_cliente);
 F   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_rfc_cliente_fkey;
       public               postgres    false    222    4709    225            "   ;  x�uVM��6=som4EJ���E����S.�D;t(�%%w���r(r�U�CR����v��<��7�D!8�E�����iPm����*K_҃V�m���[ID�4�Ӣ ��G���a7�%ȋ�z=8�U{Վ�>:z���l�w��3κ�0�#0̊܎V��٣��E{�)/�O��HZ�k�#�
�4��t�$��T�jۍa�:<B_r�Ȃ#�Ê�� ��s9�k��;i��;�#���to�Jd�j�'r+{IS%;9�����X��%�비2A`BJNn]��`ը#��p=��A�>D)�k�
� ?���c:���ՠ F,8E5E�ì��ڹ�A�:�|�����ՠc��ri��sw"�o���kT �X�40eee��Lm� ݓ��d%� 1�eC��o>i>�����$L^�z�|��0[�[���lu�#�*���7#�����E�F�]z�����'� D	���@&�s�) �IǭqA�oi>��-�zj�U���ꓘ��,b�1VE^�������^[�K�	���}�if�v+0RM^�n4�����=]U?�.�ت@_��$�h��HNg�f�([n�����7���A�F`�rc5cUu�Z'(,%��������9��"k��A?�c^��1�^=(���@8��s۫�h��&y5�[[�RAq#�]Cg����X�+H�^C\��:�Y��آ��Ш�Tt�qKQ��3�d�� *�a� �Y�X�1>O-�	[g!!@M�9�좤Fn��>�,~�Af�נ����/d}!"Q��ʷc@z�ꍎ�TC�Z�^����VV�uQ�P��;(&���]���)�!z��Lc��Z�1Z���۫�`��𜉟��A�~Q��jU�� c'�b	�`���Hל�8=��Te�Bޫ6�F���GUT���K�M�����5��'�Q��JF^������*s�I������V/��Ƚ�F���,U,���a�-��E8�}�ڗ�:qG��V���t*,����E��qT��<'bn���OT`?�b>��8��x�G3��h�)F�i�S�DY^��)r8����fXW8:/��"-N���d��
*�9�z�qs�g��k	�j@��P�������� ,1��N8`$�\����+�c��	\.���Sj��#r%�+j�[0��J�<7@���N ^䬈/�Ҍ�@�W�h�\x���x�w��%$;5��F8R���˛���g'{�=n��C5-˛�I����x�����(������$�pXsZ_��Ra���-\A��5����؁��������Df�         �  x�mVˎ�6<k�B�x�vn��rX$���riQ=2')�1�ٿ٣>{�U?�j��Ѭ}$������u��想�d�m�m���K�V[eґm�n~Wm��8�_z}�}"�xm܁S��ȁ�&�m����%i�[[R���:�������ߩ��D���c�rv�|ď�6�%����v�g��Vij'���=����o7�Q�Ƚ�����JqnԹ�H#��3Ƒ"{]
�	�>�PyA�؃ʫ��V������R�����`/I����ݨ�W��QM���zNV��͋�󣎙��6q'[�c��t�g5?�x��T=P���(H	]��B+�k�S�����8��߻���I*��Ɍ-�����d����ݼl��i�[��Z��.Y� b@9?8�S�r5䉞:ڋ�A�@ �
@��k��|S��q���{V	��ѝ�W-y��(��5t����ݼjn�D��J.��*W��1xD���	�����d�=�޾���WE������ňr�iI{.el7�a�Bi�v�8Ҙn�z�V�\:�x���d#V��*�:����x���y_�b�1sh��œ���q~ +�C������Ȣ'ײ�SĒ����_��յ����Lqţ�=1b��!j%oV�˳3�����i�V�������M���`\��O��ק��дl���hz�#���?U�0���]�pJ�#e�z�uqȪ�~聧�?�]VЯ�n�5�OB7�}���d���Jf.n �����
���e�~�N�R�/�ARL%*JDS���#lO�/��ġ9ظ}&y�����gͭ�z�����;^\7��#�'�i(�A�%.+է��(� ���?r�������\]_771���%�N�Rr,L5��ս��5|С��y�P�,cW�~�f�_�#_nH�+ ɲ7�q���2&����ϛ�Y��DsS����9a��Ѩ�q�*�?O��I����o��(��%��:+=�|F2���Q�^4�/B����SlbV���W��~�h�/9�e�c�Qn?[e��P1(�X�ˠh�c�\�ln	��BR�� �.1���%�Ө�SB*,#S(��H���@1��U��w��y�("�qg}�T#�m1~� ��I.+&��>{
�^$��_�=@���U.(ͧs�,Ӵ��J���<h�s�
I_/qV�e�L����I�T��7�o4�on�}��=Ȳә%1��qU��B��}�	�֓}�䷘:}�,_����	#Ӻ�jaU�{�o##�0t?��b��?�*�%??(P�R��e�&EE�w�߸%��'��ri��ݎ�F��M��ے��=�?�6`CrW�$�h�#a�c�vz����`I 7<Ÿ�>k��0Bq�<�I�[}�{^+�(sp��;	�ҙ�b/ܑ����r������DB���r^�ɵC��S3���l�e'�Zn��?��f�?�m�;           x��W�R�H]��B_�I�,i7�c�_%��1�DNLҲ�NY�.v�),YԢ�v�Տ͹���F3SQP`��>�hz�ㄻ�=?=c�Z�l�<��,E�f��{����ވ�����y�S���e�7��Ǟ�x�N.:��owBN�w,C��ך��,����A��4_�s�L욯�'�Fl'�N��ӳV��,�������`��7�w�2��b�_�}<���Eq��Pԙމʾ���b��]vOh�;e~�z~R�t�f��P��,����� �}�=&J�������2�.yHm�j����}�D����"h_����{{(�Nv��j[�'�?�-��ӟky�x>��A;�^�?��C&AY�e6J|�p@�̴�z���h�kU��IX��b��/��:e�$���錝IS����2�E[V��&�T�BA@c���i��l�`6�+Q�Y0/����J�H���>B"���r��#���jU=/_VD���w�X g�w�ak�^dɀ'<Y]��J��v���+v.���]��,�܄�LV��}�_���uv�/ԟy��E�6���P��#��#�c�~}��G�8�oq��G��$0��Ϳ�o(��(��H�gy����5|�!�F�y
��\�s�d��NP�%��AkQ���P�y�lf4�Lk����N��ƱOh���V�W��8v��s������C|�i]M��n0�X�+��,�ar�v���l�ҽf~�z1�I,�1|��#I���}�C���u�(��$@h���O�G���
��ء�`�{U��� F[P�}&������N��ұ���yh�^R@+��e1M��吥ō��Ҁ�=&��@�~��1�D��~�u���� 0�=���Ͼ
�$I;�(���:M|�u�l�D�+�.�<��Z]#aɞ�ggÎ@��7����,�&�����\i�ٮ�l��3@t��X�7�]ܚ�ӓ$��ŋقM*q�ўղ�7=�r#(��Z�݄�"���>*؝�ƹ�`^������(KI���d�`cT�mm��xC��09� �B�hS�<�?����y߶u�)��H_ض�t�*���֍Fne�Y��_�V����Q��@��=�f�D��J�u�|eQ>c�܊�Ӷ gy�T{!����i���ͥu�!��t1�}zn:^CJ����;*{�<��
��ca�X\;
lE;^�n]��>W4��t �'�3-��y$ ���J
���z�Q�&Lg�)|���0-@>S�k�H���3�'�!�p�������I���w��81��ĸޫ��u�`��� >�n1�-0IGz�H`G�W�E���P�Po��J�-���& ��w�D�b�t4[�D�5�G>+t��姕�gr���������sR�ѦnO�/_��T��G�0`����d/bZgY���ܿe��`�r_|1��(�0o����%H���t�x�sQv9(:\o~�ơ#7ϸ=��Z�e]ac7$�KxJ�B���5������Zi��V{�3������a��,D���?�����Cq�l�yw�sQl����2�{�^����9�Y���,Fkh6��¤l��0E�fc]>�����w
F���b��Ț^B4C��߾4��O��I�TA9��&xx99佮z\�˭Oi6�w��K��(_��3��W����Ag�=�cbn�&Wpbۀ��L�_0�懕ou�C��h!�:�>�@�£Y�I#Z��بP�^K�/�?c<x1q���!���r�ѹy19���8y6���@~)u���BVN9�E�3��\�G`A�'d�aq���C���Gx�7��&4�0��Y�C��="k�K��5�u���Oo���1���s���Η�j03	R&�e�Ԥ,˪.��^0Ӣ8���'Gk�^M�x�#9�Vb��WPG�&�7�ڇ��QȪ#�s�`��h`]Lf��<�9��:�"��\Û|D���4F������evJ���֙]�#<�8��-~ym䖆�3�,a5�8�S-L�C�8�e�*O[         a  x��Y=s�H�ǿ�@>��݈�h� A���RmK\�6Ej!��U�Ё���6����7����iD�+K�PeW����C���=qhY���G�g�Q�m�C�ѫ�Y��8�Vy��D>I.EW��D	?~F��d�Q�V'n��_�&�LX�eY��y&��e����UN�뉫r={���m1���Z�
ےމ��)�og����,V��RH���E����i?�@Zb1D�F )zI?ė"�ǀ
�����E<�N���s$0Ԥ�ҡh���o�O��齐6�|�av;]L mp"�C�v�u�0�V9�3`O��y6H�J��ɥ�d�dНė5��s�X7�N���xU��?�YO����~���ެ����R��؀�}�ub�'�=��%~z{quB ��Ɓ\��8?e�.�ZMt��J���.ћ�N��c@���;W�҈ϋ��(W��=*?-7��'�C�n���A6}0*5�9b�q`��yB�
�:٥Y
�3�8�ħ��-#�S<��s��y���<QiK���m{��"�yV���� ���ˇbypb�'N�g��Pm� ��hv��t���@O�'q.�L��X�ȳ�4	ێ��m�q)y�Λ�-q��U��"�~���|s��(��ټh�����=�l����l�*���7�Я�{br��� ��h�rĜ� >wB�'yr|��P�Q�A��� k�1rB���L�Akw�a�T�k{�դ���rq5�/Q�8]��w���m�j���eSeJ!G�7�`w3q����%x��|�y�$&�]�>F�o��-�)�{xG|��Ä�N�EQ^/Q~L�p���[���,��wX���i�sJ���F�SMb�o�U�qum����H�A �~��;���M�8N �P0�WM���zZ� \�rŻw�z0EC�#���.�Y�Uh#�M0B��`:Й���A��ɀJ���/y�z����1��7���Y���r�ryC,�kL��w��a5��jPo�{�U�{:HW3��#f���x@J�
�@����EQ��C<.�FƔ2Q����йi˷�z���iYN��0���f﫛�vJ���r��#�L��H��g?���A�R!i��7 ͽ����qJ��	�z�q=����h��mI��'F���|y��$ύ��u�=��F����V�1�t �*j�1~���$-��iO*�?1ķn�*S��#��r5�i~}�˺����x��3��E�sK������_)])�>��F�OUO�%��Y��(P6C�$��5)�|6]��`�qDY���_[oѲ���2<P�EB���@pG�<��7�.t�v�k,lZ~){Z�l���_E�'dKW��M���o��e��D�n6�y����Hj��f���=nC�6�#y�s��,��8F���nd�XA�F�6���EN��I��#����x�N(}�]�o���Xn��o�~���ݓ��Cq�,�����SwC��>��c_���6K���aLi�fC�:���M�i#Itv�׫��nY�����L���z��f}���+���'��Y�I��>	v�<��h�E�W}c����@Ghc@�;P���d�G���Ax���3�4k�9ҋ���Z�a�.�G�QE�+���W��d�l2T�X�#�R+�ѹ���]�}1&?��#䨂��6��-�n�%�p����j��v�p����<�1�@`�P�]K/B���@t'�1���3Cv�����M��ٶO,I�b>���M��!�8�]�6d;���ī�l*����φ�j~�3) JF�G�,�#�}�U���!�gVQ(ѯ-�������5u��F��d$k9��Ã��MT�!B���Y�3 �
��(ðY��uT�:1��@�+�e#=`����a�\z��"ߔ^�<U�	�F�8�'�������jŕG5���+�A��#��r��w���\S��%8��wDGOu�d��l�F��G�?O�}�ix7�����ٲ���Ϋ�h���zā>U_*.��L��&;�� ~{t�;�:�����v'��S������w��C.��S�5BOꄶ�!�v77���塑��L;/xy��}�Z7@iKOrTmp �:b5��%n�RO��7c��->6{$I�OS���(X`l�H�SI`tTQ�HX��餩���J��y�Xo�>µ$]|,�=ܮ���ȑ��	!G�. T��i����\���p���^�1�Z�1T��
޴0^[�ȕ��y!G���>�<���d�{V��������V�t3��ݔ��HM��`A�P}���Q����$�f�3�ۡz�Ѭ�9�{���uY,���^������=���(8�vt E_|5ɩc�|���-���o�P���w����G�7�%���'8�h���9���`X�q� l>_l+	�G��c��aE\6��,�e�����qC<T�j'وj'�4mf��twwż��-~G�cۇ=���j	���բ�j����8K�)$���ߵ�Y������&#�4��ķ��@�y�N�AG�f��/x����H����.��w\ۻ�� ������X�*�q ;W����^����dڤ�w����(;(��Ԯ8`𘁃��fH1���mu��/��p���.���M竆X�ud����^��1ka�*��@��
HH�u�n��&_���EpQ�mݲjc ٌ�U�Z��Gs����k���ڷ7�~�0��x���&���%�cx@�����G󉐣���8^�q��B�&���v�X-kR�v�
�>�H_pY��G�����͈���R�����H͊�iH����v�em F�s+��hZrTm�q λP��ĥ��X�2|�ޡ>{�{���P�����UW����Ίl<���j���fuG`���n^�T��ut���ӳ�M2G�8��<�i���׀�x�g#��i
����z�|��}�<XJ��!��T'���b�����Y6��٘��
ݏ�-����}�"$u��9����z��f��s�Y�ǳ���jyxw�Z�#�#�J/�~[:���F�QE5L�v,:��.�E��֩�l��׳�XC���}���إ��1;G�8�~Jל��}��m����|�ܯ���,�>�H���s�1������t�T�'fPVs�l�?���	�y(}���9���@�b�?��nd2��^�󼾓Լ	�C[w?8xL��9���.�_OQZ���G��}��=xG�%��x�X�Q�1�z����L�ɞ��Uq7;�!��T��Wp�ZSF����8��I���T������b�Ǿ�fS�є_�L\����~~��ŋ�9V�I      #   �  x�m�Ir�@E���8��ǥ�@c
\�r�sD�c�D��|�_O_��� t��"�y!:�����GDn?Ԕ@�i���"v���ʧ�E��>�3`�E�V�w鞙A��,�-�Z]��BZ<a^������J�\G�Rv��0ߣ_�Ӟ��u��g�7�(��,�AÔ�qlIU"���"��	fQ�đݳ'�O�W���q��?��S��IC��^��üW��$7�;wu�tƲ�Ew�]=��u�x��T,��<u�i,/��+���aJ:�As�̨�ˏ��y͉��R�LU)Z�Is�dU
�8ek9㦻b-���1X˙tw�v���,NQ���Z�M|�[��5L���)O��gv������JfС�l�)n{9̬����'O�rF��r�M%o!H�V��oT�������B�         )  x�mWKv�8\������%HB�`@������rY̙|���O�1�b�����U����}#��3�l6{�f�fv^�Kԣ����ɸU�rWL�Aͮ�u�|��n&ǚ�s��:G�e<���T�Z�z�^Z���y�wV7xVȪnڮg����\4������B��$�r�z1q��ʚ��z�=�^��n��1!�HU�g\�5n�#�A�b�\��w3�	�����ɭA/��_�g��(�:�R/j��l���ؤ�եl�-hV�Rނ1�mQ3�ڦ���C_��Ar\oحX���g �3j��OP�1��ӧ�H����E^�}���׈$Jde�١|�$s��˦F�� �W�(�k8������Ꮉ��|�z�������|a�V}(T�=���E{3�{�c)�ƾ��Ki jCW!���AQ,n�+�k��!Z`ˏr)��R֨�\i�[Y[��a1�����[?A��vִ���ۀu��|I�LU�4CG�׼g8��:�'�#��O>~�A�F7)�������[F�d���#\K��wӴmm�w�����vހb�)�G�T�����LhΪ|�{���{���]�0�"|[�iٶ]W��5ǵ�pP������C�kp���y����)���	�jT�vC�$k�%�Q���ݩk9�]���߉Շ�J�>ٸ�UOs�
�X���l+�;HЇ�nG���R���í�)�C�LiP
 F��K��<����'�|�c	�ݭp>�W/ܺh��2s�\�!z�A�VR�IaUG�9(�/�Q�Yࣨ .�lh��FuU �(o�aI)~̕dwԌƙ,8�� Ոf~��B�֓u�f���Y�֜aT�d0��F{u��/���V���ŧz\����b�g$P:[h��L��ѥ��ª%�͊��eS>q��.���u@�!ZX�N(���B���f=�	�����,nL���*�l;�& ���L�7'Z��\�� 1V�I�7��0��z�B��Es�n�Wz�ރ>Y\M7���AC%S&�u�z��]Ew��5���ma�O=g��.0�?�/����b��:�U����m��G�fwE��D���Ɍ&�i��w�UX+� `�O�U�Ao�=J��uO�Z���rph4�,<����q�)��!z�o���VLok���f�אf�{�[	��u�����̈́,�7�O�A�g5�O!3�ƫc��.N��X��R���`�?���Wmz���O������|��ŦC��&ŝ�$�
kLP�冁n�P���^\@mة��>x����-+(�3	��;p�TpK ��������1�OjŎEN���;����j���-�?	 ���9�/�9pp����ﻎ��nI�
2X����
��/U!ȤN��2�J����i�&y�Ћ��We1���a7��^���YF�qU %Ew�,0bkw^��'6e�P3�N��`�I ـ ��X�z�w���&ފ-��O�E�:�6�.����B�q~�!�����m�m�\
�Xw�A�|$q!��Ʌ|�3�lj{H�BY�@��]������(�#`����	B��?V�4�H):.x2��l���LP9e�_�c�rA[~߾H፶�<�o���eW�0�aK��
e&k��ş��s��E���LG+{�C��{�ZM9�獓ꀉ��w�&Ot���0��'Vλ��]���)c�ej90n���J�qL��a20�d�@ȟ<8�uV�˓��~Z�+��9�1�1�Fq mݻ?c�Q�}�R�O������E�0�h'�SP�@���oB*�C��{Q��Oj>         D  x�mT�R�8\�_�/ ��^^�̐"��R�T6gl͍�������n>�%V�f�K˾a0��Y�>�O�$[SG��,m�Z�>x��t��L���-����t|�WD!�`�N����a���e9��\
!U�1Y�E��ԏ����������y���r���R�?���I��v��_%�z��ݯ��*����|Ma�g�S��2��6�a��A�t�YU�V����.�lAu4P��k
ĎɚY[8�6�O.�-n�T�Z
=1��Y�F�R�E�/�W��������/K�T��Bw:�Q�`zY�����o}o'�?��*�HJE�
L<J$ł�R�;��P�D�C���b|����ZHEn�jg,A�-5_�rl@�q(���!UR����纅UΠ��'ⰢPJ��o����k3>����F[���U���� ST,M��Ƈ�@�������?����Vup`���q=9biU	�OA*)U�J��^0�uc쎮�=KK�*6/ϸ+���QI���,˪β<��E"�kez��_�5O��=ox�c��	~k��]N�牔
����T�1u�"�kXR��W9��z�J9!�D.��&׌�9�C2~�o������﵅��R��6&���r�rv���LQ�Y��Ի�ַ�ch��թsn����'��Ȕ\&��\��C��X�� �q�����6ü�gO�³�\���u"�~2�����w�#�i���}vEn���2�qIv��0�3�a�R�0�GF"u��XZ��K�ث�sx�6Nw�01�1I7��BN'6�y@����_��4�g%��z
A�|>H��; �      $   �   x�u�91 ��%+._m����w�����q�?/DRT��(
�{_��~�"Ȏ́= Z�S���- ��/�=�kt//\�x�����<l�ε(HZΈ�MK?�GW6gM>c����v�n�~���q��l�����^]K���I����q��|9��߫����u�      !   U  x���Kn�0�5}�^`>D���I������-����r� �Q�+.|��X^�"#�������T��b��#JB�iy r/�M!hh����|Z|��J�l�d�5�v+w$zq`xLo�+
ʴ�:,�ZQ3%,n��߭�z<���_����lIU���LK/�^`��7GB��?_M���)�s��("��'c=���1l�s!�����E�\��]�yf֣Y�&�������q`�I%J�lޖ����+���RQ�v��{������p��q_'���W̪r"61�S2?J��x��0�ώ��\���ݬS��͖�fim*��e
&�xΏ�O��/�,��     