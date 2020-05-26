<html>
<head>
<title>Proyecto HTML </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
body,td,th {
	font-size: large;
	font-weight: bold;
	text-align: center;
	font-family: "Comic Sans MS", cursive;
	color: #FF0;
}
.B {
	font-family: Georgia, Times New Roman, Times, serif;
	font-size: 75px;
	color: #09F;
}
.a {
	font-size: medium;
}
.xx {
	font-family: Trebuchet MS, Arial, Helvetica, sans-serif;
	font-size: small;
}
.kjhgvbnji {
	color: #F00;
}
</style>
</head>
<center>
<center>

<body bgcolor="black" background="file:///C|/Users/ratot/Downloads/fondos/10704299_321409068032653_2614215882419722678_o.jpg" text="white" link="#003399" vlink="#FF9999" alink="#FFFF33" tracingsrc="fondos/10704299_321409068032653_2614215882419722678_o.jpg" tracingopacity="100">

<?php

//AQUI CONECTAMOS A LA BASE DE DATOS DE POSTGRES
$conex = "host=localhost port=5432 dbname=office_manager user=postgres password=1q2w3e4r5t";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

function quitar($mensaje)
{
 $nopermitidos = array("'",'\\','<','>',"\"");
 $mensaje = str_replace($nopermitidos, "", $mensaje);
 return $mensaje;
}
if(trim($_POST["usuario"]) != "" && trim($_POST["password"]) != "")
{

 $usuario = strtolower(htmlentities($_POST["usuario"], ENT_QUOTES));
 $password = $_POST["password"];
 $result = pg_query('SELECT password, usuario FROM users WHERE usuario=\''.$usuario.'\'');
 if($row = pg_fetch_array($result)){
  if($row["password"] == $password){
   $_SESSION["k_username"] = $row['usuario'];

header ('Location: principal.php');



  }else{
   echo 'Password incorrecto';
  }
 }else{
  echo 'Usuario no existente en la base de datos';
 }
 pg_free_result($result);
}else{
 echo 'Debe especificar un usuario y password';
}
pg_close();
?>
