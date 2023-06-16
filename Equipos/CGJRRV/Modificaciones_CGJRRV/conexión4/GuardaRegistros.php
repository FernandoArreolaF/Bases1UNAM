<?php

    //Cambios en el archivo de config de xamp, quitar ';' de los 3 de pgsql

$Boton1 ="";
$articulo1 = " ";
$articulo11 = " ";
$articulo1ID = 0;
$marca1="";
$compañia1 ="";
$mr1="";

$articulo2 = " ";
$articulo22 = " ";
$articulo2ID = 0;
$marca2="";
$compañia2 ="";
$mr2="";

$articulo3 = " ";
$articulo33 = " ";
$articulo3ID = 0;
$compañia3 ="";
$marca3="";
$mr3="";

$br1 = "";
$br2 = "";
$br3 = "";
$bre1="";
$bre2="";
$bre3="";
$art1 ="";
$art2 ="";
$art3 ="";
$rfccomp="";
$aux="";
$resultadoC;
$numVen;
date_default_timezone_set('America/Mexico_City');
$fecha = date("Y-m-d");

    //PRUEBA
    //Regresar a tabla papeleria osea quitarle el 2
    $dbservername = "localhost";
    $dbusername = "postgres";
    $dbname = "papeleria3";
    $dbpassword = "xalpa318";
    $puerto = "5432";
    $conexion=pg_connect("host=$dbservername port=$puerto dbname=$dbname user=$dbusername password=$dbpassword");

    if($conexion){
        //echo "Conexión exitosa";
    } else{

        echo "No se pudo realizar la conexión";
    }

    // $consulta = "Select prov_nombre FROM PROVEEDOR";
    // $query = pg_query($conexion, $consulta);
    
    if(isset($_POST['BotonRegistro']))$Boton1=$_POST['BotonRegistro'];


