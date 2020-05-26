<!DOCTYPE html>
<html lang="en">

<head>
<title>Proyecto HTML </title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" href="main.css">
</head>
<body>



<br>

<div class="container title">
<strong class="asas"><u><em>VENTAS</em></u></strong><br>


<p>&nbsp;</p>
</div>

<div class="container-fluid">
  <div class="row">
    <div class="col-lg-6">
      <form method="post" action="comparaFechas.php">
          <div class="form-group"><strong>
<div label for="name">VENTAS ENTRE FECHAS</label></strong></div>
            <label for="name"></label>
<div label for="name">formato de fecha = AAAA-MM-DD</label></div>
 <label for="name">Año 1</label>           
            <input id="fecha1"  type="text" name="fecha1" lang="es" maxlength="20" >
<label for="name">Año 2</label>
            <input id="fecha2"  type="text" name="fecha2" lang="es" maxlength="20">

	<class="form-group">
          <button type="submit" class="btn btn-primary" name="reg_user" onclick="comparaFechas.php">Register</button>
          </div>
          </form>

    <form method="post" action="comparafechasola.php">
          <div class="form-group"><strong>
<div label for="name">VENTAS EN UNA FECHA ESPECIFICA</label></strong></div>
            <label for="name"></label>
<div label for="name">formato de fecha = AAAA-MM-DD</label></div>
 <label for="name">Fecha </label>           
            <input id="fechaX"  type="text" name="fechaX" lang="es" maxlength="20" >
<class="form-group">
          <button type="submit" class="btn btn-primary" name="reg_user" onclick="comparafechasola.php">Register</button>
          </div>
          </form>
<form method="post" action="crearOrden.php">
          <div class="form-group"><strong>
<div  label for="name">REGISTRAR NUEVA VENTA</label></strong></div>
 <div label for="idcliente">Id Cliente</label>
            <input id="idcliente"  type="text" name="idcliente" lang="es" >
          </div>
          <div class="form-group">
          
<button type="submit" class="btn btn-primary" name="realizar_compra" onclick="crearOrden.php">Registrar</button>
          </div>
	
        </form>

    </div>
  </div>
</div>

<form method="post" action="agregarcrear.php">
          <div class="form-group"><strong>
<div  label for="name">REALIZAR VENTA</label></strong></div>
            <label for="codbar">Código de Barras</label>
            <input id="codbar"  type="text" name="codbar" lang="es" >
<label for="rsocial">cantidad</label>
            <input id="cp"  type="text" name="cp" lang="es" >
          </div>

<button type="submit" class="btn btn-primary" name="agregar" onclick="agregarcrear.php">Agregar</button>
</form>


<!-- TABLA CREACION VENTA-->
<table border="1" cellspacing=1 cellpadding=2 style="font-size: 8pt"><tr>
<td><font face="verdana"><b>NOMBRE PRODUCTO</b></font></td>
<td><font face="verdana"><b>CANTIDAD ARTICULO</b></font></td>
<td><font face="verdana"><b>SUBTOTAL</b></font></td>
</tr>
<?php

$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

/*tabla de mi venta de tres articulos*/
$sqlVenta="select p.nombreproducto as nombrep,T.cantidadarticulos as cantidad,(p.precioventa * t.cantidadarticulos) as subbtotal from detalle_orden T, producto p where p.codigobarras=T.codigobarras and (select numventa FROM orden ORDER BY numventa desc LIMIT 1)=T.numventa order by nombrep";
$resultVenta=pg_query($sqlVenta);

$sqlNombre="select C.nombrec, numventa from cliente C, orden where (select idcliente FROM orden ORDER BY numventa desc LIMIT 1)=C.idcliente and (select numventa FROM orden ORDER BY numventa desc LIMIT 1)=numventa";
$resultNombre=pg_query($sqlNombre);
$row2 = pg_fetch_array($resultNombre);


$totalventa=0;
$numeroVentas = 0;
$total=0;
  while($row = pg_fetch_array($resultVenta))
  {
    echo "<tr><td width=\"25%\"><font face=\"verdana\">" . 
	    $row["nombrep"] . "</font></td>";
    echo "<td width=\"25%\"><font face=\"verdana\">" . 
	    $row["cantidad"] . "</font></td>";
    echo "<td width=\"25%\"><font face=\"verdana\">" . 
	    $row["subbtotal"] . "</font></td>";
	
   $total=$row["subbtotal"]+$total;   
$totalventa=$row["cantidad"]+$totalventa;
$numeroVentas++;
  }
echo "<tr><td colspan=\"15\"><font face=\"verdana\"><b>Cliente: "  . $row2 ["nombrec"] . 
      "</b></font></td></tr>";
echo "<tr><td colspan=\"15\"><font face=\"verdana\"><b>Numero de venta: " . $row2 ["numventa"] . 
      "</b></font></td></tr>";
 echo "<tr><td colspan=\"15\"><font face=\"verdana\"><b>Costo Total: $" . $total . 
      "</b></font></td></tr>";
 echo "<tr><td colspan=\"15\"><font face=\"verdana\"><b>Cantidad Total de Articulos: " . $totalventa . 
      "</b></font></td></tr>";
  echo "<tr><td colspan=\"15\"><font face=\"verdana\"><b>Cantidada de diferentes productos : " . $numeroVentas . 
      "</b></font></td></tr>";

  pg_free_result($resultVenta);

session_destroy();
?>	

<!-- TABLA CREACION STOCK-->
<table border="1" cellspacing=1 cellpadding=2 style="font-size: 8pt"><tr>
<td><font face="verdana"><b>nombre producto</b></font></td>
<td><font face="verdana"><b>Código barras</b></font></td>
<td><font face="verdana"><b>Stock</b></font></td>
<td><font face="verdana"><b>precio</b></font></td>
</tr>



<?php

$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();



/*tabla muestra mis articulos existentes*/
$sql="select nombreproducto,codigobarras,stock,precioventa from producto";

$result=pg_query($sql);

 $numero = 0;
  while($row = pg_fetch_array($result))
  {
    echo "<tr><td width=\"25%\"><font face=\"verdana\">" . 
	    $row["nombreproducto"] . "</font></td>";
    echo "<td width=\"25%\"><font face=\"verdana\">" . 
	    $row["codigobarras"] . "</font></td>";
    echo "<td width=\"25%\"><font face=\"verdana\">" . 
	    $row["stock"] . "</font></td>";
    echo "<td width=\"25%\"><font face=\"verdana\">" . 
	    $row["precioventa"]. "</font></td></tr>";    
    $numero++;
  }
  echo "<tr><td colspan=\"15\"><font face=\"verdana\"><b>Número: " . $numero . 
      "</b></font></td></tr>";
  
  pg_free_result($result);
session_destroy();
?>
</table>

<ul>
  	<li><a href="principal.php">Regresar</a></li><ul>
	</ul>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

</body>
</html>





