let pagina = 1; 

document.addEventListener('DOMContentLoaded', function(){
    vistas();
    
});

function vistas(){
    mostrarSeccion();
    cambiarSeccion();
}

// Permite la paginación del menú
function mostrarSeccion(){

    // Eliminar mostrar-seccion de la seccion anterior
    const seccionAnterior =  document.querySelector('.mostrar-seccion');
    if(seccionAnterior){ // Si la seccionAnterior existe
        seccionAnterior.classList.remove('mostrar-seccion');
    } 

    const seccionActual = document.querySelector(`#paso-${pagina}`);
    seccionActual.classList.add('mostrar-seccion');

    
    // Eliminar la clase de actual en el tab anterior
    const tabAnterior = document.querySelector('.tabs .actual');
    if(tabAnterior){ // Si existe tabAnterior
        tabAnterior.classList.remove('actual');
    }

    // Resalta el tab actual
    const tab = document.querySelector(`[data-paso="${pagina}"]`);
    tab.classList.add('actual');
}

function cambiarSeccion(){
    const enlaces = document.querySelectorAll('.tabs button');
    enlaces.forEach( enlace =>{
        enlace.addEventListener('click', e =>{
            e.preventDefault();
            pagina = parseInt(e.target.dataset.paso); // Lo convierte a entero
            mostrarSeccion();
            
        })
    })
}