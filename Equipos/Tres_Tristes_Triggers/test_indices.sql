-- ============================================================
-- test_indices.sql
-- Casos de prueba para los índices del sistema de restaurante
-- Proyecto Final BD - Grupo 01
-- PostgreSQL
-- ============================================================
-- INSTRUCCIONES:
-- Ejecutar DESPUES de: 01_ddl_creacion_tablas.sql,
--                      02_secuencias.sql,
--                      03_triggers.sql,
--                      04_funcion_folio.sql,
--			            05_funciones_consulta,
--                      06_vistas.sql,
--                      07_indices.sql
-- Este script es INDEPENDIENTE, no necesita ejecutar ningun
-- otro archivo para poner datos solo se necesitan las tablas.
-- ============================================================


-- ------------------------------------------------------------
-- LIMPIEZA PREVIA
-- Borra datos anteriores para que el script sea re-ejecutable
-- ------------------------------------------------------------
DELETE FROM DETALLE_ORDEN;
DELETE FROM ORDEN;
DELETE FROM CLIENTE_FACT;
DELETE FROM PLATILLO;
DELETE FROM BEBIDA;
DELETE FROM PRODUCTO;
DELETE FROM CATEGORIA;
DELETE FROM MESERO;
DELETE FROM EMPLEADO;

-- Reiniciar secuencias para que los IDs arranquen desde 1
ALTER SEQUENCE folio_seq        RESTART WITH 1;
ALTER SEQUENCE categoria_id_seq RESTART WITH 1;
ALTER SEQUENCE producto_id_seq  RESTART WITH 1;


-- ------------------------------------------------------------
-- DATOS BASE
-- ------------------------------------------------------------

-- Categoria
INSERT INTO CATEGORIA (categoria_id, nombre, descripcion)
VALUES (nextval('categoria_id_seq'), 'Comida mexicana', 'Platillos tipicos mexicanos');

-- Empleado
INSERT INTO EMPLEADO (num_empleado, nombre_pila, apellido_paterno, apellido_materno,
    rfc, fecha_nacimiento, edad, sueldo, estado, codigo_postal, colonia, calle, numero)
VALUES ('EMP-001', 'Juan', 'Garcia', 'Lopez',
    'GALJ900101ABC', '1990-01-01', 34, 8000.00,
    'CDMX', '06600', 'Juarez', 'Reforma', '100');

-- Mesero (subtipo de EMPLEADO)
INSERT INTO MESERO (num_empleado, horario)
VALUES ('EMP-001', 'Lunes a Viernes 08:00-16:00');

-- Productos
INSERT INTO PRODUCTO (producto_id, nombre, descripcion, precio, disponibilidad, receta, categoria_id, tipo)
VALUES
    (nextval('producto_id_seq'), 'Tacos de pastor',   'Tacos con carne al pastor',  85.00, TRUE,  'Carne de cerdo marinada con achiote', 1, 'platillo'),
    (nextval('producto_id_seq'), 'Agua de jamaica',   'Bebida de flor de jamaica',  25.00, TRUE,  'Flor de jamaica, agua, azucar',       1, 'bebida'),
    (nextval('producto_id_seq'), 'Enchiladas verdes', 'Enchiladas con salsa verde', 95.00, FALSE, 'Tortillas, salsa verde, pollo',       1, 'platillo');

-- Subtipos de PRODUCTO
INSERT INTO PLATILLO (producto_id) VALUES (1); -- Tacos de pastor
INSERT INTO BEBIDA   (producto_id) VALUES (2); -- Agua de jamaica
INSERT INTO PLATILLO (producto_id) VALUES (3); -- Enchiladas verdes

-- Cliente que solicita factura
INSERT INTO CLIENTE_FACT (rfc, nombre_cliente, apellido_paterno, apellido_materno,
    fecha_nacimiento, email, estado, codigo_postal, colonia, numero, calle, razon_social)
VALUES ('MELM900215XYZ', 'Maria', 'Mendoza', 'Luna',
    '1990-02-15', 'maria.mendoza@email.com',
    'CDMX', '06600', 'Juarez', '200', 'Insurgentes',
    'Tacos El Pastor S.A. de C.V.');

-- Orden CON factura (rfc NOT NULL) este debe aparecer en vista_factura
-- El trigger asigna automaticamente el folio ORD-001
INSERT INTO ORDEN (fecha, hora, num_empleado, rfc)
VALUES (CURRENT_DATE, CURRENT_TIME, 'EMP-001', 'MELM900215XYZ');

-- Detalle de ORD-001 con factura
INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad, precio_platillo)
VALUES ('ORD-001', 1, 3, 0);  -- 3 tacos de pastor a $85 = $255

INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad, precio_platillo)
VALUES ('ORD-001', 2, 2, 0);  -- 2 aguas de jamaica a $25 = $50

-- Orden SIN factura (rfc NULL) este NO debe aparecer en vista_factura
-- El trigger asigna automaticamente el folio ORD-002
INSERT INTO ORDEN (fecha, hora, num_empleado)
VALUES (CURRENT_DATE, CURRENT_TIME, 'EMP-001');

-- Detalle de ORD-002 sin factura
INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad, precio_platillo)
VALUES ('ORD-002', 1, 1, 0);  -- 1 taco de pastor a $85 = $85

-- ============================================================
-- PRUEBAS DE ÍNDICES
-- ============================================================
-- Se uza SET enable_seqscan = OFF, para forzar el uso del indice
-- ya que estamos usando pocos datos

SET enable_seqscan = OFF;

-- ============================================================
-- PRUEBA 1: idx_DetalleOrden_producto_id
-- Agrupacion por producto para obtener el mas vendido
-- ============================================================
EXPLAIN ANALYZE
SELECT producto_id, SUM(cantidad) AS total_vendido
FROM DETALLE_ORDEN
GROUP BY producto_id
ORDER BY total_vendido DESC;
-- Buscar: Index Scan using idx_DetalleOrden_producto_id on detalle_orden

-- ============================================================
-- PRUEBA 2: idx_Orden_rfc
-- Filtro de ordenes con rfc no nulo
-- ============================================================
EXPLAIN ANALYZE
SELECT folio, rfc
FROM ORDEN
WHERE rfc IS NOT NULL;
-- Buscar: Index Scan using idx_Orden_rfc on orden

-- ============================================================
-- PRUEBA 3: idx_Orden_num_empleado
-- ============================================================
EXPLAIN ANALYZE
SELECT COUNT(folio), COALESCE(SUM(total), 0)
FROM ORDEN
WHERE num_empleado = 'EMP-001';
-- Buscar: Bitmap Index Scan on idx_Orden_num_empleado

-- ============================================================
-- PRUEBA 4: idx_orden_fecha
-- Búsqueda por rango de fechas
-- ============================================================
EXPLAIN ANALYZE
SELECT COUNT(folio), COALESCE(SUM(total), 0)
FROM ORDEN
WHERE fecha >= '2025-01-01'
  AND fecha <= '2025-12-31';
-- Buscar: Index Scan using idx_orden_fecha on orden

-- ============================================================
-- PRUEBA 5: Confirmar que los 4 indices existen en la BD
-- ============================================================
SELECT
    indexname   AS indice,
    tablename   AS tabla
FROM pg_indexes
WHERE schemaname = 'public'
  AND indexname IN (
      'idx_detalleorden_producto_id',
      'idx_orden_rfc',
      'idx_orden_num_empleado',
      'idx_orden_fecha'
  )
ORDER BY tablename, indexname;
-- Resultado esperado: 4 filas, una por cada indice
