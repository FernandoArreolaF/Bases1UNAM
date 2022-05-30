let totalPlatillosOrdenados = 0;
let total = 0;
let orden = [];
let precioPlatillo = [];
let totalPlatillo = [];
let platilloBloqueado = false;

let cuenta = document.querySelector('.cuenta');

document.addEventListener('DOMContentLoaded',function(){

    // Se ejecuta cuando el usuario selecciona un platillo
    $('#orden').submit(function (e){
        e.preventDefault(); // Previene el evento
        platillo = e.target.id; // Obtiene el nombre del platillo
        let datos = $(`#${platillo}`).serializeArray();
        let cantidad = datos[0]['value']; // Obtiene la cantidad seleccionada
        if(platillo.includes("_")){
            platillo = platillo.replace(/_/g, ' ');
        } 
        if (cantidad == 0){
            errorSeleccion(); // No se pueden agregar 0 platillos
        }else{
            obtenerPlatillo(platillo, cantidad); // Obtiene el platillo y el precio de la base de datos
        }
        
    }); 
});

function obtenerPlatillo(platillo, cantidad){
    $.ajax({ // Manda una solicitud por ajax
        type: "POST",
        url: "src/php/orden.php",
        data: 'platillo='+platillo, // Manda el nombre del platillo
        success: function(response){
            datos = JSON.parse(response); // Obtiene los datos en json y los transforma
            
            precio = datos[0]['Precio'][0]; // Obtiene el precio de un pltatillo
            precio = parseFloat(precio.replace('$',''));
            let total_orden_platillo = 0;
            for(i = 0; i < cantidad;i++){
                total_orden_platillo += precio; // Obtiene el precio de la cantidad del platillo
            }
            
            // Arrays de apoyo para guardar los datos
            total+=total_orden_platillo;
            precioPlatillo.push(platillo+' = '+precio)
            orden.push(platillo+' x '+cantidad);
            totalPlatillo.push(total_orden_platillo);

            mostrarOrden(platillo); // Muestra la orden en el html
            
        }
    });
}

// Genera todo el contenido en html para mostrar la orden
function mostrarOrden(platillo){
    cuenta.classList.remove('oculto');

    let cuenta_platillo = document.querySelector('.cuenta-platillo');
    
    let contenedor = document.createElement('DIV');
    contenedor.classList.add('contenedor-platillo');

    let info_cuenta = document.createElement('LI');
    info_cuenta.textContent = platillo;

    let detalles_cuenta = document.createElement('UL');
    let precio_platillo = document.createElement('LI');
    precio_platillo.textContent = precioPlatillo.pop();
    detalles_cuenta.appendChild(precio_platillo);
    let orden_platillo = document.createElement('LI');
    orden_platillo.textContent = orden.pop();
    orden_platillo.classList.add('platillo-ordenado');
    detalles_cuenta.appendChild(orden_platillo);
    let total_platillo = document.createElement('LI');
    let totalPlt = totalPlatillo.pop();
    total_platillo.textContent = totalPlt;
    total_platillo.classList.add('precio-platillo-ordenado');
    detalles_cuenta.appendChild(total_platillo);

    let eliminar = document.createElement('BUTTON');
    eliminar.textContent = "Eliminar";
    
    info_cuenta.appendChild(detalles_cuenta);
    contenedor.appendChild(info_cuenta);
    contenedor.appendChild(eliminar);
    cuenta_platillo.appendChild(contenedor);
    
    let total_orden = document.querySelector('.cuenta-total');
    total_orden.textContent = total;

    // Bloquea el platillo que acaba de ser agregado
    bloquearPlatillo(platillo);
 
    /* Bloquear y desbloquear pedidos */

    platilloAgregado();
    totalPlatillosOrdenados++;

    // Solo se pueden agregar 3 platillos
    if (totalPlatillosOrdenados == 3){
        bloquearPedido(); 
    }

    /* Eliminar pedidos */
    eliminar.onclick = function(){
        contenedor.parentNode.removeChild(contenedor);
        total = total - totalPlt;
        total_orden.textContent = total;
        platilloEliminado();

        desbloquearPlatillo(platillo);

        if(platilloBloqueado){
            desbloquearPedido();
        }
       
        totalPlatillosOrdenados--;
        if (totalPlatillosOrdenados == 0){
            cuenta.classList.add('oculto');
        }
    };
}

// Si la cantidad de un platillo es igual a 0
function errorSeleccion(){
    alert('La cantidad del platillo seleccionado no puede ser 0.');
}

