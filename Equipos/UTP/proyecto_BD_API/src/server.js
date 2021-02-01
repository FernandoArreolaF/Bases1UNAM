import express from 'express';

const app = express();

const apiRoute = ''

//Routes
import root from './routes/index.routes'

import cliente from './routes/cliente.routes';
import compra from './routes/compra.routes';
import domicilio_cliente from './routes/domicilio_cliente.routes';
import domicilio_inventario from './routes/domicilio_inventario.routes';
import domicilio_proveedor from './routes/domicilio_proveedor.routes';
import domicilio from './routes/domicilio.routes';
import inventario_producto from './routes/inventario_producto.routes';
import inventario from './routes/inventario.routes';
import producto from './routes/producto.routes';
import proveedor from './routes/proveedor.routes';
import provee from './routes/provee.routes';
import telefono_proveedor from './routes/telefono_proveedor.routes';
import telefono from './routes/telefono.routes';
import venta from './routes/venta.routes';

//Setings
app.set('port', process.env.PORT || 3000);

app.use(express.json());

app.use(apiRoute ,root);

app.use(apiRoute + '/cliente', cliente);
app.use(apiRoute + '/compra', compra);
app.use(apiRoute + '/domicilio_cliente', domicilio_cliente);
app.use(apiRoute + '/domicilio_inventario', domicilio_inventario);
app.use(apiRoute + '/domicilio_proveedor', domicilio_proveedor);
app.use(apiRoute + '/domicilio', domicilio);
app.use(apiRoute + '/inventario_producto', inventario_producto);
app.use(apiRoute + '/inventario', inventario);
app.use(apiRoute + '/producto', producto);
app.use(apiRoute + '/proveedor', proveedor);
app.use(apiRoute + '/provee', provee);
app.use(apiRoute + '/telefono_proveedor', telefono_proveedor);
app.use(apiRoute + '/telefono', telefono);
app.use(apiRoute + '/venta', venta);

export default app;