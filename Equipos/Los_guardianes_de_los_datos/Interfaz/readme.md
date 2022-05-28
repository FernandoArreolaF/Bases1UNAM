# Interfaz grafica

La interfaz grafica de este proyecto fue desarrollada con Python3 con ayuda de la libreria grafica tkinter.
Para la ejecucion de esta interfaz se recomienda tener instalada la base de datos que se otorga en la carpeta *SQL-Registros* para poder realizar las conecciones con la base sin ningun tipo de problema. 

## Instrucciones de ejecución

1. Tener python3 instalado.
2. Tener las siguientes librerías instaladas: *psycopg2* y *PIL*.<br/>
  Si no están instaladas ejecutar:

  ```
  pip install psycopg2
  pip install pillow
  ```
  
   - En caso de existir algun problema con la clase *ImageTk* de la libreria *PIL* intentar instalar el paquete desde la terminal usando: 
    
    sudo apt-get install python-imaging-tk
    
3. Seguir las instrucciones de creacion de la base de datos.

Para la interfaz en la carpeta *ordenes*: <br/>
4. Modificar en el archivo *Modelo.py* modificar si se requiere los datos de coneccion con la BD.

  ```
  class Modelo():

  BASE_DATOS = "restaurante" # <-- nombre de la base [Modificar si se requiere]

  def __init__(self) -> None:
    self.lista_productos = []
    self.coneccion_base()
  
  def coneccion_base(self):
    try: 
    #conectandose a la BD  <-- [Modificar estos campos si se requiere]
      self.connection = psy.connect(
        host='localhost',
        user='postgres',
        password='postgres',
        database=self.BASE_DATOS
      )
  ```

Para la interfaz en la carpeta *administracion*: <br/>
5. Ir a la linea 15 del archivo *main.py* y modificar los parametros para la coneccion.
   ```
   NOMBRE_BD = "restaurante" # <----- Modificar valor si lo requiere
   PASSWORD_POSTGRES = "postgres" # <----- Modificar valor si lo requiere
  ```