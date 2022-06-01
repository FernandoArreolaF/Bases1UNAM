<?php

    include "conexion.php"; // Realiza la conexion a la base de datos

    // Obtiene los diferentes datos del platillo por medio de ajax
    $platillo = $_POST['platillo'];
    $cantidad = $_POST['cantidad'];
    $precio = $_POST['precio'];
    $total = $_POST['total'];
    $empleado = $_POST['empleado'];
    $cliente = $_POST['cliente'];
    $indice = count($platillo);

    // REaliza la consulta para obtener el numero del empleado
    $consulta_empleado = pg_query($conexion, "SELECT num_empleado FROM empleado WHERE nombre = '$empleado'"); 
    $num_empleado_array = pg_fetch_row($consulta_empleado);
    $num_empleado = (int)$num_empleado_array[0];

    // Reliza una consulta para obtener el rfc del cliente
    $consulta_cliente = pg_query($conexion, "SELECT rfc_cliente FROM cliente WHERE nombre = '$cliente'"); 
    $rfc_cliente_array = pg_fetch_row($consulta_cliente);
    $rfc_cliente = $rfc_cliente_array[0];
    
    // Genera el nuevo folio de la orden
    $psql = pg_query($conexion, "SELECT folio FROM orden ORDER BY folio DESC LIMIT 1");
    $folio = pg_fetch_row($psql);
    $folio_numero = explode("-", $folio[0]);
    $numero = (int)$folio_numero[1];
    $nuevo_numero = $numero + 1;
    if (strlen($nuevo_numero) == 1){
        $nuevo_folio = "ORD-00".$nuevo_numero;
    }elseif(strlen($nuevo_numero) == 2){
        $nuevo_folio = "ORD-0".$nuevo_numero;
    }else{
        $nuevo_folio = "ORD-".$nuevo_numero;
    }

    // Insert en tabla orden
    $insert_orden = "INSERT INTO orden (folio, num_empleado, rfc_cliente, total) values ('$nuevo_folio','$num_empleado','$rfc_cliente',0)";
    $resultado = pg_query($conexion, $insert_orden);

    // Insert en tabla enlista
    for ($i = 0; $i < $indice; $i++){
        $insert_enlista = "INSERT INTO enlista values ('$nuevo_folio', '$platillo[$i]', '$cantidad[$i]','$precio[$i]')";
        $resultado = pg_query($conexion, $insert_enlista);
    }
    // mensaje de confirmación para javascript
    $confirmacion = "OK";
    echo json_encode($confirmacion);
?>