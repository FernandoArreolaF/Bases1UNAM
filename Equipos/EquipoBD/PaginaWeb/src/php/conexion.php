<?php
// Genera la conexion a la base de datos de postgres
include "config.php";

$conexion = pg_connect($post) or die ('No se ha podido conectar');
$stat = pg_connection_status($conexion);
if (!$stat === PGSQL_CONNECTION_OK){
    die("Error de conexion");
}

?>