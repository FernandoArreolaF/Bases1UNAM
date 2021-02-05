<?php

pg_connect("dbname=officesales user=postgres password=logosiete") or die("No se
pudo realizar la conexion ".pg_last_error());

$rfc = $_POST['rfc'];
$name = $_POST['nombre'];
$lastname = $_POST['ap-pat'];
$middlename = $_POST['ap-mat'];
$street = $_POST['calle'];
$phone = $_POST['telefono'];
$housenumber = $_POST['Numero-casa'];
$colonia = $_POST['colonia'];
$postalcode = $_POST['Codpostal'];
$state = $_POST['estado'];
echo "<h2>Informacion recibida desde PHP</h2>";
echo "El nombre recibido es: " . $rfc . "<br/>";
echo "El asunto recibido es: " . $name . "<br/>";
echo "El mensaje recibido es: " . $lastname . "<br/>";

$query = "INSERT INTO client VALUES('".$rfc."','".$name."','".$lastname."','".$middlename."','".$street."',".$housenumber.",'".$colonia."',".$postalcode.",'".$state."')";

$query = pg_query($query);
if($query)
header("Location:hojas/ingresar.php");
else{

	header("Location:index.php");

}
?>