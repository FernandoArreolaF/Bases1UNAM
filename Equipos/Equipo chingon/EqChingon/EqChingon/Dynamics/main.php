<?php
session_start();

// Array de usuarios y contraseñas
$usuarios = array(
    "administrativo" => "admin123",
    "mesero" => "mesero123",
    "cocinero" => "cocinero123",
    "bdadmin" => "bdadmin123"
);

// Verificar si se ha enviado el formulario de inicio de sesión
if ($_SERVER && isset($_SERVER["REQUEST_METHOD"]) && $_SERVER["REQUEST_METHOD"] == "POST") {
    $usuario = $_POST["usuario"];
    $contrasena = $_POST["contrasena"];

    // Verificar si el usuario y la contraseña son válidos
    if (isset($usuarios[$usuario]) && $usuarios[$usuario] == $contrasena) {
        // Iniciar sesión y redirigir al usuario a su página correspondiente
        $_SESSION["usuario"] = $usuario;
        switch ($usuario) {
            case 'administrativo':
                header("Location: administrativo.php");
                break;
            case 'mesero':
                header("Location: mesero.php");
                break;
            case 'cocinero':
                header("Location: cocinero.php");
                break;
            case 'bdadmin':
                header("Location: bdadmin.php");
                break;
            default:
                // En caso de que el tipo de usuario no esté definido, redirigir a una página de error
                header("Location: error.php");
                break;
        }
        exit;
    } else {
        // Si las credenciales no son válidas, mostrar un mensaje de error
        $mensajeError = "Usuario o contraseña incorrectos.";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión</title>
</head>
<body>
    <h2>Iniciar sesión</h2>
    <?php if (isset($mensajeError)) echo "<p>$mensajeError</p>"; ?>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <label for="usuario">Usuario:</label>
        <input type="text" id="usuario" name="usuario" required><br><br>
        <label for="contrasena">Contraseña:</label>
        <input type="password" id="contrasena" name="contrasena" required><br><br>
        <input type="submit" value="Ingresar">
    </form>
</body>
</html>
