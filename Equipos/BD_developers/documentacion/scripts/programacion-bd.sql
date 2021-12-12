--@Autor: 	Juan Pablo Sanchez, Jorge Luis Pastenes, Carolina Rodriguez
--@Fecha:
--@Descripcion: Cada que hay una venta decrementa el stock
CREATE OR REPLACE FUNCTION stock_actual() RETURN TRIGGER AS $stock_actual$
	DECLARE stock_triggr integer; aux integer; act_utilidad integer;
	BEGIN
		stock_triggr=(SELECT stock FROM articulo WHERE id_articulo = new.id_articulo);
		IF(stock_triggr > 0) THEN
			IF (new.cantidad_articulo<=stock_triggr) THEN
			aux=(SELECT stock FROM articulo WHERE id_articulo = new.id_articulo) - new_cantidad_articulo;
			UPDATE articulo SET stock=aux WHERE id_articulo = new.id_artidulo;
			act_utilidad =((SELECT precio_venta FROM articulo WHERE id_articulo = new.id_articulo)-
						  (SELECT costo_compra FROM articulo WHERE id_articulo=new.id_articulo))*new.catidad_articulo+
						  (SELECT utilidad FROM articulo WHERE id_articulo=new.id_articulo);
                          UPDATE articulo SET utilidad=act_utilidad WHERE id_articulo=new.id_articulo;
                          stock_triggr=(SELECT stock FROM articulo WHERE id_artidulo = new.id_artidulo);
                          IF stock_triggr <= 3 THEN 
                                RAISE NOTICE 'Quedan % del articulo con id: %', stock_triggr,new.id_articulo;
                          END IF;
            ELSE
                RAISE NOTICE 'Transaccion cancelada, no hay sufienciente stock del articulo con id: %', new.id_articulo;
            END IF;
        ELSE
            RAISE NOTICE 'Transaccion cancelada, no hay stock del articulo con id: %', new.id_articulo;
            RETURN NULL;
        END IF;
        RETURN new;
    END $$ LANGUAGE plpgsql;

CREATE TRIGGER stock_actual
BEFORE INSERT ON participa
    FOR EACH ROW EXECUTE FUNCTION stock_actual();


----------------------------------------------------------------------------------------------------------------------------------
--@Autor: 	Carolina Rodriguez, Juan Pablo Sanchez, Jorge Luis Pastenes
--@Fecha:
--@Descripcion: Creacion de un indice

CREATE INDEX articulo_descripcion_idx ON articulo USING btree (descripcion);

----------------------------------------------------------------------------------------------------------------------------------
--@Autor: 	Jorge Luis Pastenes
--@Fecha:
--@Descripcion: Muestra la factura

CREATE OR REPLACE FUNCTION imprimir_factura(rfc_cliente varchar(13), num_venta varchar(8))
RETURNS 
TABLE (
	num_venta character varying,
	fecha_venta date,
	monto_total numeric,
	nombre character varying,
	ap_paterno character varying,
	rfc character varying,
	calle character varying,
	numero integer,
	colonia character varying,
	codigo_postal integer)
AS $$
	BEGIN
	RETURN QUERY
	SELECT client.nombre_pila, client.ap_paterno, client.rfc, client.calle, client.numero, client.colonia, client.codigo_postal, 
	vent.num_venta, vent.monto_total, vent.fecha_venta
	FROM cliente client
		INNER JOIN venta vent ON client.rfc=vent.rfc
	WHERE client.rfc=rfc_cliente AND vent.num_venta=num_venta;
END;
$$ LANGUAGE plpgsql;

----------------------------------------------------------------------------------------------------------------------------------
--@Autor: 	Jorge Luis Pastenes
--@Fecha:
--@Descripcion: Consulta de utilidad dada una fecha

CREATE OR REPLACE FUNCTION corte_caja(fecha date) 
RETURNS decimal AS $ingresos$
DECLARE ingresos decimal = (SELECT SUM(monto_total) FROM venta WHERE fecha = fecha_venta);
BEGIN
	RETURN ingresos;
END;
$ingresos$ LANGUAGE plpgsql;

----------------------------------------------------------------------------------------------------------------------------------
--@Autor: 	Jorge Luis Pastenes
--@Fecha:
--@Descripcion: Consulta de utilidad por medio de codigo de barras

CREATE FUNCTION consulta_utilidad(codigo_barras character varying(13)) 
RETURNS decimal AS $consulta_utilidad$
DECLARE carga_utilidad decimal = (SELECT utilidad FROM articulo WHERE cod_barras = codigo_barras);
BEGIN
	RETURN carga_utilidad;
END;
$consulta_utilidad$ LANGUAGE plpgsql;
