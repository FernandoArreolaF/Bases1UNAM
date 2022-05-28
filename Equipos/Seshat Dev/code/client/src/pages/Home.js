import React from 'react'
import { Link } from 'react-router-dom'
import { useState, useEffect } from 'react'

export default function () {

    const [log,setLog] = useState({
        email: '',
        password: '',
    })

    const handleSubmit = e => {
        e.preventDefault();
        if(log.email == 'gerente@acceso.com' && log.password == '123456'){
            window.location.href = '/gerente'
        }
    }

    const handleChange = e => {
        setLog({...log,[e.target.name]: e.target.value})
    }

    return (
        <React.Fragment>

            <nav class="navbar">
                <div class="navbar__container">
                    <a href="#home" id="navbar__logo">
                        <img src="assets/images/quetzalcoatl2.png" alt="" height="75" />
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
                            <a href="#about" class="navbar__links" id="about-page">Alimentos</a>
                        </li>
                        <li class="navbar__item">
                            <a href="#services" class="navbar__links" id="services-page">Servicios</a>
                        </li>
                        <li class="navbar__items">
                            <a href="#contact" class="navbar__links" id="contacts-page">Contactos</a>
                        </li>
                        <li class="navbar__btn">
                            <a href="#sign-up" class="button" id="signup">Registrarme</a>
                        </li>
                        <li class="navbar__btn">
                            <a href="/Carrito" class="button" id="car">Carrito</a>
                        </li>
                    </ul>
                </div>
            </nav>

            <div class="hero" id="home">
                <div class="hero" id="container">
                    <div class="hero__frame" id="frame">
                        <iframe src='https://my.spline.design/saltpeppercopy-565149b050e400d6b3970aafb59a7f79/' frameborder='0' width='100%' height='100%'></iframe>
                    </div>
                    <h1 class="hero__heading">Experimenta Nuevos <span>Conceptos</span></h1>
                    <p class="hero__description">¿Sabor o Calidad?</p>
                    <button class="main__btn"><a href="#ambosPopUp">Ambos</a></button>
                </div>
            </div>


            <div class="ambos__container-all" id="ambosPopUp">
                <div class="ambos__PopUp">
                    <div class="ambos__header">
                        <div class="ambos__corner--blank"></div>
                        <div class="ambos__corner--img"></div>
                    </div>
                    <div class="ambos__body">
                        <h1>Bienvenid@ a nuestro proyecto</h1>
                        <p>Inserte texto cool
                        </p>
                        <p>Con ello esperamos que disfrutes de la mejor comida mexicana mientras te sumerges en un lugar
                            mágico.
                        </p>
                    </div>
                    <div class="ambos__footer">
                        <div class="ambos__corner--blank"></div>
                        <div class="ambos__corner--img"></div>
                    </div>
                    <a href="#home" class="btn-close__ambos__PopUp">X</a>
                </div>
            </div>


            <div class="main" id="about">
                <div class="main__container">
                    <div class="main__img--container">
                        <div class="main__img--card">
                            <div class="main__img--icon">
                                <img src="assets/images/menu.png" alt="icono__menu" width="250px" height="250px" />
                            </div>
                        </div>
                    </div>
                    <div class="main__content">
                        <h1>¿Cuál es el antojo de hoy?</h1>
                        <h2>Permitenos llevar tu paladar a lugares exóticos</h2>
                        <p>Revisa platillos</p>
                        <button class="main__btn">
                            <Link to="/Menu">Ver</Link></button>
                    </div>
                </div>
            </div>

            <div class="services" id="services">
                <h1>Servicios</h1>
                <div class="services__wrapper">
                    <div class="services__card" id='masVendido'>
                        <h2>Mira nuestro platillo más pedido</h2>
                        <p>¿Lo merece...?</p>
                        <div class="services__btn"><button><Link to='/MasVendido'>Info.</Link></button></div>
                    </div>
                    <div class="services__card">
                        <h2>Nosotros</h2>
                        <p>...</p>
                        <div class="services__btn"><button><Link to="/Personal">Info.</Link></button></div>
                    </div>
                    <div class="services__card">
                        <h2>Membresias</h2>
                        <p>...</p>
                        <div class="services__btn"><button>Info</button></div>
                    </div>
                    <div class="services__card">
                        <h2>Paquetes</h2>
                        <p>...</p>
                        <div class="services__btn"><button>Info</button></div>
                    </div>
                </div>
            </div>


            <div class="sign-up" id="sign-up">
                <div class="main__container">
                    <div class="main__content">
                        <h1>¿Te gustaría darnos la oportunidad?</h1>
                        <h2>El registro es rápido</h2>
                        <p>No te arrepentirás</p>
                        <button class="main__btn"><a href="#register">Registrarme</a></button>
                        <br />
                        <a href="#login">Ya tengo una cuenta</a>
                    </div>
                    <div class="main__img--container">
                        <div class="main__img--card" id="card-2">
                            <img src="assets/images/maya1.png" alt="icono__maya1" height="250px" width="250px" />
                        </div>
                    </div>
                </div>
            </div>



            <div class="form__background" id="register">
                <div class="form__sign-up__container__all">
                    <h4>Gracias por tu elección</h4>
                    <input class="signup__txtfield" type="text" name="nombres" id="nombres" placeholder="Nombre(s)" />
                    <input class="signup__txtfield" type="text" name="apellidos" id="nombres" placeholder="Apellido(s)" />
                    <input class="signup__txtfield" type="email" name="correo" id="correo" placeholder="Correo" />
                    <input class="signup__txtfield" type="password" name="contraseña" id="contrasenia" placeholder="Ingrese su contraseña" />
                    <p>Acepto los <a href="#">Terminos y Condiciones</a></p>
                    <input class="form__btn" type="submit" value="Registrar" />
                    <a href="#sign-up" class="btn__close-signup">X</a>
                </div>
            </div>


            <div class="form__background" id="login">
                <form class="form__sign-up__container__all" id="form__login" onSubmit={handleSubmit}>
                    <h4>Bienvenid@</h4>
                    <input onChange={handleChange}  class="signup__txtfield" type="email" name="email" id="correo" placeholder="Correo" />
                    <input  onChange={handleChange}  class="signup__txtfield" type="password" name="password" id="contrasenia" placeholder="Ingrese su contraseña" />
                    <input class="form__btn" type="submit" value="Ingresar" />
                    <a href="#sign-up" class="btn__close-signup">X</a>
                </form>
            </div>


            <div class="footer__container" id="contact">
                <div class="footer__links">
                    <div class="footer__link--wrapper">
                        <div class="footer__link--items">
                            <h2>Descubre nuestra propuesta</h2>
                            <a href="#contact">Ayuda a despegar este proyecto</a> <a href="/">Reseñas</a>
                            <a href=""></a>
                        </div>
                        <div class="footer__link--items">
                            <h2>Contáctanos</h2>
                            <a href="/">Contacto <img src="assets/images/llamada.png" alt="" width="25px" height="25px" /></a>
                            <a href="/">Soporte <img src="assets/images/servicio-al-cliente.png" alt="" width="25px" height="25px" /></a>
                            <a href="/">Sugerencias <img src="assets/images/aconsejar.png" alt="" width="25px" height="25px" /></a>
                        </div>
                    </div>
                    <div class="footer__link--wrapper">
                        <div class="footer__link--items">
                            <h2>Redes Sociales</h2>
                            <a href="/">Instagram <img src="assets/images/instagram.png" width="25px" height="25px" alt="" /></a>
                            <a href="/">Facebook <img src="assets/images/facebook.png" alt="" width="25px" height="25px" /></a>
                            <a href="/">Twitter <img src="assets/assets/images/twitter.png" alt="" width="25px" height="25px" /> </a>
                        </div>
                    </div>
                </div>
                <section class="social__media">
                    <div class="social__media--wrap">
                        <div class="footer__logo">
                            <a href="/" id="footer__logo"></a>
                        </div>
                        <p class="website__rights">Derechos reservados</p>
                        <div class="social__icons">
                            <a href="/" class="social__icon--link" target="_blank">

                            </a>
                            <a href="/" class="social__icon--link">

                            </a>
                        </div>
                    </div>
                </section>
            </div>
        </React.Fragment>
    )
}
