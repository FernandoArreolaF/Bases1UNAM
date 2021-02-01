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
        <title>Ventas por fecha</title>
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

            if(isset($_POST['nueva'])){
                header('location: nueva_venta.php');
            }
            elseif(isset($_POST['orden'])) {
                    ventaNota();
                }
                else{
                ?>

                <div class="tabla">
                    <link rel="stylesheet" href="../css/tablas.css">
                    <table class="table table-success table-striped table-hovertable-hover table-responsive-sm
                    table-responsive-md table-responsive-lg table-bordered">
                        <thead class="thead-green">
                            <tr>
                                <th scope="row"></th>
                                <th scope="col" class="text-center">Cantidad vendida</th>
                                <th scope="row"></th>
                            </tr>
                            <tr>
                                <th scope="col" class="text-center">Fecha Inicio</th>
                                <th scope="col" class="text-center">Fecha Fin</th>
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
                                    $fecha_ini=$_POST['fecha-ini'];
                                    $fecha_fin=$_POST['fecha-fin'];
                                    $cadenaConexion = "host=$host port=$port dbname=$dbname user=$usuario password=$password";
                            
                                    $conexion=pg_connect($cadenaConexion) or die("Error en la conexion: ".pg_last_error());
                                    
                                    $funcion = "SELECT * FROM CANTIDAD_VENDIDA_POR_FECHA('$fecha_ini', '$fecha_fin');";
                            
                                    $tabla=pg_query($conexion, $funcion);
                                    $row = 0;
                                    if ($tabla):
                                        if( pg_num_rows($tabla) > 0 ):
                                            
                                            while($obj = pg_fetch_object($tabla) ): ?> 
                            <tr>
                                <td class="text-center"><?php echo $fecha_ini; ?> </td>
                                <td class="text-center"><?php echo $fecha_fin; ?></td>
                                <th scope="row" class="text-center"><?php echo $obj->cantidad_vendida; ?></th>
                            </tr>
                            <?php
                                        
                                            endwhile;
                                        endif;
                                    endif;
                            ?> 
                            
                        </tbody>
                    </table>
                </div>
            </div>
            <?php } ?>
        </main>

    </body>
</html>