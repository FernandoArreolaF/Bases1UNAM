<?php
    ob_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Proveedor</title>
    <link rel="stylesheet" href="css/estilos7.css"> 
    <link rel="icon" href="./images/addProvider.ico">
</head>
<body>
    <section class="form_add">
        <form action="" class="form_data" method="post" autocomplete="off">
            <center><h1>Agregar Proveedor</h1></center>
            <div class="Client-info1">
                <label for="namE">Nombre (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="nombre" placeholder="Nombre">
            </div>
            <div class="Client-info1">
                <label for="rz">Razón Social (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="razon_s" placeholder="Razón Social">
            </div>
            <div class="Client-info3">
                <label for="callE">Calle (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="calle" placeholder="Calle">
            </div>
            <div class="Client-info3">
                <label for="numerO">Número (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="numero" placeholder="#">
            </div>
            <div class="Client-info3">
                <label for="coloniA">Colonia (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="colonia" placeholder="Colonia">
            </div>
            <div class="Client-info3">
                <label for="cP">Código Postal (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="cp" placeholder="CP">
            </div>
            <div class="Client-info1">
                <label for="edO">Estado (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="edo" placeholder="Entidad Federativa">
            </div>
            <div class="Client-info1">
                <label for="tL1">Telefono 1(*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="tl1" placeholder="# Telefono">
            </div>
            <div class="Client-info1">
                <label for="tL2">Telefono 2</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="tl2" placeholder="# Telefono">
            </div>
            <div class="Client-info1">
                <label for="tL3">Telefono 3</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="tl3" placeholder="# Telefono">
            </div>
            <div class="Client-info3">
                <label for="Campos">(*) CAMPOS OBLIGATORIOS</label>
            </div>
            <div class="Btn-Options">
                <center><input type="submit" value="Registrar Proveedor" id="btnSend" name="listo"></center>
                <center><input type="submit" value="Atras" id="btnCancel" name="exiT"></center>
            </div>
        </form>
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
        if(isset($_POST['listo'])){
            require("conectpsql.php");
            $consultaID="SELECT COUNT(*) FROM persona";
            $act = pg_query($dbconn4,$consultaID) or die (pg_last_error($act));
            while($valor=pg_fetch_array($act)){
                $idAct=$valor[0];
                pg_close($dbconn4);
                $id=$idAct+1;
                $nombre=$_POST['nombre'];
                $razon_Social=$_POST['razon_s'];
                $calle=$_POST['calle'];
                $colonia=$_POST['colonia'];
                $numero=$_POST['numero'];
                $cp=$_POST['cp'];
                $edo=$_POST['edo'];
                $tl1=$_POST['tl1'];
                $tl2=$_POST['tl2'];
                $tl3=$_POST['tl3'];
                $segundot=strlen($tl2);
                if($segundot>0){
                    $tercert=strlen($tl3);
                    if($tercert>0){
                        $polixy=strlen($id)*strlen($nombre)*strlen($razon_Social)*strlen($calle)*strlen($colonia)*strlen($cp)*strlen($edo)*strlen($tl1)*strlen($tl2)*strlen($tl3);
                        if($polixy>0){
                            if($tercert < 10 || $tercert>10){
                                echo "<script>alert('El telefono 3 no es de 10 digitos');</script>";
                            }else{
                                if($segundot < 10 || $segundot>10){
                                    echo "<script>alert('El telefono 2 no es de 10 digitos');</script>";
                                }else{
                                    $longitud1=strlen($tl1);
                                    if($longitud1<10 || $longitud1>10){
                                        echo "<script>alert('El telefono 1 no es de 10 digitos');</script>";   
                                    }else{
                                        if($tl2==0 || $tl1 == 0 || $tl3==0 ){
                                            if($tl2==0 && $tl1 ==0 && $tl3==0){
                                                echo "<script>alert('Los telefonos no son validos');</script>";
                                            }else{
                                                if($tl2==0 && $tl1 ==0){
                                                    echo "<script>alert('Los telefonos 1 y 2 no son validos');</script>";
                                                }else{
                                                    if($tl2==0 && $tl3 ==0){
                                                        echo "<script>alert('Los telefonos 2 y 3no son validos');</script>";
                                                    }else{
                                                        if($tl3==0 && $tl1 ==0){
                                                            echo "<script>alert('Los telefonos 1 y 3 no son validos');</script>";
                                                        }else{
                                                            if($tl2==0){
                                                                echo "<script>alert('El telefono 2 no es valido');</script>";
                                                            }else{
                                                                if($tl3==0){
                                                                    echo "<script>alert('El telefono 3 no es valido');</script>";
                                                                }else{                                                   
                                                                        echo "<script>alert('El telefono 1 no es valido');</script>";                                                                   
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }else{
                                            require("conectpsql.php");
                                            $consulta = "INSERT INTO persona VALUES('$id','$razon_Social','$nombre','$calle','$numero','$colonia','$cp','$edo','p')";
                                            $consulta2= "INSERT INTO proveedor VALUES('$tl1','$id')";
                                            $consulta3= "INSERT INTO proveedor VALUES('$tl2','$id')";
                                            $consulta4= "INSERT INTO proveedor VALUES('$tl3','$id')";
                                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action));
                                            $action3= pg_query($dbconn4,$consulta3) or die (pg_last_error($action));
                                            echo "<script>alert('Se ha registrado con exito');</script>";
                                            pg_close($dbconn4);
                                        }
                                    }
                                }
                            }
                        }else{
                            echo "<script>alert('Todos los campos son obligaotrios $calle');</script>";
                        }
                    }else{
                        $polixy=strlen($id)*strlen($nombre)*strlen($razon_Social)*strlen($calle)*strlen($colonia)*strlen($cp)*strlen($edo)*strlen($tl1)*strlen($tl2);
                        if($polixy>0){
                            if($segundot < 10 || $segundot>10){
                                echo "<script>alert('El telefono 2 no es de 10 digitos');</script>";
                            }else{
                                $longitud1=strlen($tl1);
                                if($longitud1<10 || $longitud1>10){
                                    echo "<script>alert('El telefono no es de 10 digitos');</script>";   
                                }else{
                                    if($tl2==0 || $tl1 == 0 ){
                                        if($tl2==0 && $tl1 ==0){
                                            echo "<script>alert('Los telefonos no son validos');</script>";
                                        }else{
                                            if($tl2==0){
                                                echo "<script>alert('El telefono 2 no es valido');</script>";
                                            }else{
                                                echo "<script>alert('El telefono 1 no es valido');</script>";
                                            }
                                        }
                                    }else{
                                        require("conectpsql.php");
                                        $consulta = "INSERT INTO persona VALUES('$id','$razon_Social','$nombre','$calle','$numero','$colonia','$cp','$edo','p')";
                                        $consulta2= "INSERT INTO proveedor VALUES('$tl1','$id')";
                                        $consulta3= "INSERT INTO proveedor VALUES('$tl2','$id')";
                                        $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                                        $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action));
                                        $action3= pg_query($dbconn4,$consulta3) or die (pg_last_error($action));
                                        echo "<script>alert('Se ha registrado con exito');</script>";
                                        pg_close($dbconn4);
                                    }
                                }
                            }
                        }else{
                            echo "<script>alert('Todos los campos son obligaotrios $calle');</script>";
                        }
                    }
                }else{
                    $polixy=strlen($id)*strlen($nombre)*strlen($razon_Social)*strlen($calle)*strlen($colonia)*strlen($tl1)*strlen($cp)*strlen($edo);
                    if($polixy>0){
                        $longitud1=strlen($tl1);
                        if($longitud1<10 || $longitud1>10){
                            echo "<script>alert('El telefono no es de 10 digitos');</script>";   
                        }else{
                            if($tl1==0){
                                echo "<script>alert('El telefono no es valido');</script>";
                            }else{
                                require("conectpsql.php");
                                $consulta = "INSERT INTO persona VALUES('$id','$razon_Social','$nombre','$calle','$numero','$colonia','$cp','$edo','p')";
                                $consulta2= "INSERT INTO proveedor VALUES('$tl1','$id')";
                                $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                                $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action));
                                echo "<script>alert('Se ha registrado con exito');</script>";
                                pg_close($dbconn4);
                            }
                        }
                    }else{
                        echo "<script>alert('Todos los campos (*) son obligaotrios');</script>";
                    }
                }
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