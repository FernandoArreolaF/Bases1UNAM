import { Router } from 'express';
import data_base from '../database';

import { Venta } from '../models/venta';

const router = Router();

router.get('/', async (req, res) => {
    const response = await data_base.query('SELECT * FROM VENTA;');
    res.json(response.rows);
});

router.post('/', async (req, res) => {

    const venta = new Venta(
        null, 
        req.body.id_cliente, 
        req.body.cant_art_total, 
        req.body.precio_total, 
        req.body.fecha_venta
    );

    const response = await data_base.query('INSERT INTO VENTA(id_cliente, cant_art_total, precio_total, fecha_venta) VALUES ($1, $2, $3, $4);', [venta.id_cliente, venta.cant_art_total, venta.precio_total, venta.fecha_venta]);

    res.json(response);
});

router.post('/new', async (req, res) => {

    const venta = new Venta(
        null, 
        req.body.id_cliente, 
        0, 
        0, 
        '2021-01-21'
    );

    const response = await data_base.query('INSERT INTO VENTA(id_cliente, cant_art_total, precio_total, fecha_venta) VALUES ($1, $2, $3, $4);', [venta.id_cliente, venta.cant_art_total, venta.precio_total, venta.fecha_venta]);

    const response_id_venta = await data_base.query('SELECT id_venta FROM venta ORDER BY id_venta DESC LIMIT 1'); 

    res.json(response_id_venta.rows);
});

router.patch('/', async (req, res) => {

    const venta = new Venta(
        null, 
        req.body.cant_art_total, 
        req.body.precio_total, 
        req.body.fecha_venta
    );

    const response = await data_base.query('SELECT id_Venta FROM VENTA WHERE cant_art_total = $1 AND precio_total = $2 AND fecha_venta = $3;', [venta.cant_art_total, venta.precio_total, venta.fecha_venta]);

    //response.body = domicilio.toJson();

    res.json(response.rows);
});

export default router;