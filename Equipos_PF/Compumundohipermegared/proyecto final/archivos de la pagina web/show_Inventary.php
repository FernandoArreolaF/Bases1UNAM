<?php
    ob_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario</title>
    <link rel="stylesheet" href="css/estilos6.css"> 
    <link rel="icon" href="./images/show_Inv.ico">
</head>
<body>
    <section class="form_show">
        <div class="tabla">
            <table>
                <tr>
                    <th>Código de Barras</th>
                    <th>Marca</th>
                    <th>Precio de Adquisición</th>
                    <th>Precio de Venta</th>
                    <th>Fecha de compra</th>
                    <th>Artículos en stock</th>
                    <th>Descripción</th>
                    <th>ID de Proveedor</th>
                </tr>
                <?php
                    $consulta= "SELECT * FROM producto ORDER BY descripcion asc";
                    require("conectpsql.php");
                    $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                    $verFilas=pg_num_rows($action);
                    $filas=pg_fetch_array($action);
                    if(!$action){
                        echo "<script>alert('Error en la consulta');</script>";
                    }else{
                        if($verFilas<1){
                            echo "<tr><td>Sin registros</td></tr>";
                        }else{
                            for($i=0;$i<=$filas;$i++){
                                echo'
                                    <tr>
                                    <td>'.$filas[0].'</td>
                                    <td>'.$filas[1].'</td>
                                    <td>'.$filas[2].'</td>
                                    <td>'.$filas[3].'</td>
                                    <td>'.$filas[4].'</td>
                                    <td>'.$filas[5].'</td>
                                    <td>'.$filas[6].'</td>
                                    <td>'.$filas[8].'</td>
                                    </tr>
                                ';
                                $filas = pg_fetch_array($action);
                            }
                        }
                    }

                ?>
            </table>
        </div>

    </section>
    <footer>
        <div class="foot">Compumundohipermegared &copy;</div>
    </footer>
</body>
</html>
<?php
    session_start();
    $usuario=$_SESSION['username'];
    if(!isset($usuario)){
        header("location:index.php");
    }else{

    }
?>
<?php
    ob_end_flush();
?>