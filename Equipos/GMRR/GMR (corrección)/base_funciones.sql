--Funciones

BEGIN;

--VISTA FACTURA

    --GENERAR NÚMERO DE FACTURA

CREATE OR REPLACE FUNCTION generar_factura()
  RETURNS text AS $$
DECLARE
  nuevo_numero text;
BEGIN
  -- Obtener el último número de factura generado
  EXECUTE 'SELECT last_value + 1 FROM factura_numero_seq' INTO nuevo_numero;

  -- Actualizar la secuencia para el próximo número de factura
  EXECUTE 'SELECT setval(''factura_numero_seq'', ' || nuevo_numero || ', false)';

  -- Formatear el número de factura
  nuevo_numero := 'FAC-' || LPAD(nuevo_numero::text, 3, '0');

  -- Devolver el nuevo número de factura
  RETURN nuevo_numero;
END;
$$ LANGUAGE plpgsql;


-- FUNCIÓN FACTURA

CREATE OR REPLACE FUNCTION facturar(rfcCliente varchar, id_venta varchar)
    RETURNS void AS $$
DECLARE
	--Datos del cliente
	nomeClient RECORD;
	nombre1 text;
	a_Pat text;
	a_Mat text;
	rfc_cliente text;
	
	--Datos de la factura
	fechita date;
	numFactura text;
	
	--Datos de la dirección (calle y número) del TYPE domicilio
	direCl domicilio;
	
	--Datos del email
	r_correos EMAIL%ROWTYPE;
	r_cliente CLIENTE%ROWTYPE;
	mensaje_emails text := '';
	
	--Datos de la venta
	idVenta text;
	r_ventas VENTA%ROWTYPE;
	r_filaVenta RECORD;
	r_codigoBarras CONFORMAR%ROWTYPE;
	fila_venta text := '';
	var_cantidad integer;
	total_de_venta float;
	
BEGIN
	IF EXISTS (
        SELECT 1 FROM CLIENTE c
        INNER JOIN VENTA v ON c.rfcClien = v.rfcClien
        WHERE c.rfcClien = UPPER(rfcCliente) AND v.idven = UPPER(id_venta)
    ) THEN

	--Obten el nombre del cliente.
    SELECT nombre, aPaterno, aMaterno INTO nomeClient FROM CLIENTE
    WHERE rfcClien = UPPER(rfcCliente);
	
	--Obten la direccion del cliente.
	SELECT cp, estado, colonia, calle, num INTO direCl.cp, direCl.estado, direCl.colonia, direCl.calle, direCl.num FROM CLIENTE
	WHERE rfcClien = UPPER(rfcCliente);
	
	--Obten el total de la venta.
	SELECT total_venta INTO total_de_venta FROM VENTA WHERE idven = UPPER(id_venta) AND rfcclien = UPPER(rfcCliente);
	
	--Obten el(los) email(s)
	SELECT * INTO r_cliente FROM CLIENTE WHERE rfcclien = UPPER(rfcCliente);
	
	nombre1 := nomeClient.nombre;
	a_Pat := nomeClient.aPaterno;
	a_Mat := nomeClient.aMaterno;
	rfc_cliente := rfcCliente;
	fechita := now();
	numFactura := generar_factura();
	idVenta := UPPER(id_venta);
	
	
	FOR r_correos IN ( --For para recolectar todos los correos del rfc proporcionado.
    SELECT t1.emails FROM EMAIL t1
    JOIN CLIENTE AS t2 
	ON t2.rfcclien = t1.rfcclien
    WHERE t2.rfcclien = r_cliente.rfcClien
  ) LOOP --LOOP emails
  
  		mensaje_emails := mensaje_emails || r_correos.emails || ', ';
		
	END LOOP;
  	mensaje_emails := substring(mensaje_emails, 1, length(mensaje_emails) - 2);
	
	
	--Ventas
	SELECT * INTO r_cliente FROM CLIENTE WHERE rfcclien = UPPER(rfcCliente);
	SELECT * INTO r_ventas FROM VENTA WHERE idven = UPPER(id_venta);
	
	
	FOR r_filaVenta IN ( --For para recolectar todos los datos de la venta.
    SELECT t2.codigobarras, t3.descripcion, t3.precio, t2.cantidad, t2.total FROM VENTA t1
    JOIN CONFORMAR AS t2
	ON t1.idven = t2.idven
	JOIN PRODUCTO AS t3
	ON t2.codigobarras = t3.codigobarras
	WHERE t2.idven = r_ventas.idven AND t1.rfcclien = rfcCliente
  ) LOOP --LOOP emails
		fila_venta := fila_venta || r_filaVenta.codigobarras || ' | ' ||
    	r_filaVenta.descripcion || ' | ' || r_filaVenta.precio || ' | ' ||
    	r_filaVenta.cantidad || ' | ' || r_filaVenta.total || E'\n';

	END LOOP;
  	fila_venta := left(fila_venta, length(fila_venta) - 2);
  
  
  
  RAISE INFO '
