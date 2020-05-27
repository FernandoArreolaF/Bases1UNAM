<?php
    $dbconn4 = pg_connect("host=database-papeleria.cu6te16jsmps.us-east-2.rds.amazonaws.com port=5432 dbname=papeleria user=postgres password=P4p3l3r14");
    if($dbconn4){
        
    }
    else{
        echo "</br>No se pudo conectar";
    }
?>