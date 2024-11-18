 # proyectoBD
Proyecto de Base de Datos del equipo DataBenders

## Integrantes:
- Soto Huerta Gustavo Isaac
- Franco Arellano Luis Fernando
- Villeda Tlecuitl José Eduardo 
- Zavala Sánchez Eduardo

## Consideraciones

- Para poder abrir los archivos SQL es necesario el DBMS PostgreSQL. Para poder instalarlo en Windows verifique la documentación oficial.
- En caso de instalarlo en Ubuntu utiicé el comando:
  ```bash
  sudo apt install postgresql 

- En caso de instalarlo en Fedora utilicé el comando:
  ```bash
  sudo dnf install postgresql-*  

## Cargar la base de datos
- El comando para cargar la base de datos es:
    ```bash
  psql -U usuario -d baseDeDatos < rutaArchivo.sql    

## Generación y carga de datos a la base de datos 

- Para generar un archivo de inserciones para nuestra base de datos usaremos el compilador de Java que se instalará de la siguiente manera:
- En caso de instalarlo en Ubuntu utiicé el comando:
  ```bash
  sudo apt install openjdk-17* -y  

- En caso de instalarlo en Fedora utilicé el comando:
  ```bash
  sudo dnf install java-17-openjdk* -y
  
- Una vez instalado procederemos a crear nuestro ejecutable con el comando

  ```bash
  javac generadorDeInserciones.java

- Y lo ejecutaremos con el comando

  ```bash
  java generadorDeInserciones
  
- Esto nos debería de crear un archivo llamado inserciones.sql que cargaremos a nuestra base de datos como ya se menciono anteriormente.
