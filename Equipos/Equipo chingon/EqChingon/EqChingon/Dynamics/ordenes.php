<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mar de Marisco</title>
</head>
<body>
    <h1>Mar de Marisco</h1>
    <!-- Botón para generar nueva orden -->
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
        <input type="hidden" name="action" value="nueva_orden">
        <input type="submit" value="Nueva Orden">
    </form>
    <!-- Botón para ver orden -->
    <form action="ver_orden.php" method="get">
        <input type="submit" value="Ver Orden">
    </form>

<?php
// Establecer la conexión con la base de datos
$conection = pg_connect("host=localhost dbname=restaurante user=adminbd password='adminbd_password'");
if (!$conection) {
    echo "Error de conexión a la base de datos.";
}

// Verificar si se ha enviado el formulario de nueva orden
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["action"]) && $_POST["action"] == "nueva_orden") {
    // Generar texto con folio de orden, fecha y mesero
    $folio = substr(uniqid(), 0, 8); // Tomar solo los primeros 8 caracteres del folio único
    $fecha = date("Y-m-d"); // Obtener la fecha actual
    $mesero = "Daniel"; // Aquí deberías obtener el nombre del mesero de alguna forma

    // Realizar el INSERT en la base de datos
    $query = "INSERT INTO orden(folio_orden, fecha_orden, num_emp_administrativo, num_emp_mesero) VALUES ('$folio', CURRENT_TIMESTAMP, 1, 10)";
    $result = pg_query($conection, $query);
    
    if (!$result) {
        echo "Error al insertar la orden en la base de datos.";
    } else {
        echo "<p>Nueva orden creada: $folio / $fecha / $mesero</p>";
    }
}
?>

<!-- Formulario de Pedido -->
<form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
    <label for="categoria">Categoría:</label>
    <select name="categoria" id="categoria">
        <option value="Entradas">Entradas</option>
        <option value="Plato principal">Plato principal</option>
        <option value="Postres">Postres</option>
        <option value="Bebidas">Bebidas</option>
    </select><br><br>

    <label for="detalles">Detalles:</label><br>
    <textarea name="detalles" id="detalles" rows="4" cols="50"></textarea><br><br>

    <label for="id_producto">ID del Producto:</label>
    <input type="text" name="id_producto" id="id_producto"><br><br>

    <label for="cantidad">Cantidad:</label>
    <input type="number" name="cantidad" id="cantidad" min="1" value="1"><br><br>

    <input type="submit" value="Enviar">
</form>

</body>
</html>
