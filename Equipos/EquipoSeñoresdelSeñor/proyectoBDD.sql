CREATE TABLE empleado (
	num_empleado bigserial NOT NULL,
	rfc varchar(13) NOT NULL,
	edad smallint NOT NULL,
	sueldo DECIMAL NOT NULL,
	fecha_nacimiento date NOT NULL,
	foto bytea NOT NULL,
	nombre varchar(60) NOT NULL,
	ap_pat varchar(60) NOT NULL,
	ap_mat varchar(60),
	calle varchar(30) NOT NULL,
	numero_domicilio smallint NOT NULL,
	colonia varchar(30) NOT NULL,
	cod_postal varchar(5) NOT NULL,
	estado varchar(30) NOT NULL,
	CONSTRAINT empleado_pk PRIMARY KEY (num_empleado),
	CONSTRAINT rfc_uq UNIQUE (rfc)
);

CREATE TABLE telefono (
	telefono varchar(10) NOT NULL,
	num_empleado_empleado bigserial NOT NULL,
	CONSTRAINT telefono_pk PRIMARY KEY (telefono,num_empleado_empleado)
);

CREATE TABLE dependiente (
	curp varchar(18) NOT NULL,
	nombre varchar(60) NOT NULL,
	ap_pat varchar(60) NOT NULL,
	ap_mat varchar(60) NOT NULL,
	parentesco varchar(20) NOT NULL,
	num_empleado_empleado bigserial NOT NULL,
	CONSTRAINT dependiente_pk PRIMARY KEY (curp,num_empleado_empleado)
);

CREATE TABLE cocinero (
	especialidad varchar(30) NOT NULL,
	num_empleado_empleado bigserial NOT NULL,
	CONSTRAINT cocinero_pk PRIMARY KEY (num_empleado_empleado)
);

CREATE TABLE administrativo (
	rol varchar(20) NOT NULL,
	num_empleado_empleado bigserial NOT NULL,
	CONSTRAINT administrativo_pk PRIMARY KEY (num_empleado_empleado)
);

CREATE TABLE mesero (
	horario_inicio time NOT NULL,
	horario_fin time NOT NULL,
	num_empleado_empleado bigserial NOT NULL,
	CONSTRAINT mesero_pk PRIMARY KEY (num_empleado_empleado)
);

