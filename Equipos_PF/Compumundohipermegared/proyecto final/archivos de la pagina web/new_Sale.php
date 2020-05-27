<?php
    ob_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ingresar Venta</title>
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <link rel="stylesheet" href="css/estilos4.css"> 
    <link rel="icon" href="./images/addSale.ico">
    

</head>
<body>
    <section class="form_add">
        <form name="formulario" id="Formulario" action="" onSubmit="enviarDatos(); return false"class="form_data" method="post" autocomplete="off">
            <center><h1>Venta</h1></center>
            <div class="Client-info1">
                <label for="client">Selecciona Cliente #1 (*)</label>
            </div>
            <div class="Client-info2">
               <select name="id_Selector" id="id_Selector"  class="form-control">
                  <option>Seleccione Cliente</option>
                  <?php
                     require("conectpsql.php");
                     $consulta= "SELECT * FROM persona WHERE tipo = 'c' ORDER BY nombre ASC";
                     $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                     while ($valores = pg_fetch_array($action)) {
                           echo '<option value="'.$valores[id_persona].'">'.$valores[nombre].'</option>';
                     }
                     pg_close($dbconn4);
                  ?>
               </select>
            </div>
            <div class="Client-info1">
                <label for="art_1">¿Cliente nuevo? Agregalo ahora</label>
            </div>
            <div class="Btn-OptionsADD">
               <button type="button" id="add_client" class="form_nC" onclick="window.location.href='new_Client2.php'">Agregar Cliente</button>
            </div>
           <div class="Client-info1">
                <label for="art_1">Selecciona Artículo #1 (*)</label>
            </div>
            <div class="Client-info2">
                <select name="rol" class="form-control">
                    <option>Seleccione Artículo #1</option>
                    <?php
                        require("conectpsql.php");
                        $consulta= "SELECT DISTINCT descripcion FROM producto ORDER BY descripcion ASC";
                        $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                        while ($valores = pg_fetch_array($action)) {
                            echo '<option value="'.$valores[descripcion].'">'.$valores[descripcion].'</option>';
                        }
                        pg_close($dbconn4);
                    ?>
                </select>
            </div>
            <div class="Client-info1">
                <label for="cantidad_1">Cantidad de Artículo #1 (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="C_1" placeholder="Cantidad de Artículo 1">
            </div>
            </div>
            <div class="Client-info1">
                <label for="art_2">Selecciona Artículo #2</label>
            </div>
            <div class="Client-info2">
                <select name="rol2" class="form-control">
                    <option>Seleccione Artículo #2</option>
                    <?php
                        require("conectpsql.php");
                        $consulta3= "SELECT DISTINCT descripcion FROM producto ORDER BY descripcion ASC";
                        $action3= pg_query($dbconn4,$consulta) or die (pg_last_error($action3));
                        while ($valores = pg_fetch_array($action3)) {
                            echo '<option value="'.$valores[descripcion].'">'.$valores[descripcion].'</option>';
                        }
                        pg_close($dbconn4);
                    ?>
                </select>
            </div>
            <div class="Client-info1">
                <label for="cantidad_2">Cantidad de Artículo #2</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="C_2" placeholder="Cantidad de Artículo 2">
            </div>
            <div class="Client-info1">
                <label for="art_3">Selecciona Artículo #3</label>
            </div>
            <div class="Client-info2">
                <select name="rol3" class="form-control">
                    <option>Seleccione Artículo #3</option>
                    <?php
                        require("conectpsql.php");
                        $consulta= "SELECT DISTINCT descripcion FROM producto ORDER BY descripcion ASC";
                        $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                        while ($valores = pg_fetch_array($action)) {
                            echo '<option value="'.$valores[descripcion].'">'.$valores[descripcion].'</option>';
                        }
                        pg_close($dbconn4);
                    ?>
                </select>
            </div>
            <div class="Client-info1">
                <label for="cantidad_3">Cantidad de Artículo #3</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="C_3" placeholder="Cantidad de Artículo 3">
            </div>
            <div class="Client-info3">
                <label for="restriccion">(*) CAMPOS OBLIGATORIOS</label>
            </div>
            <div class="Btn-Options">
               <center><button type="button" id="Enviar" class="form_nC" >Agregar Venta</button></center>
                <center><input type="submit" value="Cancelar" id="btnCancel" name="exiT"></center>
                <center><input type="submit" value="Confirmar Venta" id="btnSend2" name="listo2"></center>
            </div>
        </form>
        <div id="Respuesta" class="rs"></div>
    </section>
    <footer>
        <div class="foot">Compumundohipermegared &copy;</div>
    </footer>
