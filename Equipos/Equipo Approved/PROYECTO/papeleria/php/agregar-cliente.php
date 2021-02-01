<?php
    session_start();
    $_SESSION['user']=$usuario;
        header('Location: ../paginas/clientes.php');
        
        $usuario = "papeleria";
        $password ="123456";
        $dbname = "base_pape";
        $port="5432";
        $host="localhost";
        $nombre=$_POST['nombre'];
        $ap_P=$_POST['ap-pat'];
        $ap_mat=$_POST['ap-mat'];
        $razon=$_POST['razon'];
        $cal=$_POST['calle'];
        $num=$_POST['numero-casa'];
        $col=$_POST['colonia'];
        $cp=$_POST['Codpostal'];
        $estado=$_POST['estado'];

        $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";

        $conexion=pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());
        

        $agregar=pg_query($conexion, "INSERT INTO CLIENTE VALUES('$razon','$ap_P','$ap_mat','$nombre','$col','$estado','$cal','$cp',$num)");
        $_SESSION['user']=$usuario;
        $_SESSION['user']= true;

?>