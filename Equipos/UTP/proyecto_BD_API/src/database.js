import { Pool } from 'pg';

const pool = new Pool({
    host: 'ec2-54-156-85-145.compute-1.amazonaws.com',
    user: 'fmvxyqlwzcrifv',
    database: 'd6gndvk95jok6t',
    port: '5432',
    password: '75cbbbb7f7746b7af735919fddef1d9467455f3356f1c5807511ac25d3475e98',
    ssl: { rejectUnauthorized: false }
});

export default pool;