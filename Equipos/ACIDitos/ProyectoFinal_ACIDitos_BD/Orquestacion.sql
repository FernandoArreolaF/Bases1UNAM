-- ========================================================
-- TABLAS FIJAS O DE CATÁLOGO
-- Estas tablas no dependen directamente del día.
-- Se copian completas porque sirven como base para las relaciones
-- y para que no fallen las llaves foráneas en la otra base.
-- =========================================================

-- Exporta todos los empleados a empleado.csv
\copy empleado TO 'C:/Users/atlew/ProyectoBases/empleado.csv' WITH CSV HEADER;

-- Exporta los empleados que son cocineros
\copy cocinero TO 'C:/Users/atlew/ProyectoBases/cocinero.csv' WITH CSV HEADER;

-- Exporta los empleados que son meseros
\copy mesero TO 'C:/Users/atlew/ProyectoBases/mesero.csv' WITH CSV HEADER;

-- Exporta los empleados administrativos
\copy administrativo TO 'C:/Users/atlew/ProyectoBases/administrativo.csv' WITH CSV HEADER;

-- Exporta los teléfonos de los empleados
\copy telefono TO 'C:/Users/atlew/ProyectoBases/telefono.csv' WITH CSV HEADER;

-- Exporta los dependientes de los empleados
\copy dependiente TO 'C:/Users/atlew/ProyectoBases/dependiente.csv' WITH CSV HEADER;

-- Exporta las categorías de productos
\copy categoria TO 'C:/Users/atlew/ProyectoBases/categoria.csv' WITH CSV HEADER;

-- Exporta todos los productos del restaurante
\copy producto TO 'C:/Users/atlew/ProyectoBases/producto.csv' WITH CSV HEADER;

-- Exporta todos los clientes registrados
\copy cliente TO 'C:/Users/atlew/ProyectoBases/cliente.csv' WITH CSV HEADER;


-- =========================================================
-- TABLAS DE DÍA
-- Estas tablas sí se filtran por fecha, porque representan
-- la operación diaria del restaurante.
-- =========================================================

-- Exporta únicamente las órdenes registradas el día actual
\copy (SELECT * FROM orden WHERE DATE(fecha_hora) = CURRENT_DATE) TO 'C:/Users/atlew/ProyectoBases/ordenes_dia.csv' WITH CSV HEADER;

-- Exporta únicamente los detalles de las órdenes del día actual
-- Se une historial_orden con orden porque historial_orden no tiene fecha_hora
\copy (SELECT h.* FROM historial_orden h INNER JOIN orden o ON h.folio_orden = o.folio_orden WHERE DATE(o.fecha_hora) = CURRENT_DATE) TO 'C:/Users/atlew/ProyectoBases/historial_orden_dia.csv' WITH CSV HEADER;

-- Exporta únicamente las facturas asociadas a órdenes del día actual
\copy (SELECT f.* FROM factura f INNER JOIN orden o ON f.folio_orden = o.folio_orden WHERE DATE(o.fecha_hora) = CURRENT_DATE) TO 'C:/Users/atlew/ProyectoBases/facturas_dia.csv' WITH CSV HEADER;


-- =========================================================
-- EN LA OTRA BASE
-- Aquí ya se trabaja en la base destino.
-- Primero se crean las tablas y la programación de la base.
-- =========================================================

-- Ejecuta el archivo donde están las tablas, PK, FK y restricciones
\i 'C:/Users/atlew/ProyectoBases/Tablas.sql'

-- Ejecuta el archivo donde están funciones, triggers, vistas e índices
\i 'C:/Users/atlew/ProyectoBases/Programacion.sql'


-- =========================================================
-- CARGA DE DATOS CON TABLAS TEMPORALES
-- La idea es:
-- 1. Crear una tabla temporal igual a la tabla real.
-- 2. Cargar el CSV en la tabla temporal.
-- 3. Insertar en la tabla real evitando duplicados.
-- ON CONFLICT DO NOTHING evita errores si el registro ya existe.
-- =========================================================


-- =======================
-- Carga de empleado
-- =======================

-- Crea una tabla temporal con la misma estructura de empleado, pero sin datos
CREATE TEMP TABLE tmp_empleado AS SELECT * FROM empleado WITH NO DATA;

-- Carga el archivo CSV en la tabla temporal
\copy tmp_empleado FROM 'C:/Users/atlew/ProyectoBases/empleado.csv' WITH CSV HEADER;

-- Inserta en empleado solo los registros que no estén repetidos
INSERT INTO empleado SELECT * FROM tmp_empleado ON CONFLICT DO NOTHING;


-- =======================
-- Carga de cocinero
-- =======================

CREATE TEMP TABLE tmp_cocinero AS SELECT * FROM cocinero WITH NO DATA;
\copy tmp_cocinero FROM 'C:/Users/atlew/ProyectoBases/cocinero.csv' WITH CSV HEADER;
INSERT INTO cocinero SELECT * FROM tmp_cocinero ON CONFLICT DO NOTHING;


-- =======================
-- Carga de mesero
-- =======================

CREATE TEMP TABLE tmp_mesero AS SELECT * FROM mesero WITH NO DATA;
\copy tmp_mesero FROM 'C:/Users/atlew/ProyectoBases/mesero.csv' WITH CSV HEADER;
INSERT INTO mesero SELECT * FROM tmp_mesero ON CONFLICT DO NOTHING;


-- =======================
-- Carga de administrativo
-- =======================

