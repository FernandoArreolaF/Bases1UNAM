<?php


$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$val1=$_POST['fecha1'];
$val2=$_POST['fecha2'];



$pg_query="select ventasFechaS ('$val1','$val2')";
$sql=$pg_query;
$result=pg_query($sql);

$row=pg_fetch_array($result);

echo $row[0];

while ($row = pg_fetch_array($result)){
	echo $row['ventasfechas'] ;
}


$query = pg_query($cnx,$sql);
if($query)
echo " ";
else{
echo "La seguimos cagando".pg_last_error();
}

echo '<p><a href="ventas.php">ventas</a></p>';
?>