PAPELERÍA CLARKY                                                                  FACTURA

CALLE ALMANALCO LT82
VALLE DEL BRAVO Y EJIDO
VERGEL DE COYOACÁN, COYOACÁN C.P. 14340
COYOACÁN, CDMX.

Teléfono: (55)1945-9015                                       NO. DE FACTURA: %
                                                              FECHA: %

Facturar a:
Nombre: % % %
RFC: %
Dirección: % %
Colonia, Estado, Código postal: %  %.  C.P. %
Email: %

ID VENTA: %
_______________________________________________________________________

Producto  |  Descripción  |  Precio unitario  |  Cantidad  |  Monto
_______________________________________________________________________

%

_______________________________________________________________________				       
                                                      TOTAL: $%
_______________________________________________________________________
',numFactura, fechita, nombre1, a_Pat, a_Mat, rfc_cliente, direCl.calle, 
direCl.num, direCl.colonia, direCl.estado, direCl.cp, mensaje_emails,
idVenta, fila_venta, total_de_venta;

	ELSE --Si la combinación de RFC y ID venta no coinciden
		RAISE EXCEPTION 'Es posible que el RFC o ID ingresados sean incorrectos o no existan.
		Por favor, verifica que los datos existan o sean correctos.';
    END IF;

END;
$$ LANGUAGE plpgsql;

--Crear un tipo para la vista factura.
CREATE TYPE domicilio AS (
	estado varchar,
	colonia varchar,
	cp int,
	calle varchar,
	num int
);

--Secuencia de la factura
CREATE SEQUENCE factura_numero_seq START 1;



--GANANCIA POR INTERVALO DE FECHAS

CREATE FUNCTION ganancia(fecha1 varchar(10), fecha2 varchar(10))
RETURNS FLOAT AS $$
DECLARE
	ganancia float;
BEGIN 
	RAISE NOTICE 'El total de ganancia entre el dia % y % es:', fecha1, fecha2;
	SELECT SUM(j.utilidad) INTO ganancia FROM (SELECT utilidad, fecha FROM CONFORMAR C INNER JOIN VENTA V ON C.idVen = V.idVen) AS j WHERE fecha BETWEEN fecha1::DATE AND fecha2::DATE;
	RETURN ganancia;
END;
$$ LANGUAGE plpgsql;




-- UTILIDAD

CREATE or replace FUNCTION utilidad(CB varchar) RETURNS float AS $$
declare
	rec record;
	utilidad float;
	aux int:=1;
	a float;
begin
select * into strict rec from producto where codigoBarras=CB;

	a=(select sum(cantidadsuministrar*precio_compra) from suministrar where codigobarras=CB)/(select sum(cantidadsuministrar) from suministrar where codigobarras=CB);
		utilidad=a;

	if rec.categoria='Impresiones' then
		if rec.marca='color' then
			aux=2;
		else if rec.marca='B/N' then
			aux=1;
		end if;
		end if; 
		return aux*3*utilidad;
	end if;
	if rec.categoria='Regalos' then
		return 0.1*utilidad;
	end if;
	if rec.categoria='Articulos Papeleria' then
		return 0.085*utilidad;
	end if;
	if rec.categoria='Recargas' then
		return 1;
	end if;
	return 0;
end; $$ language plpgsql;




-- PRECIO DEL PRODUCTO

CREATE or replace FUNCTION preciop(CB varchar) RETURNS void AS $$
declare
rec record;
a float;
begin
	select * into strict rec from producto where codigoBarras=CB;
	if rec.categoria!='Recargas' then
		a=(select sum(cantidadsuministrar*precio_compra) from suministrar where codigoBarras=CB);
		UPDATE Producto SET precio=((a/(select sum(cantidadsuministrar) from suministrar where codigoBarras=CB)) +(select utilidad(CB))) where codigoBarras=CB;
		raise notice ' a:% +   u=%',a,utilidad(CB);
