import React from 'react'

import { useEffect, useState } from 'react'
import styled from 'styled-components'
import { Splide, SplideSlide } from '@splidejs/react-splide'
import '@splidejs/splide/dist/css/splide.min.css'
import { Link } from 'react-router-dom'

function Nuevos() {

    const [listaComidas, setListaComidas] = useState([])

    const [comidas, setComidas] = useState([
        {
            id_identificador: '',
            precio: '',
            receta: '',
            nombre_alimento: '',
            disponibilidad: '',
            nombre_categoria: '',
            descripcion: '',
            desc_categoria: '',
            tipo_categoria: '',
            nivel_dificultad: '',
            sin_alcohol: '',
            con_alcohol: '',

        }
    ]);

    const loadComidas = async () => {

        const response = await fetch('http://localhost:4000/Comidas')
        const data = await response.json()
        setListaComidas(data)
    }

    useEffect(() => {
        loadComidas()
    }, [])

    return (
        <div>
            <div className='comidas__container' >
                <h3>Nuestro menú</h3>

                <Splide options={{
                    perPage: 4,
                    arrows: false,
                    pagination: false,
                    drag: 'free',
                    gap: '5rem',
                }}>
                    {
                        listaComidas.map(comidas => {
                            return (
                                <SplideSlide>
                                    <div className='alimento--card' key={comidas.id_identificador}>
                                        <Link to={"/DetallesComida/" + comidas.id_identificador}>
                                            <p>{comidas.nombre_alimento}</p>
                                            <img src='../../assets/images/hamburguesa.png' alt={comidas.nombre_alimento} />
                                        </Link>
                                        <div className='gradient__shadow'></div>
                                    </div>
                                </SplideSlide>
                            )
                        })
                    }
                </Splide>

            </div>
        </div>
    )
}

const Gradient = styled.div`
    z-index: 3;
    position: absolute;
    width: 100%;
    height: 100%;
    background: linear-gradient(rgba(0,0,0,0),rgba(0,0,0,0.5));
`;

export default Nuevos