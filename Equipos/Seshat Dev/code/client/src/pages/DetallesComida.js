import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import styled from 'styled-components'

import React from 'react'

function DetallesComida() {

    const [comidas, setComidas] = useState([
        {
            id_comida: '',
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

    let params = useParams();

    const [activeTab, setActiveTab] = useState('Descripción');

    const fetchDetails = async () => {
        const data = await fetch(`http://localhost:4000/Comidas/${params.name}`)
        const detailData = await data.json()
        setComidas(detailData);
    }

    useEffect(() => {
        fetchDetails();
    }, [params.name])

    return (

        <>
            <DetallesFondo className='Detalles__fondo'>
                <DetallesWrapper className="detalles__titulo" key='comidas.id_comida'>

                    <div>
                        <h2> {comidas.nombre_alimento} </h2>
                        <img src="../../assets/images/hamburguesa.png" alt="imagen del alimento" />
                    </div>
                    <Info>
                        <Button className={activeTab === 'Receta' ? 'active' : ''} onClick={() => setActiveTab('Descripción')}>Descripcion</Button>
                        <Button className={activeTab === 'Descripción' ? 'active' : ''} onClick={() => setActiveTab('Receta')}>Receta</Button>
                        {activeTab === 'Descripción' && (
                            <ContentText>
                                <h3 > {comidas.descripcion} </h3>
                            </ContentText>
                        )}
                        {activeTab === 'Receta' && (
                            <ContentText>
                                <h3 > {comidas.receta} </h3>
                            </ContentText>
                        )}
                    </Info>

                </DetallesWrapper>
            </DetallesFondo>
        </>

    )
}

const ContentText = styled.div`

    
background: linear-gradient(#fde406 0%, #a74e05 50%,#fde406 100%);
background-size: 100%;
-webkit-background-clip: text;
-moz-background-clip: text;
-webkit-text-fill-color: transparent;
-moz-text-fill-color: transparent;
font-size: 1.2rem;
line-height: 2.5rem;
    

`;

const DetallesFondo = styled.div`
    background: linear-gradient(45deg,#000000 0%,#2e2b2b 100%);
    position: absolute;
    width: 100%;
    height: 100%;
`;

const DetallesWrapper = styled.div`

    margin-top: 5rem;
    margin-bottom: 5rem;
    display: flex;
    background: #000;

    .active{
        background: rgba(0,0,0,0.6);
    }
    .active h2{
    }
    h2{
        background: linear-gradient(#fde406 0%, #a74e05 50%,#fde406 100%);
        background-size: 100%;
        -webkit-background-clip: text;
        -moz-background-clip: text;
        -webkit-text-fill-color: transparent;
        -moz-text-fill-color: transparent;
        font-size: 2rem;
        line-height: 2.5rem;
    }
    ul{
        margin-top: 2rem;
    }

`;

const Button = styled.button`

    padding: 1rem 2rem;
    color: #313131;
    border-width: 4px;
    border-style: solid;
    border-image: linear-gradient(to right,#db930e,#945207) 1;
    margin-right: 2rem;
    font-weight: 600;
    background: linear-gradient(#fde406 0%, #a74e05 50%,#fde406 100%);
    background-size: 100%;
    -webkit-background-clip: text;
    -moz-background-clip: text;
    -webkit-text-fill-color: transparent;
    -moz-text-fill-color: transparent;

`;

const Info = styled.div`

    margin-left: 10rem;

`;

export default DetallesComida