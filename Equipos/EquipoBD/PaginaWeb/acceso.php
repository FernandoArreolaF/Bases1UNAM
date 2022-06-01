<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProyectoBD</title>

    <link rel="preload" href="src/style.css" as="style">
    <link rel="stylesheet" href="src/style.css">

    <link rel="icon" href="img/favicon.png">
</head>
<?php
    include "src/php/conexion.php" // Conexion a la base de datos
?>
<body>
    <header class="header">
        <div class="contenedor">
            <div class="barra">
                <a class="logo" href="index.html">
                    <h1 class="texto-centro sombras">Proyecto<span class="negritas">BD</span></h1>
                </a>
                <nav class="navegacion sombras">
                    <a href="orden.php" class="nav-enlace">Ordenar</a>
                    <a href="nosotros.html" class="nav-enlace">Nosotros</a>
                    <a href="acceso.php" class="nav-enlace">
                        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-key" width="40" height="40" viewBox="0 0 24 20" stroke-width="2.5" stroke="#ffbf00" fill="none" stroke-linecap="round" stroke-linejoin="round">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <circle cx="8" cy="15" r="4" />
                            <line x1="10.85" y1="12.15" x2="19" y2="4" />
                            <line x1="18" y1="5" x2="20" y2="7" />
                            <line x1="15" y1="8" x2="17" y2="10" />
                          </svg>
                    </a>
                </nav>
            </div>
            <div class="texto-header texto-blanco texto-centro">
                <h2>¡No dejes para mañana lo que puedes comer hoy!</h2>
                <p>Cocinamos con amor para que comas con conciencia</p>
            </div>
        </div>
    </header>

    <form class="contendor" id="empleado">
        <div class="empleado empleado-form">
            <label>Empleado</label>
            <select class="perfil-empleado"  name="empleados">
            <!-- <datalist id="empleados" class="datalist"> list="empleados"-->
            <?php
                // Consulta de la base de datos para devolver un datalist de los paises que se pueden elegir
                $psql = pg_query($conexion, "SELECT nombre FROM empleado");
                while($nombre = pg_fetch_row($psql)){
                    echo "<option value='$nombre[0]'>$nombre[0]</option>";
                }
            ?>
            </select>
            <!-- </datalist> -->
        </div>
        <input class="submit" type="submit" name="Buscar">
    </form>

    <form class="contenedor padding" id="form-perfil">
        <fieldset>
            <legend>Informacion del Empleado</legend>
            <div class="perfil-form-contenedor">
                <div class="datos">
                    <div class="perfil-input">
                        <label>Número de Empleado</label>
                        <input class="perfil-id" type="text" name="id" disabled>
                    </div>
                    <div class="perfil-input">
                        <label>Nombre Completo</label>
                        <input class="perfil-nombre" type="text" name="nombre" disabled>
                    </div>
                    <div class="perfil-input">
                        <label>RFC</label>
                        <input class="perfil-rfc" type="text" name="rfc" disabled>
                    </div>
                    <div class="perfil-input">
                        <label>Fecha de Nacimiento</label>
                        <input class="perfil-fecha" type="date" name="fecha" disabled>
                    </div>
                    <div class="perfil-input">
                        <label>Edad</label>
                        <input class="perfil-edad" type="text" name="edad" disabled>
                    </div>
                    <div class="perfil-input">
                        <label>Sueldo</label>
                        <input class="perfil-sueldo" type="text" name="sueldo" disabled>
                    </div>
                </div>
                <div class="perfil-input foto">
                    <input class="perfil-foto" type="image" alt="Foto-Empleado" height="300px">
                </div>
                <fieldset class="fieldset-direccion">
                    <legend>Dirección</legend>
                    <div class="direccion">
                        <div class="input-direccion">
                            <label>Estado</label>
                            <input class="perfil-estado" type="text" name="direccion" disabled>
                        </div>
                        <div class="input-direccion">
                            <label>Código Postal</label>
                            <input class="perfil-cp" type="text" name="direccion" disabled>
                        </div>
                        <div class="input-direccion">
                            <label>Colonia</label>
                            <input class="perfil-colonia" type="text" name="direccion" disabled>
                        </div>
                        <div class="input-direccion">
                            <label>Calle</label>
                            <input class="perfil-calle" type="text" name="direccion" disabled>
                        </div>
                        <div class="input-direccion">
                            <label>Número</label>
                            <input class="perfil-numero" type="text" name="direccion" disabled>
                        </div>
                    </div>
                </fieldset>
            </div>
        </fieldset>
    </form>

    <footer class="footer">
        <div class="contendor">
            <div class="barra">
                <a class="logo" href="index.html">
                    <h1 class="texto-centro sombras">Proyecto<span class="negritas">BD</span></h1> <!-- span para variar el texto-->
                </a>
                <nav class="navegacion">
                    <a href="orden.html" class="nav-enlace">Ordenar</a>
                    <a href="nosotros.html" class="nav-enlace">Nosotros</a>
                </nav>
            </div>
            <p class="texto-centro texto-blanco">Todos los Derechos Reservados &copy;</p>
        </div>
    </footer>
</body>
<script src="src/js/empleado.js"></script>             
<script 
    src="https://code.jquery.com/jquery-3.6.0.js" 
    integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" 
    crossorigin="anonymous">
</script>
</html>