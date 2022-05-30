/* Modulos */

const express = require('express');
const morgan = require('morgan');
const cors = require('cors')
const fileUpload = require('express-fileupload')

/* Endpoints */

const personalRoutes = require('./routes/personal.routes');
const comidasRoutes = require('./routes/comidas.routes');
const empleadosRoutes = require('./routes/empleados.routes');
const ordenesRoutes = require('./routes/ordenes.routes');
const datosRoutes = require('./routes/datos.routes')
const imagesRoutes = require('./routes/imagenes.routes')

const app = express();

app.use(morgan('dev'))
app.use(express.json())
app.use(cors());
app.use(fileUpload());

app.use(personalRoutes)
app.use(comidasRoutes)
app.use(empleadosRoutes)
app.use(ordenesRoutes)
app.use(datosRoutes)
app.use(imagesRoutes)

app.listen(4000)
console.log('Server on port 4000')