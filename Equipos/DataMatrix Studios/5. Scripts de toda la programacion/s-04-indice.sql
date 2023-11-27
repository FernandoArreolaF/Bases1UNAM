--@Autor: DataMatrix Studios
--@Fecha creación:  2023
--@Descripción: Crear al menos, un índice, del tipo que se prefiera y donde se prefiera.
--              Justificar el porqué de la elección en ambos aspectos.

--
-- Indice para Empleado
--

CREATE INDEX rfc_empleado_idx ON EMPLEADO(RFC);

--
-- Indice para Cliente
--

CREATE INDEX rfc_cliente_idx ON CLIENTE(RFC_cliente);