</body>
<script>
   $('#Enviar').click(function(){
      $.ajax({
         url: 'otra.php',
         type: 'POST',
         data: $('#Formulario').serialize(),
         success: function(res){
            $('#Respuesta').html(res);
         }
      });
   });
</script>
</html>
<?php
    session_start();
    $usuario=$_SESSION['username'];
    if(!isset($usuario)){
        header("location:index.php");
    }else{
        if(isset($_POST['listo2'])){
            $idClient=$_POST['id_Selector'];
            $articulo1=$_POST['rol'];
            $cantidad1=$_POST['C_1'];
            $articulo2=$_POST['rol2'];
            $cantidad2=$_POST['C_2'];
            $articulo3=$_POST['rol3'];
            $cantidad3=$_POST['C_3'];
            date_default_timezone_set('America/Mexico_City'); //configuro el timezone de México
            $fecha_actual = new DateTime('NOW');
            $fecha= $fecha_actual->format('Y-m-d');
            $polixy=strlen($articulo1)*strlen($cantidad1)*strlen($idClient);
            $polixy2=strlen($articulo2)*strlen($cantidad2)*strlen($idClient);
            $polixy3=strlen($articulo3)*strlen($cantidad3)*strlen($idClient);
            if($polixy>0){
                if($polixy2>0){
                    if($polixy3>0){
                        if($cantidad1>0 && $cantidad2>0 && $cantidad3>0){
                            require("conectpsql.php");
                            $con = "SELECT email FROM cliente WHERE id_persona = $idClient FETCH FIRST 1 ROWS ONLY";
                            $act = pg_query($dbconn4,$con) or die (pg_last_error($act));
                            while($valor=pg_fetch_array($act)){
                                $email= $valor[0];
                            }
                            // Obtenemos el codigo de barras del primer articulo y su precio unitario
                            $con2= "SELECT * FROM producto where descripcion='$articulo1'";
                            $act2= pg_query($dbconn4,$con2) or die (pg_last_error($act2));
                            $arr = pg_fetch_array($act2);
                            $codigo1=$arr[0];
                            $precio1=$arr[3];
                            $stock=$arr[5];
                            // Obtenemos el codigo de barras del segundo articulo y su precio unitario
                            $conn= "SELECT * FROM producto where descripcion='$articulo2'";
                            $actt= pg_query($dbconn4,$conn) or die (pg_last_error($actt));
                            $arrr = pg_fetch_array($actt);
                            $codigo2=$arrr[0];
                            $precio2=$arrr[3];
                            $stock2=$arrr[5];
                            // Obtenemos el codigo de barras del tercer articulo y su precio unitario
                            $conn2= "SELECT * FROM producto where descripcion='$articulo3'";
                            $actt2= pg_query($dbconn4,$conn2) or die (pg_last_error($actt2));
                            $arrr2 = pg_fetch_array($actt2);
                            $codigo3=$arrr2[0];
                            $precio3=$arrr2[3];
                            $stock3=$arrr2[5];
                            if($cantidad1>$stock || $cantidad2>$stock2 || $cantidad3>$stock3){
                                if($cantidad1>$stock && $cantidad2>$stock2 && $cantidad3>$stock3){
                                    echo "<script>alert('Lo sentimos, solo contamos con $stock unidades de $articulo1, $stock2 unidades de $articulo2 y $stock3 unidades de $articulo3');</script>";
                                }else{
                                    if($cantidad1>$stock && $cantidad2>$stock2){
                                        echo "<script>alert('Lo sentimos, solo contamos con $stock unidades de $articulo1 y $stock2 unidades de $articulo2');</script>";
                                    }else{
                                        if($cantidad1>$stock && $cantidad3>$stock3){
                                            echo "<script>alert('Lo sentimos, solo contamos con $stock unidades de $articulo1 y $stock3 unidades de $articulo3');</script>";
                                        }else{
                                            if($cantidad2>$stock2 && $cantidad3>$stock3){
                                                echo "<script>alert('Lo sentimos, solo contamos con $stock2 unidades de $articulo2 y $stock3 unidades de $articulo3');</script>";
                                            }else{
                                                if($cantidad1>$stock){
                                                    echo "<script>alert('Lo sentimos, solo contamos con $stock unidades de $articulo1');</script>";
                                                }else{
                                                    if($cantidad2>$stock2){
                                                        echo "<script>alert('Lo sentimos, solo contamos con $stock2 unidades de $articulo2');</script>";
                                                    }else{
                                                        if($cantidad3>$stock3){
                                                            echo "<script>alert('Lo sentimos, solo contamos con $stock3 unidades de $articulo3');</script>";
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }else{
                                // Obtenemos los precios de venta por articulo y el precio total
                                $subprecio1= $cantidad1*$precio1;
                                $subprecio2= $cantidad2*$precio2;
                                $subprecio3= $cantidad3*$precio3;
                                $PT2=$subprecio1+$subprecio2+$subprecio3;
                                // Insertamos los datos de la venta en la tabla venta
                                $consulta = "INSERT INTO venta (fecha_venta,pago_total,email,id_persona) VALUES('$fecha','$PT2','$email','$idClient')";
                                $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                                pg_close($dbconn4);
                                require("conectpsql.php");
                                // Recuperamos el numero de venta de la tabla venta
                                $con3= "SELECT * FROM venta WHERE pago_total = $PT2 AND id_persona = $idClient AND fecha_venta= '$fecha'";
                                $act3= pg_query($dbconn4,$con3) or die (pg_last_error($act3));
                                $arr2 = pg_fetch_array($act3);
                                $numero_Venta=$arr2[0];
                                // Insertamos los datos del primer articulo vendido en detalle_venta
                                $consulta2 = "INSERT INTO detalle_venta VALUES('$codigo1','$numero_Venta','$precio1','$cantidad1')";
                                $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                                // Insertamos los datos del segundo articulo vendido en detalle_venta
                                $consultaa2 = "INSERT INTO detalle_venta VALUES('$codigo2','$numero_Venta','$precio2','$cantidad2')";
                                $actionn2= pg_query($dbconn4,$consultaa2) or die (pg_last_error($actionn2));
                                // Insertamos los datos del tercer articulo vendido en detalle_venta
                                $consultaa3 = "INSERT INTO detalle_venta VALUES('$codigo3','$numero_Venta','$precio3','$cantidad3')";
                                $actionn3= pg_query($dbconn4,$consultaa3) or die (pg_last_error($actionn3));
                                $new_Stock=$stock-$cantidad1;
                                $new_Stock2=$stock2-$cantidad2;
                                $new_Stock3=$stock3-$cantidad3;
                                if($new_Stock<4 || $new_Stock2<4 || $new_Stock3<4){
                                    if($new_Stock<4 && $new_Stock2<4 && $new_Stock3<4){
                                        echo "<script>alert('Se ha registrado con éxito quedan $new_Stock unidades de $articulo1, $new_Stock2 unidades de $articulo2 y $new_Stock3 unidades de $articulo3 en existencia');</script>";
                                        pg_close($dbconn4);
                                    }else{
                                        if($new_Stock<4 && $new_Stock2<4){
                                            echo "<script>alert('Se ha registrado con éxito quedan $new_Stock unidades de $articulo1 y $new_Stock2 unidades de $articulo2 en existencia');</script>";
                                            pg_close($dbconn4);
                                        }else{
                                            if($new_Stock<4 && $new_Stock3<4){
                                                echo "<script>alert('Se ha registrado con éxito quedan $new_Stock unidades de $articulo1 y $new_Stock3 unidades de $articulo3 en existencia');</script>";
                                                pg_close($dbconn4);
                                            }
                                            else{
                                                if($new_Stock2<4 && $new_Stock3<4){
                                                    echo "<script>alert('Se ha registrado con éxito quedan $new_Stock2 unidades de $articulo2 y $new_Stock2 unidades de $articulo3 en existencia');</script>";
                                                    pg_close($dbconn4);
                                                }else{
                                                    if($new_Stock3<4){
                                                        echo "<script>alert('Se ha registrado con éxito quedan $new_Stock3 unidades de $articulo3 en existencia');</script>";
                                                        pg_close($dbconn4);  
                                                    }else{
                                                        if($new_Stock2<4){
                                                            echo "<script>alert('Se ha registrado con éxito quedan $new_Stock2 unidades de $articulo2 en existencia');</script>";
                                                            pg_close($dbconn4);  
                                                        }else{
                                                            echo "<script>alert('Se ha registrado con éxito quedan $new_Stock unidades de $articulo1 en existencia');</script>";
                                                            pg_close($dbconn4);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }else{
                                    echo "<script>alert('Se ha registrado con éxito');</script>";
                                    pg_close($dbconn4);
                                }
                            }   
                        }else{
                            if($cantidad1 <= 0 || $cantidad2 <= 0 || $cantidad3 <= 0){
                                echo "<script>alert('Ingresa una cantidad valida para los articulos');</script>";
                            }
                        }
                    }else{
                            if($cantidad1>0 && $cantidad2>0){
                                require("conectpsql.php");
                                $con = "SELECT email FROM cliente WHERE id_persona = $idClient FETCH FIRST 1 ROWS ONLY";
                                $act = pg_query($dbconn4,$con) or die (pg_last_error($act));
                                while($valor=pg_fetch_array($act)){
                                    $email= $valor[0];
                                }
                                // Obtenemos el codigo de barras del primer articulo y su precio unitario
                                $con2= "SELECT * FROM producto where descripcion='$articulo1'";
                                $act2= pg_query($dbconn4,$con2) or die (pg_last_error($act2));
                                $arr = pg_fetch_array($act2);
                                $codigo1=$arr[0];
                                $precio1=$arr[3];
                                $stock=$arr[5];
                                // Obtenemos el codigo de barras del segundo articulo y su precio unitario
                                $conn= "SELECT * FROM producto where descripcion='$articulo2'";
                                $actt= pg_query($dbconn4,$conn) or die (pg_last_error($actt));
                                $arrr = pg_fetch_array($actt);
                                $codigo2=$arrr[0];
                                $precio2=$arrr[3];
                                $stock2=$arrr[5];
                                if($cantidad1>$stock || $cantidad2>$stock2){
                                    if($cantidad1>$stock && $cantidad2>$stock2){
                                        echo "<script>alert('Lo sentimos, solo contamos con $stock unidades de $articulo1 y $stock2 unidades de $articulo2');</script>";
                                    }else{
                                        if($cantidad1>$stock){
                                            echo "<script>alert('Lo sentimos, solo contamos con $stock unidades de $articulo1');</script>";
                                        }else{
                                            echo "<script>alert('Lo sentimos, solo contamos con $stock2 unidades de $articulo2');</script>";
                                        }
                                    }
                                }else{
                                    // Obtenemos los precios de venta por articulo y el precio total
                                    $subprecio1= $cantidad1*$precio1;
                                    $subprecio2= $cantidad2*$precio2;
                                    $PT1=$subprecio1+$subprecio2;
                                    // Insertamos los datos de la venta en la tabla venta
                                    $consulta = "INSERT INTO venta (fecha_venta,pago_total,email,id_persona) VALUES('$fecha','$PT1','$email','$idClient')";
                                    $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                                    pg_close($dbconn4);
                                    require("conectpsql.php");
                                    // Recuperamos el numero de venta de la tabla venta
                                    $con3= "SELECT * FROM venta WHERE pago_total = $PT1 AND id_persona = $idClient AND fecha_venta= '$fecha'";
                                    $act3= pg_query($dbconn4,$con3) or die (pg_last_error($act3));
                                    $arr2 = pg_fetch_array($act3);
                                    $numero_Venta=$arr2[0];
                                    // Insertamos los datos del primer articulo vendido en detalle_venta
                                    $consulta2 = "INSERT INTO detalle_venta VALUES('$codigo1','$numero_Venta','$precio1','$cantidad1')";
                                    $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                                    // Insertamos los datos del segundo articulo vendido en detalle_venta
                                    $consultaa2 = "INSERT INTO detalle_venta VALUES('$codigo2','$numero_Venta','$precio2','$cantidad2')";
                                    $actionn2= pg_query($dbconn4,$consultaa2) or die (pg_last_error($actionn2));
                                    $new_Stock=$stock-$cantidad1;
                                    $new_Stock2=$stock2-$cantidad2;
                                    if($new_Stock<4 || $new_Stock2<4){
                                        if($new_Stock<4 && $new_Stock2<4){
                                            echo "<script>alert('Se ha registrado con éxito quedan $new_Stock unidades de $articulo1 y $new_Stock2 unidades de $articulo2 en existencia');</script>";
                                            pg_close($dbconn4);
                                        }else{
                                            if($new_Stock<4){
                                                echo "<script>alert('Se ha registrado con éxito quedan $new_Stock unidades de $articulo1 en existencia');</script>";
                                                pg_close($dbconn4); 
                                            }else{
                                                echo "<script>alert('Se ha registrado con éxito quedan $new_Stock2 unidades de $articulo2 en existencia');</script>";
                                                pg_close($dbconn4); 
                                            }
                                        }
                                    }else{
                                        echo "<script>alert('Se ha registrado con exito');</script>";
                                        pg_close($dbconn4);
                                    }
                                }
                            }else{
                                if($cantidad1 <= 0 || $cantidad2 <= 0){
                                    echo "<script>alert('No es posible confirmar venta, ingresa una cantidad valida para los articulos');</script>";
                                }
                            }
                    }
                }else{
                    if($cantidad1>0){
                        require("conectpsql.php");
                        $con = "SELECT email FROM cliente WHERE id_persona = $idClient FETCH FIRST 1 ROWS ONLY";
                        $act = pg_query($dbconn4,$con) or die (pg_last_error($act));
                        while($valor=pg_fetch_array($act)){
                            $email= $valor[0];
                        }
                        $con2= "SELECT * FROM producto where descripcion='$articulo1'";
                        $act2= pg_query($dbconn4,$con2) or die (pg_last_error($act2));
                        $arr = pg_fetch_array($act2);
                        $codigo1=$arr[0];
                        $precio1=$arr[3];
                        $stock=$arr[5];
                        if($cantidad1>$stock){
                            echo "<script>alert('Lo sentimos, solo contamos con $stock unidades de $articulo1');</script>";
                        }else{
                            $subprecio1= $cantidad1*$precio1;
                            $consulta = "INSERT INTO venta (fecha_venta,pago_total,email,id_persona) VALUES('$fecha','$subprecio1','$email','$idClient')";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            pg_close($dbconn4);
                            require("conectpsql.php");
                            $con3= "SELECT * FROM venta WHERE pago_total = $subprecio1 AND id_persona = $idClient AND fecha_venta= '$fecha'";
                            $act3= pg_query($dbconn4,$con3) or die (pg_last_error($act3));
                            $arr2 = pg_fetch_array($act3);
                            $numero_Venta=$arr2[0];
                            $consulta2 = "INSERT INTO detalle_venta VALUES('$codigo1','$numero_Venta','$precio1','$cantidad1')";
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            $new_Stock=$stock-$cantidad1;
                            if($new_Stock<4){
                                echo "<script>alert('Se ha registrado con éxito quedan $new_Stock unidades de $articulo1 en existencia');</script>";
                                pg_close($dbconn4);  
                            }else{
                                echo "<script>alert('Se ha registrado con éxito');</script>";
                                pg_close($dbconn4);
                            }
                        }    
                    }else{
                        echo "<script>alert('No es posible confirmar venta, ingresa una cantidad valida para el articulo 1');</script>";
                    } 
                }
            }else{
                echo "<script>alert('No has llenado ningun campo para la venta');</script>";
            }
        }
        if(isset($_POST["exiT"])){
            header("location:principal.php");
        }
    }
    
?>
<?php
    ob_end_flush();
?>