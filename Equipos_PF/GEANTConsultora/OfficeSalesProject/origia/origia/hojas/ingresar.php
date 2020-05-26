<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" >
    <link rel="stylesheet" href="../css/estilos.css">
</head>
<body>
   <h1 >Inicio de sesion</h1>
   <form action="../php/validar.php" method="post" class="form-reg">     
      <h2 class="form-tit">Log in</h2>
      <div class="contenedor-inputs">
        <input type="text" name="nombre" placeholder="nombre"  class="input100" required>
        <input type="password" name="rfc" placeholder="rfc" class="input100" required="">
        <input type="submit" value="enviar" class="btnenviar">
        <p class="formlink"> No tienes una cuenta? <a href="../index.php"> Registrate aqui</a> </p>
        
      </div>
   </form>
    
</body>
</html>