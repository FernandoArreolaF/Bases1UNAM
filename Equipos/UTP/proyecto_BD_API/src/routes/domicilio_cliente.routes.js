import { Router } from 'express';
import data_base from '../database';
import { Domicilio_Cliente } from '../models/domicilio_cliente';

const router = Router();

router.get('/', async (req, res) => {
    const response = await data_base.query('SELECT * FROM DOMICILIO_CLIENTE;');
    res.json(response.rows);
});

router.post('/', async (req, res) => {

    const domicilio_cliente = new Domicilio_Cliente(
        null,
        req.body.id_cliente, 
        req.body.id_domicilio
    );

    const response = await data_base.query('INSERT INTO DOMICILIO_CLIENTE(id_cliente, id_domicilio) VALUES ($1, $2);', [domicilio_cliente.id_cliente, domicilio_cliente.id_domicilio]);

    response.body = domicilio_cliente.toJson();

    res.json(response);
});

router.patch('/', async (req, res) => {

    const domicilio_cliente = new Domicilio_Cliente(
        null,
        req.body.id_cliente, 
        req.body.id_domicilio
    );

    const response = await data_base.query('SELECT id_domicilio_Cliente FROM DOMICILIO_CLIENTE WHERE id_cliente = $1 AND id_domicilio = $2;', [domicilio_cliente.id_cliente, domicilio_cliente.id_domicilio]);

    res.json(response.rows);
});
export default router;