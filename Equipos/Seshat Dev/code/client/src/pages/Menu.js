import React from 'react'
import { Link } from 'react-router-dom'


export default function Menu() {
  return (
    <React.Fragment>
        
    <div class="navbarMenu">
        <div class="navbarMenu__container">
            <Link to="/">
                <img src="images/quetzalcoatl2.png" alt="" height="75" />
            </Link>
            <div class="navbarMenu__toggle" id="mobMenu">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </div>
            <ul class="navbarMenu__menu">
                <li class="navbarMenu__item">
                    <Link to="/" class="navbarMenu__links" id="home-page">Inicio</Link>
                </li>
                <li class="navbar__item">
                    <a href="#desayunos" class="navbarMenu__links" id="Desayunos-page">Desayunos</a>
                </li>
                <li class="navbar__item">
                    <a href="#comidas" class="navbarMenu__links" id="Comidas-page">Comidas</a>
                </li>
                <li class="navbar__item">
                    <a href="#postres" class="navbarMenu__links" id="Postres-page">Postres</a>
                </li>
                <li class="navbar__item">
                    <a href="#bebidas" class="navbarMenu__links" id="Bebidas-page">Bebidas</a>
                </li>
            </ul>
        </div>
    </div>

    
    <div class="desayunos" id="desayunos">
        <div class="section__container">
            <h1 class="section__heading">Para iniciar de lo mejor el día</h1>
            <div class="section__body">
                <div class="section__card">
                    <h2>Prueba nuestros Molletes</h2>
                    <p>La variedad te recetas te van a encantar</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card">
                    <h2>¿Ya conoces nuestros tamales?</h2>
                    <p>Sabores clásicos e invenciones de la casa</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card">
                    <h2>No pueden faltar unas buenas quesadillas</h2>
                    <p>Si, llevan queso</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card">
                    <h2>Especialidades de fin de semana</h2>
                    <p>Para reponerte de la semana</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
            </div>
        </div>
    </div>

    
    <div class="comidas" id="comidas">
        <div class="section__container">
            <h1 class="section__heading" id="head2">Disfruta de una tarde o noche deliciosa</h1>
            <div class="section__body">
                <div class="section__card" id="card2">
                    <h2>¿Ya probaste nuestro pastel azteca?</h2>
                    <p>Ahora es el momento</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card2">
                    <h2>Nunca pueden faltar los tacos</h2>
                    <p>Nuestra variedad de masas para tortilla de sorprenderá</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card2">
                    <h2>Acompañamientos</h2>
                    <p>Disfruta el arte de experimentar con los sabores</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card2">
                    <h2>Carta del restaurante</h2>
                    <p>Seguro algo se antoja</p>
                    <div class="section__btn"><button><Link to='/Comidas'>Info.</Link></button></div>
                </div>
            </div>
        </div>
    </div>

    
    <div class="postres" id="postres">
        <div class="section__container">
            <h1 class="section__heading" id="head3">Por que nunca puede faltar un buen remate</h1>
            <div class="section__body">
                <div class="section__card" id="card3">
                    <h2>¿Conoces el Nicuatole?</h2>
                    <p>No te pierdas más de su maravilloso sabor</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card3">
                    <h2>Deleitate con nuestra selección de dulces a base de cacao</h2>
                    <p>El chocolate como no lo conocías</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card3">
                    <h2>El piloncillo de nuestras Torrejas es singular</h2>
                    <p>Por que lo tradicional se disfruta más</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card3">
                    <h2>Carta de postres</h2>
                    <p>Seguro algo se antoja</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
            </div>
        </div>
    </div>

    
    <div class="bebidas" id="bebidas">
        <div class="section__container">
            <h1 class="section__heading" id="head4">¿Tienes calor? ¿Frío? Tenemos como hidratarte</h1>
            <div class="section__body">
                <div class="section__card" id="card4">
                    <h2>Clásicas aguas frutales</h2>
                    <p>Por que siempre se antoja ese fresco sabor a tu fruta favorita</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card4">
                    <h2>Café</h2>
                    <p>Aquí creemos que siempre es un buen momento paraun rico café</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card4">
                    <h2>Bebidas alcholicas</h2>
                    <p>Si cuentas con la edad suficiente, visita nuestra selección especial</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
                <div class="section__card" id="card4">
                    <h2>Carta de bebidas</h2>
                    <p>Olvidate de la sed</p>
                    <div class="section__btn"><button>Info.</button></div>
                </div>
            </div>
        </div>
    </div>
    </React.Fragment>
  )
}
