import React from 'react'
import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom';
import styled from 'styled-components'

export default function Personal() {

  const [listaEmpleados, setListaEmpleados] = useState([])

  // eslint-disable-next-line no-unused-vars
  const [empleados, setEmpleados] = useState([
    {
      num_empleado: '',
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
  ]);

  const loadEmpleado = async () => {
    const response = await fetch('http://localhost:4000/Empleados')
    const data = await response.json()
    setListaEmpleados(data)
    console.log(data)
  }

  useEffect(() => {
    loadEmpleado()
  }, [])

  return (
    <React.Fragment>

      <div class="navbarMenu">
        <div class="navbarMenu__container">
          <Link to="/">
            <img src="../../images/quetzalcoatl2.png" alt="" height="75" />
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

      <GlobalContainer className="global__container">
        <h1>Te presentamos a nuestra familia</h1>
      </GlobalContainer>

      {

        listaEmpleados.map(empleados => {
          return (
            <StyledEmpleados class='empleado__container' key={empleados.num_empleado}>
              <div className='column'>
                <div >
                  <img src='assets/images/usuario.png' alt='imagen del empleado' class='empleado--img' heigh='25px' width='25px' />
                </div>
                <div>
                  <h2 class='empleado__nombre'> Nombre: {empleados.nombre}  {empleados.ap_paterno} {empleados.ap_materno} </h2>
                  <p class='empleado__edad'> Edad: {empleados.edad} </p>
                  <p>Ocupacion: </p>
                </div>
              </div>
            </StyledEmpleados>
          )
        })

      }

    </React.Fragment>
  )
}

const GlobalContainer = styled.div`

.global__container{
    display: flex;
    flex-direction: column;
    justify-content: center;
    background: #000000;

}

h1{
    font-size: 60px;
    background: linear-gradient(to right, #a8c0ff, #3f2b96);
    background-size: 100%;
    -webkit-background-clip: text;
    -moz-background-clip: text;
    -webkit-text-fill-color: transparent;
    -moz-text-fill-color: transparent;
    margin-bottom: 10px;
  }

`

const StyledEmpleados = styled.div`


  display: flex;
  flex-direction: column;
  color: #fff;
  height: 200px;
  width: 400px;
  border-radius: 5px;
  background: linear-gradient(45deg,#0b071d 0%,#0c0236);

  .column{
    display: flex;
    flex-direction: row;

    img{
      margin-top: 0;
      height: 100px;
      width: 100px;
      margin-right: 10px;
    }

    h2{
      margin-top: 10px;
      place-self: center;
      font-size: 20px;
    }

    p{
      margin-top: 10px;
      text-align: left;
      font-size: 18px;
    }

  }

  

`;