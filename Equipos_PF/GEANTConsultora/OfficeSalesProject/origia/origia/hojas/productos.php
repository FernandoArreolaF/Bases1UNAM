<!DOCTYPE html>
<html>
<head>
	<title>Papeleria Geant</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, user-scalable-no,initial-scale=1, maximum-scale=1, minimum-scale=1">
	<link rel="stylesheet" href="../css/estien.css">
	<link rel="stylesheet" href="../css/fontello.css">
	<link rel="stylesheet" type="text/css" href="../css/productos.css">
</head>
<body>
    <header>
	<div class="contenedor">
	    <h1 class="icon-attach">Papeleria Geant</h1>
	    <input type="checkbox" id="menu-bar">
	    <label class="icon-menu"for="menu-bar"></label>
	   <nav class="menu">
	       <a href="ventas.php">Principal</a>
	       <a href="productos.php">Productos</a>
	       <a href="pruev.php">Carrito</a>
	       <a href="clouse.php">Cerrar sesion</a>
	   </nav>
	</div>
	</header>

	<main>
		<section id="banner">
			<img src="../img/descarga.jpg">
			<div class="contenedor">
			<h2>Bienvenidos a Geant</h2>
			<h3>Todo para tu oficina y hogar</h3>
			</div>
		</section>
		<section id="Bienbenidos">
			<div class="container-table">
				<div class="table__title">Productos</div>
				<div class="table__header">Trade</div>
				<div class="table__header">Description</div>
				<div class="table__header">Pricevendor</div>
				<div class="table__item">UNEFON</div>
				<div class="table__item">Recarga de $50 C/paquete de datos vig. 3 d¡a</div>
				<div class="table__item">50</div>
				<div class="table__item">M¢naco</div>
				<div class="table__item">Mochila M¢naco 12prom Serig t‚rmica</div>
				<div class="table__item">864.85</div>

				<div class="table__item">AT&T</div>
				<div class="table__item">Recarga de $50 C/paquete de datos vig. 3 d¡a</div>
				<div class="table__item">50</div>
				
				<div class="table__item">HP Original</div>
				<div class="table__item">Paquete Papel Bond Carta Hp Original 500 Hojas</div>
				<div class="table__item">159.65</div>
				<div class="table__item">BIC Crystal</div>
				<div class="table__item">Boligrafo Bic Med C/12 Pza Azul</div>
				<div class="table__item">45.62</div>
				<div class="table__item">HP Papers</div>
				<div class="table__item">Paquete Papel Bond Carta HP Multi 500 Hojas </div>
				<div class="table__item">190.35</div>
				<div class="table__item">Telc‚l</div>
				<div class="table__item">Recarga de $50 C/paquete de datos vig. 3 d¡a</div>
				<div class="table__item">50</div>


						
			</div>
			<form action="pruev.php"method="post" >
			<div class="costo">
				<div class="tit">Cantidad</div>
				<div >
					
					<input class="in100" type="text" value="0" name="v1">
					<input class="in100" type="text" value="0"name="v2">
					<input class="in100" type="text" value="0"name="v3">
					<input class="in100" type="text" value="0"name="v4">
					<input class="in100" type="text" value="0"name="v5">
					<input class="in100" type="text" value="0"name="v6">
					<input class="in100" type="text" value="0"name="v7">

				</div>
				<div class="calc">
					<input type="submit" value="Comprar" class="btn">
				</div>
			</div>
			</form>
			
		</section>

		<section id="info">
			<h3>Por muchas razones, Geant es la opción preferida para comprar online todo lo necesario en Papelería para satisfacer las necesidades de profesionales y oficinas en México. Amplio stock, precios inmejorables y entrega a domicilio son sólo algunas de las razones de porque todos eligen a Geant para abastecer los artículos y consumibles que una oficina requiere hoy.</h3>
			<div class="contenedor">
				<div class="infocola">
					<img src="../img/gaby.jpg">
					<h4>Gaytan Medina Gabriela</h4>
				</div>
				<div class="infocola">
					<img src="../img/omar.jpg">
					<h4>Hernandez Francisco Omar</h4>
				</div>
				<div class="infocola">
					<img src="../img/daniel.jpg">
					<h4>Daniel Alberto Zarco Manzanares</h4>
				</div>
				<div class="infocola">
					<img src="../img/josue.jpg">
					<h4>Josué David Rivera Arellane</h4>
				</div>
				
			</div>
		</section>
	</main>
	<footer>
		<div class="contenedor">
			<p class="copy"> Copyright Geant &copy; <?=date("Y")?></p>
			<div class="sociales">
				<a class="icon-facebook" href=""></a>
				<a class="icon-instagram"  href=""></a>
				<a class="icon-twitter" href=""></a>
			</div>
		</div>
   		
    </footer>
               
    
</body>
</html>