<?php
// Obtiene el empleado el nombre del empleado por medio de ajax
    $empleado =  $_POST['empleado'];
    include "conexion.php"; // Realiza la conexion a la base de datos

    // Realiza la consulta a la base de datos
    $psql = pg_query($conexion, "SELECT * FROM empleado where nombre = '$empleado'");
    $data = array();
    $resultado = pg_fetch_row($psql); // Obtiene los datos de la consulta
        $num_empleado = $resultado[0];
        $nombre = $resultado[1]." ".$resultado[2]." ".$resultado[3];
        $rfc = $resultado[4];
        $fechaNac = $resultado[5];
        $edad = $resultado[6];
        $estado = $resultado[7];
        $cp = $resultado[8];
        $colonia = $resultado[9];
        $calle = $resultado[10];
        $num_calle = $resultado[11];
        $sueldo = $resultado[12];
        $foto = pg_unescape_bytea($resultado[13]);
    // forma un array con los datos de la consulta
    $data[] = array('num empleado'=>$num_empleado, 'nombre completo'=>$nombre, 'rfc'=>$rfc, 'fecha nacimiento'=>$fechaNac,'edad'=>$edad, 
                    'estado'=>$estado,'cp'=>$cp,'colonia'=>$colonia,'calle'=>$calle,'num calle'=>$num_calle,'sueldo'=>$sueldo,'foto'=>$foto);
    echo json_encode($data); // Exporta los datos en json y los envia a javascript

?>