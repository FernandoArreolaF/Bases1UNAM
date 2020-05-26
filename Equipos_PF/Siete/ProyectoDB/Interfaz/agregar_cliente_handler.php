<?php
    $dbconn = pg_connect("host=localhost port=5432 dbname=armenta user=postgres password=0117 options='--client_encoding=UTF8'");
    if(!$dbconn) {
      echo "Error: No se ha podido conectar a la base de datos\n";
    } else {
      echo "Conexión exitosa\n";
    }

    $nombre = $_POST["name"];
    $nombre="'".$nombre."'";
    $rs = $_POST["rs"];
    $rs = "'".$rs."'";
    $email = $_POST["email"];
    $email="'".$email."'";
    $calle = $_POST["calle"];
    $calle="'".$calle."'";
    $num = $_POST["num"];
    $cp = $_POST["cp"];

    $query = "INSERT INTO cliente(rs_cliente,nombre_cliente,calle_cliente,num_cliente,cp) VALUES ($rs,$nombre,$calle,$num,$cp);";

    $result = pg_query($dbconn, $query) or die('ERROR AL INSERTAR DATOS: ' . pg_last_error());

    $result3 = pg_query($dbconn, "SELECT max(id_cliente) FROM cliente");

    $val = pg_fetch_result($result3,0);

    $query3 = "INSERT INTO email VALUES ($email,$val);";

    $result4 = pg_query($dbconn, $query3) or die('ERROR AL INSERTAR DATOS: ' . pg_last_error());

    pg_close($dbconn);

?>
  <button onclick="location.href='index.php'">regresar al Menu Principal</button><br><br><br>
