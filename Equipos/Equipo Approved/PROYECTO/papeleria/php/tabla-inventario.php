<?php

    $usuario = "papeleria";
    $password ="123456";
    $dbname = "base_pape";
    $port="5432";
    $host="localhost";
    $codigo = $_POST["codigo"];

    $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";

    $conexion=pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());
    
    $funcion = "vista_informacion('$codigo')";

    $tabla=pg_query($conexion, "SELECT * from $funcion");
	echo $tabla;
?>