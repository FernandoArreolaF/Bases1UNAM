const { Router } = require('express') // se importa un modulo que nos permite crear endpoints

/* Se importan los métodos creados para acceder a la base en los controladores */
const { getComidas, getComida, createComida,updateComida,deleteComida, getCountComidas, getMasVendido } = require('../controllers/comidas.controller')

  /* se crea la instancia de endpoint */
const router = Router();

/* Se crean endpoints para mandar y recibir información con sus respectivas funciones */

router.get('/Comidas', getComidas)

router.get('/CantComidas',getCountComidas)

router.get('/Comidas/:id',getComida)

router.get('/ComidaMain',getMasVendido)

router.post('/Comidas',createComida)

router.put('/Comidas/:id',updateComida)

router.delete('/Comidas/:id',deleteComida)

module.exports = router;