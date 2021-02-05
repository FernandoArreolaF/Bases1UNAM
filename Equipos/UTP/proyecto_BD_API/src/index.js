import '@babel/polyfill';

import app from './server';

async function main() {
    await app.listen(app.get('port'));
    console.log('Server on port', app.get('port'));
}

main();