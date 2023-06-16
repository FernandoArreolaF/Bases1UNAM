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
$sql = "SELECT * FROM proveedor";
$result = pg_query($conexion, $sql);


// Create an HTML table
$table = '<table border="1">';
$table .= '<tr><th>prov_razon_social</th><th>prov_nombre</th><th>prov_estado</th><th>prov_cp</th><th>prov_colonia</th><th>prov_calle</th><th>prov_numero</th><th>';

// Loop through the result set and add rows to the table
while ($row = pg_fetch_assoc($result)) {
    $table .= '<tr>';
    $table .= '<td>' . $row['prov_razon_social'] . '</td>';
    $table .= '<td>' . $row['prov_nombre'] . '</td>';
    $table .= '<td>' . $row['prov_estado'] . '</td>';
    $table .= '<td>' . $row['prov_cp'] . '</td>';
    $table .= '<td>' . $row['prov_colonia'] . '</td>';
    $table .= '<td>' . $row['prov_calle'] . '</td>';
    $table .= '<td>' . $row['prov_numero'] . '</td>';
    $table .= '</tr>';
}

// Close the table
$table .= '</table>';

// Output the table
echo $table;

// Close the database connection
pg_close($conexion);

?>