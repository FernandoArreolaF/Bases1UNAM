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
        <title>Proveedores</title>
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
        <div class="h1 text-center font-weight-bold"><br />Proveedores</div>
            <div class="tabla">
            <link rel="stylesheet" href="../css/tablas.css">
                <table class="table table-success table-striped table-hovertable-hover table-responsive-sm
                table-responsive-md table-responsive-lg table-bordered">
                    <thead class="thead-green">
                        <tr>
                            <th scope="col" class="text-center">Código Proveedor</th>
                            <th scope="col" class="text-center">Nombre</th>
                            <th scope="col" class="text-center">Ap. Paterno</th>
                            <th scope="col" class="text-center">Ap. Materno</th>
                            <th scope="col" class="text-center">Calle</th>
                            <th scope="col" class="text-center">Numero</th>
                            <th scope="col" class="text-center">Colonia</th>
                            <th scope="col" class="text-center">Estado</th>
                            <th scope="col" class="text-center">C.P.</th>
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
                                
                                $funcion = "SELECT * FROM PROVEEDOR ";
                        
                                $tabla=pg_query($conexion, $funcion);
                        
                                $row = 0;
                                if ($tabla):
                                    if( pg_num_rows($tabla) > 0 ):
                                        
                                        while($obj = pg_fetch_object($tabla) ): ?> 
                        <tr>
                            <th scope="row" class="text-center"><?php echo $obj->razon_proveedor; ?> </th>
                            <td class="text-center"><?php echo $obj->nombre_pila; ?></td>
                            <td class="text-center"><?php echo $obj->apellido_p; ?></td>
                            <td class="text-center"><?php echo $obj->apellido_m; ?></td>
                            <td class="text-center"><?php echo $obj->calle; ?></td>
                            <td class="text-center"><?php echo $obj->numero; ?></td>
                            <td class="text-center"><?php echo $obj->colonia; ?></td>
                            <td class="text-center"><?php echo $obj->estado; ?></td>
                            <td class="text-center"><?php echo $obj->cp; ?></td>
                        </tr>
                        <?php
                                        endwhile;
                                    endif;
                                endif;
                         ?>   
                    </tbody>
                </table>
            </div>
        </main>

    </body>
</html>