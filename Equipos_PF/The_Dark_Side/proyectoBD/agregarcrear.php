<?php

$codbar=$_POST['codbar'];
$valor1=(int)$codbar;
$cp=$_POST['cp'];
$valor2=(int)$cp;
if ($valor1==0 || $cp==0){

session_destroy();
header ('Location: ventas.php');
}else{



$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$pg_query="select ultimaVenta ($valor1,$valor2)";



$query =pg_query($cnx,$pg_query);



}


if($query){

header ('Location: ventas.php');

}else{
echo "error".pg_last_error();
}


?>
