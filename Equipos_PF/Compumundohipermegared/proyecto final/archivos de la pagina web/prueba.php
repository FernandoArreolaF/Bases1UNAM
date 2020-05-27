<?php
    require("conectpsql.php");
    $consultaID="SELECT COUNT(*) FROM persona";
    $act = pg_query($dbconn4,$consultaID) or die (pg_last_error($act));
    while($valor=pg_fetch_array($act)){
        $id=$valor[0];
        echo $id+2;
        pg_close($dbconn4);
    }
?>