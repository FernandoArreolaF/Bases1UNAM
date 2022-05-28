const { Router } = require('express');
const { getPersonal } = require('../controllers/personal.controller')



const router = Router();

router.get('/Personal', getPersonal)

module.exports = router;