const { Router } = require('express')
const {getDate} = require('../controllers/datos.controller')

const router = Router()

router.get('/Fecha',getDate)

module.exports = router