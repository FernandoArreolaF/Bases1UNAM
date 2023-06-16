<?php

// Connect to the PostgreSQL database
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


$sql2 = 'BEGIN;
SELECT obtener_factura_cursor("VENT-0007");
FETCH ALL IN "<unnamed portal 1>";
FETCH ALL IN "<unnamed portal 2>";
FETCH ALL IN "<unnamed portal 3>";
COMMIT;';
$result = pg_query($conexion, $sql2);
$table2 = '<table border="1">';
$table2 .= '<tr><th>ven_monto_total</th><th>iva</th><th>monto_final</th></tr>';


// Loop through the result set and add rows to the table
while ($row = pg_fetch_assoc($result)) {
    $table2 .= '<tr>';
    $table2 .= '<td>' . $row['ven_monto_total'] . '</td>';
    $table2 .= '<td>' . $row['iva'] . '</td>';
    $table2 .= '<td>' . $row['monto_final'] . '</td>';
    $table2 .= '</tr>';
}

// Close the table
$table2 .= '</table>';

// Output the table
echo "<br>",$table2;

// Close the database connection
pg_close($conexion);

?>