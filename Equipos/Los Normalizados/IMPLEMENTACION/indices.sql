/* ============================================================
   ÍNDICE PARA CONSULTAS POR FECHA DE ORDEN
   En este script se implementa un índice sobre la tabla orden, esto 
   para optimizar las consultas que filtran ventas por fecha o por
   rango de fechas.
   ============================================================ */

DROP INDEX IF EXISTS idx_orden_fecha;

CREATE INDEX idx_orden_fecha
ON orden(fecha);

