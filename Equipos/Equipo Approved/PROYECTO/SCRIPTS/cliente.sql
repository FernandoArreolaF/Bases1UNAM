-- Table: public.cliente

-- DROP TABLE public.cliente;

CREATE TABLE public.cliente
(
    razon_cliente character varying(13) COLLATE pg_catalog."default" NOT NULL,
    apellido_p character varying(40) COLLATE pg_catalog."default" NOT NULL,
    apellido_m character varying(40) COLLATE pg_catalog."default",
    nombre_pila character varying(60) COLLATE pg_catalog."default" NOT NULL,
    colonia character varying(40) COLLATE pg_catalog."default" NOT NULL,
    estado character varying(40) COLLATE pg_catalog."default" NOT NULL,
    calle character varying(40) COLLATE pg_catalog."default" NOT NULL,
    cp character varying(5) COLLATE pg_catalog."default" NOT NULL,
    numero integer,
    CONSTRAINT razon_cliente_pk PRIMARY KEY (razon_cliente),
    CONSTRAINT cliente_numero_check CHECK (numero > 0)
)

TABLESPACE pg_default;

ALTER TABLE public.cliente
    OWNER to papeleria;