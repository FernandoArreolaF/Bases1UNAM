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
// $sql = "SELECT * FROM inventario";
// $result = pg_query($conexion, $sql);


$sql = "SELECT p.prod_descripcion, i.inv_codigo_barras, i.inv_precio_compra, i.inv_foto_url, i.inv_fecha_compra, i.inv_stock, i.inv_modificacion_stock FROM inventario as i 
INNER JOIN producto as p 
ON p.prod_codigo_barras=i.inv_codigo_barras";
$result = pg_query($conexion, $sql);



// Check if the query executed successfully
if (!$result) {
    echo "An error occurred.\n";
    exit;
}

// Create an HTML table
$table = '<table border="1">';
$table .= '<tr><th>Nombre Producto</th><th>Código de Barras</th><th>Precio de Compra</th><th>Foto URL</th><th>Fecha de Compra</th><th>Stock</th><th>Modificación de Stock</th></tr>';

// Loop through the result set and add rows to the table
while ($row = pg_fetch_assoc($result)) {
    $table .= '<tr>';
    $table .= '<td>' . $row['prod_descripcion'] . '</td>';
    $table .= '<td>' . $row['inv_codigo_barras'] . '</td>';
    $table .= '<td>' . $row['inv_precio_compra'] . '</td>';
    $table .= '<td>' . $row['inv_foto_url'] . '</td>';
    $table .= '<td>' . $row['inv_fecha_compra'] . '</td>';
    $table .= '<td>' . $row['inv_stock'] . '</td>';
    $table .= '<td>' . $row['inv_modificacion_stock'] . '</td>';
    $table .= '</tr>';
}

// Close the table
$table .= '</table>';





//Vista de inventario mínimo

$sql2 = "select * from min_stock";
$result2 = pg_query($conexion, $sql2);
// Create an HTML table
$table2 = '<table align="center" border="1">';
$table2 .= '<tr><th>PRODUCTO</th><th>STOCK</th>';

// Loop through the result set and add rows to the table
while ($row = pg_fetch_assoc($result2)) {
    $table2 .= '<tr>';
    $table2 .= '<td>' . $row['prod_descripcion'] . '</td>';
    $table2 .= '<td>' . $row['inv_stock'] . '</td>';
    $table2 .= '</tr>';
}

// Close the table
$table2 .= '</table>';


// Output the table
echo $table;

echo '<div style="text-align: center;">';
echo "<br><br><br><br><br><br>      <t> PRODUCTOS CON STOCK MENOR A 3";

echo $table2;


// Close the database connection
pg_close($conexion);

?>
