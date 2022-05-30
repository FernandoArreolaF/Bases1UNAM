import React, { useEffect } from 'react'

import { useState } from 'react'

function AniadirAlimentos() {

    const [cantComidas,setCantComidas] = useState([
        {
            count: '',
        }
    ])

    

    const loadCantidad = async () => {
        const response = await fetch('http://localhost:4000/CantOrdenes')
        const data = await response.json()
        setCantComidas(data)
        console.log(data)
    }

    useEffect(() => {
        loadCantidad()
    },[])

    const [comida, setComida] = useState({
        id_identificador: '',
        precio: '',
        receta: '',
        nombre_alimento: '',
        disponibilidad: 'TRUE',
        nombre_categoria: '',
        descripcion: '',
        desc_categoria: '',
        tipo_categoria: '',
        nivel_dificultad: '',
        sin_alcohol: '',
        con_alcohol: '',

    })

    const handleSubmit = async (e) => {
        e.preventDefault()
        console.log(comida)

        setComida({...comida, [comida.id_identificador]:(Number(cantComidas.count)+1)})

        const res = await fetch('http://localhost:4000/comidas', {
            method: "POST",
            body: JSON.stringify(comida),
            headers: { "Content-type": "application/json" },
        })
        const data = await res.json()
        console.log(data)

    }

    const handleChange = (e) => {
        setComida({ ...comida, [e.target.name]: e.target.value })
    }

    let imgBtn = document.getElementById('img-input')
    let imgWrapper = document.getElementById('formImg__wrapper')

    const handleUploadImg = e => {
        imgBtn = document.getElementById('img-input')
        const coolBtn = document.querySelector('#coolBtn');
        e.preventDefault()
        imgBtn?.click()

        const img = document.querySelector('#img__uploaded')
        imgWrapper = document.getElementById('formImg__wrapper')

        imgBtn.addEventListener('change', function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function () {
                    const result = reader.result;
                    imgWrapper = document.getElementById('formImg__wrapper')
                    img.src = result;
                    imgWrapper?.classList.add('active')
                }
                reader.readAsDataURL(file)
            }
        })
    }

    const [imgComida,setImgComida] = useState([{
        nombre: '',
        img: '', 
    }])

    const handlePostImg = async (e) =>{
        imgBtn = document.getElementById('img-input')
        let data = new FormData();
        const imgData = imgBtn.files[0];
        data.append('img'+(Number(cantComidas.count)+1),imgData)
        setImgComida({...imgComida,[imgComida.nombre]: 'img'+(Number(cantComidas.count))})
        setImgComida({imgComida,[imgComida.img]: imgData})
        const res = await fetch(`http://localhost:4000/uploadImgComida/${(Number(cantComidas.count+1))}`, {
            method: "POST",
            body: data,
        })
        const datares = await res.json()
        console.log(data)
    }

    return (
        <React.Fragment>
            <div className='aniadir__background'>
                <h1>Introduce los datos</h1>
                <div className='forms__container'>
                    <div>
                        <form onSubmit={handleSubmit} class='aniadir__form'>
                            <div>
                                <label className='input__txt' for='nombreAlimento'>Nombre del alimento:</label>
                                <input onChange={handleChange} className='aniadir__input' name='nombre_alimento' id='nombreAlimento' />
                            </div>
                            <div>
                                <label className='input__txt' for='descripcionAlimento'>Descripcion del alimento:</label>
                                <input onChange={handleChange} className='aniadir__input' name='descripcion' id='descripcionAlimento' />
                            </div>
                            <div>
                                <label className='input__txt' for='recetaAlimento'>Receta del alimento:</label>
                                <input onChange={handleChange} className='aniadir__input' name='receta' id='recetaAlimento' />
                            </div>
                            <div>
                                <label className='input__txt' for='precioAlimento'>Precio del alimento:</label>
                                <input onChange={handleChange} className='aniadir__input' name='precio' />
                            </div>
                            <div>
                                <label className='input__txt' for='categoriaAlimeno'>Categoria del alimento:</label>
                                <input onChange={handleChange} className='aniadir__input' name='nombre_categoria' />
                            </div>
                            <div>
                                <labe className='input__txt' for='descCategoria'>Descripcion de Categoria:</labe>
                                <input onChange={handleChange} className='aniadir__input' name='desc_categoria' />
                            </div>
                            <input type='submit' value='Agregar' className='agregar__btn' />
                        </form>
                        <form className='img__form' onSubmit={handlePostImg} enctype='multipart/form-data'  >
                            <div className='formImg__container'>
                                <div class='formImg__wrapper'>
                                    <div className='formImg__img'>
                                        <img src='' alt=' ' id='img__uploaded' />
                                    </div>
                                    <div className='form__content'>
                                        <div className='icon'><img src='../../assets/images/photo.png' height='100px' width='100px'></img></div>
                                        <div className='txt__noImg'>No se ha añadido imagen</div>
                                    </div>
                                    <div className='borrar__btn'><img src='../../assets/images/cross.png' height='20px' width='20px'></img></div>
                                </div>
                            </div>
                            <input type='file' name='pic' id='img-input' hidden />
                            <button onClick={handleUploadImg} id='coolBtn'>Sube la imagen del alimento</button>
                            <input type='submit' value='Guardar imagen'/>
                        </form>
                        
                    </div>

                </div>
            </div>


        </React.Fragment>
    )
}



export default AniadirAlimentos