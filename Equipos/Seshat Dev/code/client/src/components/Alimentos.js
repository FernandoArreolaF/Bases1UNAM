import React from 'react'

import { useEffect, useState } from 'react'
import { Splide, SplideSlide } from '@splidejs/react-splide'
import '@splidejs/splide/dist/css/splide.min.css'
import { Link } from 'react-router-dom'

function Alimentos() {

    /* Es necesario utilizar los hooks useState y useEffect de react para mejorar la comunicación */

    /* Se crean hooks para almecenar los json que va a mandar el backend y la base de datos */

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

        /* Uso de la base de datos en la página web */

    const loadComidas = async () => { // esta funcion envía una solicitud GET al backend y el back end manda
                                       // la respectiva query a la base de datos

        const response = await fetch('http://localhost:4000/Comidas')
        const data = await response.json()
        setListaComidas(data) // aquí ya cargo los datos recibidos
    }

    useEffect(() => {
        loadComidas() // esta función es necesaria para llenar los hooks correctamente
    }, [])

    /* Cuando se quiera realizar una creación, actualización o eliminación en la base
        es necesario añadir el método que se quiere realizar
        DELETE -----> para DELETE
        POST ------> para INSERT
        PUT ------> para UPDATE */
    const handleDelete = async (id) => {
        const res = await fetch(`http://localhost:4000/Comidas/${id}`, {
            method: 'DELETE',
        })
        setListaComidas(comidas.filter(comidas => comidas.id_comida !== id))
    }

    const handleUpdate = (id) => {
        window.location.href = "/ActualizarAlimentos/" + id
    }

    const initAniadirAlimento = e => {
        e.preventDefault()
        window.location.href = '/AniadirAlimento'
    }



    return (
        <div>

            <div className='comidas__container' >
                <h3>Lista de alimentos</h3>

                <div >
                    <input type='button' className='Agregar__btn' value='Agregar' onClick={initAniadirAlimento} />
                </div>

                <Splide options={{
                    perPage: 4,
                    arrows: false,
                    pagination: false,        /* Se puede ver como la información proporcionada */
                    drag: 'free',               /* viene directamente de los datos que arroja la base */
                    gap: '5rem',
                }}>
                    {
                        listaComidas.map((comidas) => (
                            <React.Fragment key={comidas.id_identificador}>

                                <SplideSlide key={comidas.id_identificador}>
                                    <div className='alimento--card-G' key={comidas.id_identificador}>
                                        <p>{comidas.nombre_alimento}</p>
                                        <div className='alimento--btns'>
                                            <input type='button' className='Actualizar__btn' value='Actualizar' onClick={() => handleUpdate(comidas.id_identificador)} />
                                            <input type='button' className='Borrar__btn' value='Borrar' onClick={() => handleDelete(comidas.id_identificador)} />
                                        </div>
                                    </div>
                                </SplideSlide>
                            </React.Fragment>

                        ))
                    }
                </Splide>

            </div>

        </div>
    )

}

export default Alimentos