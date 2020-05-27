<?php
    ob_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Producto</title>
    <link rel="stylesheet" href="css/estilos5.css"> 
    <link rel="icon" href="./images/AddProduct.ico">
</head>
<body>
    <section class="form_add">
        <form action="" class="form_data" method="post" autocomplete="off">
            <center><h1>Agregar Producto</h1></center>
            <div class="Client-info1">
                <label for="iD">Código de Barras (*)</label>  
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="id" placeholder="Código de Barras 6 dígitos numéricos">
            </div>
            <div class="Client-info1">
                <label for="desC">Descripción (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="des" placeholder="Descripción">
            </div>
            <div class="Client-info1">
                <label for="mC">Marca (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="marca" placeholder="Marca">
            </div>
            <div class="Client-info1">
                <label for="pA">Precio de Adquisición (*)</label>
            </div>
            <div class="Client-info2">
                <input class="inputs" type="text" name="precio_A" placeholder="$ Precio Adquisición">
            </div>
            <div class="Client-info3">
                <label for="pV">Precio de Venta (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="precio_V" placeholder="$ Precio Venta">
            </div>
            <div class="Client-info3">
                <label for="sK">Stock (*)</label>
            </div>
            <div class="Client-info4">
                <input class="inputs" type="text" name="stock" placeholder="# Stock">
            </div>
            <div class="Client-info1">
                <label for="id_P">Proveedor (*)</label>
            </div>
            <div class="Client-info2">
                <select name="id_Selector" id="id_Selector"  class="form-control">
                    <option>Seleccione Proveedor</option>
                    <?php
                        require("conectpsql.php");
                        $consulta= "SELECT * FROM persona WHERE tipo = 'p' ORDER BY nombre ASC";
                        $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                        while ($valores = pg_fetch_array($action)) {
                            echo '<option value="'.$valores[id_persona].'">'.$valores[nombre].'</option>';
                        }
                        pg_close($dbconn4);
                    ?>
                </select>
            </div>
            <div class="Client-info1">
                <label for="art_1">¿Proveedor nuevo? Agregalo ahora</label>
            </div>
            <div class="Btn-OptionsADD">
               <button type="button" id="add_client" class="form_nC" onclick="window.location.href='new_Pr2.php'">Agregar Proveedor</button>
            </div>
            <div class="Client-info5">
                <label for="telefonO">(*) CAMPOS OBLIGATORIOS</label>
            </div>
            <div class="Btn-Options">
                <center><input type="submit" value="Registrar Producto" id="btnSend" name="listo"></center>
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
            $id=$_POST['id'];
            $codigo_6=strlen($id);
            if($codigo_6 == 6){
                if($id>0){
                    $marca=$_POST['marca'];
                    $Pa=$_POST['precio_A'];
                    $Pv=$_POST['precio_V'];
                    date_default_timezone_set('America/Mexico_City'); //configuro el timezone de México
                    $fecha_actual = new DateTime('NOW');
                    $fecha= $fecha_actual->format('Y-m-d');
                    $stock=$_POST['stock'];
                    $descripcion=$_POST['des'];
                    $proveedor=$_POST['id_Selector'];
                    require("conectpsql.php");
                    $consulta= "SELECT DISTINCT * FROM proveedor where id_persona=$proveedor FETCH FIRST 1 ROWS ONLY";
                    $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                    $array = pg_fetch_array($action);
                    $numero=$array[0];
                    pg_close($dbconn4);
                    $polixy=strlen($id)*strlen($marca)*strlen($Pa)*strlen($Pv)*strlen($fecha)*strlen($stock)*strlen($descripcion)*strlen($proveedor)*strlen($numero);
                    if($polixy>0){
                        require("conectpsql.php");
                        $consulta = "INSERT INTO producto VALUES('$id','$marca','$Pa','$Pv','$fecha','$stock','$descripcion','$numero','$proveedor')";
                        $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                        echo "<script>alert('Se ha registrado con exito');</script>";
                        pg_close($dbconn4);
                    }else{
                        echo "<script>alert('Todos los campos son obligaotrios');</script>";
                    }
                }else{
                    echo "<script>alert('El codigo de barras se compone por números, no letras ni caracteres especiales');</script>";
                }    
            }else{
                echo "<script>alert('El codigo de barras no cumple con la especificación de 6 dógitos');</script>";
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