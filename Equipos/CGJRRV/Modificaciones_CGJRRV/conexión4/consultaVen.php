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

// Query to fetch data from the INVENTARIO table
$sql = "SELECT * FROM venta";
$result = pg_query($conexion, $sql);

// Check if the query executed successfully
if (!$result) {
    echo "An error occurred.\n";
    exit;
}

// Create an HTML table
$table = '<table border="1">';
$table .= '<tr><th>ven_num_venta</th><th>ven_fecha_venta</th><th>ven_monto_total</th><th>ven_rfc_cliente</th></tr>';

// Loop through the result set and add rows to the table
while ($row = pg_fetch_assoc($result)) {
    $table .= '<tr>';
    $table .= '<td>' . $row['ven_num_venta'] . '</td>';
    $table .= '<td>' . $row['ven_fecha_venta'] . '</td>';
    $table .= '<td>' . $row['ven_monto_total'] . '</td>';
    $table .= '<td>' . $row['ven_rfc_cliente'] . '</td>';
    $table .= '</tr>';
}

// Close the table
$table .= '</table>';

// Output the table
echo $table;

?>
