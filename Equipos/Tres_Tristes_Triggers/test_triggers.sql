-- ============================================================
-- test_triggers.sql
-- Casos de prueba para los triggers del sistema de restaurante
-- Proyecto Final BD - Grupo 01
-- PostgreSQL
-- ============================================================
-- INSTRUCCIONES:
-- Ejecutar DESPUES de: 01_ddl_creacion_tablas.sql,
--                      02_secuencias.sql,
--                      04_funcion_folio.sql,
--                      03_triggers.sql
-- ============================================================


-- ------------------------------------------------------------
-- DATOS BASE PARA LAS PRUEBAS hehco con ia pues para pruebas
-- ------------------------------------------------------------

-- Categoria de prueba
INSERT INTO CATEGORIA (categoria_id, nombre, descripcion)
VALUES (nextval('categoria_id_seq'), 'Comida mexicana', 'Platillos tipicos mexicanos');

-- Empleado de prueba
INSERT INTO EMPLEADO (num_empleado, nombre_pila, apellido_paterno, apellido_materno,
    rfc, fecha_nacimiento, edad, sueldo, estado, codigo_postal, colonia, calle, numero)
VALUES ('EMP-001', 'Juan', 'Garcia', 'Lopez',
    'GALJ900101ABC', '1990-01-01', 34, 8000.00,
    'CDMX', '06600', 'Juarez', 'Reforma', '100');

-- Mesero de prueba
INSERT INTO MESERO (num_empleado, horario)
VALUES ('EMP-001', 'Lunes a Viernes 08:00-16:00');

-- Productos de prueba
INSERT INTO PRODUCTO (producto_id, nombre, descripcion, precio, disponibilidad, receta, categoria_id, tipo)
VALUES
    (nextval('producto_id_seq'), 'Tacos de pastor',  'Tacos con carne al pastor', 85.00, TRUE,  'Carne de cerdo marinada...', 1, 'platillo'),
    (nextval('producto_id_seq'), 'Agua de jamaica',  'Bebida de flor de jamaica',  25.00, TRUE,  'Flor de jamaica, agua, azucar...', 1, 'bebida'),
    (nextval('producto_id_seq'), 'Enchiladas verdes','Enchiladas con salsa verde', 95.00, FALSE, 'Tortillas, salsa verde...', 1, 'platillo');

INSERT INTO PLATILLO (producto_id) VALUES (1);
INSERT INTO BEBIDA   (producto_id) VALUES (2);
INSERT INTO PLATILLO (producto_id) VALUES (3);


-- ============================================================
-- PRUEBA 1: Generacion automatica de folio
-- Se espera que el folio sea asignado automaticamente (ORD-001)
-- ============================================================
INSERT INTO ORDEN (fecha, hora, num_empleado)
VALUES (CURRENT_DATE, CURRENT_TIME, 'EMP-001');

-- Verificar folio generado
SELECT folio, fecha, hora, total FROM ORDEN;
-- Resultado esperado: folio = 'ORD-001', total = 0.00


-- ============================================================
-- PRUEBA 2: Insertar producto disponible en DETALLE_ORDEN
-- Se espera que precio_platillo = cantidad x precio
-- y que el total de la orden se actualice
-- ============================================================
INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad, precio_platillo)
VALUES ('ORD-001', 1, 2, 0);  -- 2 tacos de pastor a $85 c/u = $170

-- Verificar subtotal y total
SELECT * FROM DETALLE_ORDEN WHERE folio = 'ORD-001';
-- Resultado esperado: precio_platillo = 170.00

SELECT folio, total FROM ORDEN WHERE folio = 'ORD-001';
-- Resultado esperado: total = 170.00


-- ============================================================
-- PRUEBA 3: Agregar segundo producto a la orden
-- Total debe acumularse: $170 + $25 = $195
-- ============================================================
INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad, precio_platillo)
VALUES ('ORD-001', 2, 1, 0);  -- 1 agua de jamaica a $25 = $25

SELECT folio, total FROM ORDEN WHERE folio = 'ORD-001';
-- Resultado esperado: total = 195.00


-- ============================================================
-- PRUEBA 4: Actualizar cantidad de un producto en la orden
-- Cambiar tacos de 2 a 3 unidades: $255 + $25 = $280
-- ============================================================
UPDATE DETALLE_ORDEN
SET cantidad = 3
WHERE folio = 'ORD-001' AND producto_id = 1;

SELECT * FROM DETALLE_ORDEN WHERE folio = 'ORD-001';
-- Resultado esperado: precio_platillo de tacos = 255.00

SELECT folio, total FROM ORDEN WHERE folio = 'ORD-001';
-- Resultado esperado: total = 280.00


-- ============================================================
-- PRUEBA 5: Eliminar un producto de la orden
-- Eliminar agua de jamaica: total debe quedar en $255
-- ============================================================
DELETE FROM DETALLE_ORDEN
WHERE folio = 'ORD-001' AND producto_id = 2;

SELECT folio, total FROM ORDEN WHERE folio = 'ORD-001';
-- Resultado esperado: total = 255.00


-- ============================================================
-- PRUEBA 6: Insertar producto NO disponible
-- Se espera un EXCEPTION con mensaje descriptivo
-- ============================================================
DO $$
BEGIN
    INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad, precio_platillo)
    VALUES ('ORD-001', 3, 1, 0);  -- Enchiladas verdes: disponibilidad = FALSE

    RAISE NOTICE 'ERROR: El trigger no lanzo la excepcion esperada';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'OK: Excepcion capturada correctamente -> %', SQLERRM;
END;
$$;
-- Resultado esperado: NOTICE con mensaje de producto no disponible


-- ============================================================
-- PRUEBA 7: Segunda orden genera folio ORD-002
-- ============================================================
INSERT INTO ORDEN (fecha, hora, num_empleado)
VALUES (CURRENT_DATE, CURRENT_TIME, 'EMP-001');

SELECT folio FROM ORDEN ORDER BY folio;
-- Resultado esperado: ORD-001 y ORD-002


-- ------------------------------------------------------------
-- LIMPIEZA DE DATOS DE PRUEBA (opcional, comentar si no se desea)
-- ------------------------------------------------------------
-- DELETE FROM DETALLE_ORDEN;
-- DELETE FROM ORDEN;
-- DELETE FROM PLATILLO;
-- DELETE FROM BEBIDA;
-- DELETE FROM PRODUCTO;
-- DELETE FROM MESERO;
-- DELETE FROM EMPLEADO;
-- DELETE FROM CATEGORIA;
-- SELECT setval('folio_seq', 1, false);

