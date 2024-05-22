<!DOCTYPE html>
<html lang= "en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2>Conexion de la base de datos en postgres con PHP</h2>
    <?php
    // Incluir el archivo con las funciones definidas
    include 'entablar.php';

    // Conexión a la base de datos
    $conection = pg_connect("host=localhost dbname=restaurante user=adminbd password='adminbd_password'");
    if (!$conection) {
        echo "Ocurrió un error al realizar la conexión :o";
        exit;
    } else {
        echo "Conexión exitosa<br>";
    }

    // Consulta a la base de datos
    $result = pg_query($conection, "SELECT * FROM empleado");
    if (!$result) {
        echo "Error en la consulta.";
        exit;
    } else {
        echo "Consulta exitosa<br>";
        // Utilizar la función muestraTab para mostrar los resultados
        muestraTab($result, pg_num_fields($result));
    }
    ?>
</body>
</html>
