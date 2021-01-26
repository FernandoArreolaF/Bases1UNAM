import { Router } from 'express';
import { Cliente } from '../models/cliente';
import { Domicilio } from '../models/domicilio';
import { Domicilio_Cliente } from '../models/domicilio_cliente';
import data_base from '../database';

const router = Router();

router.get('/', async (req, res) => {
    const response = await data_base.query('SELECT * FROM CLIENTE;');
    res.json(response.rows);
});

router.post('/', async (req, res) => {

    const cliente = new Cliente(
        null, 
        req.body.nombre, 
        req.body.ap_pat, 
        req.body.ap_mat, 
        req.body.razon_social, 
        req.body.email
    );

    const response = await data_base.query('INSERT INTO CLIENTE(nombre, ap_pat, ap_mat, razon_social, email) VALUES ($1, $2, $3, $4, $5);', [cliente.nombre, cliente.ap_pat, cliente.ap_mat, cliente.razon_social, cliente.email]);

    res.json(response);
});

router.post('/domicilio', async (req, res) => {

    const cliente = new Cliente(
        null, 
        req.body.nombre, 
        req.body.ap_pat, 
        req.body.ap_mat, 
        req.body.razon_social, 
        req.body.email
    );

    const domicilio = new Domicilio(
        null, 
        req.body.estado, 
        req.body.colonia, 
        req.body.calle, 
        req.body.numero, 
        req.body.cp
    );
    const response_cliente = await data_base.query('INSERT INTO CLIENTE(nombre, ap_pat, ap_mat, razon_social, email) VALUES ($1, $2, $3, $4, $5);', [cliente.nombre, cliente.ap_pat, cliente.ap_mat, cliente.razon_social, cliente.email]);

    const response_domicilio = await data_base.query('INSERT INTO DOMICILIO(estado, colonia, calle, numero, cp) VALUES ($1, $2, $3, $4, $5);', [domicilio.estado, domicilio.colonia, domicilio.calle, domicilio.numero, domicilio.cp]);

    const response_id_cliente = await data_base.query('SELECT id_Cliente FROM CLIENTE WHERE nombre = $1 AND ap_pat = $2 AND ap_mat = $3 AND email = $4;', [cliente.nombre, cliente.ap_pat, cliente.ap_mat, cliente.email]);

    const response_id_domicilio = await data_base.query('SELECT id_Domicilio FROM DOMICILIO WHERE estado = $1 AND colonia = $2 AND calle = $3 AND numero = $4 AND cp = $5;', [domicilio.estado, domicilio.colonia, domicilio.calle, domicilio.numero, domicilio.cp]);
    
    const domicilio_cliente = new Domicilio_Cliente(
        null,
        response_id_cliente.rows[0].id_cliente,
        response_id_domicilio.rows[0].id_domicilio
    );

    const response_domicilio_cliente = await data_base.query('INSERT INTO DOMICILIO_CLIENTE(id_cliente, id_domicilio) VALUES($1, $2);', [domicilio_cliente.id_cliente, domicilio_cliente.id_domicilio]);
    
    res.json(domicilio_cliente.toJson());
});

router.patch('/', async (req, res) => {

    const cliente = new Cliente(
        null, 
        req.body.nombre, 
        req.body.ap_pat, 
        req.body.ap_mat, 
        req.body.razon_social, 
        req.body.email
    );

    const response = await data_base.query('SELECT id_Cliente FROM CLIENTE WHERE nombre = $1 AND ap_pat = $2 AND ap_mat = $3 AND email = $4;', [cliente.nombre, cliente.ap_pat, cliente.ap_mat, cliente.email]);

    res.json(response.rows);
});

router.patch('/getID', async (req, res) => {

    const cliente = new Cliente(
        null, 
        req.body.nombre, 
        req.body.ap_pat, 
        req.body.ap_mat,
        null,
        null
    );

    const response = await data_base.query('SELECT id_Cliente FROM CLIENTE WHERE nombre = $1 AND ap_pat = $2 AND ap_mat = $3;', [cliente.nombre, cliente.ap_pat, cliente.ap_mat]);

    res.json(response.rows);
});

export default router;