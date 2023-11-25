## Getting Started

Para poder correr el el programa de forma adecuada es necesario realizar lo siguiente:

### Paso a seguir

1. Es necesario realizar un entorno virtual de Python. Para esto se deberá de tener la biblioteca virtualenv :
  ```sh
  pip install virtualenv
  ```

  Dentro de la carpeta donde se quiera almacenar el proyecto, se deberá de crear un ambiente virtual:
  ```sh
  virtualenv -p python3 .env 
  ```

   o 

  ```sh
  python3 -m venv .env
  ```

  NOTA: Ajustar la versión del pip y de python dependiendo del equipo utilizado.

2. Se deberá de activar el ambiente virtual:

  ```sh
  .env/Scripts/activate
  ```
  
  o
  
  ```sh
  source .env/Scripts/activate
  ```

  NOTA: Puede ser que Scripts esté con el nombre de Bin

3. Se necesita tener todas las bibliotecas incluidos en el archivo requirements.txt. Para esto se puede descargar el archivo y realizar:
  ```sh 
  pip install -r requirements.txt
  ```

NOTA: En caso de no funcionar lo anterior. Intentar instalar los paquetes uno por uno.

4. Para desactivar el entorno.

    ```sh 
    deactivate .env
    ```

5. Dentro del nuevo environment, habrá que tener todos los archivos, los cuales son:

- La carpeta de static para el CSS y las imágenes
- La carpeta de templates
- El código main.py

6. Para la conexión a la base es necesario crear una base vacía con el nombre restaurante_bd (o el que desee utilizar)

7. Ejecutar el siguiente comando para tener toda la base:

  ```sh 
  ./psql -U postgres -d restaurante_bd -f ruta_carpeta/nombre_dump.sql
  ```

8. Para que todas las conexiones se realicen de manera adecuada, se deberá se cambiar las siguientes líneas en python:

  ```sh 
    host = "localhost"
    database = "nombre_de_la_base"
    user = "postgres" # A menos de que asigne otro usuario como owner 
    password = "password"
  ```
  
Con todo lo anterior debería de ser capaz de utilizar la base. Todo está escrito para un sistema Unix, aunque para Windows es esencialmente lo mismo.


### Modificar base de datos

La base de datos está totalmente enlazada a la página WEB. Desde esta es posible realizar todas las operaciones solicitadas, así como agregar información. En caso de querer utilizar comandos SQL de forma directa, se tienen los siguientes para la inserción de información:

#### Agregar empleado

```sh 
    CALL restaurante.agregar_empleado(
	<IN rfc character>, 
	<IN nombre character varying>, 
	<IN apellido_pat character varying>, 
	<IN apellido_mat character varying>, 
	<IN fecha_nacimiento date>, 
	<IN edad smallint>, 
	<IN estado character varying>, 
	<IN cp character>, 
	<IN colonia character varying>, 
	<IN calle character varying>, 
	<IN numero smallint>, 
	<IN mesero boolean>, 
	<IN horario character>, 
	<IN administrativo boolean>, 
	<IN rol character varying>, 
	<IN cocinero boolean>, 
	<IN especialidad character varying>, 
	<IN sueldo double precision>, 
	<IN foto bytea>, 
	<IN telefonos bigint[]>)
```
NOTA: En el caso del empleado se tienen dos elementos complicados de insertar si no se realiza desde la página web: la foto y los teléfonos:
- La foto se inserta en un formato binario
- Los teléfonos se mandan como un arreglo '{tel1,tel2,...,teln}'

#### Agregar cliente

```sh 
    CALL restaurante.agregar_cliente(
	<IN folio_orden character>, 
	<IN rfc_dado character>, 
	<IN nombre_cliente character varying>, 
	<IN apellido_pat_cliente character varying>, 
	<IN apellido_mat_cliente character varying>, 
	<IN fecha_nacimiento_cliente date>, 
	<IN estado_cliente character varying>, 
	<IN cp_cliente character>, 
	<IN colonia_cliente character varying>, 
	<IN calle_cliente character varying>, 
	<IN numero_cliente smallint>, 
	<IN email_cliente character varying>, 
	<IN razon_social_cliente text>)
```

#### Agregar dependiente

```sh 
    CALL restaurante.agregar_dependiente(
	<IN curp character>, 
	<IN nombre character varying>, 
	<IN apellido_pat character varying>, 
	<IN apellido_mat character varying>, 
	<IN parentesco character varying>, 
	<IN num_empleado integer>)
```

#### Agregar orden

```sh 
    CALL restaurante.agregar_orden(
	<IN id_mesero integer>)
```

#### Agregar producto a orden

```sh 
    SELECT restaurante.agregar_producto_orden(
	<folio_orden character>, 
	<id_producto_agregado integer>, 
	<cantidad_producto integer>)
```

#### Agregar categoría

```sh 
    CALL restaurante.agregar_categoria(
	<IN nombre character varying>, 
	<IN descripcion text>)    
```

#### Agregar producto

```sh 
    CALL restaurante.agregar_producto(
	<IN nombre character varying>, 
	<IN descripcion text>, 
	<IN precio double precision>, 
	<IN disponibilidad boolean>, 
	<IN receta text>, 
	<IN id_categoria integer>)
```