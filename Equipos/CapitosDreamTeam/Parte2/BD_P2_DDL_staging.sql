-- ============================================================
-- Proyecto Final BD Grupo 01
-- Equipo: CapitosDreamTeam
--
-- Script DDL - Parte 2
-- Creación de tablas auxiliares para carga diaria desde archivos
-- mediante Pentaho Data Integration / Spoon.
--
-- Estas tablas no sustituyen a las tablas finales del modelo.
-- Funcionan como una zona intermedia de carga, donde primero se
-- depositan los datos leídos desde archivos CSV/TXT antes de
-- insertarlos en las tablas reales de la base de datos.
-- ============================================================


-- ============================================================
-- Tabla: staging_orden
--
-- Propósito:
-- Almacenar temporalmente las órdenes leídas desde el archivo
-- de texto correspondiente al día de operación.
--
-- Posteriormente, los registros válidos de esta tabla se insertan
-- en la tabla final ORDEN.
-- ============================================================

CREATE TABLE IF NOT EXISTS staging_orden (
    folio VARCHAR(15),
    fechaOrden TIMESTAMP,
    numeroEmpleado INTEGER,
    archivoOrigen VARCHAR(100),
    fechaCarga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- Tabla: staging_detalle_orden
--
-- Propósito:
-- Almacenar temporalmente los productos contenidos en cada orden.
--
-- Cada registro representa un producto solicitado dentro de una
-- orden específica. Después de validar que la orden exista, que el
-- producto exista y que la cantidad sea válida, estos datos se
-- insertan en DETALLE_ORDEN.
-- ============================================================

CREATE TABLE IF NOT EXISTS staging_detalle_orden (
    folio VARCHAR(15),
    idProducto SMALLINT,
    cantidad INTEGER,
    archivoOrigen VARCHAR(100),
    fechaCarga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- Tabla: staging_factura
--
-- Propósito:
-- Almacenar temporalmente las facturas solicitadas durante el día.
--
-- Antes de insertar en la tabla final FACTURA, se valida que la
-- orden exista y que el cliente exista.
-- ============================================================

CREATE TABLE IF NOT EXISTS staging_factura (
    fechaFactura TIMESTAMP,
    folio VARCHAR(15),
    idCliente INTEGER,
    archivoOrigen VARCHAR(100),
    fechaCarga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- Tabla: log_carga
--
-- Propósito:
-- Registrar el resultado del proceso de carga.
--
-- Permite guardar errores de validación, inserciones exitosas y
-- mensajes generales del flujo ETL. Esta tabla sirve como evidencia
-- de la orquestación y control de errores solicitados en la parte 2.
-- ============================================================

CREATE TABLE IF NOT EXISTS log_carga (
    idLog SERIAL PRIMARY KEY,
    nombreArchivo VARCHAR(100),
    tablaDestino VARCHAR(50),
    estatus VARCHAR(20),
    mensajeError TEXT,
    fechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);