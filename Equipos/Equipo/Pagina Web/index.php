<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title> PRUEBA </title>
</head>
<body>

	<h2> Ingreso de producto en la orden</h2>
	<form action="alta.php" method = "POST">  <!-- Se abre un formulario que al mandarse nos direccione a al archivo alta.php -->
		<label> Seleccione los productos y cantidades que iran en la orden, si no necesita agregar mas productos, deje los recuadros tal cual estan</label> <br><br>
		<label> NO INGRESAR PRODUCTOS IGUALES</label> <br><br>
		<label for="producto">Ingrese el nombre del producto:</label> <!-- Etiqueta que se imprime en pantalla--> 
		<select name="producto1"> <!-- Se crea una lista deplegable -->
		<option value="0">Seleccione</option> <!-- Definimos el valor por defecto-->
		<?php
			require 'conexion.php'; 
			$producto = "SELECT * FROM public.producto where disponibilidad = true order by nombre";
			$resultado = pg_query($conexion,$producto);
			while ($obj = pg_fetch_assoc($resultado)){
				echo '<option value="'.$obj["nombre"].'">'.$obj["nombre"].'</option>';
			}
		?>
		<!-- Se abre un php donde consultamos el nombre de todos los productos disponibles en la base -->
		<!-- con un ciclo while recorremos todos registros obtenidos en la consulta y el valor obtenido
		lo ponemos como una opcion de la liga con ese valor para simplificar -->
		</select><br><br><!-- Se cierra el registro de datos para la lista desplegable  -->  
		<label for="nombre">Ingresa la cantidad:</label>
		<input type="number" name="cantidad1"> <br><br>
		<!-- Se crea un cuadro blanco donde admite solo numeros, que representa la cantidad del producto-->
		<!-- Se REPITE EL MISMO PROC PARA LOS DEMAS PRODUCTOS -->

		<label for="producto">Ingrese el nombre del producto:</label>
		<select name="producto2">
		<option value="0">Seleccione</option>
		<?php
			require 'conexion.php';
			$producto = "SELECT * FROM public.producto where disponibilidad = true order by nombre";
			$resultado = pg_query($conexion,$producto);
			while ($obj = pg_fetch_assoc($resultado)){
				echo '<option value="'.$obj["nombre"].'">'.$obj["nombre"].'</option>';
			}
		?>
		</select><br><br>
		<label for="nombre">Ingresa la cantidad:</label>
		<input type="number" name="cantidad2"> <br><br>

		<label for="producto">Ingrese el nombre del producto:</label>
		<select name="producto3">
		<option value="0">Seleccione</option>
		<?php
			require 'conexion.php';
			$producto = "SELECT * FROM public.producto where disponibilidad = true order by nombre";
			$resultado = pg_query($conexion,$producto);
			while ($obj = pg_fetch_assoc($resultado)){
				echo '<option value="'.$obj["nombre"].'">'.$obj["nombre"].'</option>';
			}
		?>
		</select><br><br>
		<label for="nombre">Ingresa la cantidad:</label>
		<input type="number" name="cantidad3"> <br><br> 

		<input type="submit" value = "Ingresar orden"> <label >         </label> <input type="reset" name="Reset"><br><br> 
		<!-- Se crea un boton que es el evento para que la accion del formulario ocurra
		y se crea un boton de reset para reiniciar las opciones por defecto -->
	</form>




	

	<form action="prueba.php" method="POST">
	<input type="submit" value="VER informacion de los empleados.">
	<!-- Se abre un forms que nos va a llevar a prueba.php, es la pagina donde esta la tabla
	para ello creamos un boton para activar el evento  -->
	</form>

</body>
</html>