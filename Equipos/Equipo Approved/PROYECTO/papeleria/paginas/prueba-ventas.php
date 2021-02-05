<?php
    //Arrancamos la sesión
    session_start();
    //Comprobamos existencia de sesión
    if (!isset($_SESSION['user'])){
        header('location: ../index.php');
    }
?>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no,
            initial-scale=1.0, maximim-scale=1.0, minimun-scale=1.0">
        <title>Home</title>
        <link rel="shortcut icon" href="../img/favicon-96x96.png">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600i,700" rel="stylesheet">
        <link rel="stylesheet" href="../css/estilos.css">
    </head>

    <body>
        <header>
            <div class="contenedor"> 
                <nav class="menu col-xs-12 col-md-12">
                    <img src="../img/logo_pequeño.png" alt="">
                    <a href="logout.php">Cerrar Sesión</a>
                    <a href="ventas.php">Ventas</a>
                    <a href="clientes.php">Clientes</a>
                    <a href="proveedores.php">Proveedores</a>
                    <a href="inventario.php">Inventario</a>
                    <a href="home.php">Home</a>
                </nav>
            </div>
        </header>
        <main class="container">
            <div class="h1 text-center font-weight-bold"><br />Ventas</div>
                <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post"> 
                    <div class="form-group row align-items-right">
                    
                        <div class="col-1 ml-4 mr-2">
                            <input type="submit" value="Nueva Venta" name="nueva" class="btn btn-success">
                        </div>
                        <div class="col-7 mr-1"></div>
                        <div class="col-1 ml-5">
                            <input type="submit" value="Venta por Nota" name="orden" class="btn btn-primary">
                        </div>
                        <div class="col-1 ml-5">
                            <input type="submit" value="Venta por fecha" name="fecha" class="btn btn-dark">
                        </div>
                    </div>
                </form>
            
                <div class="tabla">
                    <link rel="stylesheet" href="../css/tablas.css">
                    <table class="table table-success table-striped table-hover table-responsive-sm
                    table-responsive-md table-responsive-lg table-bordered">
                        

                    <?php
                        $usuario = "papeleria";
                        $password ="123456";
                        $dbname = "base_pape";
                        $port="5432";
                        $host="localhost";
                        $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";
                        $conexion = pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());

                        function nuevaVenta($codigo, $conexion){

                            $funcion = "SELECT * FROM PRODUCTO JOIN INVENTARIO 
                            ON INVENTARIO.codigo_barras=PRODUCTO.codigo_barras WHERE PRODUCTO.codigo_barras='$codigo'";
                            
                                    $tabla=pg_query($conexion, $funcion);
                            
                                    $row = 0    ;
                                    if ($tabla):
                                        if( pg_num_rows($tabla) > 0 ):
                                            
                                            while($obj = pg_fetch_object($tabla)): 
                            echo"<tr>";
                                echo"<th scope='row' class='text-center'>$obj->id_producto</th>";
                                echo"<td class='text-center'>$obj->codigo_barras</td>";
                                echo"<td class='text-center'>$obj->nombre </td>";
                                echo"<td class='text-center'>$obj->marca</td>";
                                echo"<td class='text-center'>$obj->razon_proveedor</td>";
                                echo"<td class='text-center'>$obj->precio_compra</td>";
                                echo"<td class='text-center'>$obj->precio_venta</td>";
                                echo"<td class='text-center'>$obj->utilidad</td>";
                                echo"<td class='text-center'>$obj->fecha_compra</td>";
                                echo"<td class='text-center'>$obj->unidades_stock</td>";
                            echo"</tr>";
                                            endwhile;
                                        endif;
                                    endif;
                        }

                        function ventaOrden($nota, $conexion){
                            echo"<div class='tabla'>";
                    echo"<link rel='stylesheet' href='../css/tablas.css'>";
                    echo"<table class='table table-success table-striped table-hover table-responsive-sm
                    table-responsive-md table-responsive-lg table-bordered'>";
                            echo"<thead class='thead-green'>";
                                echo"<tr>";
                                    echo"<th scope='col' class='text-center'>Orden Cliente</th>";
                                    echo"<th scope='col' class='text-center'>Fecha de compra</th>";
                                    echo"<th scope='col' class='text-center'>Nombre</th>";
                                    echo"<th scope='col' class='text-center'>Producto</th>";
                                    echo"<th scope='col' class='text-center'>Marca</th>";
                                    echo"<th scope='col' class='text-center'>Cantidad</th>";
                                    echo"<th scope='col' class='text-center'>Precio Unitario</th>";
                                    echo"<th scope='col' class='text-center'>Total</th>";
                                    echo"</tr>";
                            echo"</thead>";
                            $funcion2 = "SELECT * FROM visita_informacion('$nota')";
                            
                                    $tabla=pg_query($conexion, $funcion2);
                            
                                    $row = 0    ;
                                    if ($tabla):
                                        if( pg_num_rows($tabla) > 0 ):
                                            
                                            while($obj = pg_fetch_object($tabla)): 
                            echo"<tr>";
                                echo"<th scope='row' class='text-center'>$obj->nota_venta</th>";
                                echo"<td class='text-center'>$obj->fecha_venta</td>";
                                echo"<td class='text-center'>$obj->concat </td>";
                                echo"<td class='text-center'>$obj->nombre</td>";
                                echo"<td class='text-center'>$obj->marca</td>";
                                echo"<td class='text-center'>$obj->cantidad_articulo</td>";
                                echo"<td class='text-center'>$obj->precio_venta_producto</td>";
                                echo"<td class='text-center'>$obj->total_pagar  </td>";
                            echo"</tr>";
                                            endwhile;
                                        endif;
                                    endif;
                                echo"</tbody>";
                            echo"</table>";
                            echo"</div>";
                        }
                        if(isset($_POST['nueva'])) {
                            nuevaVenta($conexion);
                        }
                        elseif(isset($_POST["orden"])) {
                            
                            echo "<div class='formulario'>";?>
                                <form action='<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>' method='post' class='form-registro'>
                                    <?php echo"<div class='inputs'>";
                                        echo"<input type='text' name='nota' placeholder='Ingresa Nota de Venta'  class='form-input' required>";
                                        echo"<input type='submit' value='Buscar' class='btnenviar'>";
                                    echo"</div>";
                                echo"</form>";
                            echo"</div>";
                            if(isset($_POST["buscar"])){
                                ventaOrden($_POST["orden"], $conexion);
                            }
                        }
                        
                        else{    
                                                               
                                $funcion = "SELECT * FROM vista_informacion('VENT-012')";
                        
                                $tabla=pg_query($conexion, $funcion);
                        
                                $row = 0    ;
                                if ($tabla):
                                    if( pg_num_rows($tabla) > 0 ):
                                        
                                        while($obj = pg_fetch_object($tabla)): 
                            ?> 
                            <tr>
                                <th scope="row" class="text-center"><?php echo $obj->id_producto; ?> </th>
                                <td class="text-center"><?php echo $obj->codigo_barras; ?></td>
                                <td class="text-center"><?php echo $obj->nombre; ?></td>
                                <td class="text-center"><?php echo $obj->marca; ?></td>
                                <td class="text-center"><?php echo $obj->razon_proveedor; ?></td>
                                <td class="text-center">$<?php echo $obj->precio_compra; ?></td>
                                <td class="text-center">$<?php echo $obj->precio_venta; ?></td>
                                <td class="text-center">$<?php echo $obj->utilidad; ?></td>
                                <td class="text-center"><?php echo $obj->fecha_compra; ?></td>
                                <td class="text-center"><?php echo $obj->unidades_stock; ?></td>
                            </tr>
                            <?php
                                        endwhile;
                                    endif;
                                endif;
                            }
                            ?>   
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

    </body>
</html>