-- Cálculo de precio en TIENE
CREATE OR REPLACE FUNCTION actualizar_precio()
RETURNS TRIGGER AS $$
BEGIN
    NEW.precio = (SELECT precio_articulo FROM articulo WHERE clave_articulo = NEW.clave_articulo_ARTICULO) * NEW.cantidad;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_precio_trigger
BEFORE INSERT OR UPDATE ON TIENE
FOR EACH ROW
EXECUTE FUNCTION actualizar_precio();

--Creacion trigger para actualizar el inventario
CREATE OR REPLACE FUNCTION actualizar_inventario()
RETURNS TRIGGER AS $$
DECLARE
producto_id INT;
cant_actual INTEGER;
BEGIN
-- Obtener los valores del registro insertado
producto_id := NEW.clave_articulo_articulo;
cant_actual := NEW.cantidad;

-- Actualizar el valor de cantidad de INVENTARIO
UPDATE inventario
SET cantidad = cantidad - NEW.cantidad
WHERE cod_barras = (SELECT cod_barras_INVENTARIO FROM ARTICULO WHERE clave_articulo = producto_id);

-- Verificar si el stock llega a cero para abortar la transacción
IF (SELECT cantidad FROM inventario WHERE cod_barras = (SELECT cod_barras_INVENTARIO FROM ARTICULO WHERE clave_articulo = producto_id)) <= 0 THEN
    RAISE EXCEPTION 'El stock ha llegado a cero. La transacción ha sido abortada.';
    RETURN NULL;
END IF;

-- Emitir alerta si el stock es menor o igual a 3
IF (SELECT cantidad FROM inventario WHERE cod_barras = (SELECT cod_barras_INVENTARIO FROM ARTICULO WHERE clave_articulo = producto_id)) <= 3 THEN
    RAISE NOTICE '¡Alerta! Quedan pocas unidades en stock.';
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que ejecuta a la función que actualiza el inventario
CREATE TRIGGER trigger_actualizar_inventario
AFTER INSERT ON TIENE
FOR EACH ROW
EXECUTE FUNCTION actualizar_inventario();

-- Creamos una secuencia para el num_venta
CREATE SEQUENCE num_venta_seq;

-- Creamos una función que nos permitirá respetar el formato que nos dieron: VENT-001
CREATE OR REPLACE FUNCTION generar_id_venta()
RETURNS TRIGGER AS $$
DECLARE
numero INTEGER;
BEGIN
SELECT nextval('num_venta_seq') INTO numero;
NEW.num_venta := 'VENT-' || LPAD(numero::text, 3, '0');
-- LPAD() es para agregar ceros a la izquierda del número generado por la secuencia
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que dispare la función de arriba
CREATE TRIGGER trigger_generar_id_venta
BEFORE INSERT ON public.VENTA
FOR EACH ROW
EXECUTE FUNCTION generar_id_venta();

-- Comprobamos que el trigger funciona:
-- Creamos una venta
INSERT INTO public.VENTA ( num_venta, fecha_venta, total_venta, RFC_cliente_CLIENTE)
VALUES (DEFAULT, now(), 0, 'ROHM880203H45');
-- DEFAULT nos dará el num_venta autoincremental con la estructura definida

-- Mostramos el antes de hacer la compra
SELECT * FROM INVENTARIO;

-- Insert que refleja una venta
INSERT INTO public.TIENE (num_venta_VENTA, clave_articulo_articulo, cantidad)
VALUES ('VENT-001', 1, 2);

-- Mostramos el después de hacer la compra
SELECT * FROM INVENTARIO;
-- Vemos que el stock del primer producto disminuyó en 2

-- Función para actualizar el total de una venta
CREATE OR REPLACE FUNCTION actualizar_total_venta(p_num_venta_venta character varying(20))
RETURNS VOID AS
$$
DECLARE
total MONEY;
BEGIN
-- Obtiene la suma de la cantidad multiplicada por el precio de los registros en la tabla "tiene" que corresponden a la venta dada
SELECT SUM(t.cantidad * t.precio)
INTO total
FROM tiene t
WHERE t.num_venta_venta = p_num_venta_venta;

-- Si no se encontraron registros en la tabla "tiene" para la venta dada, establece el total en cero
IF total IS NULL THEN
total := 0;
END IF;

