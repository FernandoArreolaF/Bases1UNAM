--Trigger para validar que en la VENTA los empleados (Vendedor y Cajero) pertenecen a la misma sucursal
CREATE OR REPLACE function emple_sucur() RETURNS TRIGGER AS $emple_sucur$
DECLARE suc1 integer;
DECLARE suc2 integer;

BEGIN
	SELECT DISTINCT s.id_sucursal INTO suc1 FROM VENTA as v1 
	LEFT JOIN EMPLEADO AS e ON new.id_empleado=e.id_empleado 
	LEFT JOIN SUCURSAL AS s ON s.id_sucursal=e.id_sucursal;

	SELECT DISTINCT s.id_sucursal INTO suc2 FROM VENTA as v2
	LEFT JOIN EMPLEADO AS e ON new.id_empleado1=e.id_empleado 
	LEFT JOIN SUCURSAL AS s ON s.id_sucursal=e.id_sucursal;

	IF 	(suc1!=suc2) THEN
		RAISE NOTICE 'Los empleados pertenecen a sucursales diferentes';
		RETURN NULL;
	END IF;
		RETURN NEW;
END;
$emple_sucur$ LANGUAGE PLPGSQL;


CREATE TRIGGER emple_sucur BEFORE INSERT OR UPDATE ON venta
FOR EACH ROW EXECUTE FUNCTION emple_sucur();


--Trigger para agregar por defecto el nombre completo en CLIENTE para razón social
CREATE OR REPLACE function razonS_Default() RETURNS TRIGGER AS $razonS_Default$
BEGIN
	IF 	(new.razon_social is NULL) THEN
		update cliente set razon_social=CONCAT(new.nombre,' ',new.apellido_paterno,' ',new.apellido_materno) WHERE rfc=new.rfc;
	END IF;
		RETURN NEW;
END;
$razonS_Default$ LANGUAGE PLPGSQL;


CREATE TRIGGER razonS_Default AFTER INSERT OR UPDATE ON cliente
FOR EACH ROW EXECUTE FUNCTION razonS_Default();


--Trigger para calcular el valor del monto por articulo en ES_VENDIDO
CREATE OR REPLACE function montoXArt() RETURNS TRIGGER AS $montoXArt$
DECLARE montoTot numeric(8,2);
DECLARE totalArti smallint;
DECLARE totalCosto numeric;

declare   folticket   varchar(32);
declare   artic       varchar(50);
declare   cantid      smallint;
declare   preci       numeric(8,2);
declare   totArt      smallint;
declare   montotal    numeric(8,2);
declare   fecha_t     date;

