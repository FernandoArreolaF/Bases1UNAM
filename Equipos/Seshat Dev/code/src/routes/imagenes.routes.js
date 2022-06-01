const {Router} = require('express')
const {uploadImage,getImage} = require('../controllers/imagenes.controller')

const router = Router()

router.post('/uploadImgComida/:id',uploadImage)

router.get('/getImg/:id',getImage)

module.exports = router