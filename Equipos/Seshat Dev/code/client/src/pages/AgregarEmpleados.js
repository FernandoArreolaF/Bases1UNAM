import React from 'react'
import { useState } from 'react'
import styled from 'styled-components'

function AgregarEmpleados() {

    const [empleado, setEmpleado] = useState([
        {
            edad: '',
            sueldo: '',
            fecha_nacimiento: '',
            rfc_empleado: '',
            nombre: '',
            ap_paterno: '',
            ap_materno: '',
            calle: '',
            numero: '',
            colonia: '',
            codigo_postal: '',
            estado: ''
        }
    ])

    const handleSubmit = async (e) => {
        e.preventDefault()

        const res = await fetch('http://localhost:4000/Empleados', {
            method: "POST",
            body: JSON.stringify(empleado),
            headers: { "Content-type": "application/json" },
        })
        const data = await res.json()
        console.log(data)
    }

    const handleChange = e => {
        setEmpleado({ ...empleado, [e.target.name]: e.target.value })
        console.log(empleado)
    }

    return (
        <React.Fragment>
            <ActualizaFondo className='aniadir__background'>
                <h1>Introduce los datos</h1>
                <form class='aniadir__form' onSubmit={handleSubmit}>
                    <div>
                        <label className='input__txt' for='nombreEmpleado'>Nombre del Empleado:</label>
                        <input onChange={handleChange} className='aniadir__input' name='nombre' id='nombreEmpleado' />
                    </div>
                    <div>
                        <label className='input__txt' for='apPaternoEmpleado'>Apellido paterno del Empleado:</label>
                        <input onChange={handleChange} className='aniadir__input' name='ap_paterno' id='apPaternoEmpleado' />
                    </div>
                    <div>
                        <label className='input__txt' for='recetaEmpleado'>Apellido materno del Empleado:</label>
                        <input onChange={handleChange} className='aniadir__input' name='ap_materno' id='apMaternoEmpleado' />
                    </div>
                    <div>
                        <label className='input__txt' for='precioEmpleado'>Sueldo del Empleado:</label>
                        <input onChange={handleChange} className='aniadir__input' name='sueldo' />
                    </div>
                    <div>
                        <label className='input__txt' for='categoriaAlimeno'>RFC del Empleado:</label>
                        <input onChange={handleChange} className='aniadir__input' name='rfc_empleado' />
                    </div>
                    <div>
                        <labe className='input__txt' for='descCategoria'>Calle:</labe>
                        <input onChange={handleChange} className='aniadir__input' name='calle' />
                    </div>
                    <div>
                        <labe className='input__txt' for='descCategoria'>Colonia:</labe>
                        <input onChange={handleChange} className='aniadir__input' name='colonia' />
                    </div>
                    <div>
                        <labe className='input__txt' for='descCategoria'>Numero:</labe>
                        <input onChange={handleChange} className='aniadir__input' name='numero' />
                    </div>
                    <div>
                        <labe className='input__txt' for='descCategoria'>Código Postal:</labe>
                        <input onChange={handleChange} className='aniadir__input' name='codigo_postal' />
                    </div>
                    <div>
                        <labe className='input__txt' for='descCategoria'>Estado:</labe>
                        <input onChange={handleChange} className='aniadir__input' name='estado' />
                    </div>
                    <div>
                        <labe className='input__txt' for='descCategoria'>Fecha de nacimiento:</labe>
                        <input onChange={handleChange} className='aniadir__input' name='fecha_nacimiento' />
                    </div>
                    <div>
                        <labe className='input__txt' for='descCategoria'>Edad:</labe>
                        <input onChange={handleChange} className='aniadir__input' name='edad' />
                    </div>
                    <input type='submit' value='Agregar' className='agregar__btn' />
                </form>
            </ActualizaFondo>


        </React.Fragment>
    )
}

const ActualizaFondo = styled.div`
    background: #000;

    h1{
        margin-top: 2rem;
        background: linear-gradient(to right, #ad5389, #3c1053);
        background-size: 100%;
        -webkit-background-clip: text;
        -moz-background-clip: text;
        -webkit-text-fill-color: transparent;
        -moz-text-fill-color: transparent;
        font-size: 2rem;
        line-height: 2.5rem;
    }

    form{
        margin-top: 100px;
        border-radius: 5px;
        display: flex;
        flex-direction: column;
        background: linear-gradient(to right, #a8c0ff, #3f2b96);
        text-align: left;
    }

    .input__txt{
        margin-right: 5px;
        font-size: 20px;
    }

    .agregar__btn{
        margin-top: 10px;
        height: 50px;
        width: 100px;
        border-radius: 10px;
    }

`;

export default AgregarEmpleados