const pool = require('../db')

const getPersonal = async (req, res) => {

    try {
        const personal = await pool.query('SELECT * FROM personal')

        console.log(personal)
        res.json(personal.rows);
    } catch (error) {
        console.log(error.message);
    }

}

module.exports = {
    getPersonal
}