CREATE TEMP TABLE tmp_administrativo AS SELECT * FROM administrativo WITH NO DATA;
\copy tmp_administrativo FROM 'C:/Users/atlew/ProyectoBases/administrativo.csv' WITH CSV HEADER;
INSERT INTO administrativo SELECT * FROM tmp_administrativo ON CONFLICT DO NOTHING;


-- =======================
-- Carga de telefono
-- =======================

CREATE TEMP TABLE tmp_telefono AS SELECT * FROM telefono WITH NO DATA;
\copy tmp_telefono FROM 'C:/Users/atlew/ProyectoBases/telefono.csv' WITH CSV HEADER;
INSERT INTO telefono SELECT * FROM tmp_telefono ON CONFLICT DO NOTHING;


-- =======================
-- Carga de dependiente
-- =======================

CREATE TEMP TABLE tmp_dependiente AS SELECT * FROM dependiente WITH NO DATA;
\copy tmp_dependiente FROM 'C:/Users/atlew/ProyectoBases/dependiente.csv' WITH CSV HEADER;
INSERT INTO dependiente SELECT * FROM tmp_dependiente ON CONFLICT DO NOTHING;


-- =======================
-- Carga de categoria
-- =======================

CREATE TEMP TABLE tmp_categoria AS SELECT * FROM categoria WITH NO DATA;
\copy tmp_categoria FROM 'C:/Users/atlew/ProyectoBases/categoria.csv' WITH CSV HEADER;
INSERT INTO categoria SELECT * FROM tmp_categoria ON CONFLICT DO NOTHING;


-- =======================
-- Carga de producto
-- =======================

CREATE TEMP TABLE tmp_producto AS SELECT * FROM producto WITH NO DATA;
\copy tmp_producto FROM 'C:/Users/atlew/ProyectoBases/producto.csv' WITH CSV HEADER;
INSERT INTO producto SELECT * FROM tmp_producto ON CONFLICT DO NOTHING;


-- =======================
-- Carga de cliente
-- =======================

CREATE TEMP TABLE tmp_cliente AS SELECT * FROM cliente WITH NO DATA;
\copy tmp_cliente FROM 'C:/Users/atlew/ProyectoBases/cliente.csv' WITH CSV HEADER;
INSERT INTO cliente SELECT * FROM tmp_cliente ON CONFLICT DO NOTHING;


-- =========================================================
-- CARGA DE TABLAS DE DÍA
-- Estas tablas representan la operación del día:
-- órdenes, historial de órdenes y facturas.
-- =========================================================


-- =======================
-- Carga de orden
-- =======================

CREATE TEMP TABLE tmp_orden AS SELECT * FROM orden WITH NO DATA;
\copy tmp_orden FROM 'C:/Users/atlew/ProyectoBases/ordenes_dia.csv' WITH CSV HEADER;
INSERT INTO orden SELECT * FROM tmp_orden ON CONFLICT DO NOTHING;


-- =======================
-- Carga de historial_orden
-- =======================

CREATE TEMP TABLE tmp_historial_orden AS SELECT * FROM historial_orden WITH NO DATA;
\copy tmp_historial_orden FROM 'C:/Users/atlew/ProyectoBases/historial_orden_dia.csv' WITH CSV HEADER;
INSERT INTO historial_orden SELECT * FROM tmp_historial_orden ON CONFLICT DO NOTHING;


-- =======================
-- Carga de factura
-- =======================

CREATE TEMP TABLE tmp_factura AS SELECT * FROM factura WITH NO DATA;
\copy tmp_factura FROM 'C:/Users/atlew/ProyectoBases/facturas_dia.csv' WITH CSV HEADER;
INSERT INTO factura SELECT * FROM tmp_factura ON CONFLICT DO NOTHING;


-- =========================================================
-- AJUSTE DE SECUENCIAS
-- Después de importar datos desde CSV, las secuencias SERIAL
-- no se actualizan automáticamente.
-- Por eso se ajustan al valor máximo existente en cada tabla.
-- Así el siguiente registro insertado continúa con el número correcto.
-- =========================================================

-- Ajusta la secuencia de empleado al último id_empleado existente
SELECT setval('empleado_id_empleado_seq', (SELECT MAX(id_empleado) FROM empleado));

-- Ajusta la secuencia de telefono al último id_telefono existente
SELECT setval('telefono_id_telefono_seq', (SELECT MAX(id_telefono) FROM telefono));

-- Ajusta la secuencia de categoria al último id_categoria existente
SELECT setval('categoria_id_categoria_seq', (SELECT MAX(id_categoria) FROM categoria));

-- Ajusta la secuencia de producto al último id_producto existente
SELECT setval('producto_id_producto_seq', (SELECT MAX(id_producto) FROM producto));

-- Ajusta la secuencia de historial_orden al último id_detalle existente
SELECT setval('historial_orden_id_detalle_seq', (SELECT MAX(id_detalle) FROM historial_orden));

-- Ajusta la secuencia de factura al último id_factura existente
SELECT setval('factura_id_factura_seq', (SELECT MAX(id_factura) FROM factura));


-- =========================================================
-- AJUSTE DE SECUENCIA DEL FOLIO DE ORDEN
-- Esta secuencia controla los folios tipo ORD-001, ORD-002, etc.
-- SUBSTRING(folio_orden FROM 5) obtiene la parte numérica.
-- Por ejemplo, de ORD-005 obtiene 005.
-- Luego CAST lo convierte a número.
-- =========================================================

SELECT setval('seq_folio_orden', (SELECT MAX(CAST(SUBSTRING(folio_orden FROM 5) AS INT)) FROM orden));