// Confirmacion de que el platillo se agregó correctamente
function platilloAgregado(){
    document.querySelector('.cuenta').focus();
    const body = document.querySelector('body');
    let contenedor = document.createElement('DIV');
    contenedor.classList.add('texto-centro');
    let mensaje = document.createElement('h2');
    mensaje.textContent = 'Correctamente agregado a la orden';

    contenedor.appendChild(mensaje)
    body.appendChild(contenedor);
    mensaje.classList.add('platillo-confirmacion');
    
    setTimeout(function(){
        body.removeChild(contenedor);
    }, 1500); // El mensaje desaparece despues de un segundo y medio
}

// Confirmación de que un platillo se eliminó correctamente
function platilloEliminado(){
    const body = document.querySelector('body');
    let contenedor = document.createElement('DIV');
    contenedor.classList.add('texto-centro');
    let mensaje = document.createElement('h2');
    mensaje.textContent = 'Correctamente eliminado de la orden';

    contenedor.appendChild(mensaje)
    body.appendChild(contenedor);
    mensaje.classList.add('platillo-eliminado');
    
    setTimeout(function(){
        body.removeChild(contenedor);
    }, 1500); // El mensaje desaparece despues de un segundo y medio
}

function bloquearPedido(){
    inputs = document.querySelectorAll('.informacion');
    inputs.forEach(input => {
        input.disabled = true;
    });
    platilloBloqueado = true;
}

function desbloquearPedido(){
    inputs = document.querySelectorAll('.informacion');
    inputs.forEach(input => {
        input.disabled = false;
    });
    platilloBloqueado = false;
}

function bloquearPlatillo(platillo){
    if(platillo.includes(" ")){
        platillo = platillo.replace(/ /g, '_');
    }
    plato = document.querySelector(`#${platillo} .informacion`);
    plato.disabled = true;
}

function desbloquearPlatillo(platillo){
    if(platillo.includes(" ")){
        platillo = platillo.replace(/ /g, '_');
    }
    plato = document.querySelector(`#${platillo} .informacion`);
    plato.disabled = false;
}

/* Validando orden */
function validarOrden(){

    let platos = [];
    let cantidades = [];
    let preciosTotales = [];
    let objeto = new Object();

    let mesero = document.querySelector('.nombre-mesero').value;
    let cliente = document.querySelector('.nombre-cliente').value;

    if(mesero == ''){
        alert('Tiene que seleccionar un empleado');
        return;
    }

    if(cliente == ''){
        alert('Tiene que seleccionar un cliente');
        return;
    }

    platillos = document.querySelectorAll('.platillo-ordenado');
    platillos.forEach(platillo =>{
        let arr = platillo.textContent.split(' x ');
        platos.push(arr[0]);
        cantidades.push(parseInt(arr[1]));
    });
    
    precios = document.querySelectorAll('.precio-platillo-ordenado');
    precios.forEach(precio =>{
        preciosTotales.push((parseInt(precio.textContent)));
    });

    objeto['platillo'] = platos;
    objeto['cantidad'] = cantidades;
    objeto['precio'] = preciosTotales;
    objeto['total'] = total;
    objeto['empleado'] = mesero;
    objeto['cliente'] = cliente;

    $.ajax({ // Manda una solicitud por ajax
        type: "POST",
        url: "src/php/validarOrden.php",
        data: objeto, // Manda el objeto de los datos del platillo
        success: function(response){
            datos = JSON.parse(response); // Obtiene los datos en json y los transforma
            console.log(datos);
            if(datos == 'OK'){
                ordenConfirmada();
                setTimeout(function(){
                    window.open('orden.php','_self');
                }, 1000);
            }else{
                ordenDenegada();
            }
        }
    });
}

function ordenConfirmada(){
    document.querySelector('.cuenta').focus();
    const body = document.querySelector('body');
    let contenedor = document.createElement('DIV');
    contenedor.classList.add('texto-centro');
    let mensaje = document.createElement('h2');
    mensaje.textContent = 'La orden ha sido procesada con éxito';

    contenedor.appendChild(mensaje)
    body.appendChild(contenedor);
    mensaje.classList.add('platillo-confirmacion');
    
    setTimeout(function(){
        body.removeChild(contenedor);
    }, 1500); // El mensaje desaparece despues de un segundo y medio
}

function ordenDenegada(){
    const body = document.querySelector('body');
    let contenedor = document.createElement('DIV');
    contenedor.classList.add('texto-centro');
    let mensaje = document.createElement('h2');
    mensaje.textContent = 'Su orden ha sido denegada';

    contenedor.appendChild(mensaje)
    body.appendChild(contenedor);
    mensaje.classList.add('platillo-eliminado');
    
    setTimeout(function(){
        body.removeChild(contenedor);
    }, 1500); // El mensaje desaparece despues de un segundo y medio
}