end if;	
	if rec.categoria='Recargas' then
	ALTER TABLE help ALTER COLUMN valor SET DATA TYPE varchar;
	insert into help (id,valor) values (CB,rec.descripcion);
	ALTER TABLE help ALTER COLUMN valor SET DATA TYPE int USING valor::integer;
	UPDATE Producto SET precio=(select valor from help H inner join Producto P on H.id=P.codigobarras 
		where P.codigobarras=CB) +(select utilidad(CB)) WHERE codigobarras=CB;
	end if;

end;$$ language plpgsql;




-- ACTUALIZAR STOCK


CREATE OR REPLACE FUNCTION actualizar_stock()
RETURNS TRIGGER AS $$
DECLARE
	stockv int;
	categ varchar(50); 
BEGIN
	SELECT categoria INTO categ FROM PRODUCTO WHERE codigoBarras = NEW.codigoBarras;
	SELECT stock INTO stockv FROM PRODUCTO WHERE codigoBarras = NEW.codigoBarras;

	IF (stockv - NEW.cantidad ) >= 0 THEN
		RAISE NOTICE 'Compra Realizada';
		IF (stockv - NEW.cantidad) = 0 THEN
			RAISE NOTICE 'ADVERTENCIA: AHORA EL STOCK SE ENCUENTRA VACIO';
		ELSIF (stockv - NEW.cantidad) < 3 THEN
			RAISE NOTICE 'ADVERTENCIA: ESTE PRODUCTO TIENE MENOS DE 3 UNIDADES EN STOCK';
		END IF;

		IF categ = 'Recargas' THEN
			UPDATE PRODUCTO SET stock = stock - NEW.total+1
			WHERE codigoBarras = NEW.codigoBarras;
 		ELSE
			UPDATE PRODUCTO SET stock = stock - NEW.cantidad
			WHERE codigoBarras = NEW.codigoBarras;
		END IF;
	ELSE
		RAISE NOTICE 'Sin stock suficiente, Compra no realizada';
		DELETE FROM CONFORMAR WHERE (codigoBarras = NEW.codigoBarras) AND (idVen = NEW.idVen);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_actualizar_stock
AFTER INSERT ON CONFORMAR
FOR EACH ROW 
EXECUTE FUNCTION actualizar_stock();

--SUMAR STOCK
CREATE OR REPLACE FUNCTION sumar_stock()
RETURNS TRIGGER AS $$
DECLARE
	stockv int;
BEGIN
	SELECT stock INTO stockv FROM PRODUCTO WHERE codigoBarras = NEW.codigoBarras;

	UPDATE PRODUCTO SET stock = stock + NEW.cantidadSuministrar
	WHERE codigoBarras = NEW.codigoBarras;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_sumar_stock
AFTER INSERT ON SUMINISTRAR
FOR EACH ROW 
EXECUTE FUNCTION sumar_stock();




--ID VENTA

CREATE SEQUENCE id_venta_secuencial;

ALTER SEQUENCE id_venta_secuencial START 1 INCREMENT 1 NO MAXVALUE MINVALUE 1;
--Esta sentencia hace que empiece en 1, vaya aumentando de a 1, no haya límite en el 001 y el mínimo sea 1.

CREATE OR REPLACE FUNCTION id_venta_serial() --Crear la función
RETURNS TEXT AS

$$
DECLARE
  secuencia TEXT;
  
	BEGIN
  		secuencia := 'VENT-' || LPAD(nextval('id_venta_secuencial')::TEXT, 3, '0'); --Se construye el VENT-001
  		RETURN secuencia;
	END;
	
$$ LANGUAGE plpgsql;

ALTER TABLE "VENTA" ALTER COLUMN idVen SET DEFAULT id_venta_serial();




-- COMPRAR

CREATE OR REPLACE PROCEDURE comprar(cliente varchar(13), codigoBarrasParametro varchar(14), cantidadParametro int)
LANGUAGE plpgsql
AS $$
DECLARE
	num_venta varchar(8);
	num_actual_cantidad int;
	num_actual_total float;
	num_actual_utilidad float;
	stockv int;
	categ varchar(50);
