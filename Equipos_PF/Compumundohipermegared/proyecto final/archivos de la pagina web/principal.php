<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Principal</title>

    <link rel="stylesheet" href="css/estilos2.css"> 
    <link rel="icon" href="./images/alcemi.ico">
</head>
<body>
    <section class="form_menu">
        <section class="add_client">
            <img class="img-option1" src="./images/addClient.png" alt="">
            <center><button class="form_nC" onclick="window.location.href='new_Client.php'">Agregar Cliente</button></center>
        </section>
        <section class="add_sale">
            <img class="img-option2" src="./images/addSale.png" alt="">
            <center><button class="form_nC" onclick="window.location.href='new_Sale.php'">Ingresar Venta</button></center>
        </section>
        <section class="add_product">
            <img class="img-option3" src="./images/AddProduct.png" alt="">
            <center><button class="form_nC" onclick="window.location.href='new_Product.php'">Agregar Producto</button></center>
        </section>
        <section class="view_inventary">
            <img class="img-option4" src="./images/show_Inv.png" alt="">
            <center><button class="form_nC" onclick="window.location.href='show_Inventary.php'">Consultar Inventario</button></center>
        </section>
        <section class="add_provider">
            <img class="img-option5" src="./images/addProvider.png" alt="">
            <center><button class="form_nC" onclick="window.location.href='new_Pr.php'">Agregar Proveedor</button></center>
        </section>
        <section class="exit_main">
            <img class="img-option6" src="./images/exit.png" alt="">
            <form action="" class="form_ext" method="post">
                <center><input type="submit" value="Salir" id="btn_ext" name="exiT"></center>
            </form>
        </section>
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
        if(isset($_POST["exiT"])){
            header("location:salir.php");
        }  
    }
    
?>