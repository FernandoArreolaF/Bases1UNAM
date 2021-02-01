import { Router } from 'express';
import data_base from '../database';

import { Producto } from '../models/producto';

const router = Router();

router.get('/', async (req, res) => {
    const response = await data_base.query('SELECT * FROM PRODUCTO;');
    res.json(response.rows);
});

router.patch('/', async (req, res) => {

    const producto = new Producto(
        req.body.codigo_barras,
        req.body.precio_Venta,
        req.body.tipo_Articulo,
        req.body.nombre
    );

    const response = await data_base.query('INSERT INTO PRODUCTO(codigo_barras, precio_Venta, tipo_Articulo, nombre) VALUES ($1, $2, $3, $4);', [producto.codigo_barras, producto.precio_Venta, producto.tipo_Articulo, producto.nombre]);

    res.json(response);
});

router.patch('/', async (req, res) => {

    const producto = new Producto(
        null,
        req.body.precio_Venta,
        req.body.tipo_Articulo,
        req.body.nombre
    );

    const response = await data_base.query('SELECT codigo_barras FROM PRODUCTO WHERE precio_Venta = $1 AND tipo_Articulo = $2 AND nombre = $3;', [producto.precio_Venta, producto.tipo_Articulo, producto.nombre]);

    res.json(response.rows);
});

export default router;