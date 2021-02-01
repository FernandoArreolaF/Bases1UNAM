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
        <title>Venta</title>
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
                            <a href="nueva_venta.php"><input type="submit" value="Nueva Venta" name="nueva" class="btn btn-success"></a>
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

                <?php
                function ventaNota(){
                    echo "<div class='formulario'>";
                        echo "<form action='venta-orden.php' method='post' class='form-registro'>";
                            echo"<h2 class='form-titulo'>Venta por Nota</h2>";
                            echo"<br />";
                            echo"<div class='inputs'>";
                                echo"<input type='text' name='orden' placeholder='Ingresa la Nota de Venta'  class='form-input' required>";
                                echo"<input type='submit' value='Buscar' class='btnenviar'>";
                            echo"</div>";
                        echo"</form>";
                    echo"</div>";
                }
                function ventaFecha(){
                    echo "<div class='formulario'>";
                        echo"<link rel='stylesheet' href='../css/formulario-registro.css'>";
                        echo "<form action='venta-fecha.php' method='post' class='form-registro'>";
                            echo"<h2 class='form-titulo'>Actualizar Cliente</h2>";
                            echo"<div class='form-group row'>";
                                echo"<label for='razon' class='col-sm-3 col-form-label'>Fecha inicio</label>";
                                echo"<div class='col-sm-9'>";
                                    echo"<input type='date' class='form-control' name='fecha-ini' placeholder='Fecha Inicio'>";
                                echo"</div>";
                            echo"</div>";
                            echo"<div class='form-group row'>";
                                echo"<label for='razon' class='col-sm-3 col-form-label'>Fecha fin</label>";
                                echo"<div class='col-sm-9'>";
                                    echo"<input type='date' class='form-control' name='fecha-fin' placeholder='Fecha Fin'>";
                                echo"</div>";
                            echo"</div>";
                            echo"<div class='form-group row'>";
                                echo"<input type='submit' value='Buscar' class='btnenviar'>";
                            echo"</div>";
                        echo"</form>";
                    echo"</div>";
                }
                if(isset($_POST['nueva'])){
                    header('location: nueva_venta.php');
                }
                elseif(isset($_POST['orden'])) {
                    ventaNota();
                }
                elseif(isset($_POST['fecha'])) {
                    ventaFecha();
                }
                else{
                ?>
            
                <div class="tabla">
                    <link rel="stylesheet" href="../css/tablas.css">
                    <table class="table table-success table-striped table-hovertable-hover table-responsive-sm
                    table-responsive-md table-responsive-lg table-bordered">
                        <thead class="thead-green">
                            <tr>
                                <th scope="col" class="text-center">No. Venta</th>
                                <th scope="col" class="text-center">Nota de Venta</th>
                                <th scope="col" class="text-center">Codigo Cliente</th>
                                <th scope="col" class="text-center">Producto</th>
                                <th scope="col" class="text-center">Marca</th>
                                <th scope="col" class="text-center">Cantidad</th>
                                <th scope="col" class="text-center">Precio unitario</th>
                                <th scope="col" class="text-center">Total</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                                
                                    $usuario = "papeleria";
                                    $password ="123456";
                                    $dbname = "base_pape";
                                    $port="5432";
                                    $host="localhost";
                            
                                    $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";
                            
                                    $conexion=pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());
                                    
                                    $funcion = "SELECT  ov.no_venta, ov.fecha_venta ,ov.razon_cliente,ov.nota_venta, od.no_orden_detalle,
                                                od.cantidad_articulo,od.precio_venta_producto,od.total_pagar, pd.nombre, pd.marca 
                                                FROM ORDEN_VENTA AS ov JOIN ORDEN_DETALLE AS od 
                                                ON ov.no_venta=od.no_venta JOIN PRODUCTO AS pd ON od.id_producto=pd.id_producto;";
                            
                                    $tabla=pg_query($conexion, $funcion);
                                    $total = 0;
                                    $row = 0;
                                    if ($tabla):
                                        if( pg_num_rows($tabla) > 0 ):
                                            
                                            while($obj = pg_fetch_object($tabla) ): ?> 
                            <tr>
                                <th scope="row" class="text-center"><?php echo $obj->no_venta; ?> </th>
                                <td class="text-center"><?php echo $obj->nota_venta; ?></td>
                                <td class="text-center"><?php echo $obj->razon_cliente; ?></td>
                                <td class="text-center"><?php echo $obj->nombre; ?></td>
                                <td class="text-center"><?php echo $obj->marca; ?></td>
                                <td class="text-center"><?php echo $obj->cantidad_articulo; ?></td>
                                <td class="text-center"><?php echo $obj->precio_venta_producto; ?></td>
                                <td class="text-center"><?php echo $obj->total_pagar; ?></td>
                            </tr>
                            <?php
                                        $total = $total + $obj->total_pagar;
                                            endwhile;
                                        endif;
                                    endif;
                            ?> 
                            <tr> 
                                <td></td><td></td><td></td><td></td><td></td><td></td>  
                                <th scope="row" class="text-center">Total</th> 
                                <th scope="row" class="text-center">$<?php echo $total; ?> </th>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <?php } ?>
        </main>

    </body>
</html>