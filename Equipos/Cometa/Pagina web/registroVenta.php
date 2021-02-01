<DOCTYPE html>
<html lang = "es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="viewport" content="width = device - width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie-edge">
	<link rel="icon" type="icon/png"  href="https://e7.pngegg.com/pngimages/565/209/png-clipart-computer-icons-icon-design-graphics-flying-kites-triangle-logo.png">
	<title>PAPELERIA</title>
	<link rel="stylesheet"  href="css/estilos.css">

</head>

<body>
		<main>
			<?php
				include("conexion.php");
			?>
			<section class="Venta">
				<div class="contenedor">
					<h2 class="titulo">Registro Venta</h2>
					<div class="galeria-prod">
						<div class="imagen-productos">
							<img src="img/undraw_web_shopping_dd4l.svg" alt="" >
						</div>
						<div class="form_top">
							<h4>REGISTRO</h4>
						</div>
							<form id="frmVentasProductos" class="form_reg" action="regVenta.php", method="POST">
								<label>Selecciona Cliente</label>
								<select class="form-control input-sm" id="clienteVenta" name="clienteVenta" required="">
                                    <option value="A">Selecciona</option>
                                    <?php
                                        $sql="SELECT razon_Social FROM CLIENTE";
                                        $result = pg_query($cnx, $sql);
                                        while($cliente=pg_fetch_row($result)):     
                                    ?>
                                    <option value="<?php echo $cliente[0]?>"><?php echo $cliente[0]?></option>
                                    <?php endwhile; ?>
								</select>
								<label>Producto</label>
								<select class="form-control input-sm" id="productoVenta1" name="productoVenta1" required="">
                                    <option value="A">Selecciona</option>
                                    <?php
                                        $sql2="SELECT codigo_Barras, descripcion FROM PRODUCTO";
                                        $result1= pg_query($cnx,$sql2);
                                        while($producto1=pg_fetch_row($result1)):
                                    ?>
                                    <option value="<?php echo $producto1[0]?>"><?php echo $producto1[1]?></option>
                                    <?php endwhile; ?>
								</select>
								<input class="input" type="number" max="99" min="1"  id = "cantidad1" name="cantidad1" placeholder="&#35; Cantidad" required="">
								<label>Producto</label>
								<select class="form-control input-sm" id="productoVenta2" name="productoVenta2">
                                    <option value="A">Selecciona</option>
                                    <?php
                                        $sql2="SELECT codigo_Barras, descripcion FROM PRODUCTO";
                                        $result2= pg_query($cnx,$sql2);
                                        while($producto2=pg_fetch_row($result2)):
                                    ?>
                                    <option value="<?php echo $producto2[0]?>"><?php echo $producto2[1]?></option>
                                    <?php endwhile; ?>
								</select>
								<input class="input" type="number" max="99" min="1" id = "cantidad2" name="cantidad2" placeholder="&#35; Cantidad" >
								<label>Producto</label>
								<select class="form-control input-sm" id="productoVenta3" name="productoVenta3">
                                    <option value="A">Selecciona</option>
                                    <?php
                                        $sql2="SELECT codigo_Barras, descripcion FROM PRODUCTO";
                                        $result3= pg_query($cnx,$sql2);
                                        while($producto3=pg_fetch_row($result3)):
                                    ?>
                                    <option value="<?php echo $producto3[0]?>"><?php echo $producto3[1]?></option>
                                    <?php endwhile; ?>
								</select>
								<input class="input" type="number" max="99" min="1" id= "cantidad3" name="cantidad3" placeholder="&#35; Cantidad" >

								<div class="btn_form">
                               		 <input class="btn_submit" type="submit" value="REGISTRAR">
                               		 <input class="btn_reset" type="reset" value="LIMPIAR"> 
	                            </div>
							</form>
						 <div class="btn_form">
                            <a href="./index.html" class="btn_back"> ATRAS</a>
                        </div>
					</div>
					
				</div>
			</section>
		</main>
	</header>
</body>
</html>