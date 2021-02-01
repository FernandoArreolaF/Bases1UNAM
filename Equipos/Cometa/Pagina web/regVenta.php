<DOCTYPE html>
<html lang = "es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="viewport" content="width = device - width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie-edge">
	<link rel="stylesheet"  href="css/estilos.css">
	<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico">
	<title>COMETA</title>

</head>

<body>
<?php
include("conexion.php");

$razonSocial = $_POST['clienteVenta'];
$producto1 = $_POST['productoVenta1'];
$cantidad1 = $_POST['cantidad1'];
$producto2 = $_POST['productoVenta2'];
$cantidad2 = $_POST['cantidad2'];
$producto3 = $_POST['productoVenta3'];
$cantidad3 = $_POST['cantidad3'];


$sql= "INSERT INTO VENTA (razon_Social) VALUES ('$razonSocial') ";
pg_query($cnx, $sql);
//Obtención del numero de venta
$ultimoVenta="SELECT LAST_VALUE FROM noventa";

$resultado = pg_query($cnx, $ultimoVenta);

if(pg_num_rows($resultado)> 0){
    while($row=pg_fetch_assoc($resultado)){
       // echo 'VENT-0'. $row['last_value'];
       $numVent= 'VENT-0'. $row['last_value'];
    }
}
$compra1= "CALL ingresa_Detalle ('$producto1', '$numVent', $cantidad1)";
pg_query($cnx, $compra1);

if($producto2!= 'A'){
    $compra2 = "CALL ingresa_Detalle ('$producto2', '$numVent', $cantidad2)";
    pg_query($cnx, $compra2);
}

if($producto3!= 'A'){
    $compra3= "CALL ingresa_Detalle ('$producto3', '$numVent', $cantidad3)";
    pg_query($cnx, $compra3);
}


$precio="SELECT precio_venta FROM PRODUCTO WHERE codigo_Barras= '$producto1'";
$result=pg_query($cnx,$precio);
if(pg_num_rows($result)> 0){
    while($row=pg_fetch_assoc($result)){
       // echo $row['precio_venta'];
       $totProd1= $row['precio_venta'];
    }
}
$total1= $totProd1*intval($cantidad1);
//echo $total1. "\n";

if($producto2 != 'A'){
    $precio2="SELECT precio_venta FROM PRODUCTO WHERE codigo_Barras= '$producto2'";
    $result2=pg_query($cnx,$precio2);
    if(pg_num_rows($result2)> 0){
        while($row=pg_fetch_assoc($result2)){
           // echo $row['precio_venta'];
        $totProd2= $row['precio_venta'];
    }
}
$total2= $totProd2*intval($cantidad2);
//echo $total2. "\n";
}
else{
    $totProd2=0;
    $total2=0;
}

if($producto3!= 'A'){
    $precio3="SELECT precio_venta FROM PRODUCTO WHERE codigo_Barras= '$producto3'";
    $result3=pg_query($cnx,$precio3);
    if(pg_num_rows($result3)> 0){
        while($row=pg_fetch_assoc($result3)){
           // echo $row['precio_venta'];
        $totProd3= $row['precio_venta'];
        }
    }
    $total3= $totProd3*intval($cantidad3);
    //echo $total3. "\n";
}
else{
    $totProd3=0;
    $total3=0;
}

$grantotal=$total1+$total2+$total3;
//echo "\n".$grantotal;

//Obtención de nombres
$nombre1="SELECT descripcion FROM PRODUCTO WHERE codigo_barras = '$producto1'";
$nm1=pg_query($cnx, $nombre1);
if(pg_num_rows($nm1)> 0){
    while($row=pg_fetch_assoc($nm1)){
        //echo $row['descripcion'];
       $descripcion1= $row['descripcion'];
    }
}
if($producto2 != 'A'){
    $nombre2="SELECT descripcion FROM PRODUCTO WHERE codigo_Barras= '$producto2'";
    $nm2=pg_query($cnx,$nombre2);
    if(pg_num_rows($nm2)> 0){
        while($row=pg_fetch_assoc($nm2)){
           // echo $row['descripcion'];
        $descripcion2= $row['descripcion'];
        }
    }
}
else{
    $descripcion2='--';
}

if($producto3 != 'A'){
    $nombre3="SELECT descripcion FROM PRODUCTO WHERE codigo_Barras= '$producto3'";
    $nm3=pg_query($cnx, $nombre3);
    if(pg_num_rows($nm3)> 0){
        while($row=pg_fetch_assoc($nm3)){
          //  echo $row['descripcion'];
        $descripcion3= $row['descripcion'];
        }
    }
}
else{
    $descripcion3='--';
}

?>

    <main>
        
            <h2 class="titulo"> TICKET </h2>
                <table style ="margin:0 auto">
                <style type ="text/css">
                    table, th, td{

                        background-color: #52c7a49a;
	                
                    }
                    table{
	                	text-align: center;
                        }
                    th, td {

                            padding: 10px;
                            }

                </style>

			        <tr>
				        <th>
					        Artículo
                        </th>
                        <th>
                            Precio Unitario
                        </th>
				         <th>
					        Cantidad
				        </th>
				        <th>
					        Subtotal
				        </th>	
			        </tr>

			        <tr >
                        <td><?php echo $descripcion1   ?></td>
                        <td><?php echo '$'.$totProd1     ?></td>
				        <td><?php echo $cantidad1      ?></td>
				        <td><?php echo '$'.$total1     ?></td>
			        </tr>

			        <tr >
                        <td><?php echo $descripcion2    ?></td>
                        <td><?php echo '$'.$totProd2     ?></td>
				        <td><?php echo $cantidad2       ?></td>
				        <td><?php echo '$'.$total2      ?></td>
			        </tr>

			        <tr >
                        <td><?php echo $descripcion3    ?></td>
                        <td><?php echo '$'.$totProd3     ?></td>
				        <td><?php echo $cantidad3       ?></td>
				        <td><?php echo '$'.$total3      ?></td>
                    </tr>
                    <tr >
                        <td></td>
                        <td></td>
				        <td></td>
                         <td><b>Total:</b><?php echo '$'.$grantotal       ?></td>	
                    </tr>
			

                </table>
    </main>
    <div class="btn_form">
                    <a href="./index.html" class="btn_back"> ATRAS</a>
                </div>
        
            </body>
</html>