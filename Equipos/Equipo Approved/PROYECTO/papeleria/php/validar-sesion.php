<?php

    $usuario = $_POST["usuario"];
    $password = $_POST["pass"];
    $dbname = "base_pape";
    $port="5432";
    $host="localhost";

    $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";

    $conexion = pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());
    

    

    $row=pg_query($conexion,"select * from USUARIO where usuario_pape='$usuario' and password='$password' ");
    session_start();
    $_SESSION['user']=$usuario;
    $_SESSION['user']= true;

    if(pg_fetch_array($row)>0){
        header("Location:../paginas/home.php");

    }
    else{
        echo "Ocurri&oacute; un error! ".pg_last_error();
    }
    
?>