-- Actualiza el valor de "total_venta" en la tabla "venta" con el total calculado
UPDATE venta
SET total_venta = total
WHERE num_venta = p_num_venta_venta;
END;
$$
LANGUAGE plpgsql;

-- Aquí actualizamos el total para la venta 001
SELECT actualizar_total_venta('VENT-001');

-- Lo probamos de nuevo
-- Creamos una nueva venta
INSERT INTO public.VENTA (num_venta, fecha_venta, total_venta, RFC_cliente_CLIENTE)
VALUES (DEFAULT, now(), 0, 'PEGJ810505A78');

-- Insert donde se vende un artículo
INSERT INTO public.TIENE (num_venta_VENTA, clave_articulo_articulo, cantidad)
VALUES ('VENT-002', 1, 1);

-- Actualizamos el total de venta 002
SELECT actualizar_total_venta('VENT-002');

-- Creación vista
CREATE VIEW vista_factura AS
SELECT
    V.num_venta AS num_factura,
    V.fecha_venta AS fecha,
    C.RFC_cliente AS rfc_cliente,
    C.nombre_cliente AS nombre_cliente,
    C.ap_pat_cliente || ' ' || C.ap_Mat_cliente AS apellidos_cliente,
    C.calle_cliente || ', ' || C.num_cliente AS direccion_cliente,
    CP.estado_cliente AS estado_cliente,
    CP.colonia_cliente AS colonia_cliente,
    A.clave_articulo AS clave_articulo,
    A.descripcion_articulo AS descripcion_articulo,
    A.marca_articulo AS marca_articulo,
    T.cantidad AS cantidad,
    A.precio_articulo AS precio_unitario,
    T.precio AS precio_total
FROM
    public.VENTA V
    JOIN public.CLIENTE C ON V.RFC_cliente_CLIENTE = C.RFC_cliente
    JOIN public.CP_CLIENTE CP ON C.CP_cliente_CP_CLIENTE = CP.CP_cliente
    JOIN public.TIENE T ON V.num_venta = T.num_venta_VENTA
    JOIN public.ARTICULO A ON T.clave_articulo_ARTICULO = A.clave_articulo;

-- Mostramos vista_factura
SELECT * FROM vista_factura;

-- Dado una fecha de inicio y una de fin, mostrar la ganancia total y la cantidad total
SELECT
    SUM(T.cantidad) AS Cantidad_total,
    SUM((T.cantidad * A.precio_articulo) - (P.precio_compra * T.cantidad)) AS Ganancia_total
FROM
    public.TIENE T
    JOIN public.ARTICULO A ON T.clave_articulo_ARTICULO = A.clave_articulo
    JOIN public.PROVEE P ON A.cod_barras_INVENTARIO = P.cod_barras_INVENTARIO
    JOIN public.VENTA V ON T.num_venta_VENTA = V.num_venta
WHERE
    V.fecha_venta >= '2023-01-01' AND V.fecha_venta <= '2023-06-30';

-- Prueba al intentar quedar 3 en stock
INSERT INTO public.TIENE (num_venta_VENTA, clave_articulo_articulo, cantidad)
VALUES ('VENT-002', 3, 13);
-- Muestra alerta de poco stock

-- Prueba al pedir más de lo que existe en stock
INSERT INTO public.TIENE (num_venta_VENTA, clave_articulo_articulo, cantidad)
VALUES ('VENT-002', 4, 11);
-- Muestra alerta sin stock

--Al recibir el codigo de barras mostrar la utilidad
SELECT V.num_venta, ((A.precio_articulo - P.precio_compra) * T.cantidad) AS utilidad
FROM TIENE T
JOIN ARTICULO A ON T.clave_articulo_articulo = A.clave_articulo
JOIN PROVEE P ON A.cod_barras_INVENTARIO = P.cod_barras_INVENTARIO
JOIN venta v ON T.num_venta_venta = V.num_venta
WHERE A.cod_barras_INVENTARIO = '123456789012';

-- Creación de indice
CREATE INDEX idx_marca_articulo ON public.ARTICULO (marca_articulo);

-- Comprobamos la existencia del índice en nuestra base de datos con el siguiente comando:
-- \di public.idx_marca_articulo
