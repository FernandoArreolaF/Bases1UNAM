<?php
session_start();
if (!isset($_SESSION["usuario"]) || $_SESSION["usuario"] !== "administrativo") {
    header("Location: index.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenida - Administrativo</title>
</head>
<body>
    <h2>Bienvenido, Administrativo</h2>
    <p>Hola, <?php echo $_SESSION["usuario"]; ?>.</p>
    <a href="menu.php"><button>Menú</button></a>
    <a href="ordenes.php"><button>Órdenes</button></a>
    <a href="main.php"><button style="font-size: 12px;">Cerrar sesión</button></a>
</body>
</html>