BEGIN
	SELECT idVen INTO num_venta FROM VENTA WHERE (rfcClien = cliente) AND (total_venta = 0);
	IF EXISTS(SELECT * FROM CONFORMAR WHERE idVen = num_venta AND codigoBarras = codigoBarrasParametro) THEN
		SELECT cantidad INTO num_actual_cantidad FROM CONFORMAR WHERE idVen = num_venta AND codigoBarras = codigoBarrasParametro;
		SELECT total INTO num_actual_total FROM CONFORMAR WHERE idVen = num_venta AND codigoBarras = codigoBarrasParametro;		
		SELECT utilidad INTO num_actual_utilidad FROM CONFORMAR WHERE idVen = num_venta AND codigoBarras = codigoBarrasParametro;
		SELECT stock INTO stockv FROM PRODUCTO WHERE codigoBarras = codigoBarrasParametro;
		SELECT categoria INTO categ FROM PRODUCTO WHERE codigoBarras = codigoBarrasParametro;		

		IF (stockv - cantidadParametro ) >= 0 THEN
			RAISE NOTICE 'Compra Realizada';
			IF (stockv - cantidadParametro) = 0 THEN
				RAISE NOTICE 'ADVERTENCIA: AHORA EL STOCK SE ENCUENTRA VACIO';
			ELSIF (stockv - cantidadParametro) < 3 THEN
				RAISE NOTICE 'ADVERTENCIA: ESTE PRODUCTO TIENE MENOS DE 3 UNIDADES EN STOCK';
			END IF;
			
			UPDATE CONFORMAR SET cantidad = num_actual_cantidad + cantidadParametro WHERE idVen = num_venta AND codigoBarras = codigoBarrasParametro;
			UPDATE CONFORMAR SET total = num_actual_total + (cantidadParametro*calcular_total_producto(codigoBarrasParametro)) WHERE idVen = num_venta AND codigoBarras = codigoBarrasParametro;
			UPDATE CONFORMAR SET utilidad = num_actual_utilidad + (cantidadParametro*utilidad(codigoBarrasParametro)) WHERE idVen = num_venta AND codigoBarras = codigoBarrasParametro;
			
			IF categ = 'Recargas' THEN
				UPDATE PRODUCTO SET stock = stock - calcular_total_producto(codigoBarrasParametro)+1
				WHERE codigoBarras = codigoBarrasParametro;
 			ELSE
				UPDATE PRODUCTO SET stock = stock - cantidadParametro
				WHERE codigoBarras = codigoBarrasParametro;
			END IF;
		ELSE
			RAISE NOTICE 'Sin stock suficiente, Compra no realizada';
		END IF;	
		
	ELSE
		INSERT INTO CONFORMAR VALUES(codigoBarrasParametro, num_venta, cantidadParametro, calcular_total_producto(codigoBarrasParametro)*cantidadParametro, cantidadParametro*utilidad(codigoBarrasParametro));
	END IF;	
END;
$$;




-- FINALIZAR UNA VENTA

CREATE OR REPLACE PROCEDURE finalizarVenta(cliente varchar(13))
LANGUAGE plpgsql
AS $$
DECLARE
	num_venta varchar(8);
	totalf float;
BEGIN
	SELECT idVen INTO num_venta FROM VENTA WHERE (rfcClien = cliente) AND (total_venta = 0);
	SELECT sum(total) INTO totalf FROM CONFORMAR WHERE idVen = num_venta;
	UPDATE VENTA SET total_venta = totalf WHERE idVen = num_venta;
END;
$$;


-- INDICE

CREATE INDEX Estado ON Provedor ('estado');


-- CALCULAR TOTAL PRODUCTO

CREATE OR REPLACE FUNCTION calcular_total_producto(idproducto varchar(14))
RETURNS FLOAT AS $$
DECLARE
	p float;
BEGIN
	
	SELECT precio INTO p FROM PRODUCTO WHERE codigoBarras = idproducto;
	RETURN p;
END;
$$ LANGUAGE plpgsql;



-- CALCULAR LA GANANCIA TOTAL DE UNA FECHA

CREATE FUNCTION ganancia(fechaG varchar(10))
RETURNS FLOAT AS $$
DECLARE
	ganancia float;
BEGIN 
	RAISE NOTICE 'El total de ganancia el dia % es:', fechaG;
	SELECT SUM(j.utilidad) INTO ganancia FROM (SELECT utilidad, fecha FROM CONFORMAR C INNER JOIN VENTA V ON C.idVen = V.idVen) AS j WHERE fecha = fechaG::DATE;
	RETURN ganancia;
