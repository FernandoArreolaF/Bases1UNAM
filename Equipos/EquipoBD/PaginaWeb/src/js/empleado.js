document.addEventListener('DOMContentLoaded',function(){

    // Se ejecuta cuando el usuario selecciona un empleado
    $('#empleado').submit(function (e){
        e.preventDefault(); // Previene el evento
        empleado = document.querySelector('.perfil-empleado').value; // Toma el valor seleccionado por el usuario
        infoEmpleado(empleado); // Realiza la consulta a php (base de datos)
    }); 
});

function infoEmpleado(empleado){
    $.ajax({ // Manda una solicitud por ajax
        type: "POST",
        url: "src/php/empleado.php",
        data: 'empleado='+empleado, // Manda el nombre del empleado
        success: function(response){
            datos = JSON.parse(response); // Obtiene los datos en json y los transforma
            imprimirDatos(datos); // Imprime los datos en pantalla
        }
    });
}

// Esta funcion imprime los datos del empleado en el form 
// de html
function imprimirDatos(datos){
    let numEmpleado = document.querySelector('.perfil-id');
    numEmpleado.value = datos[0]['num empleado'];
    let nombre = document.querySelector('.perfil-nombre');
    nombre.value = datos[0]['nombre completo'];
    let rfc = document.querySelector('.perfil-rfc');
    rfc.value = datos[0]['rfc'];
    let fechaNac = document.querySelector('.perfil-fecha');
    fechaNac.value = datos[0]['fecha nacimiento'];
    let edad = document.querySelector('.perfil-edad');
    edad.value = datos[0]['edad'];
    let estado = document.querySelector('.perfil-estado');
    estado.value = datos[0]['estado'];
    let cp = document.querySelector('.perfil-cp');
    cp.value = datos[0]['cp'];
    let colonia = document.querySelector('.perfil-colonia');
    colonia.value = datos[0]['colonia'];
    let calle = document.querySelector('.perfil-calle');
    calle.value = datos[0]['calle'];
    let num_calle = document.querySelector('.perfil-numero');
    num_calle.value = datos[0]['num calle'];
    let sueldo = document.querySelector('.perfil-sueldo');
    sueldo.value = datos[0]['sueldo'];
    let foto = document.querySelector('.perfil-foto');
    foto.src =  datos[0]['foto'];
}