ALTER TABLE telefono ADD CONSTRAINT empleado_fk FOREIGN KEY (num_empleado_empleado)
REFERENCES empleado (num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE dependiente ADD CONSTRAINT empleado_fk FOREIGN KEY (num_empleado_empleado)
REFERENCES empleado (num_empleado) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE cocinero ADD CONSTRAINT empleado_fk FOREIGN KEY (num_empleado_empleado)
REFERENCES empleado (num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE administrativo ADD CONSTRAINT empleado_fk FOREIGN KEY (num_empleado_empleado)
REFERENCES empleado (num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE mesero ADD CONSTRAINT empleado_fk FOREIGN KEY (num_empleado_empleado)
REFERENCES empleado (num_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE orden (
	folio varchar(7) NOT NULL CHECK (folio ~ '^ORD-\d+$'),
	fecha_y_hora timestamp NOT NULL,
	cantidad_a_pagar DECIMAL NOT NULL,
	num_empleado_empleado_mesero bigserial NOT NULL,
	rfc_cliente varchar(13) NOT NULL,
	CONSTRAINT orden_pk PRIMARY KEY (folio)
);

CREATE TABLE cliente (
	rfc varchar(13) NOT NULL,
	email text NOT NULL,
	fecha_nacimiento date NOT NULL,
	razon_social varchar(100) NOT NULL,
	nombre varchar(60) NOT NULL,
	ap_pat varchar(60) NOT NULL,
	ap_mat varchar(60),
	calle varchar(30) NOT NULL,
	numero_domicilio smallint NOT NULL,
	colonia varchar(30) NOT NULL,
	cod_postal varchar(5) NOT NULL,
	estado varchar(30) NOT NULL,
	CONSTRAINT cliente_pk PRIMARY KEY (rfc)
);

ALTER TABLE orden ADD CONSTRAINT mesero_fk FOREIGN KEY (num_empleado_empleado_mesero)
REFERENCES mesero (num_empleado_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE orden ADD CONSTRAINT cliente_fk FOREIGN KEY (rfc_cliente)
REFERENCES cliente (rfc) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE categoria (
	id_categoria integer NOT NULL,
	nombre_categoria varchar(30) NOT NULL,
	descrip_categoria varchar(60) NOT NULL,
	CONSTRAINT categoria_pk PRIMARY KEY (id_categoria)
);

CREATE TABLE producto (
	cod_barra integer NOT NULL,
	nombre_producto varchar(30) NOT NULL,
	precio DECIMAL NOT NULL,
	receta varchar(255) NOT NULL,
	descripcion_producto varchar(100) NOT NULL,
	disponibilidad boolean NOT NULL,
	id_categoria_categoria integer NOT NULL,
	CONSTRAINT producto_pk PRIMARY KEY (cod_barra)
);

ALTER TABLE producto ADD CONSTRAINT categoria_fk FOREIGN KEY (id_categoria_categoria)
REFERENCES categoria (id_categoria) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE agrega (
	folio_orden varchar(7) NOT NULL,
	cod_barra_producto integer NOT NULL,
	cantidad_producto smallint NOT NULL,
	total_por_pagar money NOT NULL,
	CONSTRAINT agrega_pk PRIMARY KEY (folio_orden,cod_barra_producto)
);

ALTER TABLE agrega ADD CONSTRAINT orden_fk FOREIGN KEY (folio_orden)
REFERENCES public.orden (folio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE agrega ADD CONSTRAINT producto_fk FOREIGN KEY (cod_barra_producto)
REFERENCES public.producto (cod_barra) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

------ FUNCION PARA AGREGAR  ------

CREATE OR REPLACE FUNCTION agregarProducto(p_idproducto INTEGER, p_cantidad INTEGER, p_idorden VARCHAR (7))
    RETURNS VOID 
    AS
    $$
    DECLARE 
        disponibilidadActual BOOLEAN;
        precioProducto DECIMAL; 
        nuevoTotal DECIMAL;
        cantidadActualizar INTEGER;

    BEGIN

        SELECT disponibilidad, precio INTO disponibilidadActual, precioProducto
        FROM producto
        WHERE cod_barra = p_idproducto;
        
        SELECT cantidad_a_pagar INTO nuevoTotal
        FROM orden 
        WHERE folio = p_idorden;

        SELECT cantidad_producto INTO cantidadActualizar
        FROM agrega 
        WHERE folio_orden = p_idorden AND cod_barra_producto = p_idproducto;

        IF disponibilidadActual = TRUE THEN 
            INSERT INTO agrega (folio_orden, cod_barra_producto, cantidad_producto, total_por_pagar)
            VALUES (p_idorden, p_idproducto, p_cantidad, p_cantidad*precioProducto)
            ON CONFLICT (folio_orden, cod_barra_producto) DO UPDATE
            SET cantidad_producto = cantidadActualizar + p_cantidad,
                total_por_pagar = nuevoTotal + (p_cantidad * precioProducto);

            UPDATE orden 
            SET cantidad_a_pagar = nuevoTotal + (p_cantidad * precioProducto)
            WHERE folio = p_idorden;   

            RAISE NOTICE 'Producto agregador correctamente';
        ELSE 
            RAISE EXCEPTION 'Producto no disponible';
        END IF;
    
    END;
    $$
    LANGUAGE plpgsql;


CREATE TABLE agrega_historial (
    id SERIAL PRIMARY KEY,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_operacion VARCHAR(10),
    folio_orden VARCHAR(7),
    cod_barra_producto INTEGER,
    cantidad_anterior INTEGER,
    cantidad_nueva INTEGER,
    total_anterior DECIMAL,
    total_nuevo DECIMAL
);

-- Crear una función de trigger
CREATE OR REPLACE FUNCTION tr_agrega_historial()
    RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO agrega_historial (tipo_operacion, folio_orden, cod_barra_producto, cantidad_nueva, total_nuevo)
        VALUES ('INSERT', NEW.folio_orden, NEW.cod_barra_producto, NEW.cantidad_producto, NEW.total_por_pagar);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO agrega_historial (tipo_operacion, folio_orden, cod_barra_producto, cantidad_anterior, cantidad_nueva, total_anterior, total_nuevo)
        VALUES ('UPDATE', OLD.folio_orden, OLD.cod_barra_producto, OLD.cantidad_producto, NEW.cantidad_producto, OLD.total_por_pagar, NEW.total_por_pagar);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO agrega_historial (tipo_operacion, folio_orden, cod_barra_producto, cantidad_anterior, total_anterior)
        VALUES ('DELETE', OLD.folio_orden, OLD.cod_barra_producto, OLD.cantidad_producto, OLD.total_por_pagar);
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger
CREATE TRIGGER trg_agrega_historial
AFTER INSERT OR UPDATE OR DELETE ON agrega
FOR EACH ROW
EXECUTE FUNCTION tr_agrega_historial();
------ FUNCION PARA OBTENER LA DISPONIBILIDAD ------
CREATE OR REPLACE FUNCTION productos_no_disponibles()
RETURNS TABLE (
    codi_barra INTEGER,
    nombre VARCHAR(30),
    stock BOOLEAN
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        cod_barra,
        nombre_producto,
        disponibilidad
    FROM
        producto
    WHERE
        disponibilidad = FALSE;
END;
$$ LANGUAGE plpgsql;

------ FUNCION PARA VER LAS ORDENES DE UN MESERO ------

CREATE OR REPLACE FUNCTION ordenes_por_empleado(p_num_empleado bigserial)
RETURNS TABLE (
    fecha DATE,
    cantidad_ordenes BIGINT,
    pago_total DECIMAL
)
AS $$
DECLARE 
    es_mesero BOOLEAN;
BEGIN
    SELECT TRUE
    INTO es_mesero
    FROM mesero
    WHERE num_empleado_empleado = p_num_empleado;

    
    IF es_mesero IS NULL THEN
        RAISE EXCEPTION 'El empleado con número % no es un mesero.', p_num_empleado;
    END IF;


    RETURN QUERY
    SELECT
        fecha_y_hora::DATE AS fecha,
        COUNT(*) AS cantidad_ordenes,
        SUM(cantidad_a_pagar) AS pago_total
    FROM
        orden
    WHERE
        num_empleado_empleado_mesero = p_num_empleado
    GROUP BY
        fecha_y_hora::DATE;
END;
$$ LANGUAGE plpgsql;


------- FUNCION PARA OBTENER LAS ORDENES EN UN RANGO DE FECHAS ------
CREATE OR REPLACE FUNCTION ordenes_fechas (p_fechainicio TIMESTAMP, p_fechafin TIMESTAMP)
RETURNS TABLE (
	total_ventas BIGINT,
	total_pagado DECIMAL)
AS $$
BEGIN
	SELECT COUNT(folio), SUM (cantidad_a_pagar) INTO total_ventas, total_pagado
	FROM orden 
	WHERE fecha_y_hora::DATE BETWEEN p_fechainicio::DATE AND p_fechafin::DATE;

	RETURN QUERY SELECT total_ventas, total_pagado;  
END;
$$ LANGUAGE plpgsql; 


----- FUNCION PARA OBTENER LAS ORDENDES DE UN SOLO DIA ------

CREATE OR REPLACE FUNCTION ordenes_por_dia2(p_fechainteres TIMESTAMP)
RETURNS TABLE (
    total_ordenes BIGINT,
    total_pago DECIMAL
)
AS $$
DECLARE
    total_ordenes BIGINT;
    total_pago DECIMAL;
BEGIN
    SELECT COUNT(folio), SUM(cantidad_a_pagar)
    INTO total_ordenes, total_pago
    FROM orden
    WHERE fecha_y_hora::DATE = p_fechainteres::DATE;

    RETURN QUERY SELECT total_ordenes, total_pago;
END;
$$ LANGUAGE plpgsql;

---------------------------
------ VISTA PARA EL PRODUCTO MÁS VENDIDO ------
CREATE VIEW vista_producto_mas_vendido AS
SELECT
    p.cod_barra,
    p.nombre_producto,
    p.precio,
    SUM(a.cantidad_producto) AS total_vendido
FROM
    producto p
JOIN
    agrega a ON p.cod_barra = a.cod_barra_producto
GROUP BY
    p.cod_barra, p.nombre_producto, p.precio
ORDER BY
    total_vendido DESC
LIMIT 1;

------ INDICE ------
-- Crear un índice en la tabla producto
CREATE INDEX idx_producto_codigo_barras ON producto(cod_barra);

-- Crear un índice en la tabla agrega
CREATE INDEX idx_agrega_codigo_barras ON agrega(cod_barra_producto);

EXPLAIN ANALYZE
SELECT
    p.cod_barra,
    p.nombre_producto,
    COALESCE(COUNT(a.folio_orden), 0) AS total_ventas
FROM
    producto p
LEFT JOIN
    agrega a ON p.cod_barra = a.cod_barra_producto
GROUP BY
    p.cod_barra, p.nombre_producto
ORDER BY
    total_ventas DESC;


EXPLAIN ANALYZE
SELECT
    p.cod_barra,
    p.nombre_producto,
    COALESCE(SUM(a.cantidad_producto), 0) AS total_ventas
FROM
    producto p
LEFT JOIN
    agrega a ON p.cod_barra = a.cod_barra_producto
GROUP BY
    p.cod_barra, p.nombre_producto
ORDER BY
    total_ventas DESC;


------ VISTAS FACTURA -------
CREATE VIEW vista_factura AS 
SELECT
    c.rfc AS rfc_cliente,
    c.nombre AS nombre_cliente,
    c.ap_pat AS apellido_paterno_cliente,
    c.ap_mat AS apellido_materno_cliente,
    c.email AS email_cliente,
    c.fecha_nacimiento AS fecha_nacimiento_cliente,
    c.razon_social AS razon_social_cliente,
    c.calle AS calle_cliente,
    c.numero_domicilio AS numero_domicilio_cliente,
    c.colonia AS colonia_cliente,
    c.cod_postal AS cod_postal_cliente,
    c.estado AS estado_cliente,
    o.folio AS folio_orden,
    o.fecha_y_hora AS fecha_y_hora_orden,
    o.cantidad_a_pagar AS cantidad_a_pagar_orden,
    o.num_empleado_empleado_mesero AS num_empleado_mesero_orden,
    a.cod_barra_producto,
    a.cantidad_producto,
    a.total_por_pagar
FROM
    cliente c
JOIN
    orden o ON c.rfc = o.rfc_cliente
JOIN
    agrega a ON o.folio = a.folio_orden;






----------------------------------------
----- FUNCION VISTA FACTURA -----------
CREATE OR REPLACE FUNCTION terminar_y_facturar(rfc_cliente_param varchar, folio_orden_param varchar)
RETURNS TABLE (
    rfc_factura varchar(13),
    nombre_cliente_factura varchar(60),
    apellido_paterno_cliente_factura varchar(60),
    apellido_materno_cliente_factura varchar(60),
    email_cliente_factura text,
    fecha_nacimiento_cliente_factura date,
    razon_social_cliente_factura varchar(100),
    calle_cliente_factura varchar(30),
    numero_domicilio_cliente_factura smallint,
    colonia_cliente_factura varchar(30),
    cod_postal_cliente_factura varchar(5),
    estado_cliente_factura varchar(30),
    folio_facturaorden_factura varchar(7),
    fecha_y_hora_orden_factura timestamp,
    cantidad_a_pagar_orden_factura DECIMAL,
    num_empleado_mesero_orden_factura bigserial,
    cod_barra_producto_factura integer,
    cantidad_producto_factura smallint,
    total_por_pagar_factura DECIMAL
)
AS $$
BEGIN

    RETURN QUERY
    SELECT *
    FROM vista_factura
    WHERE rfc_cliente = rfc_cliente_param
    AND folio_orden = folio_orden_param;

    UPDATE orden 
    SET estado_orden = 'TERMINADA' WHERE folio= folio_orden_param;
    
END;
$$ LANGUAGE plpgsql;







