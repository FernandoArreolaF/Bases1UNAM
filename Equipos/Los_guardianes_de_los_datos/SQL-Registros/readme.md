# Creacion de la Base de Datos
## Instrucciones: 

Para el caso de querer crear la base de datos e importar los registros manualmente: 
1. Crear una base de datos con nombre *restaurante* y que le pertenezca al usuario postgres. 
2. Ejecutar el archivo *restauranteA.sql* dentro de la base de datos restaurante.
  ```
    \i 'restauranteA.sql'
  ```
4. Exportar los archivos csv en el siguiente orden y con la siguiente instruccion: 
  - Empleado:
  ```
    \copy empleado from 'Empleado.csv' delimiter ',' csv header;
  ```

  - Telefono:
  ```
    \copy telefono from 'Telefono.csv' delimiter ',' csv header;
  ```
  - Dependiente:
  ```
    \copy dependiente from 'Dependiente.csv' delimiter ',' csv header;
  ```
  - Categoria: 
  ```
    \copy categoria from 'Categoria.csv' delimiter ',' csv header;
  ```
  - Producto: 
  ```
    \copy producto from 'Producto.csv' delimiter ',' csv header;
  ```
  - Cliente: 
  ```
    \copy cliente from 'Cliente.csv' delimiter ',' csv header;
  ```
  - Orden:
    - Copiar insert del archivo *orden.txt* en pgAdmin o en la terminal.
  - incluye:
  ```
    \copy incluye from 'Incluye.csv' delimiter ',' csv header;
  ```

Para el caso de no quererlo hacer manual:
1. Ejecutar el archivo *restauranteB.sql* con el usuario postgres.
  ```
    \i 'restauranteA.sql'
  ```

*Nota:* la ruta de los archivos csv se debe especificar en cada caso.