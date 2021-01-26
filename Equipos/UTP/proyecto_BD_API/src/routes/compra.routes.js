import { Router } from 'express';
import data_base from '../database';

import { Compra } from '../models/compra'

const router = Router();

router.get('/', async (req, res) => {
    const response = await data_base.query('SELECT * FROM COMPRA;');
    res.json(response.rows);
});

router.post('/', async (req, res) => {

    const compra = new Compra(
        null,
        req.body.id_venta,
        req.body.cant_art,
        req.body.codigo_barras
    );

    const response = await data_base.query('INSERT INTO COMPRA(id_venta, cant_art, codigo_barras) VALUES ($1, $2, $3);', [compra.id_venta, compra.cant_art, compra.codigo_barras]);

    res.json(response);
});

router.patch('/', async (req, res) => {

    const compra = new Compra(
        null,
        req.body.id_venta,
        req.body.cant_art,
        req.body.codigo_barras
    );

    const response = await data_base.query('SELECT id_Compra FROM COMPRA WHERE id_venta = $1 AND cant_art = $2 AND codigo_barras = $3;', [compra.id_venta, compra.cant_art, compra.codigo_barras]);

    //response.body = domicilio.toJson();

    res.json(response.rows);
});

export default router;