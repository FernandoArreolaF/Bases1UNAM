<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no,
        initial-scale=1.0, maximim-scale=1.0, minimun-scale=1.0">
        <title>Inicio</title>
        <link rel="shortcut icon" href="img/favicon-96x96.png">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600i,700" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">
    </head>

    <body>
        <header>
            <div class="container">
                    <div class="logo">
                       <center> <a href="#"><img src="img/logo.png" alt=""></a></center>
                    </div>
                </div>
            </div>

        </header>
        <div class="formulario">
        <link rel="stylesheet" href="css/formulario.css">
            <form action="php/validar-sesion.php" method="post" class="form-ingreso">     
                <h2 class="form-titulo">Inicio de Sesión</h2>
                <div class="inputs">
                    <input type="text" name="usuario" placeholder="Usuario"  class="nombre" required>
                    <input type="password" name="pass" placeholder="Password" class="nombre" required="">
                    <input type="submit" value="Enviar" class="btnenviar">

                </div>
            </form>
        </div>
        <footer>

        </footer>
    </body>
</html>
