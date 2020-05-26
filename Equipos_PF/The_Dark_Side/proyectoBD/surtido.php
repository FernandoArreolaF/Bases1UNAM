<!-- TABLA CREACION STOCK-->
<table border="1" cellspacing=1 cellpadding=2 style="font-size: 8pt"><tr>
<td><font face="verdana"><b>productos a surtir</b></font></td>
</tr>

<?php


$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

$pg_query="select getLowStock()";
$sql = $pg_query;


$result=pg_query($sql);
$row=pg_fetch_array($result);



echo $row[0];

while ($row = pg_fetch_array($result)){
	echo $row['getlowstock'] ;
}




$query = pg_query($cnx,$sql);
if($query){


}else{
echo "La seguimos cagando".pg_last_error();
}

echo '<p><a href="producto.php">producto</a></p>';
?>
