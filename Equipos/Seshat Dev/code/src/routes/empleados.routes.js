const { Router } = require('express')
const { getEmpleados, getEmpleado, getCantEmpleados,createEmpleado, updateEmpleado, deleteEmpleado} = require('../controllers/empleados.controller')

const router = Router()

router.get('/Empleados', getEmpleados)

router.get('/Empleado/:id', getEmpleado)

router.get('/CantEmpleados',getCantEmpleados)

router.post('/Empleados', createEmpleado)

router.put('/Empleado/:id', updateEmpleado)

router.delete('/Empleado/:id', deleteEmpleado)

module.exports = router;