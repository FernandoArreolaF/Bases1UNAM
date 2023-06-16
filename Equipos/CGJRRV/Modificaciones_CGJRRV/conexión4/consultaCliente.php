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
$sql = "SELECT * FROM cliente";
$result = pg_query($conexion, $sql);

// Check if the query executed successfully
if (!$result) {
    echo "An error occurred.\n";
    exit;
}

// Create an HTML table
$table = '<table border="1">';
$table .= '<tr><th>cli_rfc</th><th>cli_nombre</th><th>cli_ap_pat</th><th>cli_ap_mat</th><th>cli_estado</th><th>cli_cp</th><th>cli_colonia</th><th>cli_calle</th><th>cli_numero</th><th>';

// Loop through the result set and add rows to the table
while ($row = pg_fetch_assoc($result)) {
    $table .= '<tr>';
    $table .= '<td>' . $row['cli_rfc'] . '</td>';
    $table .= '<td>' . $row['cli_nombre'] . '</td>';
    $table .= '<td>' . $row['cli_ap_pat'] . '</td>';
    $table .= '<td>' . $row['cli_ap_mat'] . '</td>';
    $table .= '<td>' . $row['cli_estado'] . '</td>';
    $table .= '<td>' . $row['cli_cp'] . '</td>';
    $table .= '<td>' . $row['cli_colonia'] . '</td>';
    $table .= '<td>' . $row['cli_calle'] . '</td>';
    $table .= '<td>' . $row['cli_numero'] . '</td>';
    $table .= '</tr>';
}

// Close the table
$table .= '</table>';

// Output the table
echo $table;

// Close the database connection
pg_close($conexion);

?>
