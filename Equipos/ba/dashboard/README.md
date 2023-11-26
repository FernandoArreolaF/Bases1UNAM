# Consideraciones
Para poder ejecutar esta aplicación es necesario tener instalado <a href="https://nodejs.org/en">Nodejs</a> en su version LTS <a href="https://nodejs.org/download/release/v18.18.2/"><code>LTS 18.18.2</code></a> asi como configurar el path. También puede usarse la herramienta <a href="https://github.com/coreybutler/nvm-windows"><code>nvm-windows</code></a> la cual facilita este trabajo.<br>
Es necesario tener instalado docker para poder levantar la base de datos.Ve el siguiente link para obtener mas informacion de la configuración necesaria <a href="https://docs.docker.com/get-docker/"><code>Docker</code></a>. Asegurarse de también instalar la herramienta<code>Docker Compose</code><br>
Si los siguientes comandos no presentan problemas podrás continuar:<br>
* <code>docker --version</code><br>
* <code>node --version</code><br>
* <code>docker compose version</code><br>
# Script <code>s.ps1</code>
Este script permite ejecutar los pasos que se muestran mas adelante. Como parámetro recibe una bandera <code>-b</code> que construye la aplicación y la ejecuta. En caso de no estar presente esta bandera entonces solo se levanta la app en modo de desarrollo.

# Ejecutar en modo Modo De Desarrollo

1. Una vez instalado <code>nodejs</code> ejecutar <code>npm install --global yarn</code> y comprobar con <code>yarn --version</code>
1. Entrar a la carpeta donde se descargo el proyecto, al mismo nivel que este archivo
1. Ejecutar <code>yarn</code> que instalara las dependencias del proyecto en la carpeta <code>node_modules</code>
1. Levantar la base de datos con <code>docker compose up -d</code>.<b>Nota</b>: se debe estar al mismo nivel que el archivo <code>docker-compose.yml</code>
1. Ejecutar <code>yarn dev</code><br>

Para eliminar la instancia de base de datos ejecutar <code>docker compose down</code>
# Ejecutar la aplicación construida
Los pasos son exactamente igual hasta el numero 4.<br>
5. Ejecutar <code>yarn build</code><br>
6. Una vez que la construcción haya terminado, ejecutar <code>yarn start</code>


