<?php

pg_connect("dbname=officesales user=postgres password=logosiete") or die("No se
pudo realizar la conexi&oacute;n ".pg_last_error());

$rfc = $_POST["rfc"];
$name = $_POST["nombre"];

$row=pg_query("select * from client where name='$name' and rfc='$rfc' ");
session_start();
$_SESSION['rf']=$rfc;

if(pg_fetch_array($row)>0){
header("Location:../hojas/ventas.php");

}
else{
echo "Ocurri&oacute; un error! ".pg_last_error();
}
?>