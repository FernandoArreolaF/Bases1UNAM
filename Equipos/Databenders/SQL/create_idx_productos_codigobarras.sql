-- ========================================
-- Script: create_idx_productos_codigobarras.sql
-- Descripción:
-- Crea un índice B-tree en la columna 'codigobarras' de la tabla 'productos'
-- para optimizar las consultas que buscan productos por su código de barras.
-- ========================================

-- Crear el índice B-tree en 'codigobarras' de la tabla 'productos'
CREATE INDEX idx_productos_codigobarras
ON productos (codigobarras);

-- ========================================
-- Justificación Breve
-- ========================================

-- El índice B-tree en 'codigobarras' mejora la eficiencia de las consultas
-- que buscan productos específicos por su código de barras, especialmente
-- en funciones como 'obtener_utilidad_producto'. Dado que 'codigobarras' es
-- una columna frecuentemente utilizada y altamente selectiva, el índice
-- optimiza el tiempo de respuesta y reduce el costo de ejecución de las
-- consultas.
