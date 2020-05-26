<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MY WEBSITE PAGE</title>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.17/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.17/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function(e) {
    $("#date").datepicker();
});
</script>
</head>


<body>

  <?php
      $dbconn = pg_connect("host=localhost port=5432 dbname=armenta user=postgres password=0117 options='--client_encoding=UTF8'");
        if(!$dbconn) {
        echo "Error: No se ha podido conectar a la base de datos\n";
      } else {
        echo "Conexión exitosa\n";
      }

      $result = pg_query($dbconn, "SELECT cp FROM regiones");


  ?>


    <form action="agregar_cliente_handler.php" method="post">
      Name: <input type="text" name="name" required><br>
      E-mail: <input type="text" name="email" required><br>
      Razon Social: <input type="text" name="rs" required><br>
      Calle:  <input type="text"  name="calle" required><br>
      Numero: <input type="number" min="0" name ="num" required><br>
      CP: <input type="number" min="0" name ="cp" required><br>

        <input type="submit">
    </form>



</body>
</html>