END;
$$ LANGUAGE plpgsql;


COMMIT;


-- INSERTAR UN PRODUCTO

create or replace function insertarP(RfcProve varchar, fecha date,cantidad int, precioC float,Categoria varchar, Marca varchar, Descri varchar) returns void as $$
	declare
		codigoBarr varchar;
		next int;
		CB varchar;
	begin
		if Categoria='Impresiones' then
		next=nextval('sec_imp'); 
		end if;
		if Categoria='Recargas' then
			if (select char_length(Descri))<3 then
				Descri=concat(0,Descri);
			end if;
		next=nextval('sec_rec'); 
		end if;
		if Categoria='Regalos' then
		next=nextval('sec_reg'); 
		end if;
		if Categoria='Articulos Papeleria' then
		next=nextval('sec_art'); 
		end if;
		CB=concat(UPPER(substring(Categoria, 1, 3)),UPPER(substring(Marca, 1, 3)),UPPER(substring(Descri, 1, 3)));
		if CB=(select UPPER(substring(codigobarras, 1, 9)) from Producto where Descripcion=Descri) then
			CB=(select codigoBarras from producto where Descripcion=Descri);
			insert into Suministrar(id_sum,rfcpro,codigobarras,precio_compra,cantidadSuministrar,fecha_compra) values(nextval('sec_sum'),RfcProve,CB,precioC,cantidad,fecha);
			execute preciop(CB);
		else 
		codigoBarr=concat(CB,next);		

		insert into Producto (codigobarras,categoria,marca,descripcion,stock) values(codigoBarr,Categoria,Marca,Descri,cantidad);
		insert into Suministrar(id_sum,rfcpro,codigobarras,precio_compra,cantidadSuministrar,fecha_compra) values(nextval('sec_sum'),RfcProve,codigoBarr,precioC,cantidad,fecha);
		
execute preciop(codigoBarr);
		end if;
	end; $$ language plpgsql;


-- Insertar Proveedor

create or replace function insertarPro(rfc varchar, nombre varchar, razonsocial varchar, estado varchar, colonia varchar, cp int, num int, calle varchar) returns void as $$
	begin
	INSERT INTO PROVEDOR (rfcpro, nombre, razonsocial, estado, colonia, cp, num, calle)
	VALUES (rfc, nombre, razonsocial, estado, colonia, cp, num, calle);
	end; $$ language plpgsql;

-- Insertar cliente

	create or replace function Suscribir(rfc varchar, nombre varchar, AP varchar,AM varchar,email varchar, estado varchar, colonia varchar, calle varchar, cp int, num int) returns void as $$
	begin
	INSERT INTO Cliente (rfcClien,nombre,aPaterno,aMaterno,cp,estado,colonia,calle,num)
	VALUES (rfc, nombre, AP ,AM, cp, estado, colonia, calle, num);
	Insert into email values(rfc,email);
	end; $$ language plpgsql;

-- SECUENCIAS

create sequence sec_ART  start with 1000  increment by 1 maxvalue 6000;
create sequence sec_IMP  start with 6001  increment by 1 maxvalue 6500;
create sequence sec_REG  start with 6501  increment by 1 maxvalue 9000;
create sequence sec_REC  start with 9001  increment by 1 maxvalue 9999;
create sequence sec_Sum  start with 1  increment by 1;
CREATE SEQUENCE id_venta_secuencial;
CREATE SEQUENCE factura_numero_seq START 1;

ALTER SEQUENCE id_venta_secuencial START 1 INCREMENT 1 NO MAXVALUE MINVALUE 1;
--Esta sentencia hace que empiece en 1, vaya aumentando de a 1, no haya límite en el 001 y el mínimo sea 1.

-- VENTA INDICE

CREATE OR REPLACE FUNCTION id_venta_serial() --Crear la función
RETURNS TEXT AS

$$
DECLARE
  secuencia TEXT;
  
	BEGIN
  		secuencia := 'VENT-' || LPAD(nextval('id_venta_secuencial')::TEXT, 3, '0'); --Se construye el VENT-001
  		RETURN secuencia;
	END;
$$ LANGUAGE plpgsql;

ALTER TABLE "VENTA" ALTER COLUMN idVen SET DEFAULT id_venta_serial();