BEGIN

	SELECT precio_venta INTO montoTot FROM articulo AS ar WHERE ar.codigo_barras=new.codigo_barras;

	IF(montoTot IS NULL) THEN
		SELECT precio_venta INTO montoTot FROM low_stock AS lw WHERE lw.codigo_barras=new.codigo_barras;
	END IF;

	IF	(TG_OP='INSERT') THEN
		update es_vendido set monto=(montoTot*new.cantidad)  WHERE codigo_barras=new.codigo_barras AND folio=new.folio;

		--Parte que realiza el cálculo del monto total y de la cantidad total
		IF(new.finish) THEN
			SELECT SUM(cantidad) INTO totalArti FROM es_vendido GROUP BY folio HAVING folio=new.folio;
			SELECT SUM(monto) INTO totalCosto FROM es_vendido GROUP BY folio HAVING folio=new.folio;

			UPDATE venta SET monto_total=totalCosto, cantidad_total=totalArti WHERE folio=new.folio;
			--INICIA TICKET
			create temporary table ticket(
				folio_ticket      varchar(32)     primary key, --Folio unico
				articulo          varchar(50)     not null,
				cantidad_articulos          smallint        not null,
				precio            numeric(8,2)    not null,
				total_articulos   smallint        not null,
				monto_total       numeric(8,2)    not null,
				fecha             date            not null
			) on commit drop; --cuando termine la transacción, se elimina la tabla

			--Se consultan todos los datos necesarios para el ticket

			select a.nombre into artic from venta v 
				join es_vendido ev on(v.folio=ev.folio)
				join articulo a on(a.codigo_barras = ev.codigo_barras)
				where (v.folio = new.folio) and (a.codigo_barras = new.codigo_barras) 
					and (ev.folio = new.folio) and (ev.codigo_barras = new.codigo_barras)
				group by a.nombre, ev.cantidad, v.cantidad_total, v.monto_total,v.fecha;

			select ev.cantidad into cantid from venta v 
				join es_vendido ev on(v.folio=ev.folio)
				join articulo a on(a.codigo_barras = ev.codigo_barras)
				where (v.folio = new.folio) and (a.codigo_barras = new.codigo_barras) 
					and (ev.folio = new.folio) and (ev.codigo_barras = new.codigo_barras)
				group by a.nombre, ev.cantidad, v.cantidad_total, v.monto_total,v.fecha;

			select sum(ev.monto) into preci from venta v 
				join es_vendido ev on(v.folio=ev.folio)
				join articulo a on(a.codigo_barras = ev.codigo_barras)
				where (v.folio = new.folio) and (a.codigo_barras = new.codigo_barras) 
					and (ev.folio = new.folio) and (ev.codigo_barras = new.codigo_barras)
				group by a.nombre, ev.cantidad, v.cantidad_total, v.monto_total,v.fecha;

			select v.cantidad_total into totArt from venta v 
				join es_vendido ev on(v.folio=ev.folio)
				join articulo a on(a.codigo_barras = ev.codigo_barras)
				where (v.folio = new.folio) and (a.codigo_barras = new.codigo_barras) 
					and (ev.folio = new.folio) and (ev.codigo_barras = new.codigo_barras)
				group by a.nombre, ev.cantidad, v.cantidad_total, v.monto_total,v.fecha;
			
			select v.fecha into fecha_t from venta v 
				join es_vendido ev on(v.folio=ev.folio)
				join articulo a on(a.codigo_barras = ev.codigo_barras)
				where (v.folio = new.folio) and (a.codigo_barras = new.codigo_barras) 
					and (ev.folio = new.folio) and (ev.codigo_barras = new.codigo_barras)
				group by a.nombre, ev.cantidad, v.cantidad_total, v.monto_total,v.fecha;	

			select md5(random()::varchar(32)) into folticket; --Función que devuelve cifrados aleatorios de 32 caracteres

			--Se inserta el nuevo folio con las funciones md5() y random(), así como los valores consultados
			insert into ticket(folio_ticket, articulo, cantidad, precio, total_articulos, monto_total, fecha) 
			values(folticket, artic, cantid, preci, totArt, montotal, fecha_t);
			--Al final, sólo se tiene un registro en esta tabla.
			--FIN TICKET
		END IF;
	END IF;

	RETURN NEW;
END;
$montoXArt$ LANGUAGE PLPGSQL;


CREATE TRIGGER montoXArt AFTER INSERT OR UPDATE ON ES_VENDIDO
FOR EACH ROW EXECUTE FUNCTION montoXArt();

--Trigger para generar el formato del ID de la VENTA (MBL-XXX)
CREATE OR REPLACE FUNCTION venta_formato() RETURNS TRIGGER AS $$
DECLARE valAct smallint;
BEGIN
	valAct=CAST(new.folio AS smallint);
	IF(valAct<10) THEN
		UPDATE venta set folio=CONCAT('MBL-00',valAct) where folio=NEW.folio;
	ELSEIF(valAct<100) THEN
		UPDATE venta set folio=CONCAT('MBL-0',valAct) where folio=NEW.folio;
	ELSEIF(valAct<1000) THEN
		UPDATE venta set folio=CONCAT('MBL-',valAct) where folio=NEW.folio;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER venta_formato AFTER INSERT ON venta
FOR EACH ROW EXECUTE FUNCTION venta_formato();

--Secuencia para ser utilizada en el formato del ID de VENTA
CREATE SEQUENCE secue_folio_venta AS smallint
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999
	START 1
	NO CYCLE
	OWNED BY VENTA.folio;

CREATE TABLE public.low_stock(
	codigo_barras bigint NOT NULL,
	nombre varchar(50) NOT NULL,
	precio_compra numeric(8,2) NOT NULL,
	precio_venta numeric(8,2) NOT NULL,
	stock smallint NOT NULL,
	fotografia text NOT NULL,
	"id_categoria" integer NOT NULL,
	CONSTRAINT "LOW_STOCK_pk" PRIMARY KEY (codigo_barras)
);
CREATE TABLE public.low_stock_provee (
	"rfc" varchar(13) NOT NULL,
	"codigo_barras" bigint NOT NULL,
	fecha_comienzo date NOT NULL,
	CONSTRAINT "low_stock_provee_pk" PRIMARY KEY ("rfc","codigo_barras")
);

