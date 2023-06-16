<?php


$dateq = $_POST["dateq"];
date_default_timezone_set('America/Mexico_City');
$fecha = date("Y-m-d");

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

$sql2 = "select ganancias_a_partir_de('$dateq')";
$result = pg_query($conexion, $sql2);
$table2 = '<table border="1">';
$table2 .= '<tr><th>Ganancias por fecha</th>';

// Loop through the result set and add rows to the table
while ($row = pg_fetch_assoc($result)) {
    $table2 .= '<tr>';
    $table2 .= '<td>' . $row['ganancias_a_partir_de'] . '</td>';
    $table2 .= '</tr>';
}



// Close the table
$table2 .= '</table>';

// Output the table
echo "<br>",$table2;


// Close the database connection
pg_close($conexion);

?>
