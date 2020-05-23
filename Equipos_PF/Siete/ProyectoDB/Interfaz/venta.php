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

      $query = "select A.cod_barras, B.descripcion from inventario A join (SELECT cod_barras, descripcion FROM producto_detalles) as B on A.cod_barras = B.cod_barras where A.stock>0";
      $result = pg_query($query);

        //while($row=pg_fetch_array($result)){
          //  echo $row[cod_barras];
          //  echo $row[descripcion];
          //}
         ?>


    <form action="venta_handler.php" method="post">
      Num.Cliente (Puede ir vacio): <input type="number" min=1 name="numero" value=""><br>
      Articulo 1 :<select name="art1">
                      <?php
                      $query = "select A.cod_barras, B.descripcion from inventario A join (SELECT cod_barras, descripcion FROM producto_detalles) as B on A.cod_barras = B.cod_barras where A.stock>0";
                      $result = pg_query($query);
                            while($row=pg_fetch_array($result)){
                                    echo "<option value='".$row['cod_barras']."'>'".$row['descripcion']."'</option>";
                            }
                      ?>
                  </select>
      Cantidad  :  <input type="number" min="1" name ="cant1" required ><br>
      Articulo 2 : <select name="art2">
                            <option value=""></option>
                            <?php
                                  $query = "select A.cod_barras, B.descripcion from inventario A join (SELECT cod_barras, descripcion FROM producto_detalles) as B on A.cod_barras = B.cod_barras where A.stock>0";
                                    $result = pg_query($query);
                                      while($row=pg_fetch_array($result)){
                                        echo "<option value='".$row['cod_barras']."'>'".$row['descripcion']."'</option>";
                                        }
                            ?>
        <option value=""></option>
                  </select>
      Cantidad  :  <input type="number" min="1" name ="cant2" ><br>
      Articulo 3 : <select name="art3">
                        <option value=""></option>
                        <?php
                              $query = "select A.cod_barras, B.descripcion from inventario A join (SELECT cod_barras, descripcion FROM producto_detalles) as B on A.cod_barras = B.cod_barras where A.stock>0";
                                $result = pg_query($query);
                                  while($row=pg_fetch_array($result)){
                                    echo "<option value='".$row['cod_barras']."'>'".$row['descripcion']."'</option>";
                                    }
                        ?>
                  </select>
      Cantidad  :  <input type="number" min="1" name ="cant3" ><br><br>
        <p>PRESIONE PARA COMPLETAR LA VENTA</p>
        <input type="submit">
    </form>

</body>
</html>
