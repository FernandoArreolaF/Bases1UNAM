<?php
session_start();
if (!isset($_SESSION["usuario"]) || $_SESSION["usuario"] !== "mesero") {
    header("Location: index.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenida - Mesero</title>
</head>
<body>
    <h2>Bienvenido, Mesero</h2>
    <p>Hola, <?php echo $_SESSION["usuario"]; ?>.</p>
    <a href="menu.php"><button>Menú</button></a>
    <a href="ordenes.php"><button>Órdenes</button></a>
    <a href="main.php"><button style="font-size: 12px;">Cerrar sesión</button></a>
</body>
</html>
