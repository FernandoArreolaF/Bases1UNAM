<?php


$dateq1 = $_POST["dateq1"];
$dateq2 = $_POST["dateq2"];
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

$sql2 = "select ganancias_por_rango_fechas('$dateq1','$dateq2')";
$result = pg_query($conexion, $sql2);
$table2 = '<table border="1">';
$table2 .= '<tr><th>Ganancias por rango de fechas</th>';

// Loop through the result set and add rows to the table
while ($row = pg_fetch_assoc($result)) {
    $table2 .= '<tr>';
    $table2 .= '<td>' . $row['ganancias_por_rango_fechas'] . '</td>';
    $table2 .= '</tr>';
}



// Close the table
$table2 .= '</table>';

// Output the table
echo "<br>",$table2;


// Close the database connection
pg_close($conexion);

?>
