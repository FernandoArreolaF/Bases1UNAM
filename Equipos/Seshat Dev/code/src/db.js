const { Pool } = require('pg') // Se importa el modulo pg de node para comunicar el back end 
                                    // y la base de datos

const {bd} = require('./config') // Y se importa el archivo .config que contiene el 
                                    //acceso a las variables de entorno que dan acceso a la base

const pool = new Pool({ // Se establecen los parametros para la conexión de la base
    user: bd.user,        // Por seguridad se añadieron los parametros en las variables de enotorno
    password: bd.password,
    host: bd.host,
    port: bd.port,
    database: bd.database,
    ssl: {
        rejectUnauthorized: false,
    }
})

module.exports = pool; // se exporta el modulo configurado