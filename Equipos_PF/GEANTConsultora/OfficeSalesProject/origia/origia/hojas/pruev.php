<?php  
	pg_connect("dbname=officesales user=postgres password=logosiete") or die("No se
	pudo realizar la conexi&oacute;n ".pg_last_error());
	$row=pg_query("select pricevendor from product where barcode='4 051236 253610'");
	$query=pg_fetch_array($row);
	$p1=$query[0];
	$v1=$_POST['v1'];
	$rp1=$p1*$v1;

	$row2=pg_query("select pricevendor from product where barcode='7 452136 748510'");
	$query2=pg_fetch_array($row2);
	$p2=$query2[0];
	$v2=$_POST['v2'];
	$rp2=$p2*$v2;

	$row3=pg_query("select pricevendor from product where barcode='4 051236 657841'");
	$query3=pg_fetch_array($row3);
	$p3=$query3[0];
	$v3=$_POST['v3'];
	$rp3=$p3*$v3;
	
	$row4=pg_query("select pricevendor from product where barcode='9 820145 658784'");
	$query4=pg_fetch_array($row4);
	$p4=$query4[0];
	$v4=$_POST['v4'];
	$rp4=$p4*$v4;

	$row5=pg_query("select pricevendor from product where barcode='6 458712 562387'");
	$query5=pg_fetch_array($row5);
	$p5=$query5[0];
	$v5=$_POST['v5'];
	$rp5=$p5*$v5;

	$row6=pg_query("select pricevendor from product where barcode='9 587632 502058'");
	$query6=pg_fetch_array($row6);
	$p6=$query6[0];
	$v6=$_POST['v6'];
	$rp6=$p6*$v6;

	$row7=pg_query("select pricevendor from product where barcode='4 051236 498771'");
	$query7=pg_fetch_array($row7);
	$p7=$query7[0];
	$v7=$_POST['v7'];
	$rp7=$p7*$v7;

	$sum=$rp1+$rp2+$rp3+$rp4+$rp5+$rp6+$rp7;
	session_start();
	$rff=$_SESSION['rf'];
	if ($v1>0) {
		$venta = "INSERT INTO sale VALUES(default,current_date,'".$rp1."','".$rff."','".$v1."','4 051236 253610')";

	$ventacp = pg_query($venta);
	if($ventacp)
	echo "insercion";
	else{
	echo "error";}
	}else{
		echo "no insertaste";
	}
	if ($v2>0) {
		$venta2 = "INSERT INTO sale VALUES(default,current_date,'".$rp2."','".$rff."','".$v2."','7 452136 748510')";

	$ventacp2 = pg_query($venta2);
	if($ventacp2)
	echo "insercion";
	else{
	echo "error";}
	}else{
		echo "no insertaste";
	}
	if ($v3>0) {
		$venta3 = "INSERT INTO sale VALUES(default,current_date,'".$rp3."','".$rff."','".$v3."','4 051236 657841')";

	$ventacp3 = pg_query($venta3);
	if($ventacp3)
	echo "insercion";
	else{
	echo "error";}
	}else{
		echo "no insertaste";
	}
	if ($v4>0) {
		$venta4 = "INSERT INTO sale VALUES(default,current_date,'".$rp4."','".$rff."','".$v4."','9 820145 658784')";

	$ventacp4 = pg_query($venta4);
	if($ventacp4)
	echo "insercion";
	else{
	echo "error";}
	}else{
		echo "no insertaste";
	}
	if ($v5>0) {
		$venta5 = "INSERT INTO sale VALUES(default,current_date,'".$rp5."','".$rff."','".$v5."','6 458712 562387')";

	$ventacp5 = pg_query($venta5);
	if($ventacp5)
	echo "insercion";
	else{
	echo "error";}
	}else{
		echo "no insertaste";
	}
	if ($v6>0) {
		$venta6 = "INSERT INTO sale VALUES(default,current_date,'".$rp6."','".$rff."','".$v6."','9 587632 502058')";

	$ventacp6 = pg_query($venta6);
	if($ventacp6)
	echo "insercion";
	else{
	echo "error";}
	}else{
		echo "no insertaste";
	}

	if ($v7>0) {
		$venta7 = "INSERT INTO sale VALUES(default,current_date,'".$rp7."','".$rff."','".$v7."','4 051236 498771')";

	$ventacp7 = pg_query($venta7);
	if($ventacp7)
	echo "insercion";
	else{
	echo "error";}
	}else{
		echo "no insertaste";
	}


?>



<!DOCTYPE html>
<html>
<head>
	<title>Papeleria Geant</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, user-scalable-no,initial-scale=1, maximum-scale=1, minimum-scale=1">
	<link rel="stylesheet" href="../css/estien.css">
	<link rel="stylesheet" href="../css/fontello.css">
	<link rel="stylesheet" type="text/css" href="../css/carrito.css">
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
				<div class="table__title">Carrito de compras</div>
				<div class="table__header">Producto</div>
				<div class="table__header">Subtotal</div>
				<div class="table__item">UNEFON</div>
				<div class="table__item"><?php echo $rp1;?></div>
				<div class="table__item">M¢naco</div>
				<div class="table__item"><?php echo $rp2; ?></div>
				<div class="table__item">AT&T</div>
				<div class="table__item"><?php echo $rp3; ?></div>
				<div class="table__item">HP Original</div>
				<div class="table__item"><?php echo $rp4; ?></div>
				<div class="table__item">BIC Crystal</div>
				<div class="table__item"><?php echo $rp5; ?></div>
				<div class="table__item">HP Papers</div>
				<div class="table__item"><?php echo $rp6; ?></div>
				<div class="table__item">Telc‚l</div>
				<div class="table__item"><?php echo $rp7; ?></div>
				<div class="table__header">Total</div>
				<div class="table__header"><?php echo $sum;  ?></div>
			</div>
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