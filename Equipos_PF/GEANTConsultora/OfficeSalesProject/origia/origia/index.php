<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" >
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
   <h1 >Formulario registro</h1>
   <form action="registrar.php" method="post" class="form-reg">     
      <h2 class="form-tit">Registrar</h2>
      <div class="contenedor-inputs">
        <input type="text" name="nombre" placeholder="nombre"  class="input100" required>
        <input type="text" name="ap-pat" placeholder="paterno" class="input100"  required>
        <input type="text" name="ap-mat" placeholder="materno" class="input100" >
        <input type="text" name="calle" placeholder="calle" class="input30" required>
        <input type="text" name="No-casa" placeholder="num casa" class="input30" required>
        <input type="text" name="colonia" placeholder="colonia" class="input30" required>
        <input type="text" name="Codpostal" placeholder="Cod. postal" class="input48" required>
        <input type="text" name="estado" placeholder="estado" class="input48" required>
        <input type="password" name="rfc" placeholder="rfc" class="input100" required>
        <input type="submit" value="enviar" class="btnenviar">
        <p class="formlink"> ya tienes una cuenta? <a href="hojas/ingresar.php"> Ingresa aqui</a> </p>
        
      </div>
   </form>
</body>
</html>