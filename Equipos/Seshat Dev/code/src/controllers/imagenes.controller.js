const pool = require('../db')

const uploadImage = async (req, res) => {

    try {
        const id = req.params
        const { name, data } = req.files.pic;
        const result = await pool.query('INSERT INTO img_comida(id_img_comida,nombre,img) VALUES ($1,$2,$3)', [id,name, data])
    } catch (error) {
        console.log(error.message)
    }

}

const getImage = async (req,res) => {
    try {
        const id = req.params
        const img = await pool.query('SELECT * FROM img_comida WHERE id_img_comida=$1',[id])

        res.end(img.img)
    } catch (error) {
        
    }
}

module.exports = {
    uploadImage,
    getImage
}