-- Trigger para crear una tabla auxiliar para productos con stock menor a 3
CREATE OR REPLACE FUNCTION eliminacion_2() RETURNS TRIGGER AS $$
DECLARE cantidad smallint;
	BEGIN
		SELECT COUNT(*) INTO cantidad FROM articulo where stock<3;
		IF(cantidad!=0) THEN

			INSERT INTO low_stock SELECT * FROM articulo AS ar WHERE ar.stock<3;
			INSERT INTO low_stock_provee SELECT pr.rfc,pr.codigo_barras,pr.fecha_comienzo FROM provee AS pr 
				LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock<3 ;

			DELETE FROM provee pr WHERE rfc=(select pr.rfc from provee pr LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock<3) 
				AND codigo_barras=(select pr.codigo_barras from provee pr LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock<3);
			DELETE FROM articulo WHERE stock<3;
			RAISE NOTICE 'El articulo ya no esta disponible';
		END IF;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminacion_2 AFTER INSERT OR UPDATE OR DELETE ON articulo FOR EACH ROW EXECUTE PROCEDURE eliminacion_2();


-- Tigger pare retornar productos desde tabla auxiliar a tabla de artículos para productos con stock mayor a 3
CREATE OR REPLACE FUNCTION agregacion_2() RETURNS TRIGGER AS $$
DECLARE amount smallint;
	BEGIN
		SELECT COUNT(*) INTO amount FROM low_stock where stock>3;
		IF(amount!=0) THEN
			INSERT INTO articulo SELECT * FROM low_stock AS lw WHERE lw.stock>3;
			INSERT INTO provee SELECT pr.rfc,pr.codigo_barras,pr.fecha_comienzo FROM low_stock_provee AS pr 
				LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock>3;

			DELETE FROM low_stock_provee pr WHERE rfc=(select pr.rfc from provee pr LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock>3)
				AND codigo_barras=(select pr.codigo_barras from provee pr LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock>3);
			DELETE FROM low_stock WHERE stock>3;
			RAISE NOTICE 'El articulo esta disponible';
		END IF;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER agregacion_2 AFTER INSERT OR UPDATE OR DELETE ON low_stock FOR EACH ROW EXECUTE PROCEDURE agregacion_2();


--Trigger que actualiza los valores en stock de los articulos
CREATE OR REPLACE function restador_stock() RETURNS TRIGGER AS $restador_stock$
DECLARE stockArt smallint;
BEGIN
	SELECT stock INTO stockArt FROM articulo where codigo_barras=new.codigo_barras;
	IF(stockArt<=new.cantidad) THEN
		RAISE NOTICE 'La cantidad de articulos en el carrito supera el stock disponible';
		RETURN NULL;
	END IF;

	UPDATE articulo SET stock=(stockArt-new.cantidad) where codigo_barras=new.codigo_barras;

	RETURN NEW;
END;
$restador_stock$ LANGUAGE PLPGSQL;

CREATE TRIGGER restador_stock BEFORE INSERT ON es_vendido
FOR EACH ROW EXECUTE FUNCTION restador_stock();


create or replace function formato_curp() returns trigger
    language plpgsql
as
$$
    declare
    cadenaCurp char(18);
    c char;
begin
    cadenaCurp = new.curp;
    if char_length(new.curp) is null or char_length(new.curp) != 18 then
        raise exception 'curp invalido';
        end if;
        for i in 1.. 18 loop
            c = substring(cadenaCurp, i, 1);
            --raise notice 'posicion % Caracter % ', i, c;
             if (i <= 4  and c !~* '[a-z]')
                    then
                        raise EXCEPTION 'caracteres invalidos en las primeras 4 posiciones';
                        exit;
                elsif (i>4 and i <= 10 and c !~* '[0-9]')
                    then
                        raise exception 'los caracteres que corresponden a la fecha son incorrectos';
                        exit ;
                elsif (i=11 and c !~* '[h|m]')
                    then
                        raise exception 'caracter referente a sexo invalido';
                        exit ;
                elsif (i > 11 and i <= 16 and c !~* '[a-z]')
                    then
                        raise exception 'error en entidad federativa o caracteres subsecuentes';
                        exit ;
                elsif (i > 16 and i <= 18 and c !~* '[a-z0-9]')
                    then
                        raise exception 'ultimos 2 caracteres invalidos';
                        exit ;
                end if;
        end loop;
    if (tg_op = 'UPDATE') then
        raise notice 'Cambiando curp % a nuevo curp %', old.curp, new.curp;
    end if;
    return new;
