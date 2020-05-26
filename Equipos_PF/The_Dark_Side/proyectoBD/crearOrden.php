<?php


$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$rsocial=$_POST['idcliente'];
$entero=(int)$rsocial;

$pg_query="INSERT INTO orden (idcliente,fechaventa) VALUES ($entero,cast(current_date as varchar))";

$query =pg_query($cnx,$pg_query);
if($query)
header ('Location: ventas.php');
else{
echo "error".pg_last_error();
}


?>
