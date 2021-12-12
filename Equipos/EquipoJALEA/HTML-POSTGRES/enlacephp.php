<?php
//Sábado 11 de Diciembre, 2021
//Autor: EQUIPO JALEA, BD GPO 1
//Descripcion: archivo php que conecta formulario con la base de datos
	//conectamos Con el servidor
	$conectar=pg_connect("host=b0c9rpn69qut7zlpkr4t-postgresql.services.clever-cloud.com dbname=b0c9rpn69qut7zlpkr4t user=ukx2eg1y5fxtqzogudca password=Nd1MXRV2wOOrFgCXu52k");
	//verificamos la conexion
	if(!$conectar){
		echo"No Se Pudo Conectar Con El Servidor";
	}
	//recuperar las variables
	$RFC=$_POST['RFC'];
	$nombre=$_POST['nombre'];
	$ap_paterno=$_POST['ap_paterno'];
	$ap_materno=$_POST['ap_materno'];
	$estado=$_POST['estado'];
	$codigo_postal=$_POST['codigo_postal'];
	$colonia=$_POST['colonia'];
	$calle=$_POST['calle'];
	$num_domicilio=$_POST['num_domicilio'];

	//hacemos la sentencia de sql
	$sql="INSERT INTO cliente (RFC, nombre, ap_paterno, ap_materno, estado, codigo_postal, colonia, calle, num_domicilio) VALUES('$RFC',
									'$nombre',
									'$ap_paterno',
									'$ap_materno',
									'$estado',
									'$codigo_postal',
									'$colonia',
									'$calle',
									'$num_domicilio')";
	//ejecutamos la sentencia de sql
	$ejecutar=pg_query($sql);
	//verificamos la ejecucion
	if(!$ejecutar){
		echo"Hubo Algun Error<br><a href='formulario.html'>Volver</a>";
	}else{
		echo"Datos Guardados Correctamente<br><a href='formulario.html'>Volver</a>";
		
	}
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"> 
        <title>Tabla Cliente</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
		<div class="tabla">
			<table>
				<tr>
					<th>ID CLIENTE</th>
					<th>RFC</th>
					<th>Nombre</th>
					<th>Apellido Paterno</th>
					<th>Apellido Materno</th>
					<th>Estado</th>
					<th>Codigo Postal</th>
					<th>Colonia</th>
					<th>Calle</th>
					<th>Num Domicilio</th>
				</tr>
					<?php
						//Creacion de la tabla para visualizarla al ingresar los datos.
						$consulta = "SELECT * FROM cliente";
						$ejecutarConsulta = pg_query($conectar, $consulta);
						$verFilas = pg_num_rows($ejecutarConsulta);
						$fila = pg_fetch_array($ejecutarConsulta);

						if(!$ejecutarConsulta){
							echo"Error en la consulta";
						}else{
							if($verFilas<1){
								echo"<tr><td>Sin registros</td></tr>";
							}else{
								for($i=0; $i<=$fila; $i++){
									echo'
										<tr>
											<td>'.$fila[0].'</td>
											<td>'.$fila[1].'</td>
											<td>'.$fila[2].'</td>
											<td>'.$fila[3].'</td>
											<td>'.$fila[4].'</td>
											<td>'.$fila[5].'</td>
											<td>'.$fila[6].'</td>
											<td>'.$fila[7].'</td>
											<td>'.$fila[8].'</td>
											<td>'.$fila[9].'</td>
										</tr>
									';
									$fila = pg_fetch_array($ejecutarConsulta);

								}

							}
						}

					?>
			</table>
		</div>
	</div>
	<script src="formulario.html"></script>
</body>
</html>
