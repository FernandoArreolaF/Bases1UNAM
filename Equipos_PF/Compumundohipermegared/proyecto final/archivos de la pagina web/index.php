<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Papelería</title>

    <link rel="stylesheet" href="css/estilos.css"> 
    <link rel="icon" href="./images/alcemi.ico">

</head>
<body>

    <section class="form_wrap">

        <section class="cantact_info">
            <section class="info_title">
                <img class="brand-logo" src="./images/alcemi.png" alt="">
            </section>
            <section class="info_items">
                <p><span class="fa fa-envelope"></span>alcemi@papeleria.com.mx</p>
                <p><span class="fa fa-mobile"></span>5568321496</p>
            </section>
        </section>

        <form action="" class="form_contact" method="post" autocomplete="off">
            <center><h2>Inicia Sesión</h2></center>
            <div class="user_info">
                <label for="names">Nombre de usuario</label>
                <input type="text" id="names" name="nmbre">

                <label for="email">Contraseña</label>
                <input type="password" id="email" name="cla">


                <input type="submit" value="Ingresar" id="btnSend" name="listo">
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
        if(isset($_POST['listo'])){
            $usuario=$_POST['nmbre'];
            $ps=$_POST['cla'];
            $polixy=strlen($usuario)*strlen($ps);
        
            if($polixy>0){
                require("conectpsql.php");
                $consulta = "SELECT * FROM usuarios  WHERE usuario = '$usuario' AND clave = '$ps'";
                $action= pg_query($dbconn4,$consulta) or die (pg_last_error($action));
                $check = pg_num_rows($action);
                if($check==0){
                    echo "<script>alert('El usuario y/o contraseña no coinciden');</script>";
                }else{
                    while ($array = pg_fetch_array($action)) {
                        $_SESSION['username']=$usuario;
                        header("location:principal.php");            
                    }
                }
                pg_close($dbconn4);
            }else{
                echo "<script>alert('Todos los campos son obligaotrios');</script>";
            }

        }
?>