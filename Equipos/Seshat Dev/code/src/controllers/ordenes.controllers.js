const pool = require('../db')

const getCantidadOrdenes = async (req, res) => {
    const result = await pool.query('SELECT count(*) FROM orden')

    res.json(result.rows[0])
}
const createOrden = async (req, res) => {
    try {
        const { rfc_cliente} = req.body;
        const result = await pool.query('INSERT INTO orden (rfc_cliente) VALUES ($1)', [
            rfc_cliente
        ])
    } catch (error) {
        console.log(error.message)
    }
}

const getOrdenesRango = async (req,res) => {
    const result = await pool.query('SELECT sum(precio) FROM menu_categoria inner JOIN CONTIENE ON menu_categoria.ID_IDENTIFICADOR=CONTIENE.ID_IDENTIFICADOR inner JOIN ORDEN ON CONTIENE.FOLIO=ORDEN.FOLIO WHERE extract(month from orden.fecha)>=$1 and extract(month from orden.fecha)<$2;'[mesIni,mesFin])
    res.json(result.rows[0])
}

const agregaAlimento = async (req, res) => {
    try {
        const { folio,id_identificador } = req.body
        const result = await pool.query('INSERT INTO contiene (folio,id_identificador) VALUES ($1,$2);', [folio, id_identificador])
        console.log(result)
    } catch (error) {
        console.log(error.message)
    }
}

const getOrdenesEmpleadoXDia = async (req, res) => {
    const { id } = req.body
    const result = await pool.query('SELECT ordenes_empleado($1)', [id])
    res.json(result.rows[0])
}

module.exports = {
    getCantidadOrdenes,
    createOrden,
    agregaAlimento,
    getOrdenesEmpleadoXDia,
    getOrdenesRango
}