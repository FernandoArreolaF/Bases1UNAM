<?php
    session_start();
        header('Location: ../paginas/clientes.php');
        $usuario = "papeleria";
        $password ="123456";
        $dbname = "base_pape";
        $port="5432";
        $host="localhost";
        $razon=$_POST['razon'];

        $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";

        $conexion=pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());
        $borrar="DELETE FROM CLIENTE WHERE razon_cliente='$razon'";
        $agregar=pg_query($conexion, $borrar);


?>