CREATE SEQUENCE num_venta_sec 
INCREMENT 1
MINVALUE 00001
START 00001;

-- funcion de mensajes y triggers para insertar

CREATE OR REPLACE FUNCTION mensaje_insert_proveedor()
  RETURNS trigger AS
$BODY$
BEGIN
    RAISE NOTICE 'Se ha insertado datos en la tabla proveedor';
    RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql;

CREATE TRIGGER AVISO_PROVEEDORES_INSERT
AFTER INSERT ON proveedor 
FOR EACH ROW EXECUTE PROCEDURE
mensaje_insert_proveedor();

CREATE OR REPLACE FUNCTION mensaje_insert_telefono()
  RETURNS trigger AS
$BODY$
BEGIN
    RAISE NOTICE 'Se ha insertado datos en la tabla telefono';
    RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql;