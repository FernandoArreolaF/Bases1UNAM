<?php
session_start();
$_SESSION['user']=$usuario;
    header('Location: ../paginas/clientes.php');
    
    $usuario = "papeleria";
    $password ="123456";
    $dbname = "base_pape";
    $port="5432";
    $host="localhost";
    $razon=$_POST['razon'];
    $opcion=$_POST['opcion'];
    $dato=$_POST['dato'];

    $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";

    $conexion=pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());

    $modificar=pg_query($conexion, "UPDATE CLIENTE SET $opcion='$dato' WHERE razon_cliente='$razon'");

    $_SESSION['user']=$usuario;
    $_SESSION['user']= true;
?>