CREATE DATABASE office_manager
ENCODING = 'UTF-8'
CONNECTION LIMIT = -1;
\c office_manager

CREATE TABLE public.cliente (
	IDCliente serial PRIMARY KEY,
	razonSocC varchar(50) not null,
	estadoC varchar(25) not null,
	cpC integer,
	coloniaC varchar(40),
	calleC varchar(40),
	numeroC varchar(15),
	nombreC varchar(40)
	--CONSTRAINTS
);

CREATE TABLE public.proveedor (
	IDProv serial PRIMARY KEY,
	razonSocP varchar(50) not null,
	estadoP varchar(25) not null,
	cpP integer,
	coloniaP varchar(40),
	calleP varchar(40),
	numeroP varchar(15),
	nombreP varchar(40) 
	--CONSTRAINTS
);

CREATE TABLE public.telefono_prov (
	IDProv integer not null ,
	telefono integer not null,
	CONSTRAINT telefono_fk FOREIGN KEY (IDProv)
		REFERENCES public.proveedor (IDProv) ON DELETE CASCADE,
	--CONSTRAINTS
	CONSTRAINT telefono_pk PRIMARY KEY (IDProv,telefono)
);



--agregar constrains**********

alter table telefono_prov  add CONSTRAINT telefono_fk FOREIGN KEY (IDProv)
		REFERENCES public.proveedor (IDProv) ON DELETE CASCADE,
	CONSTRAINT telefono_pk PRIMARY KEY (IDProv,telefono);


--fin constrainst telefono_prov********

CREATE TABLE public.categoria (
	IDCategoria integer PRIMARY KEY,
	nombreCategoria varchar(30) not null
	--CONSTRAINTS
);

CREATE TABLE public.producto (
	codigoBarras integer, --PRIMARY KEY,
	nombreProducto varchar(30) not null,
	fechaCompra date not null,
	stock integer not null CONSTRAINT stock_posi CHECK (stock >= 0),
	precio_adquirido decimal(6,2) not null CHECK (precio_adquirido > 0),
	precioVenta decimal(6,2) not null CHECK (precioVenta >0),
	IDCategoria integer not null,
	marca varchar(30) not null/*,
	CONSTRAINTS
	CONSTRAINT producto_IDCategoria_fk FOREIGN KEY (IDCategoria) 
		REFERENCES public.categoria (IDCategoria) ON DELETE CASCADE*/
);


--Contraint producto

alter table producto add CONSTRAINT producto_IDCategoria_fk FOREIGN KEY (IDCategoria) 
		REFERENCES public.categoria (IDCategoria) ON DELETE CASCADE;

--fin const prodycto--*****


CREATE TABLE public.orden (
	numVenta varchar(10) not null,
	fechaVenta date not null,
	total decimal(7,2) not null CHECK (total>0),
	IDCliente integer not null/*,
	CONSTRAINT orden_fk FOREIGN KEY (IDCliente)
		REFERENCES public.cliente (IDCliente) ON DELETE CASCADE,
	CONSTRAINT orden_pk PRIMARY KEY (numVenta) */
	--CONSTRAINTS
);


--constraint orden

alter table orden add CONSTRAINT orden_fk FOREIGN KEY (IDCliente)--******checar este que no se pudo
		REFERENCES public.cliente (IDCliente) ON DELETE CASCADE;

alter table orden add CONSTRAINT orden_pk PRIMARY KEY (numVenta);

----fin orden---



CREATE TABLE public.detalle_orden (
	codigoBarras int  not null,
	numVenta varchar(10) not null,
	cantidadArticulos int not null,
	subtotal decimal(7,2) not null/*,
	--CONSTRAINTS
	CONSTRAINT detalle_cb_fk FOREIGN KEY (codigoBarras)
		REFERENCES public.producto (codigoBarras) ON DELETE NO ACTION,
	--SE DEBE DE HACER UN TRIGGER QUE DECREMENTE EL TOTAL DE UNA ORDEN Y
	--AUMENTE EL STOCK!
	constraint detalle_nv_fk FOREIGN KEY (numVenta)
		REFERENCES public.orden (numVenta) ON DELETE NO ACTION,
	CONSTRAINT detalle_pk PRIMARY KEY (codigoBarras,numVenta)*/
);


--constraint detalle_orden



alter table detalle_orden add CONSTRAINT detalle_cb_fk FOREIGN KEY (codigoBarras)-- checar porque no se pudo
		REFERENCES public.producto (codigoBarras) ON DELETE NO ACTION;

