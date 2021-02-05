import { Router } from 'express';
const router = Router();

router.get('/', (req, res) => {
    res.json({ body: 'This is a API of Proyect of DataBase' });
});

export default router;