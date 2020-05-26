<?php


$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$rsocial=$_POST['rsocial'];
$estado=$_POST['estado'];
$cp=$_POST['cp'];
$colonia=$_POST['colonia'];
$calle=$_POST['calle'];
$numero=$_POST['numero'];
$nombre=$_POST['nombre'];


$pg_query="INSERT INTO cliente VALUES (DEFAULT,'$rsocial','$estado','$cp','$colonia','$calle','$numero','$nombre')";

$query =pg_query($cnx,$pg_query);
if($query)
header ('Location: cliente.php');
else{
echo "error".pg_last_error();
}


?>
