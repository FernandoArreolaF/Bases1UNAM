import React from 'react'
import { Link } from 'react-router-dom'

import Alimentos from '../components/Alimentos'
import Empleados from '../components/Empleados'

function Gerente() {
    return (
        <React.Fragment>
            <nav class="navbar">
                <div class="navbar__container">
                    <a href="#home" id="navbar__logo">
                        <img src="../../assets/images/quetzalcoatl2.png" alt="" height="75" />
                    </a>
                    <div class="navbar__toggle" id="mobile-menu">
                        <span class="bar"></span>
                        <span class="bar"></span>
                        <span class="bar"></span>
                    </div>
                    <ul class="navbar__menu">
                        <li class="navbar__item">
                            <a href="#home" class="navbar__links" id="home-page">Inicio</a>
                        </li>
                        <li class="navbar__item">
                            <a href="#alimentos" class="navbar__links" id="about-page">Alimentos</a>
                        </li>
                        <li class="navbar__item">
                            <a href="#empleados" class="navbar__links" id="services-page">Empleados</a>
                        </li>
                    </ul>
                </div>
            </nav>

            <div>
                <Alimentos id='alimentos' />
            </div>

            <div>
                <Empleados id='empleados'/>
            </div>


        </React.Fragment>
    )
}

export default Gerente