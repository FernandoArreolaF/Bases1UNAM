-- ============================================================
-- 07_inidices.sql
-- Indice_producto_id
-- Indice_rfc
-- Indice_numEmpleado
-- Indice_rango
-- ============================================================

-- Usaremos index B-tree porque segun lo que investigue es el más versaltil para operaciones de igualdad, rango y ordenamiento
-- Entonces usarmos un index para las llaves foraneas ya que asi aceleraremos los cruces de datos y operaciones de busqueda
-- Tenemos como FK's,que no tengan primary key o unique: 'detalle_orden.producto_id', 'orden.rfc', 'orden.num_empleado' 
-- Creamos los indices respectivos

-- Para producto_id
CREATE INDEX idx_DetalleOrden_producto_id ON DETALLE_ORDEN(producto_id);

-- Para rfc
CREATE INDEX idx_Orden_rfc ON ORDEN(rfc);

-- Para num_empleado
CREATE INDEX idx_Orden_num_empleado ON ORDEN(num_empleado);


-- Y por ultimo hacemos un index para la 'fecha' ya que lo que mando Evans en la funcion de ventas por rango de fechas,
-- se esta usando (como su nombre dice jaja) un rango en 'WHERE fecha >= p_fecha_inicio'. Donde el B-tree es ideal para rangos
-- proque no desordena los valores y sigue un secuencia en su escaneo del limite inferio hasta el superior
-- sin recorrer toda la tabla.
CREATE INDEX idx_orden_fecha ON ORDEN (fecha);




