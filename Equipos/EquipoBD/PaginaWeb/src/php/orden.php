<?php

    // Obtiene el nombre del platillo por medio de ajax
    $platillo = $_POST['platillo'];
    include "conexion.php"; // Reliza la conexion a la base de datos
    
    if(strpos($platillo, "_") !== false){
        $platillo = str_replace("_" ," ", $platillo); 
    } // Revisa el nombre del platillo 
    // Realiza la consulta a la base de datos
    $psql = pg_query($conexion, "SELECT precio FROM platillo_bebida where nombre_platillobebida = '$platillo'");
    $data = array();
    $resultado = pg_fetch_row($psql); // Obtiene el resultado de la consulta
        $data[] = array('Platillo'=>$platillo, 'Precio'=>$resultado); // Forma un array del resultado
    echo json_encode($data); // Convierte el array a json y lo exporta a javascript

?>