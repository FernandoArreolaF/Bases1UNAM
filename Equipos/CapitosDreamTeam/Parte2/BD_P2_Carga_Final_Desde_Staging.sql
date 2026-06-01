-- ============================================================
-- Proyecto Final BD Grupo 01
-- Equipo: CapitosDreamTeam
--
-- Script PgSQL - Parte 2
-- Procedimiento para pasar datos desde tablas staging hacia las
-- tablas finales del modelo relacional.
--
-- Flujo general:
-- 1. Validar registros cargados desde archivos.
-- 2. Registrar errores en log_carga.
-- 3. Insertar únicamente datos válidos en las tablas finales.
-- 4. Respetar dependencias entre tablas:
--      ORDEN -> DETALLE_ORDEN -> FACTURA
--
-- Nota:
-- Los triggers de la Parte 1 se encargan de calcular:
-- - precioTotalProducto en DETALLE_ORDEN
-- - totalAPagar en ORDEN
-- - actualización de cantidadDisponible en PRODUCTO
-- ============================================================


CREATE OR REPLACE PROCEDURE cargar_staging_a_tablas_finales()
LANGUAGE plpgsql
AS $$
DECLARE
    v_ordenes_insertadas INTEGER := 0;
    v_detalles_insertados INTEGER := 0;
    v_facturas_insertadas INTEGER := 0;

