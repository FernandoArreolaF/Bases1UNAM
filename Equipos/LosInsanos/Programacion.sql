/* 
 Código de la programacion en la bd
 Fecha: 29/05/2026   
*/
/*
 PUNTO 1
 Cada que se agregue un producto a la orden, debe actualizarse los totales
 (por producto y venta), así como validar que el producto esté disponible
*/
--Funcion para el trigger
CREATE OR REPLACE FUNCTION fn_validar_producto_orden()
RETURNS TRIGGER AS $$
DECLARE
    v_disponibilidad CHAR(1);
    v_precio NUMERIC(8,2);
BEGIN
    --Obtener disponibilidad y precio del producto
    SELECT disponibilidad, precio
    INTO v_disponibilidad, v_precio
    FROM PRODUCTO
    WHERE id_producto = NEW.id_producto;

    --Validar que el producto esté disponible
    IF v_disponibilidad <> 'S' THEN
        RAISE EXCEPTION 'El producto % no está disponible.', NEW.id_producto;
    END IF;

    --Calcular el total por producto y sobreescribir el valor que venga en el INSERT
    NEW.total_por_producto := v_precio * NEW.cantidad_producto;

    --Actualizar el total general en la tabla ORDEN
    UPDATE ORDEN 
    SET total_pagar = total_pagar + NEW.total_por_producto
    WHERE folio = NEW.folio;

    RETURN NEW;  --Continúa con el INSERT usando los valores modificados
END;
$$ LANGUAGE plpgsql;

--Trigger en ORDEN_PRODUCTO
CREATE OR REPLACE TRIGGER trg_antes_agregar_producto
BEFORE INSERT ON ORDEN_PRODUCTO
FOR EACH ROW
EXECUTE FUNCTION fn_validar_producto_orden();

/*
   PUNTO 2
   Crear al menos, un índice, del tipo que se prefiera y donde se prefiera.
    Justificar el porqué de la elección en ambos aspectos.
*/

CREATE INDEX idx_orden_fecha_hora 
ON ORDEN (fecha_hora);

/*
   JUSTIFICACIÓN DE LA ELECCIÓN:
   
   1. ¿POR QUÉ EN ESTA TABLA Y COLUMNA (LUGAR)?
      - Optimización de Funciones de Reporteo: en nuestro sistema, la tabla 'ORDEN' es la que
        presenta mayor crecimiento transaccional. La columna 'fecha_hora' es bastante utilizada 
		por dos de nuestras funciones críticas:
          * fn_ordenes_del_dia: realiza un filtrado diario empleando 'CURRENT_DATE'.
          * fn_ventas_por_periodo: realiza escaneos por rangos mediante la cláusula 'BETWEEN'.
      - Evitar Escaneos Secuenciales: sin este índice, cada vez que el gerente o el 
        sistema solicita las ventas de un rango de fechas, PostgreSQL a realiza 
        un escaneo completo de la tabla de arriba a abajo. Al indexar 'fecha_hora', la búsqueda
        pasa de una complejidad temporal lineal O(N) a una logarítmica O(log N).

   2. ¿POR QUÉ ESTE TIPO DE ÍNDICE?
      - En PostgreSQL, el comando 'CREATE INDEX'crea por defecto una estructura de árbol 
	  	balanceado. Este tipo de índice es el único para optimizar consultas que involucren 
		los operadores '<', '<=', '=', '>=', '>' y,en nuestro caso, 'BETWEEN'.
      - Los nodos del B-Tree almacenan los datos de forma ordenada, lo que permite al 
	    planificador de consultas de PostgreSQL realizar un "Index Scan" o un "Index Only 
		Scan" para recuperar los folios de las órdenes dentro de cualquier ventana de tiempo
		seleccionada.
*/

-- Prueba
-- SELECT * FROM ORDEN WHERE fecha_hora BETWEEN '2026-05-30 00:00:00' AND '2026-05-30 23:59:59';

/*
   PUNTO 3
   Dado un número de empleado, mostrar la cantidad
   de órdenes registradas en el día y el total pagado.
   Si no es mesero, mostrar mensaje de error.
*/
CREATE OR REPLACE FUNCTION fn_ordenes_del_dia(p_numero_empleado NUMERIC)
RETURNS TABLE (
    cantidad_ordenes BIGINT,
    total_pagado NUMERIC(10,2)
) AS $$
DECLARE
    v_es_mesero INT;
