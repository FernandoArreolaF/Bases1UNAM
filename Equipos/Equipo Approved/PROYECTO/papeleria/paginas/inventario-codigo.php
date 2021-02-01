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
                        <label for="vacio" class="col-7 col-form-label"></label>
                        <label for="codigo" class="col-2 col-form-label font-weight-bold text-right ">Código de barras</label>
                        <div class="col-2">
                            <input type="text" class="form-control" name="codigo" id="codigo" value=""/>
                        </div>
                        <div class="col-1">
                            <input type="submit" value="Buscar" name="submit" class="btn btn-primary">
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
                                <th scope="col" class="text-center">Razon Proveedor</th>
                                <th scope="col" class="text-center">Precio de Compra</th>
                                <th scope="col" class="text-center">Precio de Venta</th>
                                <th scope="col" class="text-center">Utilidad</th>
                                <th scope="col" class="text-center">Fecha de compra</th>
                                <th scope="col" class="text-center">Unidades</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                                if(isset($_POST['submit'])):
                                    $usuario = "papeleria";
                                    $password ="123456";
                                    $dbname = "base_pape";
                                    $port="5432";
                                    $host="localhost";
                                    $codigo = $_POST["codigo"];
                            
                                    $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";
                            
                                    $conexion=pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());
                                    
                                    $funcion = "SELECT * FROM nombre_si_da_codigo('$codigo')";
                            
                                    $tabla=pg_query($conexion, $funcion);
                            
                                    $row = 0    ;
                                    if ($tabla):
                                        if( pg_num_rows($tabla) > 0 ):
                                            
                                            while($obj = pg_fetch_object($tabla)): ?> 
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
                                endif;
                            ?>   
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </body>
</html>