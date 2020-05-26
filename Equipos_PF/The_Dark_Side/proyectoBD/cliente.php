<!DOCTYPE html>
<html lang="en">
<head>
<title>Proyecto HTML </title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" href="main.css">
</head>
<body>
<br>

<div class="container title">
<strong class="asas"><u><em>Cliente</em></u></strong><br>

<li><span class="required_notification"><span class="required_notification">&quot; Ingresa datos del Cliente</span></span> <span class="required_notification">&quot; </span></li>
<p>&nbsp;</p>
</div>

<div class="container-fluid">
  <div class="row">
    <div class="col-lg-6">
      <form method="post" action="clientecrear.php">
          <div class="form-group">
            <label for="name">Nombre</label>
            
            <input id="name"  type="text" name="nombre" lang="es" maxlength="30" >
          </div>
          <div class="form-group">
            <label for="rsocial">Razon social</label>
            <input id="rsocial"  type="text" name="rsocial" lang="es" >
          </div>
          <div class="form-group">
            <label for="estado">Estado</label>
            
            <input id="estado" type="text" name="estado" lang="es" >
          </div>
          <div class="form-group">
            <label for="cp">C.P.</label>
            
            <input id="cp" type="text" name="cp" lang="es" >
          </div>
          <div class="form-group">
            <label for="colonia">Colonia</label>
            
            <input id="colonia"  type="text" name="colonia" lang="es" >
          </div>
          <div class="form-group">
            <label for="calle">Calle</label>
            <input id="calle"  type="text" name="calle" lang="es" >
          </div>
          <div class="form-group">
            <label for="numero">Numero</label>
            <input id="numero" type="text" name="numero" lang="es" >  
          </div>
          <div class="form-group">
          <button type="submit" class="btn btn-primary" name="reg_user" onclick="clientecrear.php">Register</button>
          </div>
	<ul>
  	<li><a href="principal.php">Regresar</a></li><ul>
  	<li><a href="email.php">Email</a></li>
	</ul>
        </form>
    </div>
  </div>
</div>



  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

</body>
</html>





