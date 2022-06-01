const pool = require('../db')  //Se importan los datos de la conexión a la base de datos remota


    /* Función para recibir las filas de la tabla con los alimentos */

const getComidas = async (req, res) => { //req es la info que recibe y res lo que va a enviar al frontend

    try {

        const comidas = await pool.query('SELECT * FROM menu_categoria') //Se realiza la consulta en este caso

        console.log(comidas)
        res.json(comidas.rows); // se envía la info en formato json para que el fornt end lo pueda leer

    } catch (error) {
        console.log(error.message); // este mensaje colo es para control en el desarrollo
    }

}

const getMasVendido = async (req,res) => {
    const comida = await pool.query('SELECT * FROM PLATILLOMAIN')
    res.json(comida.rows[0]);
}

const getCountComidas = async (req, res) => {
    try {
        const result = await pool.query('SELECT count(*) FROM menu_categoria')

        res.json(result.rows[0])
    } catch (error) {
        console.log(error.message)
    }
}

const getComida = async (req, res) => {

    const { id } = req.params;
    const result = await pool.query('SELECT * FROM menu_categoria WHERE id_identificador = $1', [id]);

    res.json(result.rows[0]);

}

const createComida = async (req, res) => {

    try {
        const { precio, receta, nombre_alimento, disponibilidad, nombre_categoria, descripcion, desc_categoria } = req.body;


        const result = await pool.query('INSERT INTO menu_categoria (precio, receta, nombre_alimento, disponibilidad, nombre_categoria, descripcion, desc_categoria) VALUES ($1,$2,$3,$4,$5,$6,$7)', [
            
            precio,
            receta,
            nombre_alimento,
            disponibilidad,
            nombre_categoria,
            descripcion,
            desc_categoria,
        ])
    } catch (error) {
        console.log(error.message)
    }

}

const updateComida = async (req, res) => {

    try {
        const { id } = req.params;
        const { precio, receta, nombre_alimento, disponibilidad, nombre_categoria, descripcion, desc_categoria } = req.body;
        const result = await pool.query('UPDATE menu_categoria SET precio= $1, receta= $2, nombre_alimento= $3,disponibilidad= $4,nombre_categoria= $5, descripcion= $6,desc_categoria= $7 WHERE id_identificador= $8 RETURNING *', [
            precio,
            receta,
            nombre_alimento,
            disponibilidad,
            nombre_categoria,
            descripcion,
            desc_categoria,
            id
        ]);

        if (result.rows.length == 0)
            return res.status(404).json({
                message: "Task not found",
            });

        console.log(result)


        return res.json(result.rows[0])



    } catch (error) {
        console.log(error.message)
    }

}

const deleteComida = async (req, res) => {

    try {
        const { id } = req.params
        const result = pool.query('DELETE FROM menu_categoria WHERE id_comida= $1', [id])
        return res.sendStatus(204); // sin devolución pero todo en orden :)
    } catch (error) {
        console.log(error.message)
    }

}

module.exports = {
    getComidas,
    getComida,
    createComida,
    updateComida,
    deleteComida,
    getCountComidas,
    getMasVendido
}
