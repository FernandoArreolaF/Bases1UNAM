<?php
   session_start();
   $usuario=$_SESSION['username'];
   if(!isset($usuario)){
       header("location:index.php");
   }else{

        $idClient=$_POST['id_Selector'];
        $articulo1=$_POST['rol'];
        $cantidad1=$_POST['C_1'];
        $articulo2=$_POST['rol2'];
        $cantidad2=$_POST['C_2'];
        $articulo3=$_POST['rol3'];
        $cantidad3=$_POST['C_3'];
        $polixy=strlen($articulo1)*strlen($cantidad1)*strlen($idClient);
        if($polixy>0){
            $polixy2=strlen($articulo2)*strlen($cantidad2);
            if($polixy2>0){
               $polixy3=strlen($articulo3)*strlen($cantidad3);
               if($polixy3>0){
                  if($cantidad1>0 && $cantidad2>0 && $cantidad3>0){
                     require("conectpsql.php");
                     $consulta2= "SELECT * FROM producto where descripcion='$articulo1'";
                     $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                     $array = pg_fetch_array($action2);
                     $precio1=$array[3];
                     $subprecio1= $cantidad1*$precio1;
                     $consulta3= "SELECT * FROM producto where descripcion='$articulo2'";
                     $action3= pg_query($dbconn4,$consulta3) or die (pg_last_error($action3));
                     $array2 = pg_fetch_array($action3);
                     $precio2=$array2[3];
                     $subprecio2= $cantidad2*$precio2;
                     $subprecio1= $cantidad1*$precio1;
                     $consulta4= "SELECT * FROM producto where descripcion='$articulo3'";
                     $action4= pg_query($dbconn4,$consulta4) or die (pg_last_error($action4));
                     $array3 = pg_fetch_array($action4);
                     $precio3=$array3[3];
                     $subprecio3= $cantidad3*$precio3;
                     $precioT2=$subprecio1+$subprecio2+$subprecio3;
                           echo "<table>
                                 <tr>
                                    <th>Descripción</th>
                                    <th>Precio unitario</th>
                                    <th>Cantidad</th>
                                    <th>Sutbtotal </th>
                                 </tr>
                                 <tr>
                                    <td>$articulo1</td>
                                    <td>$precio1</td>
                                    <td>$cantidad1</td>
                                    <td>$subprecio1</td>
                                 </tr>
                                 <tr>
                                    <td>$articulo2</td>
                                    <td>$precio2</td>
                                    <td>$cantidad2</td>
                                    <td>$subprecio2</td>
                                 </tr>
                                 <tr>
                                    <td>$articulo3</td>
                                    <td>$precio3</td>
                                    <td>$cantidad3</td>
                                    <td>$subprecio3</td>
                                 </tr>
                                 <tr>
                                    <th>Total:</th>
                                    <th></th>
                                    <th></th>
                                    <th>$precioT2</th>
                                 </tr>
                              </table>
                              <div class='Client-infoF'>
                                 <label for='clientt'>Para finalizar con la venta haz click en  'Confirmar Venta'</label>
                              </div>
                              ";
                           pg_close($dbconn4);
                  }else{
                     if($cantidad1 <= 0 || $cantidad2 <= 0 || $cantidad3 <= 0){
                        echo "<script>alert('Ingresa una cantidad valida para los articulos 1, 2 y 3');</script>";
                     }
                  }
               }else{
                        if($cantidad1>0 && $cantidad2>0){
                           require("conectpsql.php");
                           $consulta2= "SELECT * FROM producto where descripcion='$articulo1'";
                           $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                           $array = pg_fetch_array($action2);
                           $precio1=$array[3];
                           $subprecio1= $cantidad1*$precio1;
                           $consulta3= "SELECT * FROM producto where descripcion='$articulo2'";
                           $action3= pg_query($dbconn4,$consulta3) or die (pg_last_error($action3));
                           $array2 = pg_fetch_array($action3);
                           $precio2=$array2[3];
                           $subprecio2= $cantidad2*$precio2;
                           $precioT=$subprecio1+$subprecio2;
                           echo "<table>
                                 <tr>
                                    <th>Descripción</th>
                                    <th>Precio unitario</th>
                                    <th>Cantidad</th>
                                    <th>Sutbtotal </th>
                                 </tr>
                                 <tr>
                                    <td>$articulo1</td>
                                    <td>$precio1</td>
                                    <td>$cantidad1</td>
                                    <td>$subprecio1</td>
                                 </tr>
                                 <tr>
                                    <td>$articulo2</td>
                                    <td>$precio2</td>
                                    <td>$cantidad2</td>
                                    <td>$subprecio2</td>
                                 </tr>
                                 <tr>
                                    <th>Total:</th>
                                    <th></th>
                                    <th></th>
                                    <th>$precioT</th>
                                 </tr>
                              </table>
                              <div class='Client-infoF'>
                                 <label for='clientt'>Para finalizar con la venta haz click en  'Confirmar Venta'</label>
                              </div>
                              ";
                           pg_close($dbconn4); 
                        }else{
                           if($cantidad1 <= 0 || $cantidad2 <= 0){
                              echo "<script>alert('Ingresa una cantidad valida para los articulos');</script>";
                           }
                        }
                     }
                }else{
                   if($cantidad1>0){
                     require("conectpsql.php");
                     $consulta2= "SELECT * FROM producto where descripcion='$articulo1'";
                     $action2= pg_query($dbconn4,$consulta2) or die (pg_last_error($action2));
                     $array = pg_fetch_array($action2);
                     $precio1=$array[3];
                     $subprecio1= $cantidad1*$precio1;
                     echo "<table>
                                 <tr>
                                    <th>Descripción</th>
                                    <th>Precio unitario</th>
                                    <th>Cantidad</th>
                                    <th>Sutbtotal </th>
                                 </tr>
                                 <tr>
                                    <td>$articulo1</td>
                                    <td>$precio1</td>
                                    <td>$cantidad1</td>
                                    <td>$subprecio1</td>
                                 </tr>
                                 <tr>
                                    <th>Total:</th>
                                    <th></th>
                                    <th></th>
                                    <th>$subprecio1</th>
                                 </tr>
                              </table>
                              <div class='Client-infoF'>
                                 <label for='clientt'>Para finalizar con la venta haz click en  'Confirmar Venta'</label>
                              </div>
                              ";
                        pg_close($dbconn4);
                  }else{
                     echo "<script>alert('Ingresa una cantidad valida para el articulo 1');</script>";
                  }     
            }
        }else{
            echo "<script>alert('Todos los campos (*) son obligaotrios');</script>";
        }
   }
    
?> 