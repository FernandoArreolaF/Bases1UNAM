import React from 'react'
import { useState, useEffect } from 'react'
import { useParams } from "react-router-dom";
import styled from 'styled-components'

function ActualizarEmpleados() {


  const [empleado, setEmpleado] = useState([
    {
      sueldo: 'c',
      nombre: 'g',
      ap_paterno: 'h',
      ap_materno: 'i',
      calle: 'j',
      numero: 'k',
      colonia: 'l',
      codigo_postal: 'l',
      estado: 'm',
    },
  ]);

  let params = useParams();

    const fetchDetails = async (id_comida) => {
        const data = await fetch(`http://localhost:4000/Empleado/${params.name}`)
        const detailData = await data.json()

        setEmpleado(detailData);
    }



    useEffect(() => {

        fetchDetails();
    }, [params.name])

  const handleSubmit = async (e) => {
    e.preventDefault()

    await fetch(`http://localhost:4000/Empleado/${params.name}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(empleado)
    });


  }

  const handleChange = (e) => {
    e.preventDefault()
    setEmpleado({ ...empleado, [e.target.name]: e.target.value })
    console.log(empleado)
  }

  return (
    <ActualizaFondo>
      <h1> {empleado.nombre} </h1>
      <form className='form__actualiza' onSubmit={handleSubmit}>
        <FormActualiza>
          <div>
            <label className='txt__lab' htmlFor='nombre_alimento'>Nombre del empleado:</label>
            <input readOnly contentEditable='false' type='text' className='inpxt' name='nombre' value={empleado.nombre || ''} />
          </div>
          <div>
            <label className='txt__lab' htmlFor='ap_paterno'>Apellido paterno:</label>
            <input readOnly contentEditable='false' className='input__txt' name='ap_paterno' value={empleado.ap_paterno || ''} />
          </div>
          <div>
            <label className='txt__lab' htmlFor='ap_materno'>Apellido materno:</label>
            <input readOnly contentEditable='false' className='input__txt' name='ap_materno' value={empleado.ap_materno || ''} />
          </div>
          <div>
            <label className='txt__lab' htmlFor='sueldo'>Sueldo: </label>
            <input onChange={handleChange} contentEditable='true' type='text' className='input__txt' name='sueldo' value={empleado.sueldo || ''} />
          </div>
          <div>
            <label className='txt__lab' htmlFor='calle'>Calle:</label>
            <input onChange={handleChange} contentEditable='true' className='input__txt' name='calle' value={empleado.calle || ''} />
          </div>
          <div>
            <label className='txt__lab' htmlFor='numero'>Numero:</label>
            <input onChange={handleChange} contentEditable='true' className='input__txt' name='numero' value={empleado.numero || ''} />
          </div>
          <div>
            <label className='txt__lab' htmlFor='colonia'>Colonia:</label>
            <input onChange={handleChange} contentEditable='true' className='input__txt' name='colonia' value={empleado.colonia || ''} />
          </div>
          <div>
            <label className='txt__lab' htmlFor='codigo_postal'>Codigo postal:</label>
            <input onChange={handleChange} contentEditable='true' className='input__txt' name='colonia' value={empleado.codigo_postal || ''} />
          </div>
          <div>
            <label className='txt__lab' htmlFor='estado'>Estado:</label>
            <input onChange={handleChange} contentEditable='true' className='input__txt' name='colonia' value={empleado.estado || ''} />
          </div>
          <input type='submit' value='Actualizar' className='agregar__btn' />
        </FormActualiza>
      </form>
    </ActualizaFondo>
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

export default ActualizarEmpleados