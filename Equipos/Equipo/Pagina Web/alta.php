<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
	<?php
	require  'conexion.php';
	
	$query = "SELECT *  FROM Ingresar_productos('$_REQUEST[producto1]','$_REQUEST[cantidad1]','$_REQUEST[producto2]','$_REQUEST[cantidad2]','$_REQUEST[producto3]','$_REQUEST[cantidad3]')";
	$consulta = pg_query($conexion,$query); 
	pg_close();
	echo 'La orden se ha registrado correctamente';
?>
<!--  Se ejecuta una funcion diseñada para este requerimiento, como parametros, pasamos los valores obtenidos en cada select,
los valores son llamados por medio de "REQUEST", si se ejecuta el query al final se imprime un mensaje de que se ingresaron los  productos en la orden . Al final se crea un boton para regresar a la pagina inicial, para ver los mensajes -->
	



	<form action="index.php" method="POST">
			<input type="submit" value="Regresar"> 
			</form>

</body>
</html>