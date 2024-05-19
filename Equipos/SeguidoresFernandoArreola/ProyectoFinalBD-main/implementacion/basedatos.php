<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Empleados</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Lista de Empleados</h1>
        
        <!-- Formulario para filtrar por número de empleado -->
        <form method="GET" action="basedatos.php">
            <label for="num_empleado">Filtrar por Número de Empleado:</label>
            <input type="text" id="num_empleado" name="num_empleado" placeholder="Ingrese número de empleado">
            <button type="submit">Filtrar</button>
        </form>

        <?php
        $conexion = pg_connect("host=localhost dbname=proyecto user=postgres password=123456");

        if (!$conexion) {
            die("Error al conectar con la base de datos: " . pg_last_error());
        }

        $num_empleado = isset($_GET['num_empleado']) ? $_GET['num_empleado'] : '';

        $query = "SELECT num_empleado, nom_empleado, appat_empleado, apmat_empleado, fotografia, calle_empleado, numero_empleado, sueldo, esadmin, rol, escocinero, especialidad, esmesero, horario FROM empleado";
        
        if ($num_empleado) {
            $query .= " WHERE num_empleado = '" . pg_escape_string($num_empleado) . "'";
        }

        $consulta = pg_query($conexion, $query);

        if (!$consulta) {
            die("Error en la consulta: " . pg_last_error());
        }

        echo "<table>";
        echo "<tr><th>Número de Empleado</th><th>Nombre</th><th>Apellido Paterno</th><th>Apellido Materno</th><th>Imagen</th><th>Calle</th><th>Número</th><th>Sueldo</th><th>Es Administrador</th><th>Rol</th><th>Es Cocinero</th><th>Especialidad</th><th>Es Mesero</th><th>Horario</th></tr>";
        while ($row = pg_fetch_assoc($consulta)) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['num_empleado']) . "</td>";
            echo "<td>" . htmlspecialchars($row['nom_empleado']) . "</td>";
            echo "<td>" . htmlspecialchars($row['appat_empleado']) . "</td>";
            echo "<td>" . htmlspecialchars($row['apmat_empleado']) . "</td>";
            echo "<td><img src='" . htmlspecialchars($row['fotografia']) . "' alt='Imagen del Empleado'></td>";
            echo "<td>" . htmlspecialchars($row['calle_empleado']) . "</td>";
            echo "<td>" . htmlspecialchars($row['numero_empleado']) . "</td>";
            echo "<td>" . htmlspecialchars($row['sueldo']) . "</td>";
            echo "<td>" . htmlspecialchars($row['esadmin']) . "</td>";
            echo "<td>" . htmlspecialchars($row['rol']) . "</td>";
            echo "<td>" . htmlspecialchars($row['escocinero']) . "</td>";
            echo "<td>" . htmlspecialchars($row['especialidad']) . "</td>";
            echo "<td>" . htmlspecialchars($row['esmesero']) . "</td>";
            echo "<td>" . htmlspecialchars($row['horario']) . "</td>";
            echo "</tr>";
        }
        echo "</table>";

        pg_free_result($consulta);
        pg_close($conexion);
        ?>
        <a href="index.php"><button>Volver a la Página de Inicio</button></a>
    </div>
</body>
</html>
