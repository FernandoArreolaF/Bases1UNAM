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
        <title>Inventario</title>
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
            <div class="h1 text-center font-weight-bold"><br />Inventario</div>
                <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post"> 
                    <div class="form-group row ">
                        <label for="vacio" class="col-4 col-form-label"></label>
                        <label for="cod" class="col-2 col-form-label font-weight-bold text-right ">Código de barras</label>
                        <div class="col-2">
                            <input type="text" class="form-control" name="codigo" id="codigo" value=""/>
                        </div>
                        <div class="col-1">
                            <input type="submit" value="Buscar" name="cod" class="btn btn-primary">
                        </div>
                        <div class="col-2">
                            <input type="submit" value="Productos con pocas unidades" name="stock" class="btn btn-danger">
                        </div>
                    </div>
                </form>

                <div class="tabla">
                    <link rel="stylesheet" href="../css/tablas.css">
                    <table class="table table-success table-striped table-hover table-responsive-sm
                    table-responsive-md table-responsive-lg table-bordered">
                        <thead class="thead-green">
                            <tr>
                                <th scope="col" class="text-center">Id Producto</th>
                                <th scope="col" class="text-center">Codigo de Barras</th>
                                <th scope="col" class="text-center">Articulo</th>
                                <th scope="col" class="text-center">Marca</th>
                                <th scope="col" class="text-center">Código Proveedor</th>
                                <th scope="col" class="text-center">Precio de Compra</th>
                                <th scope="col" class="text-center">Precio de Venta</th>
                                <th scope="col" class="text-center">Utilidad</th>
                                <th scope="col" class="text-center">Fecha de compra</th>
                                <th scope="col" class="text-center">Unidades</th>
                            </tr>
                        </thead>

                    <?php
                        $usuario = "papeleria";
                        $password ="123456";
                        $dbname = "base_pape";
                        $port="5432";
                        $host="localhost";
                        $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";
                        $conexion = pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());

                        function codigoFunc($codigo, $conexion){
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

                        function stockFunc($conexion){
                            $funcion2 = "SELECT * FROM stock_menor_3()";
                            
                                    $tabla=pg_query($conexion, $funcion2);
                            
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
                        if(isset($_POST['stock'])) {
                            stockFunc($conexion);
                        }
                        elseif(isset($_POST["cod"])) {
                            codigoFunc($_POST["codigo"], $conexion);
                        }
                        
                        else{    
                                                               
                                $funcion = "SELECT * FROM PRODUCTO JOIN INVENTARIO
                                            ON INVENTARIO.codigo_barras=PRODUCTO.codigo_barras ORDER BY id_producto";
                        
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