BEGIN

    -- ========================================================
    -- 1. VALIDACIONES PARA STAGING_ORDEN
    -- ========================================================

    -- Validar campos obligatorios en órdenes
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(archivoOrigen, 'ordenes_dia.csv'),
        'orden',
        'ERROR',
        'Orden rechazada. Existen campos obligatorios nulos en el folio: ' || COALESCE(folio, 'SIN_FOLIO')
    FROM staging_orden
    WHERE folio IS NULL
       OR fechaOrden IS NULL
       OR numeroEmpleado IS NULL;


    -- Validar formato del folio
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(archivoOrigen, 'ordenes_dia.csv'),
        'orden',
        'ERROR',
        'Orden rechazada. El folio no cumple el formato ORD-0000: ' || folio
    FROM staging_orden
    WHERE folio IS NOT NULL
      AND folio !~ '^ORD-[0-9]{4}$';


    -- Validar que el empleado sea mesero
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(s.archivoOrigen, 'ordenes_dia.csv'),
        'orden',
        'ERROR',
        'Orden rechazada. El empleado ' || s.numeroEmpleado || ' no existe o no está registrado como mesero.'
    FROM staging_orden s
    WHERE s.numeroEmpleado IS NOT NULL
      AND NOT EXISTS (
          SELECT 1
          FROM mesero m
          WHERE m.numeroEmpleado = s.numeroEmpleado
      );


    -- Validar que la orden no exista previamente
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(s.archivoOrigen, 'ordenes_dia.csv'),
        'orden',
        'ERROR',
        'Orden rechazada. El folio ya existe en la tabla ORDEN: ' || s.folio
    FROM staging_orden s
    WHERE EXISTS (
        SELECT 1
        FROM orden o
        WHERE o.folio = s.folio
    );


    -- ========================================================
    -- 2. INSERTAR ÓRDENES VÁLIDAS
    -- ========================================================

    INSERT INTO orden(folio, fechaOrden, numeroEmpleado)
    SELECT
        s.folio,
        s.fechaOrden,
        s.numeroEmpleado
    FROM staging_orden s
    WHERE s.folio IS NOT NULL
      AND s.fechaOrden IS NOT NULL
      AND s.numeroEmpleado IS NOT NULL
      AND s.folio ~ '^ORD-[0-9]{4}$'
      AND EXISTS (
          SELECT 1
          FROM mesero m
          WHERE m.numeroEmpleado = s.numeroEmpleado
      )
      AND NOT EXISTS (
          SELECT 1
          FROM orden o
          WHERE o.folio = s.folio
      );

    GET DIAGNOSTICS v_ordenes_insertadas = ROW_COUNT;

    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    VALUES (
        'ordenes_dia.csv',
        'orden',
        'OK',
        'Carga de órdenes finalizada. Registros insertados: ' || v_ordenes_insertadas
    );


    -- ========================================================
    -- 3. VALIDACIONES PARA STAGING_DETALLE_ORDEN
    -- ========================================================

    -- Validar campos obligatorios en detalle de orden
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(archivoOrigen, 'detalle_orden_dia.csv'),
        'detalle_orden',
        'ERROR',
        'Detalle rechazado. Existen campos obligatorios nulos en el folio: ' || COALESCE(folio, 'SIN_FOLIO')
    FROM staging_detalle_orden
    WHERE folio IS NULL
       OR idProducto IS NULL
       OR cantidad IS NULL;


    -- Validar que la cantidad sea positiva
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(archivoOrigen, 'detalle_orden_dia.csv'),
        'detalle_orden',
        'ERROR',
        'Detalle rechazado. La cantidad debe ser mayor que cero. Folio: ' || folio || ', producto: ' || idProducto
    FROM staging_detalle_orden
    WHERE cantidad IS NOT NULL
      AND cantidad <= 0;


    -- Validar que la orden exista
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(s.archivoOrigen, 'detalle_orden_dia.csv'),
        'detalle_orden',
        'ERROR',
        'Detalle rechazado. La orden no existe en la tabla ORDEN. Folio: ' || s.folio
    FROM staging_detalle_orden s
    WHERE s.folio IS NOT NULL
      AND NOT EXISTS (
          SELECT 1
          FROM orden o
          WHERE o.folio = s.folio
      );


    -- Validar que el producto exista
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(s.archivoOrigen, 'detalle_orden_dia.csv'),
        'detalle_orden',
        'ERROR',
        'Detalle rechazado. El producto no existe. idProducto: ' || s.idProducto
    FROM staging_detalle_orden s
    WHERE s.idProducto IS NOT NULL
      AND NOT EXISTS (
          SELECT 1
          FROM producto p
          WHERE p.idProducto = s.idProducto
      );


    -- Validar que no exista ya el mismo producto dentro de la misma orden
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(s.archivoOrigen, 'detalle_orden_dia.csv'),
        'detalle_orden',
        'ERROR',
        'Detalle rechazado. Ya existe el producto ' || s.idProducto || ' en la orden ' || s.folio
    FROM staging_detalle_orden s
    WHERE EXISTS (
        SELECT 1
        FROM detalle_orden d
        WHERE d.folio = s.folio
          AND d.idProducto = s.idProducto
    );


    -- Validar disponibilidad considerando la suma total solicitada por producto
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        'detalle_orden_dia.csv',
        'detalle_orden',
        'ERROR',
        'Detalle rechazado. La cantidad solicitada del producto ' || p.idProducto ||
        ' supera la existencia disponible. Solicitado: ' || sp.cantidad_solicitada ||
        ', disponible: ' || p.cantidadDisponible
    FROM (
        SELECT idProducto, SUM(cantidad) AS cantidad_solicitada
        FROM staging_detalle_orden
        WHERE idProducto IS NOT NULL
          AND cantidad IS NOT NULL
          AND cantidad > 0
        GROUP BY idProducto
    ) sp
    JOIN producto p ON p.idProducto = sp.idProducto
    WHERE sp.cantidad_solicitada > p.cantidadDisponible;


    -- ========================================================
    -- 4. INSERTAR DETALLES VÁLIDOS
    -- ========================================================

    WITH solicitud_producto AS (
        SELECT idProducto, SUM(cantidad) AS cantidad_solicitada
        FROM staging_detalle_orden
        WHERE idProducto IS NOT NULL
          AND cantidad IS NOT NULL
          AND cantidad > 0
        GROUP BY idProducto
    )
    INSERT INTO detalle_orden(folio, idProducto, cantidad)
    SELECT
        s.folio,
        s.idProducto,
        s.cantidad
    FROM staging_detalle_orden s
    JOIN producto p
        ON p.idProducto = s.idProducto
    JOIN solicitud_producto sp
        ON sp.idProducto = s.idProducto
    WHERE s.folio IS NOT NULL
      AND s.idProducto IS NOT NULL
      AND s.cantidad IS NOT NULL
      AND s.cantidad > 0
      AND EXISTS (
          SELECT 1
          FROM orden o
          WHERE o.folio = s.folio
      )
      AND NOT EXISTS (
          SELECT 1
          FROM detalle_orden d
          WHERE d.folio = s.folio
            AND d.idProducto = s.idProducto
      )
      AND sp.cantidad_solicitada <= p.cantidadDisponible;

    GET DIAGNOSTICS v_detalles_insertados = ROW_COUNT;

    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    VALUES (
        'detalle_orden_dia.csv',
        'detalle_orden',
        'OK',
        'Carga de detalles finalizada. Registros insertados: ' || v_detalles_insertados
    );


    -- ========================================================
    -- 5. VALIDACIONES PARA STAGING_FACTURA
    -- ========================================================

    -- Validar campos obligatorios en factura
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(archivoOrigen, 'facturas_dia.csv'),
        'factura',
        'ERROR',
        'Factura rechazada. Existen campos obligatorios nulos en el folio: ' || COALESCE(folio, 'SIN_FOLIO')
    FROM staging_factura
    WHERE fechaFactura IS NULL
       OR folio IS NULL
       OR idCliente IS NULL;


    -- Validar que la orden exista
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(s.archivoOrigen, 'facturas_dia.csv'),
        'factura',
        'ERROR',
        'Factura rechazada. La orden no existe. Folio: ' || s.folio
    FROM staging_factura s
    WHERE s.folio IS NOT NULL
      AND NOT EXISTS (
          SELECT 1
          FROM orden o
          WHERE o.folio = s.folio
      );


    -- Validar que el cliente exista
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(s.archivoOrigen, 'facturas_dia.csv'),
        'factura',
        'ERROR',
        'Factura rechazada. El cliente no existe. idCliente: ' || s.idCliente
    FROM staging_factura s
    WHERE s.idCliente IS NOT NULL
      AND NOT EXISTS (
          SELECT 1
          FROM cliente c
          WHERE c.idCliente = s.idCliente
      );


    -- Validar que no exista ya una factura para la misma orden
    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    SELECT
        COALESCE(s.archivoOrigen, 'facturas_dia.csv'),
        'factura',
        'ERROR',
        'Factura rechazada. Ya existe una factura para la orden: ' || s.folio
    FROM staging_factura s
    WHERE EXISTS (
        SELECT 1
        FROM factura f
        WHERE f.folio = s.folio
    );


    -- ========================================================
    -- 6. INSERTAR FACTURAS VÁLIDAS
    -- ========================================================

    INSERT INTO factura(fechaFactura, folio, idCliente)
    SELECT
        s.fechaFactura,
        s.folio,
        s.idCliente
    FROM staging_factura s
    WHERE s.fechaFactura IS NOT NULL
      AND s.folio IS NOT NULL
      AND s.idCliente IS NOT NULL
      AND EXISTS (
          SELECT 1
          FROM orden o
          WHERE o.folio = s.folio
      )
      AND EXISTS (
          SELECT 1
          FROM cliente c
          WHERE c.idCliente = s.idCliente
      )
      AND NOT EXISTS (
          SELECT 1
          FROM factura f
          WHERE f.folio = s.folio
      );

    GET DIAGNOSTICS v_facturas_insertadas = ROW_COUNT;

    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    VALUES (
        'facturas_dia.csv',
        'factura',
        'OK',
        'Carga de facturas finalizada. Registros insertados: ' || v_facturas_insertadas
    );


    -- ========================================================
    -- 7. REGISTRO GENERAL DEL PROCESO
    -- ========================================================

    INSERT INTO log_carga(nombreArchivo, tablaDestino, estatus, mensajeError)
    VALUES (
        'proceso_carga_diaria',
        'general',
        'OK',
        'Proceso de carga desde staging finalizado correctamente.'
    );

END;
$$;