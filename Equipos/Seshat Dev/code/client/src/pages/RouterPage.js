import React from 'react'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Home from './Home'
import Menu from './Menu'
import Personal from './Personal'
import Comidas from './Comidas'
import DetallesComida from './DetallesComida'
import Gerente from './Gerente'
import AniadirAlimentos from './AniadirAlimentos'
import ActualizaAlimento from './ActualizaAlimento'
import ActualizarEmpleados from './ActualizarEmpleados'
import AgregarEmpleados from './AgregarEmpleados'
import Carrito from './Carrito'
import MasVendido from './MasVendido'

export default function RouterPage() {
    return (
        <div>
            <Router>
                <Routes>
                    <Route path='/' element={<Home />} />
                    <Route path='/Menu' element={<Menu />} />
                    <Route path='/Personal' element={<Personal />} />
                    <Route path='/Comidas' element={< Comidas />} />
                    <Route path='/DetallesComida/:name' element={<DetallesComida />} />
                    <Route path='/Gerente' element={<Gerente />} />
                    <Route path='/AniadirAlimento' element={<AniadirAlimentos />} />
                    <Route path='/ActualizarAlimentos/:name' element={<ActualizaAlimento />} />
                    <Route path='/ActualizarEmpleado/:name' element={<ActualizarEmpleados />} />
                    <Route path='/AgregarEmpleado' element={<AgregarEmpleados />} />
                    <Route path='/Carrito' element={<Carrito />} />
                    <Route path='/MasVendido' element={<MasVendido />} />
                </Routes>
            </Router>
        </div>
    )
}