BEGIN
    -- Verificar si el empleado es mesero
    SELECT COUNT(*)
    INTO v_es_mesero
    FROM MESERO
    WHERE numero_empleado = p_numero_empleado;

    IF v_es_mesero = 0 THEN
        RAISE EXCEPTION 'El empleado % no es un mesero', p_numero_empleado;
    END IF;

    -- Retornar conteo y suma de órdenes del día
    RETURN QUERY
        SELECT COUNT(folio),
               CASE 
                   WHEN SUM(total_pagar) IS NULL THEN 0 
                   ELSE SUM(total_pagar) 
               END
        FROM ORDEN
        WHERE numero_empleado = p_numero_empleado
          AND DATE(fecha_hora) = CURRENT_DATE;
END;
$$ LANGUAGE plpgsql;

-- Modo de uso:
-- SELECT * FROM fn_ordenes_del_dia(1000000001);

/*
   PUNTO 4
   Todos los detalles del platillo más vendido.
*/
CREATE OR REPLACE VIEW vista_platillo_mas_vendido AS
    SELECT p.id_producto,
        p.nombre_producto,
        p.disponibilidad,
        p.precio,
        p.receta,
        p.descripcion_producto,
        c.id_categoria,
        c.nombre_categoria,
        c.descripcion_categoria,
        ventas.total_vendido
    FROM PRODUCTO p
    JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
    JOIN (
               SELECT id_producto, SUM(cantidad_producto) AS total_vendido
               FROM ORDEN_PRODUCTO
               GROUP BY id_producto
           ) AS ventas ON ventas.id_producto = p.id_producto
		   WHERE ventas.total_vendido = (
		   --Busca el valor máximo absoluto vendido
		   	 SELECT MAX(total) 
			 FROM (SELECT SUM(cantidad_producto) AS total 
			 FROM ORDEN_PRODUCTO 
			 GROUP BY id_producto) AS sub_totales
);

-- Modo de uso:
-- SELECT * FROM vista_platillo_mas_vendido;

/*
   PUNTO 5
   Obtener el nombre de los productos no disponibles.
*/
CREATE OR REPLACE FUNCTION fn_productos_no_disponibles()
RETURNS TABLE (nombre_producto VARCHAR) AS $$
BEGIN
    RETURN QUERY
        SELECT p.nombre_producto
        FROM PRODUCTO p
        WHERE p.disponibilidad <> 'S';
END;
$$ LANGUAGE plpgsql;

-- Modo de uso:
-- SELECT * FROM fn_productos_no_disponibles();

/*
   PUNTO 6
   De manera automática se genere una vista 
   que contenga información necesaria para 
   asemejarse a una factura de una orden
*/
CREATE OR REPLACE VIEW vista_factura AS
    SELECT
        --Datos de la orden
        o.folio,
        o.fecha_hora,
        --Datos del cliente
        o.rfc_cliente,
        cl.nombre_cl AS nombre_cliente,
        cl.apellido_paterno_cl,
        cl.apellido_materno_cl,
        cl.email AS email_cliente,
        --Datos del mesero
        o.numero_empleado,
        e.nombre_emp AS nombre_mesero,
        e.apellido_paterno_emp,
        --Detalle de productos en la orden
        op.id_producto,
        p.nombre_producto,
        op.cantidad_producto,
        p.precio              AS precio_unitario,
        op.total_por_producto,
        --Total de la orden
        o.total_pagar
    FROM ORDEN o
    LEFT JOIN CLIENTE cl ON cl.rfc_cliente = o.rfc_cliente
    JOIN EMPLEADO e ON e.numero_empleado = o.numero_empleado
    JOIN ORDEN_PRODUCTO op ON op.folio = o.folio
    JOIN PRODUCTO p ON p.id_producto = op.id_producto;

-- Modo de uso (factura de una orden específica):
-- SELECT * FROM vista_factura WHERE folio = 'ORD001';
/*
   PUNTO 7
   Función: Dada una fecha, o un rango de fechas, retornar
   el total de ventas y el monto total en ese período.
*/

