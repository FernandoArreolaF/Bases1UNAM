-- ============================================================
-- test_funciones.sql
-- SQL para probar las funciones de consulta
-- Proyecto Final BD - Grupo 01
-- PostgreSQL
-- ============================================================
-- INSTRUCCIONES:
-- Este archivo es autocontenido: limpia e inserta sus propios
-- datos de prueba, por lo que puede ejecutarse de forma
-- independiente sin depender del estado de pruebas anteriores.
-- ============================================================
-- Limpieza para pruebas sin colisiones.
DELETE FROM DETALLE_ORDEN;
DELETE FROM ORDEN;
DELETE FROM PLATILLO;
DELETE FROM BEBIDA;
DELETE FROM PRODUCTO;
DELETE FROM MESERO;
DELETE FROM EMPLEADO;
DELETE FROM CATEGORIA;

-- Reiniciamos secuencias
SELECT setval('folio_seq',        1, false);
SELECT setval('producto_id_seq',  1, false);
SELECT setval('categoria_id_seq', 1, false);
SELECT setval('dependiente_id_seq', 1, false);
-- ============================================================
-- Agregamos Categoria
INSERT INTO CATEGORIA (categoria_id, nombre, descripcion)
VALUES (nextval('categoria_id_seq'), 'Comida mexicana', 'Platillos tipicos mexicanos');
 
-- Insertamos Empleado 
INSERT INTO EMPLEADO (
    num_empleado, nombre_pila, apellido_paterno, apellido_materno,
    rfc, fecha_nacimiento, edad, sueldo,
    estado, codigo_postal, colonia, calle, numero
)
VALUES (
    'EMP-001', 'Juan', 'Garcia', 'Lopez',
    'GALJ900101ABC', '1990-01-01', 34, 8000.00,
    'CDMX', '06600', 'Juarez', 'Reforma', '100'
);
 
-- Le asignamos Rol de mesero
INSERT INTO MESERO (num_empleado, horario)
VALUES ('EMP-001', 'Lunes a Viernes 08:00-16:00');
 
-- Productos (1 = tacos, 2 = agua)
INSERT INTO PRODUCTO (producto_id, nombre, descripcion, precio, disponibilidad, receta, categoria_id, tipo)
VALUES
    (nextval('producto_id_seq'), 'Tacos de pastor', 'Tacos con carne al pastor', 85.00, TRUE,  'Carne de cerdo marinada...', 1, 'platillo'),
    (nextval('producto_id_seq'), 'Agua de jamaica', 'Bebida de flor de jamaica',  25.00, TRUE,  'Flor de jamaica, agua, azucar...', 1, 'bebida');
 
INSERT INTO PLATILLO (producto_id) VALUES (1);
INSERT INTO BEBIDA   (producto_id) VALUES (2);
 
-- Orden del dia validando también trigger de la creación de ORD-001
INSERT INTO ORDEN (fecha, hora, num_empleado)
VALUES (CURRENT_DATE, CURRENT_TIME, 'EMP-001');
 
-- Detalles de la orden:
--   2 tacos de pastor: 2 x $85 = $170
--   1 agua de jamaica: 1 x $25 =  $25
--   Total esperado: $195.00
-- El trigger fn_insertar_detalle_orden calcula precio_platillo automaticamente

INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad, precio_platillo)
VALUES ('ORD-001', 1, 2, 0);
 
INSERT INTO DETALLE_ORDEN (folio, producto_id, cantidad, precio_platillo)
VALUES ('ORD-001', 2, 1, 0);
-- ============================================================
-- PRUEBA PARA LA FUNCIÓN ordenes_mesero_hoy
-- Se espera que lance un error "Error: El empleado con número EMP-999 no es un mesero válido."
DO $$
BEGIN
    -- Perform para no guardar el resultado
    PERFORM * FROM ordenes_mesero_hoy('EMP-999');
    RAISE NOTICE 'ERROR: La función dejó pasar al empleado falso.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Prueba pasada: el sistema bloqueó al mesero falso correctamente.';
END;
$$;

--Se espera que devuelva tabla con una orden y $195.00 de total cobrado
SELECT * FROM ordenes_mesero_hoy('EMP-001');


-- ============================================================
-- PRUEBA PARA LA FUNCIÓN ventas_por_fechas
-- Se espera que se devuelva el total de ventas del día de hoy.
SELECT * FROM ventas_por_fechas(CURRENT_DATE);

-- Se espera que devuelva el acumulado de todo el mes de mayo.
SELECT * FROM ventas_por_fechas('2026-05-01', '2026-05-31');
