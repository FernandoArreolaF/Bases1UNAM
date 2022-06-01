import Nuevos from '../components/Nuevos'
import { Link } from 'react-router-dom'


import React from 'react'

function comidas() {



    return (

        <>
            <div class="navbarMenu">
                <div class="navbarMenu__container">
                    <Link to="/">
                        <img src="../../assets/images/quetzalcoatl2.png" alt="" height="75" />
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
                    </ul>
                </div>
            </div>
            <div>
                <Nuevos />
            </div>
        </>
    )
}

export default comidas