CREATE OR REPLACE FUNCTION fn_ventas_por_periodo(
    p_fecha_inicio DATE,
    p_fecha_fin DATE DEFAULT NULL
)
RETURNS TABLE(
    numero_de_ventas BIGINT,
    monto_total NUMERIC(12,2)
) AS $$
BEGIN
    --Si no se recibe fecha de fin, se evalúa un solo día
    IF p_fecha_fin IS NULL THEN
        p_fecha_fin := p_fecha_inicio;
    END IF;

    --Retornar conteo y suma 
    RETURN QUERY
        SELECT COUNT(folio),
               CASE 
                   WHEN SUM(total_pagar) IS NULL THEN 0.00
                   ELSE SUM(total_pagar)
               END
        FROM ORDEN
        WHERE DATE(fecha_hora) BETWEEN p_fecha_inicio AND p_fecha_fin;
END;
$$ LANGUAGE plpgsql;
-- Modo de uso:
-- SELECT * FROM fn_ventas_por_periodo('2026-05-01', '2026-05-29');


/* ========================================================
   PARTE DOS - INSERCIÓN DESDE TXT
   ======================================================== */


-- Tabla para almacenar los errores de validación de la carga diaria
CREATE TABLE IF NOT EXISTS LOG_ERRORES_CARGA (
    id_error            SERIAL PRIMARY KEY,
    fecha_error         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    folio_afectado      VARCHAR(10),
    descripcion_error   TEXT,
    contexto_error      TEXT
);


CREATE OR REPLACE PROCEDURE pr_cargar_ordenes_desde_txt(p_ruta_archivo TEXT)
LANGUAGE plpgsql AS $$
DECLARE
    v_registro RECORD;
    v_fecha TIMESTAMP;
    v_total NUMERIC(10,2);
    v_rfc VARCHAR(13);
    v_empleado NUMERIC;
    
    -- Variables para capturar los errores
    v_error_msg TEXT;
    v_error_context TEXT;
    v_num_linea INT := 0;
BEGIN
    -- Crear una tabla de staging (tránsito) temporal para romper las líneas del archivo
    -- Usamos un esquema temporal para que no interfiera con otros procesos
    CREATE TEMPORARY TABLE IF NOT EXISTS staging_txt_lineas (
        linea_completa TEXT
    ) ON COMMIT DROP;
    
    
    TRUNCATE TABLE staging_txt_lineas;

    BEGIN
        -- Importar el archivo de la ruta introducida a la tabla temporal
        EXECUTE format('COPY staging_txt_lineas FROM %L WITH (FORMAT text);', p_ruta_archivo);
        RAISE NOTICE 'Archivo cargado a la tabla temporal exitosamente.';
    EXCEPTION WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS v_error_msg = MESSAGE_TEXT;
        INSERT INTO LOG_ERRORES_CARGA (folio_afectado, descripcion_error)
        VALUES ('SISTEMA', 'Error de acceso a la ruta física: ' || v_error_msg);
        RAISE EXCEPTION 'No se pudo leer el archivo en la ruta especificada: %', v_error_msg;
    END;

    -- Recorrer las líneas importadas para procesar los datos e insertar
    FOR v_registro IN 
        SELECT regexp_split_to_array(linea_completa, ',') AS datos FROM staging_txt_lineas
    LOOP
        v_num_linea := v_num_linea + 1;

        BEGIN
            v_fecha    := trim(v_registro.datos[1])::TIMESTAMP;
            v_total    := trim(v_registro.datos[2])::NUMERIC;
            v_rfc      := trim(v_registro.datos[3]);
            v_empleado := trim(v_registro.datos[4])::NUMERIC;

            INSERT INTO ORDEN (fecha_hora, total_pagar, rfc_cliente, numero_empleado)
            VALUES (v_fecha, v_total, v_rfc, v_empleado);
            
            COMMIT;

        EXCEPTION WHEN OTHERS THEN
            -- Capturar la excepción exacta del motor de la base de datos
            GET STACKED DIAGNOSTICS 
                v_error_msg = MESSAGE_TEXT,
                v_error_context = PG_EXCEPTION_CONTEXT;
            
            -- Reportar a la bitácora histórica el número de renglón del TXT que venía defectuoso
            INSERT INTO LOG_ERRORES_CARGA (folio_afectado, descripcion_error, contexto_error)
            VALUES ('LÍNEA TXT ' || v_num_linea, v_error_msg, v_error_context);
            
            RAISE WARNING 'Línea % rechazada y enviada a la bitácora de errores.', v_num_linea;
            
            ROLLBACK;
        END;
    END LOOP;
    
    RAISE NOTICE 'Orquestación finalizada. Carga concluida.';
END;
$$;

--Ejecución
--CALL pr_cargar_ordenes_desde_txt('ruta\ordenes_prueba.txt');
