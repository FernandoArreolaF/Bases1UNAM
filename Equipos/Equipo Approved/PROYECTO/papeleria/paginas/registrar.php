<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no,
        initial-scale=1.0, maximim-scale=1.0, minimun-scale=1.0">
        <title>Registrar</title>
        <link rel="shortcut icon" href="../img/favicon-96x96.png">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600i,700" rel="stylesheet">
        <link rel="stylesheet" href="../css/estilos.css">
    </head>

    <body>
        <header>
            <div class="container">
                    <div class="logo">
                       <center> <a href="#"><img src="../img/logo.png" alt=""></a></center>
                    </div>
                </div>
            </div>

        </header>
        <div class="formulario">
            <link rel="stylesheet" href="../css/formulario-registro.css">
            <form action="../php/registro.php" method="post" class="form-registro">     
                <h2 class="form-titulo">Formulario de Registro</h2>
                <br />
                <div class="inputs">
                    <input type="text" name="nombre" placeholder="Nombre"  class="form-input" required>
                    <input type="text" name="ap-pat" placeholder="Apellido paterno" class="form-input"  required>
                    <input type="text" name="ap-mat" placeholder="Apellido materno" class="form-input" >
                    <input type="text" name="tel" placeholder="Teléfono" class="form-input" required>
                    <input type="text" name="calle" placeholder="Calle" class="form-input" required>
                    <input type="text" name="numero-casa" placeholder="Número exterior" class="form-input-corto" required>
                    <input type="text" name="Codpostal" placeholder="Código postal" class="form-input-corto" required>
                    <input type="text" name="colonia" placeholder="Colonia" class="form-input" required>                    
                    <input type="text" name="estado" placeholder="Estado" class="form-input" required>
                    <input type="password" name="rfc" placeholder="RFC" class="form-input" required>
                    <input type="submit" value="Registrar" class="btnenviar">
                    <br /><br /><p class="registrarse">¿Ya estás registrado?</p><p class="registrarse"> <br /><a href="../index.php" class="btn-registrar">Ingresa aqui</a> </p>
                    
                </div>
            </form>
</div>
    </body>
</html>