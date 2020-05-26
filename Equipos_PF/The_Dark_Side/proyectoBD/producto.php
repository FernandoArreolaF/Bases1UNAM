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
<strong class="asas"><u><em>PRODUCTO</em></u></strong><br>

<li><span class="required_notification"><span class="required_notification">&quot; Ingresa datos del Producto</span></span> <span class="required_notification">&quot; </span></li>
<p>&nbsp;</p>
</div>

<div class="container-fluid">
  <div class="row">
    <div class="col-lg-6">
      <form method="post" action="funcionBarras.php">
          <div class="form-group">
	<label for="codigobarras">Calcular la utilidad de un producto</label>
            <div label for="codigobarras">Ingresar Codigo de Barras</label>
            <input id="codigobarras"  type="text" name="codigobarras" lang="es" maxlength="30" >

   

</form>
	  <div class="form-group">
          <button type="submit" class="btn btn-primary" name="codigoB" onclick="funcionBarras.php">Register</button>
          </div>
          </div>
          <div class="form-group">
            <label for="rsocial">Producto a surtir</label>
       
          </div>
          <form method="post" action="surtido.php">
          <div class="form-group">
          <button type="submit" class="btn btn-primary" name="reg_user" onclick="surtido.php">Register</button>
          </div>
</form>
	<ul>
  	<li><a href="principal.php">Regresar</a></li><ul>
  	
	</ul>
        
    </div>
  </div>
</div>



  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

</body>
</html>












<!--
<html>
<head>
<title>Proyecto HTML </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
body,td,th {
	font-size: large;
	font-weight: bold;
	text-align: left;
}
.asas {
	font-size: xx-large;
}
.asas u em {
	text-align: center;
	color: #0F0;
}
.qwq {
	text-align: center;
}
.required_notification {
	color: #FF0;
}
</style>
</head>
<center>
<center>

<body bgcolor="black" background="fondos/10704299_321409068032653_2614215882419722678_o.jpg" text="white" link="#003399" vlink="#FF9999" alink="#FFFF33">
<br>
<strong class="asas"><u><em>Producto</em></u></strong><br>
<br><!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server"> 

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<li><span class="required_notification"><span class="required_notification">&quot; Ingresa datos del Producto</span></span> <span class="required_notification">&quot;</span></li>
<p>&nbsp;</p>
<!--
necesitamos codigo de barras
funcion

consulta - de 3
(hacer query en una funcion en postgres que con un boton accione la funcion )


<li>Código de Barras
  <input name="checkbox3" type="text" id="checkbox" lang="es" maxlength="30" onclick="funcionBarras.php">
    <label for="checkbox"></label>
<form name="form1" method="post" action="">
  <label class="qwq">
    <input name="" type="submit" id="Aceptar" lang="es" value="Revisar">

  </label>
</form>
</li>

<li>Para resurtir
<form name="form1" method="post" action="">
  <label class="qwq">
    <input name="" type="submit" id="Aceptar" lang="es" value="Revisar">
  </label>
</form>
  
</li>
<body>
<!--
<form name="form1" method="post" action="">
  <label class="qwq">
    <input name="" type="submit" id="Aceptar" lang="es" value="Aceptar">
  </label>
</form>

<ul>
  <li><a href="principal.php">Regresar</a></li><ul>
  <li><a href="categorias.php">Ir a Categorías</a></li>
</ul>
</ul>
<p>&nbsp;</p>
</body>
</html>-->
