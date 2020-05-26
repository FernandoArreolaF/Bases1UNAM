<?php
    $dbconn = pg_connect("host=localhost port=5432 dbname=armenta user=postgres password=0117 options='--client_encoding=UTF8'");
    if(!$dbconn) {
      echo "Error: No se ha podido conectar a la base de datos\n";
    } else {
      echo "Conexión exitosa\n";
    }

    echo $_POST["numero"];
    echo $_POST["art1"];
echo $_POST["cant1"];
    $numero = $_POST["numero"];
    $art1 = $_POST["art1"];
    $art2 = $_POST["art2"];
    $art3 = $_POST["art3"];
    $cant1 = $_POST["cant1"];
    $cant2 = $_POST["cant2"];
    $cant3 = $_POST["cant3"];
    //$calle="'".$calle."'";
    if($numero == ""){
      $query = "select crear_venta();";
    }else{
      $query = "select crear_venta($numero);";
    }

    $result = pg_query($dbconn, $query) or die('ERROR AL INSERTAR DATOS de venta: ' . pg_last_error());

    //------------------------

    $venta_actual = "SELECT max(A::int) from (select substring(id_venta,6) as A from venta) as B;";
    $result2 = pg_query($dbconn, $venta_actual) or die('ERROR AL INSERTAR DATOS: ' . pg_last_error());
    $valventa = pg_fetch_result($result2,0);
    $valventa2 = "'".'Vent-'.$valventa."'";


    echo $valventa2;
    echo $art1;
    echo $cant1;

          function agregar_producto($dbconn,$articulo,$cantidad,$venta){

              $checkquery = "SELECT stock from inventario where cod_barras = $articulo;";
              $result1 = pg_query($dbconn, $checkquery) or die('ERROR AL INSERTAR DATOS: ' . pg_last_error());
              $val = pg_fetch_result($result1,0);
              $valstock = $val - $cantidad;
              if($valstock>0){
                    $query1 = "select agregar_prod($venta,$articulo,$cantidad);";
                    $result1 = pg_query($dbconn, $query1);
                }else {
                  echo "<br>El articulo ".$articulo. " tiene stock insuficiente <br>";
                }

          }

        agregar_producto($dbconn,$art1,$cant1,$valventa2);
        if ($art2 != ""){agregar_producto($dbconn,$art2,$cant2,$valventa2);}
        if ($art3 != ""){agregar_producto($dbconn,$art3,$cant3,$valventa2);}


        $fq = "SELECT * from info_factura($valventa2);";
        $factura = pg_query($dbconn,$fq) or die('ERROR AL obterner DATOS de factura: ' . pg_last_error());
        $fid=pg_fetch_result($factura,0,4);

        if($fid = ""){ }else{
        echo "<br>Datos de FACTURA: <br>";
        echo "<br>Numero de cliente: ". pg_fetch_result($factura,0,0)."<br><br>";
        echo "Nombre: ". pg_fetch_result($factura,0,2)."<br><br>";
        echo "razon social: ". pg_fetch_result($factura,0,1)."<br><br>";
        echo "CP: ". pg_fetch_result($factura,0,3)."<br><br>";
        echo "Numero de venta: ". pg_fetch_result($factura,0,4)."<br><br>";
        echo "Fecha: ". pg_fetch_result($factura,0,5)."<br><br>";
        echo "----------------------------------------Total de la compra: ". pg_fetch_result($factura,0,11)."<br><br>";

        echo "----------------------------------------Desgloce: <br><br> ";
        echo "----------------------------------------Articulo: ". pg_fetch_result($factura,0,6)." Descripcion: ".pg_fetch_result($factura,0,7)." Cantidad: ".pg_fetch_result($factura,0,8)." Subtotal: ".pg_fetch_result($factura,0,9)."<br><br>";
        echo "----------------------------------------Articulo: ". pg_fetch_result($factura,1,6)." Descripcion: ".pg_fetch_result($factura,1,7)." Cantidad: ".pg_fetch_result($factura,1,8)." Subtotal: ".pg_fetch_result($factura,1,9)."<br><br>";
        echo "----------------------------------------Articulo: ". pg_fetch_result($factura,2,6)." Descripcion: ".pg_fetch_result($factura,2,7)." Cantidad: ".pg_fetch_result($factura,2,8)." Subtotal: ".pg_fetch_result($factura,2,9)."<br><br>";
        }
          pg_close($dbconn);
?>

  <br>
  <button onclick="location.href='index.php'">regresar al Menu Principal</button><br><br><br>