//Recuperar las variables del formulario par al parte de cleintes
    if($Boton1){
        $rfc = $_POST["rfc"];
        $cli_nombre = $_POST["nombre"];
        $cli_ap_Pat = $_POST["apellidopaterno"];
        $cli_ap_Mat = $_POST["apellidomaterno"];
        $cli_estado = $_POST["estado"];
        $cli_CP = $_POST["codigopostal"];
        $cli_colonia = $_POST["colonia"];
        $cli_calle = $_POST["calle"];
        $cli_numero = $_POST["numero"];
        $email = $_POST["email"];
        echo "\nEl RFC del cliente es : " .$rfc ;
        echo "\nEl Nombre del cliente es :  ".$cli_nombre;
        echo "\nEl Paterno del cliente es :  ".$cli_ap_Pat;
        echo "\nEl Materno del cliente es : ".$cli_ap_Mat;
        echo "\nEl estado del cliente es : ".$cli_estado;
        echo "\nEl CP del cliente es : ".$cli_CP;
        echo "\nEl colonia del cliente es :  ".$cli_colonia;
        echo "\nEl calle cliente es : ".$cli_calle;
        echo "\nEl numero del cliente es : ".$cli_numero;
        echo "\nEl email del cliente es : ".$email;

        //Inserción de datos sobre tabla CLIENTE
        $resultadoN = pg_query($conexion,$queryn);
        if(pg_num_rows($resultadoN) > 0 ){
            echo '<script language="javascript">alert("EL CLIENTE YA EXISTE");window.location.href="index02-2.html"</script>';
            return 1;
        } else{
             //Inserción de datos sobre tabla CLIENTE
            $query="INSERT INTO cliente VALUES('$rfc','$cli_nombre','$cli_ap_Pat','$cli_ap_Mat','$cli_estado','$cli_CP','$cli_colonia','$cli_calle','$cli_numero')"; 
            pg_query($conexion,$query);

            $query2="INSERT INTO EMAIL VALUES('$email','$rfc')"; 
            pg_query($conexion,$query2);

            echo '<script language="javascript">alert("CLIENTE NUEVO REGISTRADO CORRECTAMENTE");window.location.href="index02-2.html"</script>';
            return 0;
        }

        //header("location:principal.html");

    } else { 
            $articulo1 = $_POST["articulo1"];
            $cantidad1 = $_POST["cantidad1"];
            $articulo2 = $_POST["articulo2"];
            $cantidad2 = $_POST["cantidad2"];
            $articulo3 = $_POST["articulo3"];
            $cantidad3 = $_POST["cantidad3"];
            $cli_rfc2 = $_POST["cli_rfc2"];
            $rfccomp= $cli_rfc2;
            
            $query3= "SELECT * FROM cliente where cli_rfc = '$cli_rfc2' ";
            $resultadoC = pg_query($conexion,$query3);
            if(pg_num_rows($resultadoC) > 0 ){
                //echo "SI ESTA REGISTRADO";

                if ($articulo1 != ' '){
                    if($articulo1 == 'Lapiz'){
                        $articulo11 = '114056211990';
                        $articulo1ID = 16;
                        $art1 ='1';
                        $marca1='Prismacolor';
                    } 
                    elseif($articulo1 == 'Goma'){
                        $articulo11 = '687499736256';
                        $articulo1ID = 15;
                        $art1 ='1';
                        $marca1='FACTIS';
                    }
                    elseif($articulo1 == 'Pritt'){
                        $articulo11 = '484139753236';
                        $articulo1ID = 17;
                        $art1 ='1';
                        $marca1='PRITT';
                    }
                    elseif($articulo1 == 'Pluma'){
                        $articulo11 = '715150864290';
                        $articulo1ID = 18;
                        $art1 ='1';
                        $marca1='Paper Mate';
                    }
                    elseif($articulo1 == 'Cuaderno Raya'){
                        $articulo11 = '114056211990';
                        $articulo1ID = 14;
                        $art1 ='1';
                        $marca1='Scribe';
                    }
                    elseif($articulo1 == 'Cuaderno Cuadro Chico'){
                        $articulo11 = '687499736256';
                        $articulo1ID = 13;
                        $art1 ='1';
                        $marca1='Scribe';
                    }
                    elseif($articulo1 == 'Cuaderno Jean Book Cuadro'){
                        $articulo11 = '399590618155';
                        $articulo1ID = 12;
                        $art1 ='1';
                        $marca1='Jean Book';
                    }
                    elseif($articulo1 == 'Recarga Telcel'){
                        $articulo11 = '114056211990';
                        $articulo1ID = 10;
                        $br1 = '1';
                        $compañia1 ="Telcel";
                    }
                    elseif($articulo1 == 'Taza Decorada Mario Bros'){
                        $articulo11 = '457917919598';
                        $articulo1ID = 9;
                        $bre1 = '1';
                        $mr1="Home";
                    }
                    elseif($articulo1 == 'Recarga Pillofon'){
                        $articulo11 = '741231014278';
                        $articulo1ID = 7;
                        $br1 = '1';
                        $compañia1 ="Pillofon";
                    }
                    elseif($articulo1 == 'Oso de peluche'){
                        $articulo11 = '447860646475';
                        $articulo1ID = 6;
                        $bre1 = '1';
                        $mr1="Toys";
                    }
                    elseif($articulo1 == 'Recarga Movistar'){
                        $articulo11 = '293191272802';
                        $articulo1ID = 4;
                        $br1 = '1';
                        $compañia1 ="Movistar";
                    }
                    elseif($articulo1 == 'Mochila'){
                        $articulo11 = '600724784868';
                        $articulo1ID = 3;
                        $bre1 = '1';
                        $mr1="NIKE";
                    }
                    elseif($articulo1 == 'Recarga AT&T'){
                        $articulo11 = '394789821973';
                        $articulo1ID = 2;
                        $br1 = '1';
                        $compañia1 ="AT&T";
                    }
                    elseif($articulo1 == 'Impresion'){
                        $articulo11 = '456986321457';
                        $articulo1ID = 20;
                        $br1 = '1';
                    }
                    //echo "<br>El articulo 1 del cliente es : ".$articulo1;
                   // echo "<br>El código de barras  del articulo 1 del cliente es : ".$articulo11;
                    //echo "<br>El ID del articulo 1 del cliente es : ".$articulo1ID;
                    //echo "<br>La cantidad del articulo 1 del cliente es : ".$cantidad1;

                    $queryI="INSERT INTO venta VALUES(default,'$fecha', default, '$cli_rfc2')";
                    pg_query($conexion,$queryI);

                   // $queryL="SELECT v.ven_num_venta from venta v where ven_rfc_cliente = '$cli_rfc2' order by v.ven_fecha_venta desc
                    //limit 1";
                   // $res = pg_query($conexion,$queryL);

                    // $queryP="Select ven_num_venta from venta order by ven_num_venta desc limit 1"; 
                    // $res = pg_query($conexion,$queryP);
                    // if(pg_num_rows($queryP) > 0){
                    //     while($row = $res ->fetch_assoc() ){
                    //         $numVen -> fetch_assoc();
                    //         echo "Hola soy numVen ".$numVen;
                    //     }
                    // }



                    //consultar la última venta hecha y de ahí jalar el idventa ('VENT-0009', 1, 3),
                    $queryCont = "INSERT INTO contener VALUES(default, '$articulo1ID', '$cantidad1', default)";
                    pg_query($conexion, $queryCont);
                    //while (($message = pg_last_notice($conexion)) !== false) {
                    //    $queryI="INSERT INTO venta VALUES(default,'$fecha', default, '$cli_rfc2')";
                   //     pg_query($conexion,$queryI);
                   //     echo '<script language="javascript">alert("' . $message . '");window.location.href="index02-2.html";</script>';
                   // }
                    

                    // if($art1 =='1'){
                    //     $queryC2="INSERT INTO articulo VALUES('$articulo1ID','$marca1')"; 
                    //     pg_query($conexion,$queryC2);
                    // }
                    // elseif($br1 =='1'){  //recarga
                    //     $queryC3="INSERT INTO recarga VALUES('$articulo1ID',default,'$compañia1')"; 
                    //     pg_query($conexion,$queryC3);
                    // }
                    // elseif($bre1 =='1'){ //bre = regalo
                    //     $queryC4="INSERT INTO regalo VALUES('$articulo1ID','$mr1','General')"; 
                    //     pg_query($conexion,$queryC4);
                    // }
                    echo '<script language="javascript">alert("Venta Registrada Con Exito");window.location.href="index02-2.html"</script>';
                }
                
                if ($articulo2 != ' '){
                    if($articulo2 == 'Lapiz'){
                        $articulo22 = '114056211990';
                        $articulo2ID = 16;
                        $art2 ='1';
                        $marca2='FACTIS';
                    }
                    elseif($articulo2 == 'Goma'){
                        $articulo22 = '687499736256';
                        $articulo2ID = 15;
                        $art2 ='1';
                        $marca2='Prismacolor';
                    }
                    elseif($articulo2 == 'Pritt'){
                        $articulo22 = '484139753236';
                        $articulo2ID = 17;
                        $art2 ='1';
                        $marca2='PRITT';
                    }
                    elseif($articulo2 == 'Pluma'){
                        $articulo22 = '715150864290';
                        $articulo2ID = 18;
                        $art2 ='1';
                        $marca2='Paper Mate';
                    }
                    elseif($articulo2 == 'Cuaderno Raya'){
                        $articulo22 = '114056211990';
                        $articulo2ID = 14;
                        $art2 ='1';
                        $marca2='Scribe';
                    }
                    elseif($articulo2 == 'Cuaderno Cuadro Chico'){
                        $articulo22 = '687499736256';
                        $articulo2ID = 13;
                        $art2 ='1';
                        $marca2='Scribe';
                    }
                    elseif($articulo2 == 'Cuaderno Jean Book Cuadro'){
                        $articulo22 = '399590618155';
                        $articulo2ID = 12;
                        $art2 ='1';
                        $marca2='Jean Book';
                    }
                    elseif($articulo2 == 'Recarga Telcel'){
                        $articulo22 = '114056211990';
                        $articulo2ID = 10;
                        $br2 = '1';
                        $compañia2 ="Telcel";
                    }
                    elseif($articulo2 == 'Taza Decorada Mario Bros'){
                        $articulo22 = '457917919598';
                        $articulo2ID = 9;
                        $bre2 = '1';
                        $mr2="Home";
                    }
                    elseif($articulo2 == 'Recarga Pillofon'){
                        $articulo22 = '741231014278';
                        $articulo2ID = 7;
                        $br2 = '1';
                        $compañia2 ="Pillofon";
                    }
                    elseif($articulo2 == 'Oso de peluche'){
                        $articulo22 = '447860646475';
                        $articulo2ID = 6;
                        $bre2 = '1';
                        $mr2="Toys";
                    }
                    elseif($articulo2 == 'Recarga Movistar'){
                        $articulo22 = '293191272802';
                        $articulo2ID = 4;
                        $br2 = '1';
                        $compañia2 ="Movistar";
                    }
                    elseif($articulo2 == 'Mochila'){
                        $articulo22 = '600724784868';
                        $articulo2ID = 3;
                        $bre2 = '1';
                        $mr2="NIKE";
                        
                    }
                    elseif($articulo2 == 'Recarga AT&T'){
                        $articulo22 = '394789821973';
                        $articulo2ID = 2;
                        $br2 = '1';
                        $compañia2 ="AT&T";
                    }
                    elseif($articulo2 == 'Impresion'){
                        $articulo22 = '456986321457';
                        $articulo2ID = 20;
                        $br2 = '1';
                    }
                    //echo "<br>AEl articulo 2 del cliente es : ".$articulo2;
                    //echo "<br>El código de barras  del articulo 2 del cliente es : ".$articulo22;
                    //echo "<br>El ID del articulo 2 del cliente es : ".$articulo2ID;
                   // echo "<br>La cantidad del articulo 2 del cliente es : ".$cantidad2;

                    $queryb="INSERT INTO venta VALUES(default,'$fecha', default, '$cli_rfc2')";
                    pg_query($conexion,$queryb);

                    $queryCont2="INSERT INTO contener VALUES(default,'$articulo2ID','$cantidad2',default)"; 
                    pg_query($conexion,$queryCont2);
                   // $queryCont = "INSERT INTO contener VALUES(default, '$articulo1ID', '$cantidad1', default)";
                   // pg_query($conexion, $queryCont);
                   // while (($message = pg_last_notice($conexion)) !== false) {
                   //     echo '<script language="javascript">alert("' . $message . '");window.location.href="index02-2.html";</script>';
                   // }


                    // if($art2 =='1'){
                    //     $queryC2="INSERT INTO articulo VALUES('$articulo2ID','$marca2')"; 
                    //     pg_query($conexion,$queryC2);
                    // }
                    // elseif($br2 =='1'){  //recarga
                    //     $queryC3="INSERT INTO recarga VALUES('$articulo2ID',default,'$compañia2')"; 
                    //     pg_query($conexion,$queryC3);
                    //     //nextval('recarga_rec_id_producto_seq'::regclass) el default que se quito
                    // }
                    // elseif($bre2 =='1'){ //bre = regalo
                    //     $queryC4="INSERT INTO regalo VALUES('$articulo2ID','$mr2','General')"; 
                    //     pg_query($conexion,$queryC4);
                    // }
                    echo '<script language="javascript">alert("Venta Registrada Con Exito");window.location.href="index02-2.html"</script>';

                }

                if ($articulo3 != ' '){
                    if($articulo3 == 'Lapiz'){
                        $articulo33 = '114056211990';
                        $articulo3ID = 16;
                        $art3 ='1';
                        $marca3='Prismacolor';
                    }
                    elseif($articulo3 == 'Goma'){
                        $articulo33 = '687499736256';
                        $articulo3ID = 15;
                        $art3 ='1';
                        $marca3='FACTIS';
                    }
                    elseif($articulo3 == 'Pritt'){
                        $articulo33 = '484139753236';
                        $articulo3ID = 17;
                        $art3 ='1';
                        $marca3='PRITT';
                    }
                    elseif($articulo3 == 'Pluma'){
                        $articulo33 = '715150864290';
                        $articulo3ID = 18;
                        $art3 ='1';
                        $marca3='Paper Mate';
                    }
                    elseif($articulo3 == 'Cuaderno Raya'){
                        $articulo33 = '114056211990';
                        $articulo3ID = 14;
                        $art3 ='1';
                        $marca3='Scribe';
                    }
                    elseif($articulo3 == 'Cuaderno Cuadro Chico'){
                        $articulo33 = '687499736256';
                        $articulo3ID = 13;
                        $art3 ='1';
                        $marca3='Scribe';
                    }
                    elseif($articulo3 == 'Cuaderno Jean Book Cuadro'){
                        $articulo33 = '399590618155';
                        $articulo3ID = 12;
                        $art3 ='1';
                        $marca3='Jean Book';
                    }
                    elseif($articulo3 == 'Recarga Telcel'){
                        $articulo33 = '114056211990';
                        $articulo3ID = 10;
                        $br3 = '1';
                        $compañia3 = 'Telcel';
                    }
                    elseif($articulo3 == 'Taza Decorada Mario Bros'){
                        $articulo33 = '457917919598';
                        $articulo3ID = 9;
                        $bre3 = '1';
                        $mr3="Home";
                    }
                    elseif($articulo3 == 'Recarga Pillofon'){
                        $articulo33 = '741231014278';
                        $articulo3ID = 7;
                        $br3 = '1';
                        $compañia3 = 'Pillofon';
                    }
                    elseif($articulo3 == 'Oso de peluche'){
                        $articulo33 = '447860646475';
                        $articulo3ID = 6;
                        $bre3 = '1';
                        $mr3="Toys";
                    }
                    elseif($articulo3 == 'Recarga Movistar'){
                        $articulo33 = '293191272802';
                        $articulo3ID = 4;
                        $br3 = '1';
                        $compañia3 = 'Movistar';
                    }
                    elseif($articulo3 == 'Mochila'){
                        $articulo33 = '600724784868';
                        $articulo3ID = 3;
                        $bre3 = '1';
                        $mr3="NIKE";
                    }
                    elseif($articulo3 == 'Recarga AT&T'){
                        $articulo33 = '394789821973';
                        $articulo3ID = 2;
                        $br3 = '1';
                        $compañia3 ='AT&T';
                    }
                    elseif($articulo3 == 'Impresion'){
                        $articulo33 = '456986321457';
                        $articulo3ID = 20;
                        $br3 = '1';
                    }
                    //echo "<br>AEl articulo 3 del cliente es : ".$articulo3;
                    //echo "<br>El código de barras  del articulo 3 del cliente es : ".$articulo33;
                    //echo "<br>El ID del articulo 3 del cliente es : ".$articulo3ID;
                    //echo "<br>La cantidad del articulo 3 del cliente es : ".$cantidad3;


                    $queryc="INSERT INTO venta VALUES(default,'$fecha', default, '$cli_rfc2')";
                    pg_query($conexion,$queryc);

                    $queryCont3="INSERT INTO contener VALUES(default,'$articulo3ID','$cantidad3',default)"; 
                    pg_query($conexion,$queryCont3);

                    //while (($message = pg_last_notice($conexion)) !== false) {
                    //     echo '<script language="javascript">alert("' . $message . '");window.location.href="index02-2.html";</script>';
                   // }
                                        

                    // if($art3 =='1'){
                    //     $queryC2="INSERT INTO articulo VALUES('$articulo3ID','$marca3')"; 
                    //     pg_query($conexion,$queryC2);
                    // }
                    // elseif($br3 =='1'){  //recarga
                    //     $queryC3="INSERT INTO recarga VALUES('$articulo3ID',default,'$compañia3')"; 
                    //     pg_query($conexion,$queryC3);
                    // }
                    // elseif($bre3 =='1'){ //bre = regalo
                    //     $queryC4="INSERT INTO regalo VALUES('$articulo3ID','$mr3','General')"; 
                    //     pg_query($conexion,$queryC4);
                    // }
                    echo '<script language="javascript">alert("Venta Registrada Con Exito");window.location.href="index02-2.html"</script>';

                }
                return 1;

            } else {
                echo '<script language="javascript">alert("Registrate primero");window.location.href="index02-2.html"</script>';
                return 0;
                //Header ("location:principal.html");
            }
       //header("location:principal.html");
    }       
?>