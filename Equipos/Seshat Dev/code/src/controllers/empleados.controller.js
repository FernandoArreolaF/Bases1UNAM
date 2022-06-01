const pool = require('../db')

const getEmpleados = async (req, res) => {

    try {

        const empleados = await pool.query('SELECT * FROM empleado')

        console.log(empleados)
        res.json(empleados.rows)

    } catch (error) {
        console.log(error.message)
    }

}

const getEmpleado = async (req, res) => {

    const { id } = req.params;
    const result = await pool.query('SELECT * FROM empleado WHERE id_empleado= $1', [id]);

    res.json(result.rows[0]);

}



const createEmpleado = async (req, res) => {

    try {
        const { edad, sueldo, fecha_nacimiento, rfc_empleado, nombre, ap_paterno, ap_materno, calle, numero, colonia, codigo_postal, estado } = req.body
        const result = await pool.query('INSERT INTO empleado (edad,sueldo,fecha_nacimiento,rfc_empleado,nombre,ap_paterno,ap_materno,calle,numero,colonia,codigo_postal,estado) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)', [
            edad, sueldo, fecha_nacimiento, rfc_empleado, nombre, ap_paterno, ap_materno, calle, numero, colonia, codigo_postal, estado
        ])
    } catch (error) {
        console.log(error.message)
    }

}

const getCantEmpleados = async (req,res) => {
    const result = await pool.query('SELECT count(*) FROM empleado')
    res.json(result.rows[0])
}

const updateEmpleado = async (req, res) => {

    try {
        const { id } = req.params
        const { sueldo, nombre, ap_paterno, ap_materno, calle, numero, colonia, codigo_postal, estado } = req.body
        const result = await pool.query('UPDATE empleado SET sueldo= $1, nombre=$2,ap_paterno=$3,ap_materno=$4,calle=$5,numero=$6,colonia=$7,codigo_postal=$8,estado=$9 WHERE id_empleado=$10', [
            sueldo, nombre, ap_paterno, ap_materno, calle, numero, colonia, codigo_postal, estado, id
        ])
        return res.json(result.rows[0])
    } catch (error) {
        console.log(error.message)
    }

}

const deleteEmpleado = async (req, res) => {

    try {
        const { id } = req.params
        const result = pool.query('DELETE FROM empleado WHERE id_empleado=$1', [id])
        return res.sendStatus(204); // sin devolución pero todo en orden :)
    } catch (error) {
        console.log(error.message)
    }
}

module.exports = {
    getEmpleados,
    getEmpleado,
    createEmpleado,
    updateEmpleado,
    deleteEmpleado,
    getCantEmpleados
}