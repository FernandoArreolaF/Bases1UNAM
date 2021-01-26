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
        <title>Actualizar Cliente</title>
        <link rel="shortcut icon" href="../img/favicon-96x96.png">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600i,700" rel="stylesheet">
        <link rel="stylesheet" href="../css/estilos.css">
        <script src="/scripts/snippet-javascript-console.min.js?v=1"></script>
        <script languague="javascript">
            function mostrar() {
                    div = document.getElementById('flotante');
                    div.style.display = '';
                }
                
                function cerrar() {
                    div = document.getElementById('flotante');
                    div.style.display = 'none';
                }
        </script>
    </head>

    <body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
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
        <div class="h1 text-center font-weight-bold"><br />Clientes</div>
            <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post"> 
                <div class="form-group row ">
                <div class="col-1"></div>
                    <div class="col-2">
                        <input type="submit" value="Agregar Cliente" name="insert" class="btn btn-success">
                    </div>
                    <div class="col-2">
                        <input type="submit" value="Actualizar Cliente" name="update" class="btn btn-warning">
                    </div>
                    <div class="col-2">
                        <a href="javascript:cerrar();"><input type="submit" value="Borrar Cliente" name="delete" class="btn btn-danger"></a>
                    </div>
                </div>
            </form>
           
            <?php
                if(isset($_POST['insert'])) {
                    insertFunc();
                }
                if(isset($_POST['update'])) {
                    updateFunc();
                }
                if(isset($_POST['delete'])) {
                    deleteFunc();
                }

                function insertFunc(){
                    echo "<div class='formulario'>";
                        echo"<link rel='stylesheet' href='../css/formulario-registro.css'>";
                        echo "<form action='../php/agregar-cliente.php' method='post' class='form-registro'>";
                            echo"<h2 class='form-titulo'>Registro de Cliente</h2>";
                            echo"<br />";
                            echo"<div class='inputs'>";
                            echo"<input type='text' name='nombre' placeholder='Nombre'  class='form-input' required>";
                            echo"<input type='text' name='ap-pat' placeholder='Apellido paterno' class='form-input'  required>";
                            echo"<input type='text' name='ap-mat' placeholder='Apellido materno' class='form-input' required>";
                            echo"<input type='text' name='razon' placeholder='Razon de Cliente' class='form-input' required>";
                            echo"<input type='text' name='calle' placeholder='Calle' class='form-input' required>";
                            echo"<input type='text' name='numero-casa' placeholder='Número exterior' class='form-input-corto' required>";
                            echo"<input type='text' name='Codpostal' placeholder='Código postal' class='form-input-corto' required>";
                            echo"<input type='text' name='colonia' placeholder='Colonia' class='form-input' required>";
                            echo"<input type='text' name='estado' placeholder='Estado' class='form-input' required>";
                            echo"<input type='submit' value='Registrar' class='btnenviar'>";
                        echo"</form>";
                    echo"</div>";
                }
                function updateFunc(){
                    echo "<div class='formulario'>";
                        echo"<link rel='stylesheet' href='../css/formulario-registro.css'>";
                        echo "<form action='../php/agregar-cliente.php' method='post' class='form-registro'>";
                            echo"<h2 class='form-titulo'>Actualizar Cliente</h2>";
                            echo"<div class='form-group row'>";
                                echo"<label for='razon' class='col-sm-3 col-form-label'>Razón del Cliente</label>";
                                echo"<div class='col-sm-9'>";
                                    echo"<input type='text' class='form-control' name='razon' placeholder='Razón'>";
                                echo"</div>";
                            echo"</div>";
                            echo"<div class='form-group row'>";
                                echo"<label for='opcion' class='col-sm-3 col-form-label'>Dato a cambiar</label>";
                                echo"<select class='form-control col-sm-4 col-form-label' name='opcion'>";
                                    echo"<option value='nombre_pila'>Nombre</option>";
                                    echo"<option value='apellido_p'>Ap. Paterno</option>";
                                    echo"<option value='apellido_m'>Ap. Materno</option>";
                                    echo"<option value='calle'>Calle</option>";
                                    echo"<option value='numero'>Numero exterior</option>";
                                    echo"<option value='colonia'>Colonia</option>";
                                    echo"<option value='estado'>Estado</option>";
                                    echo"<option value='cp'>Código Postal</option>";
                                echo"</select>";
                                echo"<div class='col-sm-1'></div>";
                                echo"<input type='text' name='dato' placeholder='Dato nuevo' class='form-control col-sm-4 col-form-label' required>";
                                
                            echo"</div";
                            echo"<div class='form-group row'>";
                                echo"<input type='submit' value='Actualizar' class='btnenviar'>";
                            echo"</div>";
                        echo"</form>";
                    echo"</div>";
                }
                function deleteFunc(){
                    echo "<form action='../php/borrar-cliente.php' method='post' class='form-registro'>";
                            echo"<h2 class='form-titulo'>Borrar Cliente</h2>";
                            echo"<br />";
                            echo"<div class='inputs'>";
                            echo"<input type='text' name='razon' placeholder='Ingresa la razon del Cliente a borrar'  class='form-input' required>";
                            echo"<input type='submit' value='Borrar' class='btnenviar'>";
                        echo"</form>";
                    echo"</div>";
                }
                ?>    
                   

            <div class="tabla" id="flotante">
            <link rel="stylesheet" href="../css/tablas.css">
                <table class="table table-success table-striped table-hover table-hover table-responsive-sm
                table-responsive-md table-responsive-lg table-bordered">
                    <thead class="thead-green">
                        <tr>
                            <th scope="col" class="text-center">Razón Cliente</th>
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
                                
                                $funcion = "SELECT * FROM CLIENTE";
                        
                                $tabla=pg_query($conexion, $funcion);
                        
                                $row = 0;
                                if ($tabla):
                                    if( pg_num_rows($tabla) > 0 ):
                                        
                                        while($obj = pg_fetch_object($tabla) ): ?> 
                        <tr>
                            <th scope="row" class="text-center"><?php echo $obj->razon_cliente; ?> </th>
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
            </div>
        </main>

    </body>
</html>