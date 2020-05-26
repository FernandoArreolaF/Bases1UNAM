<?php


$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$idcliente=$_POST['idcliente'];
$email=$_POST['email'];


$pg_query="INSERT INTO email_cliente VALUES ($idcliente,'$email')";

$query =pg_query($cnx,$pg_query);
if($query)
header ('Location: emailcrear.php');
else{
header ('Location: cliente.php');
}


?>
