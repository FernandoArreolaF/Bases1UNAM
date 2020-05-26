<?php
$codbar=$_POST['codbar'];
$valor1=(int)$codbar;
$cp=$_POST['cp'];
if ($valor=0 ){
session_destroy();
header ('Location: ventas.php');

}else{
$valor2=(int)$cp;
$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$pg_query="INSERT INTO ventat (codigobarras,cantidadarticulos) VALUES ($valor1,$valor2)";
$query =pg_query($cnx,$pg_query);
}





?>
