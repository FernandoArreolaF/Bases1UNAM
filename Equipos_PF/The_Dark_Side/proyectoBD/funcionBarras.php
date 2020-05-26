<?php


$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$codigobarras=$_POST['codigobarras'];
$valor=(int)$codigobarras;

$sql="select utilidadProducto($valor)";

$result=pg_query($sql);

$row=pg_fetch_array($result);


echo $row['sql'];



$query = pg_query($cnx,$sql);

if($query)

echo print_r($row[0],"registro");
else{
echo "La seguimos cagando".pg_last_error();
}

echo '<p><a href="producto.php">producto</a></p>';
?>
