const pool = require('../db')

const getDate = async (req,res) => {
    const result = pool.query('SELECT CURRENT_DATE')
    res.json((await result).rows[0])
}

module.exports = {
    getDate
}