alter table detalle_orden add constraint detalle_nv_fk FOREIGN KEY (numVenta)
		REFERENCES public.orden (numVenta) ON DELETE NO ACTION;

alter table detalle_orden add CONSTRAINT detalle_pk PRIMARY KEY (codigoBarras,numVenta);--checar no se pudo


--fin detalle_orden




CREATE TABLE public.email_cliente(
	IDCliente integer not null,
	email varchar(50) not null/*,
	--CONSTRAINTS
	CONSTRAINT email_c_fk FOREIGN KEY (IDCliente)
		REFERENCES public.cliente (IDCliente),
	CONSTRAINT email_c_pk PRIMARY KEY (IDCliente,email)*/
);

--constraint email_cliente

alter table email_cliente add CONSTRAINT email_c_fk FOREIGN KEY (IDCliente)
		REFERENCES public.cliente (IDCliente);

alter table email_cliente add CONSTRAINT email_c_pk PRIMARY KEY (IDCliente,email);

--fin email_cliente




--recibir codigo barras salida utilidad
CREATE OR REPLACE FUNCTION utilidadProducto (inpt integer) 
RETURNS decimal(6,2) as $utilidad$
DECLARE
	utilidad decimal(6,2);
BEGIN
	SELECT p.precioVenta-p.precio_adquirido INTO utilidad
	FROM producto p
	WHERE p.codigoBarras = inpt;
	RETURN utilidad;
END; $utilidad$ LANGUAGE plpgsql;


-- dada una o dos fechas determinar cuanto se vendió en ese dia/periodo
CREATE OR REPLACE FUNCTION ventasFecha (fechaI varchar)
	RETURNS TABLE (
			codigoBarras integer,
			uVendidas bigint,
			montoTotal decimal (8,2)
			)
AS $$
BEGIN
	RETURN QUERY SELECT detalle_orden.codigoBarras, (sum(detalle_orden.cantidadArticulos)) X, SUM(detalle_orden.subtotal)
				FROM
				detalle_orden , orden
				WHERE
				detalle_orden.numVenta = orden.numVenta and orden.fechaVenta = fechaI
				GROUP BY detalle_orden.codigoBarras;
END; $$ LANGUAGE 'plpgsql';




--E, BUENAS

CREATE OR REPLACE FUNCTION ventasFechaS (fechaI varchar,fechaF varchar)

	
	RETURNS TABLE (
			codigoBarras integer,
			uVendidas bigint,
			montoTotal decimal (8,2)
			)
AS $$
BEGIN

	RETURN QUERY SELECT detalle_orden.codigoBarras, (sum (detalle_orden.cantidadArticulos)) X , SUM(detalle_orden.subtotal)
				FROM
				detalle_orden, orden 
				WHERE
				detalle_orden.numVenta =orden.numVenta and orden.fechaVenta between fechaI and fechaF
				GROUP BY detalle_orden.codigoBarras;
END; $$ LANGUAGE 'plpgsql';




--obtener nombre de los productos con menos de 3 piezas
CREATE OR REPLACE FUNCTION getLowStock()
	RETURNS TABLE(
			codigoBarras integer,
			nombreProducto varchar(30)
			)
AS $$ 
BEGIN
	RETURN QUERY SELECT p.codigoBarras as codigoBarras, p.nombreProducto as nombreProducto 
				FROM producto p
				WHERE p.stock < 3;
END; $$ LANGUAGE 'plpgsql';





--Generar vista automáticamente para facturación.



-- decrementar stock por vender
CREATE OR REPLACE FUNCTION stockDec() RETURNS TRIGGER AS $$
DECLARE _dispA integer;
BEGIN 
	SELECT stock p INTO _dispA from producto p WHERE p.codigoBarras = new.codigoBarras;

	--SELECT new.cantidadArticulos INTO _dispB from NEW;
	IF (_dispA >= new.cantidadArticulos) THEN
		if(_dispA < 3) THEN
		RAISE NOTICE 'Advertencia: Queda(n) % articulo(s) en stock!',_dispA-new.cantidadArticulos;
		end if;
		UPDATE producto 
		SET stock = _dispA - new.cantidadArticulos
		WHERE producto.codigoBarras = new.codigoBarras;

		RETURN NEW;
	else
		RAISE EXCEPTION 'No hay suficiente stock, queda(n) % pieza(s) en stock',  _dispA ;
	END IF;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER stockDec BEFORE INSERT or UPDATE ON detalle_orden
	FOR EACH ROW EXECUTE PROCEDURE stockDeC(); 


