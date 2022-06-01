const { Router } = require('express')
const { getCantidadOrdenes, createOrden, agregaAlimento, getOrdenesEmpleadoXDia, getOrdenesRango } = require('../controllers/ordenes.controllers')

const router = Router()

router.get('/CantOrdenes', getCantidadOrdenes)

router.get('/GetOrdenesEmpleado', getOrdenesEmpleadoXDia)

router.get('/OrdenesRango',getOrdenesRango)

router.post('/AgregarAlimentoOrden', agregaAlimento)

router.post('/CreateOrden', createOrden)

module.exports = router;