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

    <div class="contendor fondo-titulo texto-centro">
        <h1>Seleccione hasta 3 platillos/bebidas para ordenar</h1>
    </div>

    <div class="cuenta oculto contenedor" tabindex="0">
        <fieldset>
            <legend>Cuenta</legend>
            <div class="cuenta-formulario">
                <div class="cuenta-formulario-empleado">
                    <label>Mesero</label>
                    <select class="nombre-mesero" name="empleados">
                    <?php
                        // Consulta de la base de datos para devolver un datalist de los paises que se pueden elegir
                        $psql = pg_query($conexion, "SELECT e.nombre FROM empleado e inner join mesero m on e.num_empleado = m.num_empleado");
                        while($nombre = pg_fetch_row($psql)){
                            echo "<option value='$nombre[0]'>$nombre[0]</option>";
                        }
                    ?>
                    </select>
                </div>
                <div class="cuenta-formulario-cliente">
                    <label>Cliente</label>
                    <select class="nombre-cliente" name="clientes">
                    <?php
                        // Consulta de la base de datos para devolver un datalist de los paises que se pueden elegir
                        $psql = pg_query($conexion, "SELECT nombre FROM cliente");
                        while($nombre = pg_fetch_row($psql)){
                            echo "<option value='$nombre[0]'>$nombre[0]</option>";
                        }
                    ?>
                    </select>
                </div>
            </div>
            <div>
                <ul class="cuenta-platillo">
                </ul>
            </div>
            <div class="contenedor texto-centro">
                <h2 class="texto-negro">Total</h2>
                <p class="cuenta-total"></p>
                <button onclick="validarOrden()">Confirmar Orden</button>
            </div>
        </fieldset>
    </div>
    
    <div class="fondo-menu texto-blanco" id="orden">
        <nav class="contendor tabs">
            <button type="button" data-paso="1">Sopas, Pastas y Ensaladas</button>
            <button type="button" data-paso="2">Carnes, Comida Mexicana y Mariscos</button>
            <button type="button" data-paso="3">Bebidas y Postres</button>
        </nav>
        <hr>
        <div id="paso-1" class="menu-texto seccion">
            <div class="orden">
                <div class="orden-seccion platillo">
                        <!-- Sopas -->
                        <h2 class="texto-centro texto-blanco">Sopas</h2>
                        <h3>Sopa de Cebolla</h3>
                        <p>Platillo francés cuyo principal ingrediente es la cebolla caramelizada, acompañada de pan y especias.</p>
                        <p class="texto-derecha">$80.00</p>
                        <form id="Sopa_de_Cebolla" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Sopa Gulash</h3>
                        <p>Plato húngaro elaborado principalmente con carne, cebollas, pimiento y pimentón.</p>
                        <p class="texto-derecha">$100.00</p>
                        <form id="Sopa_Gulash" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Sopa Miso</h3>
                        <p>La sopa de Miso es una sopa japonesa preparada a base de un caldo Dashi y pasta de miso, que le da nombre.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Sopa_Miso" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Sopa Harina</h3>
                        <p>Sopa tradicional europea hecha de legumbres, carne y tomate.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Sopa_Harina" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Gazpacho</h3>
                        <p>Sopa refrescante elaborada inicialmente con miga de pan seco, ajo, vinagre, aceite y agua a la que posteriormente se incorporó jitomate, pimiento y pepino.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Gazpacho" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                    </div>
                    <div class="orden-seccion platillo">
                        <!-- Pastas -->
                        <h2 class="texto-centro texto-blanco">Pastas</h2>
                        <h3>Espagueti a los Quesos</h3>
                        <p>Espagueti bañado en una salsa cremosa hecha con una combinación tres quesos.</p>
                        <p class="texto-derecha">$70.00</p>
                        <form id="Espagueti_a_los_Quesos" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Macarrones con Queso</h3>
                        <p>Exquisitos macarrones bañados en salsa de queso.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Macarrones_con_Queso" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Fideos con Champiñones</h3>
                        <p>Cremosos fideos acompañados de Champiñones.</p>
                        <p class="texto-derecha">$70.00</p>
                        <form id="Fideos_con_Champiñones" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Tallarines con Tomates</h3>
                        <p>Deliciosos tallarines bañados en una salsa de tomate y queso.</p>
                        <p class="texto-derecha">$60.00</p>
                        <form id="Tallarines_con_Tomates" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                    </div>
                    <div class="orden-seccion platillo">
                        <!-- Ensaladas -->
                        <h2 class="texto-centro texto-blanco">Ensaladas</h2>
                        <h3>Ensalada César</h3>
                        <p>Ensalada de lechuga romana y trozos de pan tostado con jugo de limón, aceite de oliva, huevo, salsa Worcestershire, ajo, mostaza, queso parmesano y pimienta negra.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Ensalada_César" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Ensalada Mixta</h3>
                        <p>Platillo frío elaborado con pollo, lechuga y jitomate en rodajas; opcionalmente aguacate rebanado, zanahoria y alguna otra verdura a elección.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Ensalada_Mixta" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Ensalada Waldorf</h3>
                        <p>Ensalada elaborada con manzana, apio, nueces y se adereza con mayonesa y limón.</p>
                        <p class="texto-derecha">$70.00</p>
                        <form id="Ensalada_Waldorf" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Ensalada Griega</h3>
                        <p>Ensalada elaborada con tomate, pepino, cebolla, pimiento, aceitunas negras y aceite de oliva.</p>
                        <p class="texto-derecha">$80.00</p>
                        <form id="Ensalada_Griega" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                    </div>
                </div>
            </div>
            <div id="paso-2" class="menu-texto seccion">
                <div class="orden">
                    <div class="orden-seccion platillo">
                        <!-- Carnes -->
                        <h2 class="texto-centro texto-blanco">Carnes</h2>
                        <h3>Arrachera</h3>
                        <p>Corte fino de res de 45 cm de largo y un grueso de un centímetro aproximadamente.</p>
                        <p class="texto-derecha">$150.00</p>
                        <form id="Arrachera" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Hamburguesa</h3>
                        <p>Platillo tipo sándwich hecho a base de carne de res molida, aglutinada en forma de filete cocinado a la parrilla, acompañada de papas fritas.</p>
                        <p class="texto-derecha">$100.00</p>
                        <form id="Hamburguesa" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Pollo al horno</h3>
                        <p>Pollo cocinado en sus propios jugos y grasa, acompañado o aderezado con hierbas aromáticas y vegetales.</p>
                        <p class="texto-derecha">$100.00</p>
                        <form id="Pollo_al_horno" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Chuleta de cordero</h3>
                        <p>Pollo cocinado en sus propios jugos y grasa, acompañado o aderezado con hierbas aromáticas y vegetales.</p>
                        <p class="texto-derecha">$200.00</p>
                        <form id="Chuleta_de_cordero" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                    </div>
                    <div class="orden-seccion platillo">
                        <!-- Comida Mexicana -->
                        <h2 class="texto-centro texto-blanco">Comida Mexicana</h2>
                        <h3>Tacos</h3>
                        <p>Cinco piezas de deliciosos tacos de suadero.</p>
                        <p class="texto-derecha">$80.00</p>
                        <form id="Tacos" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Mole con Pollo</h3>
                        <p>Pollo bañado en salsa espesa echa a base de chocolates, chiles y especias.</p>
                        <p class="texto-derecha">$130.00</p>
                        <form id="Mole_con_Pollo" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Cochinita Pibil</h3>
                        <p>Platillo basado en carne de cerdo marinada en una preparación con achiote y cocida al horno.</p>
                        <p class="texto-derecha">$200.00</p>
                        <form id="Cochinita_Pibil" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Pozole</h3>
                        <p>Platillo a base de granos de maíz nixtamalizados y carne de res.</p>
                        <p class="texto-derecha">$100.00</p>
                        <form id="Pozole" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                    </div>
                    <div class="orden-seccion postres">
                        <!-- Mariscos -->
                        <h2 class="texto-centro texto-blanco">Mariscos</h2>
                        <h3 class="texto-blanco">Salmón al horno</h3>
                        <p>Delicioso salmón cocinado al horno acompañado de pure de papas.</p>
                        <p class="texto-derecha">$500.00</p>
                        <form id="Salmón_al_horno" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Ceviche</h3>
                        <p>Platillo preparado con trozos de pescado crudo, marinados en jugo de limón u otro líquido ácido y condimentado con otros ingredientes.</p>
                        <p class="texto-derecha">$300.00</p>
                        <form id="Ceviche" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Camarones empanizados</h3>
                        <p>Ocho piezas de camarones empanizados crujientes acompañados de una salsa para mojar.</p>
                        <p class="texto-derecha">$200.00</p>
                        <form id="Camarones_empanizados" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Pescado a la mantequilla</h3>
                        <p>Filetes de pescado fritos con mantequilla acompañados de verdura.</p>
                        <p class="texto-derecha">$150.00</p>
                        <form id="Pescado_a_la_mantequilla" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                    </div>
                </div>
            </div>
            <div id="paso-3" class="menu-texto seccion">
                <div class="orden">
                    <div class="orden-seccion postres">
                        <!-- Postres -->
                        <h2 class="texto-centro texto-blanco">Postres</h2>
                        <h3 class="texto-blanco">Flan</h3>
                        <p>Postre elaborado con una natilla, teniendo como ingredientes principales huevos enteros, leche y azúcar.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Flan" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Pastel de chocolate</h3>
                        <p>Rebanada de delicioso pastel sabor chocolate.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Pastel_de_Chocolate" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Tiramisú</h3>
                        <p>Postre que se prepara con láminas de masa de bizcocho empapadas en café.</p>
                        <p class="texto-derecha">$100.00</p>
                        <form id="Tiramisú" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Pay de Limón</h3>
                        <p>Rebanada de delicioso Pay de Limón.</p>
                        <p class="texto-derecha">$50.00</p>
                        <form id="Pay_de_Limón" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                    </div>
                    <div class="orden-seccion bebidas">
                        <!-- Bebidas -->
                        <h2 class="texto-centro texto-blanco">Bebidas</h2>
                        <h3 class="texto-blanco">Limonada</h3>
                        <p>Bebida refrescante elaborada con agua natural o mineral, azúcar y jugo de limón.</p>
                        <p class="texto-derecha">$30.00</p>
                        <form id="Limonada" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Cerveza</h3>
                        <p>Bebida alcohólica elaborada a partir de azúcares obtenidas de cereales y otros granos.</p>
                        <p class="texto-derecha">$20.00</p>
                        <form id="Cerveza" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Soda</h3>
                        <p>Bebida gaseosa de diversos sabores y sin alcohol, elaborada con agua y ácido carbónico.</p>
                        <p class="texto-derecha">$15.00</p>
                        <form id="Soda" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                        <h3 class="texto-blanco">Café</h3>
                        <p>Bebida que se obtiene a partir de los granos tostados y molidos de los frutos de la planta del café, tipo americano o cappuccino.</p>
                        <p class="texto-derecha">$15.00</p>
                        <form id="Cafe" class="orden-seleccion">
                            <input type="number" min="0" max="10" name="cantidad" value="0">
                            <input class="informacion" type="submit" value="Agregar" name="submit">
                        </form>
                        <hr>
                    </div>
                </div>
            </div>
    </div>

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
<script src="src/js/vista.js"></script>             
<script src="src/js/orden.js"></script>             
<script 
    src="https://code.jquery.com/jquery-3.6.0.js" 
    integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" 
    crossorigin="anonymous">
</script>
</html>