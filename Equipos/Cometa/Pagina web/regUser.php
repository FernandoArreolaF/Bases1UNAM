<DOCTYPE html>
<html lang = "es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="viewport" content="width = device - width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie-edge">
	<link rel="stylesheet"  href="css/estilos.css">
	<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico">
	<title>COMETA</title>

</head>

<body>
	<header>
		<section class="textos-header">
			<h1>PAPELERIA COMETA</h1>
			<h2>Todo en un mismo lugar</h2>
		</section>
		<div class="wave" style="height: 150px; overflow: hidden;" ><svg viewBox="0 0 500 150" preserveAspectRatio="none" style="height: 100%; width: 100%;"><path d="M0.00,49.99 C334.11,162.00 325.31,13.98 500.29,49.99 L506.45,152.14 L0.00,150.00 Z" style="stroke: none; fill: #fff;"></path></svg></div>

		<main>
			<section class="contenedor clientes">
						<div class="btn_form">
							<a href="./registroUsuario.html" class="btn_submit">CLIENTES</a>
							<a href="./registroVenta.php" class="btn_reset">VENTAS</a>
							
						</div>
					</form>
				</div>
			</section>
						
		</main>
	</header>
	<?php
	include ("conexion.php");
	//obtenemos los valores del formulario
	$razonSocial = $_POST['razonSocial'];
	$nombre = $_POST['nombreCliente'];
	$ap_pat = $_POST['apPatCliente'];
	$ap_Mat = $_POST['apMatCliente'];
	$email = $_POST['email'];
	$calle = $_POST['calle'];
	$colonia = $_POST['colonia'];
	$estado = $_POST['estado'];
	$numero = $_POST['numero'];
	$codigoPostal = $_POST['codigoPostal'];

	//Ingresar la infromacion a la tabla datos
	$sql= "insert into CLIENTE values ('$razonSocial','$nombre', '$ap_pat', '$ap_Mat', '$estado', '$codigoPostal', '$colonia','$calle', '$numero' )";
	$sql1 = "insert into EMAIL  values ('$email', '$razonSocial') ";
	//Ejecutamos la sentencia de sql
	pg_query($cnx, $sql);
	pg_query($cnx, $sql1);

	?>
</body>
</html>