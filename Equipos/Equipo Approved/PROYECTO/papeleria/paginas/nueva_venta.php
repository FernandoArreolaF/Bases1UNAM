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
        <title>Nueva Venta</title>
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
            <div class="h1 text-center font-weight-bold"><br />Nueva Venta</div>
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

                if(isset($_POST['orden'])) {
                    ventaNota();
                }
                elseif(isset($_POST['fecha'])) {
                    ventaFecha();
                }
                else{
                ?>
                <div class="formulario">
                <link rel="stylesheet" href="../css/formulario-registro.css">
                <form action="../php/generar-venta.php" method="post" class="form-registro">     
                    <h2 class="form-titulo">Nueva Venta</h2>
                    <br />
                    <div class="inputs">
                        <div class="form-group row">
                            <label for="codigo" class="col-sm-3 col-form-label">Código del Cliente:</label>
                            <div class="col-sm-9">
                                <input type="text" name="codigo" placeholder="Código"  class="form-input" required>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="producto" class="col-sm-3 col-form-label">Numero de venta:</label>
                            <div class="col-sm-9">
                                <input type="text" name="producto" placeholder="Numero de Venta"  class="form-input" required>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="producto" class="col-sm-3 col-form-label">Producto:</label>
                            <div class="col-sm-9">
                                <input type="text" name="producto" placeholder="Producto"  class="form-input" required>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="marca" class="col-sm-3 col-form-label">Marca:</label>
                            <div class="col-sm-9">
                                <input type="text" name="marca" placeholder="Marca"  class="form-input" required>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="cantidad" class="col-sm-3 col-form-label">Cantidad:</label>
                            <div class="col-sm-9">
                                <input type="text" name="cantidad" placeholder="Cantidad"  class="form-input" required>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="fecha" class="col-sm-3 col-form-label">Fecha</label>
                            <div class="col-sm-9">
                                <input type="date" name="fecha" placeholder="Fecha"  class="form-input" required>
                            </div>
                        </div>


                        
                        <input type="submit" value="Generar" class="btnenviar">

                        
                </div>
            </form>
</div>
            <?php } ?>
        </main>

    </body>
</html>