end
$$;

create function formato_rfc() returns trigger
    language plpgsql
as
$$
    declare
    cadenaRfc char(13);
    c char;
begin
    cadenaRfc = new.rfc;
    if char_length(new.rfc) is null or char_length(new.rfc) != 13 then
        raise exception 'rfc invalido';
        end if;
        for i in 1.. 13 loop
            c = substring(cadenaRfc, i, 1);
            --raise notice 'posicion % Caracter % ', i, c;
             if (i <= 4  and c !~* '[a-z]')
                    then
                        raise EXCEPTION 'caracteres invalidos en las primeras 4 posiciones';
                        exit;
                elsif (i>4 and i <= 10 and c !~* '[0-9]')
                    then
                        raise exception 'los caracteres que corresponden a la fecha son incorrectos';
                        exit ;
                elsif (i > 10 and i <= 13 and c !~* '[a-z0-9]')
                    then
                        raise exception 'homoclave invalida';
                        exit ;
                end if;
        end loop;
    if (tg_op = 'UPDATE') then
        raise notice 'Cambiando rfc % a nuevo rfc %', old.rfc, new.rfc;
    end if;
    return new;
end
$$;

create trigger verifica_rfcempleado before insert or update on empleado
for each row execute procedure formato_rfc();

create trigger verifica_curpcempleado before insert or update on empleado
for each row execute procedure formato_curp();

create trigger verifica_rfccliente before insert or update on cliente
for each row execute procedure formato_rfc();


-- Creamos un índice en artículo porque es la información que más se consulta
create index ix_articulo on articulo(
  codigo_barras,
  nombre,
  precio_compra,
  precio_venta,
  stock,
  id_categoria
);


--NOTA DE VENTAS_SUCURSAL_* : count(*) -> numero de ventas por sucursal
--							  sum(v.monto_total) -> total por sucursal

create or replace function ventas_sucursal_if(p_fecha_inicial date, p_fecha_final date) returns varchar
as $$

--variables a utilizar
declare v_resultado varchar(10000);

begin
	if(p_fecha_final <= p_fecha_inicial) then
		RAISE NOTICE 'La fecha final no puede ser menor o igual que la fecha inicial';
	else 
		select cast( 
		  (s.id_sucursal,
			count(*),
			sum(v.monto_total)
		  ) as varchar(10000)
		) into v_resultado
		from venta v join empleado e on(v.id_empleado=e.id_empleado)
		join sucursal s on(e.id_sucursal = s.id_sucursal)
		where (fecha >= p_fecha_inicial) and (fecha <= p_fecha_final)
		group by s.id_sucursal;
	end if;
	return v_resultado;
end;
$$ language plpgsql;


create or replace function ventas_sucursal() returns varchar 
as $$

--variables a utilizar
declare v_resultado varchar(10000);

begin
	select cast( 
	  (s.id_sucursal,
		count(*), 
		sum(v.monto_total)
	  ) as varchar(10000)
	) into v_resultado
	from venta v join empleado e on(v.id_empleado=e.id_empleado)
	join sucursal s on(e.id_sucursal = s.id_sucursal)
	where (fecha <= current_date)
	group by s.id_sucursal;

	return v_resultado;
end;
$$ language plpgsql;


create or replace function ventas_sucursal_f(
	p_fecha_final date
) returns varchar
as $$

--variables a utilizar
declare v_resultado varchar(10000);

begin
	select cast( 
	  (s.id_sucursal,
		count(*),
		sum(v.monto_total)
	  ) as varchar(10000)
	) into v_resultado
	from venta v join empleado e on(v.id_empleado=e.id_empleado)
	join sucursal s on(e.id_sucursal = s.id_sucursal)
	where (fecha < p_fecha_final)
	group by s.id_sucursal;
	return v_resultado;
end;
$$ language plpgsql;