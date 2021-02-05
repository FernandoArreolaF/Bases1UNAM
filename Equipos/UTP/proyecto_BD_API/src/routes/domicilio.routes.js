import { Router } from 'express';
import data_base from '../database';
import { Domicilio } from '../models/domicilio';

const router = Router();

router.get('/', async (req, res) => {
    const response = await data_base.query('SELECT * FROM DOMICILIO;');
    res.json(response.rows);
});

router.post('/', async (req, res) => {

    const domicilio = new Domicilio(
        null, 
        req.body.estado, 
        req.body.colonia, 
        req.body.calle, 
        req.body.numero, 
        req.body.cp
    );

    const response = await data_base.query('INSERT INTO DOMICILIO(estado, colonia, calle, numero, cp) VALUES ($1, $2, $3, $4, $5);', [domicilio.estado, domicilio.colonia, domicilio.calle, domicilio.numero, domicilio.cp]);

    response.body = domicilio.toJson();

    res.json(response);
});

router.patch('/', async (req, res) => {

    const domicilio = new Domicilio(
        null, 
        req.body.estado, 
        req.body.colonia, 
        req.body.calle, 
        req.body.numero, 
        req.body.cp
    );

    const response = await data_base.query('SELECT id_Domicilio FROM DOMICILIO WHERE estado = $1 AND colonia = $2 AND calle = $3 AND numero = $4 AND cp = $5;', [domicilio.estado, domicilio.colonia, domicilio.calle, domicilio.numero, domicilio.cp]);

    res.json(response.rows);
});

export default router;