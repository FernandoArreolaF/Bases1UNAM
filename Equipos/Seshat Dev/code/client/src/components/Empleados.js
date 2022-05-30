import { Splide, SplideSlide } from '@splidejs/react-splide'
import '@splidejs/splide/dist/css/splide.min.css'
import React, { useEffect, useState } from 'react'
import styled from 'styled-components'

function Empleados() {

    const [listaEmpleados, setListaEmpleados] = useState([])

    const [empleado, setEmpleado] = useState([
        {
            id_empleado: '',
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
            estado: '',
        }
    ])



    const loadEmpleados = async () => {
        const response = await fetch('http://localhost:4000/Empleados')
        const data = await response.json()
        setListaEmpleados(data)
        console.log(data)
    }

    useEffect(() => {
        loadEmpleados()
    }, [])

    const handleAdd = e => {
        e.preventDefault()
        window.location.href = '/AgregarEmpleado';
    }

    const handleUpdate = (id) => {
        window.location.href = "/ActualizarEmpleado/" + id;
    }

    const handleDelete = async (id) => {
        window.location.reload()
        const res = await fetch(`http://localhost:4000/Empleado/${id}`, {
            method: 'DELETE',
        })
        setListaEmpleados(empleado.filter(empleado => empleado.id_empleado !== id))
    }


    return (
        <div>
            <EmpleadosContainer className='empleados__container'>
                <h1>Lista de empleados</h1>
                <div>
                    <input type='button' className='agregarEmpleado__btn' value='Agregar' id='agregarEmpleado__btn' onClick={handleAdd} />
                </div>
                <Splide options={{
                    perPage: 4,
                    arrows: false,
                    pagination: false,
                    drag: 'free',
                    gap: '5rem',
                }}>
                    {
                        listaEmpleados.map((empleado) => (
                            <React.Fragment key={empleado.id_empleado}>
                                <SplideSlide key={empleado.id_empleado}>
                                    <CardEmpleado key={empleado.id_empleado}>
                                        <div className='empleado--card' key={empleado.id_empleado}>
                                            <p> {empleado.nombre} {empleado.ap_paterno} {empleado.ap_materno} </p>
                                            <div className='empleado__btns'>
                                                <input type='button' value='Actualizar' onClick={() => handleUpdate(empleado.id_empleado)} />
                                                <input type='button' value='Borrar' onClick={() => handleDelete(empleado.id_empleado)} />
                                            </div>
                                        </div>
                                    </CardEmpleado>
                                </SplideSlide>
                            </React.Fragment>
                        ))
                    }
                </Splide>
            </EmpleadosContainer>
        </div>
    )
}

const EmpleadosContainer = styled.div`

    h1{
        margin-top: 3rem;
        background: linear-gradient(#e04e14 0%, #8f3a13 50%, #e03314 100%);
        background-size: 100%;
        -webkit-background-clip: text;
        -moz-background-clip: text;
        -webkit-text-fill-color: transparent;
        -moz-text-fill-color: transparent;
        font-size: 60px;
    }

    #agregarEmpleado__btn{
        margin-top: 2rem;
    }

    

`;

const CardEmpleado = styled.div`

.empleado--card{
    background: linear-gradient(to right, #a8c0ff, #3f2b96);
    color: #000000;
    height: 100px;
    width: 200px;
    border-radius: 2rem;
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

.empleado--card p{
    font-weight: 600;
    height: 60%;
    width: 100%;
    position: relative;
    place-items: center;
    justify-content: center;
    align-items: center;
    text-align: center;
}

.empleado--btns{
    height: 40%;
    width: 100%;
    display: flex;
}

.Agregar__btn{
    margin-bottom: 2rem;
}



.Actualizar__btn{
    height: 25px;
    width: 100px;
    border-radius: 5px;
    padding: 0 2rem;
    box-shadow: #000000 9px #999;
}

.Borrar__btn{
    height: 25px;
    width: 100px;
    border-radius: 5px;
    box-shadow: #000000 9px #999;
    
}

`

export default Empleados