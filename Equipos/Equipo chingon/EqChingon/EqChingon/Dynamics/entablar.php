<?php
function muestraTab($result, $num_fields) {
    // Mostrar la tabla HTML solo si la consulta es exitosa
    if ($result && $num_fields > 0) {
        echo "<table border='1'><tr>";
        // Mostrar los nombres de las columnas como encabezados de tabla
        for ($i = 0; $i < $num_fields; $i++) {
            echo "<th>" . pg_field_name($result, $i) . "</th>";
        }
        echo "</tr>";
        // Mostrar los datos de la consulta en la tabla
        while ($row = pg_fetch_assoc($result)) {
            echo "<tr>";
            foreach ($row as $field) {
                echo "<td>$field</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
    } else {
        // Mostrar un mensaje si no se encontraron resultados
        echo "No se encontraron resultados.";
    }
    
}
?>
