<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú</title>
</head>
<body>
    <h1>Menú</h1>
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
        <label for="categoria">Selecciona una categoría:</label>
        <select id="categoria" name="categoria">
            <option value="Entradas">Entradas</option>
            <option value="Plato principal">Plato principal</option>
            <option value="Postres">Postres</option>
            <option value="Bebidas">Bebidas</option>
        </select>
        <br><br>
        <input type="submit" value="Mostrar">
    </form>
    
    <br>
</body>
</html>
<?php
// Incluir el archivo que contiene la función muestraTab
include 'entablar.php';
// Verificar si se ha enviado el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtener la categoría seleccionada
    $categoria = $_POST["categoria"];

    // Conexión a la base de datos
    $conection = pg_connect("host=localhost dbname=restaurante user=adminbd password='adminbd_password'");
    if (!$conection) {
        echo "Error de conexión a la base de datos.";
    } else {
        // Consulta a la base de datos según la categoría seleccionada
        $query = "";
        // Consulta a la base de datos según la categoría seleccionada
        switch ($categoria) {
            case 'Entradas':
                $query = "SELECT m.id_prod, m.nombre_prod, m.receta_prod, m.precio_unitario_prod, m.disponibilidad_prod, m.categoria
                FROM menu m
                INNER JOIN entrante e ON m.id_prod = e.id_prod";
                break;
            case 'Plato principal':
                $query = "SELECT m.id_prod, m.nombre_prod, m.receta_prod, m.precio_unitario_prod, m.disponibilidad_prod, m.categoria
                FROM menu m
                INNER JOIN plato_principal p ON m.id_prod = p.id_prod";
                break;
            case 'Postres':
                $query = "SELECT m.id_prod, m.nombre_prod, m.receta_prod, m.precio_unitario_prod, m.disponibilidad_prod, m.categoria
                FROM menu m
                INNER JOIN postre po ON m.id_prod = po.id_prod";
                break;
            case 'Bebidas':
                $query = "SELECT m.id_prod, m.nombre_prod, m.receta_prod, m.precio_unitario_prod, m.disponibilidad_prod, m.categoria
                FROM menu m
                INNER JOIN bebida b ON m.id_prod = b.id_prod";
                break;
            default:
                echo "Categoría no válida.";
                break;
        }

        // Ejecutar la consulta
        $result = pg_query($conection, $query);
        if (!$result) {
            echo "Error al ejecutar la consulta.";
        } else {
            // Obtener todas las filas de resultados
            $rows = pg_fetch_all($result);
                // Mostrar tabla de productos disponibles
                echo "<h2>" . $categoria . ":</h2>";
                muestraTab($result, pg_num_fields($result));
        }

        $query = "SELECT id_prod,nombre_prod,precio_unitario_prod 
        FROM menu
        WHERE disponibilidad_prod = false;
        ";
        echo "<h2> Productos no disponibles :</h2>";
        $result = pg_query($conection, $query);
        muestraTab($result, pg_num_fields($result));
        // Cerrar conexión
        pg_close($conection);
    }
}
?>
<html>
<a href="mesero.php">Regresar a Mesero</a>
</html>

