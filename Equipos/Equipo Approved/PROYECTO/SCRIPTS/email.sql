-- Table: public.email

-- DROP TABLE public.email;

CREATE TABLE public.email
(
    razon_cliente character varying(13) COLLATE pg_catalog."default" NOT NULL,
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT email_pk PRIMARY KEY (razon_cliente, email),
    CONSTRAINT cliente_fk FOREIGN KEY (razon_cliente)
        REFERENCES public.cliente (razon_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE public.email
    OWNER to papeleria;