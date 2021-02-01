<?php
    session_start();
    $_SESSION['user']=$usuario;
        header('Location: ../paginas/ventas.php');

    $usuario = "papeleria";
    $password ="123456";
    $dbname = "base_pape";
    $port="5432";
    $host="localhost";
    $codigo = $_POST["codigo"];
    $producto = $_POST["producto"];
    $marca = $_POST["marca"];
    $cantidad = $_POST["cantidad"];
    $fecha = $_POST["fecha"];
    $numero=$_POST['numero'];

    $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";

    $conexion=pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());
    
    $id_producto=pg_query($conexion,"SELECT id_producto FROM PRODUCTO where nombre='$producto");

    $precio=pg_query($conexion, "SELECT precio_venta FROM PRODUCTO where nombre='$producto'");

    $total=$precio * $cantidad;
    $insertar= "INSERT INTO ORDEN_VENTA(fecha_venta,razon_cliente) values('fecha','codigo')";
    $funcion = "INSERT INTO ORDEN_DETALLE(No_venta,id_producto,cantidad_articulo,precio_venta_producto,total_pagar) values($numero, $id_producto, $cantidad, $precio, $total)";

    $_SESSION['user']=$usuario;
    $_SESSION['user']= true;
?>