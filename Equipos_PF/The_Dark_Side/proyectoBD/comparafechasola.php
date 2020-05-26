<?php


$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$val1=$_POST['fechaX'];



$pg_query="select ventasFecha ('$val1')";
$sql=$pg_query;
$result=pg_query($sql);

$row=pg_fetch_array($result);

echo $row[0];

while ($row = pg_fetch_array($result)){
	echo $row['ventasfechas'] ;
}


$query = pg_query($cnx,$sql);
if($query)
//echo print_r( $row[0],"");
echo " ";
//echo print_r($fecha1);
//echo print_r($row[0],"registro");
else{
//echo $fecha1;
//echo gettype($);
//echo date_format($freal1,'Y-m-d');
echo "La seguimos cagando".pg_last_error();
}

echo '<p><a href="ventas.php">ventas</a></p>';
?>
