<?php
    ob_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Cliente</title>
    <link rel="stylesheet" href="css/estilos3.css"> 
    <link rel="icon" href="./images/addClient.ico">

</head>
<body>
    <section class="form_add">
        <form action="" class="form_data" method="post" autocomplete="off">
            <center><h1>Agregar Cliente</h1></center>
            <div class="Client-info1">
                <label for="namE">Nombre (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="nombre" placeholder="Nombre">
            </div>
            <div class="Client-info1">
                <label for="aP">Apellido Paterno (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="ap" placeholder="Apellido Paterno">
            </div>
            <div class="Client-info1">
                <label for="aM">Apellido Materno</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="am" placeholder="Apellido Materno">
            </div>
            <div class="Client-info1">
                <label for="rz">Razón Social</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="razon_s" placeholder="Razón Social">
            </div>
            <div class="Client-info1">
                <label for="emaiL">Email #1 (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="email" placeholder="@ Email">
            </div>
            <div class="Client-info1">
                <label for="emaiL2">Email #2</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="email2" placeholder="@ Email">
            </div>
            <div class="Client-info3">
                <label for="callE">Calle (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="calle" placeholder="Calle">
            </div>
            <div class="Client-info3">
                <label for="coloniA">Colonia (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="colonia" placeholder="Colonia">
            </div>
            <div class="Client-info3">
                <label for="numerO">Número (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="numero" placeholder="#">
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
            <div class="Client-info3">
                <label for="telefonO">(*) CAMPOS OBLIGATORIOS</label>
            </div>
            <div class="Btn-Options">
                <center><input type="submit" value="Registrar Cliente" id="btnSend" name="listo"></center>
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
            $aP=$_POST['ap'];
            $aM=$_POST['am'];
            $razon_Social=$_POST['razon_s'];
            $email=$_POST['email'];
            $email2=$_POST['email2'];
            $calle=$_POST['calle'];
            $colonia=$_POST['colonia'];
            $numero=$_POST['numero'];
            $cp=$_POST['cp'];
            $edo=$_POST['edo'];
            $materno=strlen($aM);
            $rS=strlen($razon_Social);
            $corr2=strlen($email2);
            if($materno>0){
                if($rS>0){
                    if($corr2>0){
                        $polixy=strlen($id)*strlen($nombre)*strlen($aP)*strlen($aM)*strlen($razon_Social)*strlen($email)*strlen($email2)*strlen($calle)*strlen($colonia)*strlen($cp)*strlen($edo)*strlen($numero);
                        if($polixy>0){
                            require("conectpsql.php");
                            $consulta = "INSERT INTO persona VALUES('$id','$razon_Social','$nombre','$calle','$numero','$colonia','$cp','$edo','c')";
                            $consulta2= "INSERT INTO cliente VALUES('$email','$id','$aP','$aM')";
                            $consulta3= "INSERT INTO cliente VALUES('$email2','$id','$aP','$aM')";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            $action3= pg_query($dbconn4,$consulta3) or die (pg_last_error($action3));
                            echo "<script>alert('Se ha registrado con exito');</script>";
                            pg_close($dbconn4);
                        }else{
                            echo "<script>alert('Todos los campos son obligaotrios');</script>";
                        }
                    }else{
                        $polixy=strlen($id)*strlen($nombre)*strlen($aP)*strlen($aM)*strlen($razon_Social)*strlen($email)*strlen($calle)*strlen($colonia)*strlen($cp)*strlen($edo)*strlen($numero);
                        if($polixy>0){
                            require("conectpsql.php");
                            $consulta = "INSERT INTO persona VALUES('$id','$razon_Social','$nombre','$calle','$numero','$colonia','$cp','$edo','c')";
                            $consulta2= "INSERT INTO cliente VALUES('$email','$id','$aP','$aM')";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            echo "<script>alert('Se ha registrado con exito');</script>";
                            pg_close($dbconn4);
                        }else{
                            echo "<script>alert('Todos los campos son obligaotrios');</script>";
                        } 
                    }   
                }else{
                    if($corr2>0){
                        $polixy=strlen($id)*strlen($nombre)*strlen($aP)*strlen($aM)*strlen($email)*strlen($email2)*strlen($calle)*strlen($colonia)*strlen($cp)*strlen($edo)*strlen($numero);
                        if($polixy>0){
                            require("conectpsql.php");
                            $consulta = "INSERT INTO persona VALUES('$id',NULL,'$nombre','$calle','$numero','$colonia','$cp','$edo','c')";
                            $consulta2= "INSERT INTO cliente VALUES('$email','$id','$aP','$aM')";
                            $consulta3= "INSERT INTO cliente VALUES('$email2','$id','$aP','$aM')";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            $action3= pg_query($dbconn4,$consulta3) or die (pg_last_error($action3));
                            echo "<script>alert('Se ha registrado con exito');</script>";
                            pg_close($dbconn4);
                        }else{
                            echo "<script>alert('Todos los campos son obligaotrios');</script>";
                        }
                    }else{
                        $polixy=strlen($id)*strlen($nombre)*strlen($aP)*strlen($aM)*strlen($email)*strlen($calle)*strlen($colonia)*strlen($cp)*strlen($edo)*strlen($numero);
                        if($polixy>0){
                            require("conectpsql.php");
                            $consulta = "INSERT INTO persona VALUES('$id',NULL,'$nombre','$calle','$numero','$colonia','$cp','$edo','c')";
                            $consulta2= "INSERT INTO cliente VALUES('$email','$id','$aP','$aM')";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            echo "<script>alert('Se ha registrado con exito');</script>";
                            pg_close($dbconn4);
                        }else{
                            echo "<script>alert('Todos los campos son obligaotrios');</script>";
                        }
                    } 
                }    
            }else{
                if($rS>0){
                    if($email2>0){
                        $polixy=strlen($id)*strlen($nombre)*strlen($aP)*strlen($razon_Social)*strlen($email)*strlen($email2)*strlen($calle)*strlen($colonia)*strlen($numero)*strlen($cp)*strlen($edo);
                        if($polixy>0){
                            require("conectpsql.php");
                            $consulta = "INSERT INTO persona VALUES('$id','$razon_Social','$nombre','$calle','$numero','$colonia','$cp','$edo','c')";
                            $consulta2= "INSERT INTO cliente VALUES('$email','$id','$aP',NULL)";
                            $consulta3= "INSERT INTO cliente VALUES('$email2','$id','$aP',NULL)";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            $action3= pg_query($dbconn4,$consulta3) or die (pg_last_error($action3));
                            echo "<script>alert('Se ha registrado con exito');</script>";
                            pg_close($dbconn4);
                        }else{
                            echo "<script>alert('Todos los campos (*) son obligaotrios');</script>";
                        }
                    }else{
                        $polixy=strlen($id)*strlen($nombre)*strlen($aP)*strlen($razon_Social)*strlen($email)*strlen($calle)*strlen($colonia)*strlen($numero)*strlen($cp)*strlen($edo);
                        if($polixy>0){
                            require("conectpsql.php");
                            $consulta = "INSERT INTO persona VALUES('$id','$razon_Social','$nombre','$calle','$numero','$colonia','$cp','$edo','c')";
                            $consulta2= "INSERT INTO cliente VALUES('$email','$id','$aP',NULL)";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            echo "<script>alert('Se ha registrado con exito');</script>";
                            pg_close($dbconn4);
                        }else{
                            echo "<script>alert('Todos los campos (*) son obligaotrios');</script>";
                        }
                    }  
                }else{
                    if($email2>0){
                        $polixy=strlen($id)*strlen($nombre)*strlen($aP)*strlen($email)*strlen($email2)*strlen($calle)*strlen($colonia)*strlen($numero)*strlen($cp)*strlen($edo);
                        if($polixy>0){
                            require("conectpsql.php");
                            $consulta = "INSERT INTO persona VALUES('$id',NULL,'$nombre','$calle','$numero','$colonia','$cp','$edo','c')";
                            $consulta2= "INSERT INTO cliente VALUES('$email','$id','$aP',NULL)";
                            $consulta3= "INSERT INTO cliente VALUES('$email2','$id','$aP',NULL)";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            $action3= pg_query($dbconn4,$consulta3) or die (pg_last_error($action3));
                            echo "<script>alert('Se ha registrado con exito');</script>";
                            pg_close($dbconn4);
                        }else{
                            echo "<script>alert('Todos los campos (*) son obligaotrios');</script>";
                        }
                    }else{
                        $polixy=strlen($id)*strlen($nombre)*strlen($aP)*strlen($email)*strlen($calle)*strlen($colonia)*strlen($numero)*strlen($cp)*strlen($edo);
                        if($polixy>0){
                            require("conectpsql.php");
                            $consulta = "INSERT INTO persona VALUES('$id',NULL,'$nombre','$calle','$numero','$colonia','$cp','$edo','c')";
                            $consulta2= "INSERT INTO cliente VALUES('$email','$id','$aP',NULL)";
                            $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                            $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                            echo "<script>alert('Se ha registrado con exito');</script>";
                            pg_close($dbconn4);
                        }else{
                            echo "<script>alert('Todos los campos (*) son obligaotrios');</script>";
                        }
                    }
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