import React from 'react'
import { useState, useEffect } from 'react'
import { useParams } from "react-router-dom";
import styled from 'styled-components'

function ActualizaAlimento() {

    const [comidas, setComidas] = useState([
        {
            precio: '1',
            receta: 'a',
            nombre_alimento: 'b',
            disponibilidad: 'c',
            nombre_categoria: 'd',
            descripcion: 'e',
            desc_categoria: 'f',
            tipo_categoria: 'g',
            nivel_dificultad: 'h',
            sin_alcohol: 'i',
            con_alcohol: 'j',

        }
    ]);



    let params = useParams();

    const fetchDetails = async (id_comida) => {
        const data = await fetch(`http://localhost:4000/Comidas/${params.name}`)
        const detailData = await data.json()
        setComidas(detailData);
    }



    useEffect(() => {

        fetchDetails();
    }, [params.name])

    const handleSubmit = async (e) => {
        e.preventDefault()

        await fetch(`http://localhost:4000/Comidas/${params.name}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(comidas)
        });

    }

    const handleChange = (e) => {

        setComidas({ ...comidas, [e.target.name]: e.target.value })
        console.log(comidas)
    }

    return (
        <ActualizaFondo className="actualizar" id='actualiza__background'>
            <h1> {comidas.nombre_alimento} </h1>
            <form className='form__actualiza' onSubmit={handleSubmit}>
                <FormActualiza>
                    <div>
                        <label className='txt__lab' htmlFor='nombre_alimento'>Nombre del alimento</label>
                        <input onChange={handleChange} contentEditable='true' type='text' className='input__txt' name='nombre_alimento' value={comidas.nombre_alimento || ''} />
                    </div>
                    <div>
                        <label className='txt__lab' htmlFor='precio'>Precio del alimento</label>
                        <input onChange={handleChange} contentEditable='true' className='input__txt' name='precio' value={comidas.precio || ''} />
                    </div>
                    <div>
                        <label className='txt__lab' htmlFor='receta'>Receta del alimento</label>
                        <input onChange={handleChange} contentEditable='true' className='input__txt' name='receta' value={comidas.receta || ''} />
                    </div>
                    <div>
                        <label className='txt__lab' htmlFor='descripcion'>Descripcion del alimento</label>
                        <input onChange={handleChange} type='text' className='input__txt' name='descripcion' value={comidas.descripcion || ''} />
                    </div>
                    <div>
                        <label className='txt__lab' htmlFor='nombre_categoria'>Nombre de la categoria</label>
                        <input onChange={handleChange} contentEditable='true' className='input__txt' name='nombre_categoria' value={comidas.nombre_categoria || ''} />
                    </div>
                    <div>
                        <label className='txt__lab' htmlFor='desc_categoria'>Descripcion de la categoria</label>
                        <input onChange={handleChange} contentEditable='true' className='input__txt' name='desc_categoria' value={comidas.desc_categoria || ''} />
                    </div>
                    <div>
                        <label className='txt__lab' htmlFor='disponibilidad'>Disponibilidad del alimento</label>
                        <input onChange={handleChange} contentEditable='true' className='input__txt' name='disponibilidad' value={comidas.disponibilidad || ''} />
                    </div>
                    <input type='submit' value='Actualizar' className='agregar__btn' />
                </FormActualiza>
            </form>
        </ActualizaFondo >
    )
}

const ActualizaFondo = styled.div`
    background: linear-gradient(45deg,#000000 0%,#2e2b2b 100%);
    position: absolute;
    width: 100%;
    height: 100%;

    h1{
        margin-top: 2rem;
        background: linear-gradient(#14a0e0 0%, #13498f 50%, #14a0e0 100%);
        background-size: 100%;
        -webkit-background-clip: text;
        -moz-background-clip: text;
        -webkit-text-fill-color: transparent;
        -moz-text-fill-color: transparent;
        font-size: 2rem;
        line-height: 2.5rem;
    }
`;

const FormActualiza = styled.div`

    margin-top: 100px;
    border-radius: 5px;
    display: flex;
    flex-direction: column;
    background: linear-gradient(45deg, #13498f 0%, #14a0e0 100%);
    text-align: left;

    .agregar__btn{
        margin-top: 10px;
        height: 50px;
        width: 100px;
        border-radius: 10px;
    }

    .txt__lab{
        margin-right: 5px;
        font-size: 20px;
    }

    .input__txt{
        font-size: 12px;
    }

`

export default ActualizaAlimento