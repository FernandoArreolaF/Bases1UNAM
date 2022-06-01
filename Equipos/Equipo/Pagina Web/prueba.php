
<?php
require 'conexion.php';
$query = "SELECT no_empleado,foto,UPPER(concat(nombre,' ',ap_paterno)) as nombre, 
		rfc,UPPER(concat(calle,' #',no_exterior,' ,',colonia,' ,',estado,' ',cp)) as direccion, 
		fecha_nacimiento,edad, concat('$',sueldo) as sueldo, horario,
		UPPER(especialidad) as especialidad ,UPPER(rol) as rol,telefonos(no_empleado) as telefono FROM empleado";

$consulta = pg_query($conexion,$query);
?>
<!-- indicamos la consulta que se va a ejecutar($query), el reultado lo guardamos en la variable consulta, poniendo la conexion y el query -->
<!DOCTYPE html>
<html lang = "en">
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
<h2> Tabla de Empleados</h2>
</head>
<body>

	<table border = "1">
		<thead>
			<tr> 

				<!-- Creamos una tabla con las siguientes columnas y su nombre correspondiente-->
				<th>No_empleado</th>
				<th>Foto</th>
				<th>Nombre</th>
				<th>RFC</th>
				<th>Direccion</th>
				<th>Fecha_Nacimiento</th>
				<th>Edad</th>
				<th>Sueldo</th>
				<th>Horario</th>
				<th>Especialidad</th>
				<th>Rol</th>
				<th>Telefonos</th>
			</tr>
		</thead>
		<tbody>

				<!-- Abrimos y cerramos constantemente un php, para obtener y trabajar con los resultados del php 
				e insertarlos en la tabla del html.
				Basicamente, recorremos los registros obtenidos como si fuera una vaiable Record utilizando
				 ciclo while y en cada iteracion se insertan los valores en su columna correspondiente con la variable
				 "$obj->nombre" donde obj es el objeto donde se guarda el registro actual y "->nombre" es el nombre de la columna obtenida
				 en la base de datos. para la imagen indicamos que se imprima la imagen en su casilla correspondiente
				 ,con la direccion que guardamos en la base de datos    -->
			<?php
			while($obj=pg_fetch_object($consulta)){ ?>
				<tr>
					<center>
					<td><?php echo $obj->no_empleado;?></td>
					</center>
					<td><?php echo "<img src='$obj->foto'";?></td>
					<td><?php echo $obj->nombre;?></td>
					<td><?php echo $obj->rfc;?></td>
					<td><?php echo $obj->direccion;?></td>
					<td><?php echo $obj->fecha_nacimiento;?></td>
					<td><?php echo $obj->edad;?></td>
					<td><?php echo $obj->sueldo;?></td>
					<td><?php echo $obj->horario;?></td>
					<td><?php echo $obj->especialidad;?></td>
					<td><?php echo $obj->rol;?></td>
					<td><?php echo $obj->telefono;?></td>

				</tr>
				<?php
			}
			?>
	</table>
		<br>
		<form action="index.php" method="POST">
			<input type="submit" value="Regresar"> 
			</form>

</tbody>
			


