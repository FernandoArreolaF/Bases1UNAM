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
<strong class="asas"><u><em>Email</em></u></strong><br>

<li><span class="required_notification"><span class="required_notification">&quot; Ingresa Email del Cliente</span></span> <span class="required_notification">&quot; </span></li>
<p>&nbsp;</p>
</div>

<div class="container-fluid">
  <div class="row">
    <div class="col-lg-6">
<!--**************************-->
      <form method="post" action="emailcrear.php">
          <div class="form-group">
            <label for="idcliente">ID Cliente</label>
            
            <input id="idcliente"  type="text" name="idcliente" lang="es" maxlength="30" >
          </div>
          <div class="form-group">
            <label for="email">Email</label>
            <input id="email"  type="text" name="email" lang="es" >
          </div>
          <div class="form-group">
          <button type="submit" class="btn btn-primary" name="reg_user" onclick="emailcrear.php">Register</button>
          </div>
	<ul>
  	<li><a href="cliente.php">Regresar</a></li><ul>
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





