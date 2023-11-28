from flask import Flask, request, render_template
import psycopg2
from io import BytesIO
from PIL import Image
import os
from io import BytesIO

# Hacer menú. Optimizar el agregar un cliente

host = "localhost"
database = "restaurante_bd"
user = "postgres"
password = "da4nji1ro0?."

app = Flask(__name__)

datos_empleado = []
rfc = None

#para definir la ruta base en la que buscar "@app.route"

@app.route('/')
def inicio():
  datos_empleado.clear()
  ruta_del_archivo = 'static/images/empleado.jpg'
  if os.path.exists(ruta_del_archivo):
    try:
      os.remove(ruta_del_archivo)
      print(f'Archivo {ruta_del_archivo} borrado con éxito.')
    except OSError as e:
      print(f'Error al borrar el archivo: {e}')
  return render_template('index.html')


@app.route('/agregarEmpleado')
def agregarEmpleado():
  return render_template('agregar-empleado.html')


@app.route('/mostrarEmpleado')
def mostrarEmpleado():
  return render_template('mostrar-empleado.html')

@app.route('/obtenerInfoEmpleado')
def obtenerInfoEmpleado():
  # Se tiene que eliminar la imagen para no tener basura en el html
  ruta_del_archivo = 'static/images/empleado.jpg'
  if os.path.exists(ruta_del_archivo):
    try:
      os.remove(ruta_del_archivo)
      print(f'Archivo {ruta_del_archivo} borrado con éxito.')
    except OSError as e:
      print(f'Error al borrar el archivo: {e}')
  return render_template('obtener-info-empleado.html')

@app.route('/agregarCliente')
def agregarCliente():
  return render_template('agregar-cliente.html')

@app.route('/obtenerInformacion')
def obtenerInformacion():
  return render_template('info-ordenes.html')

@app.route('/agregarCategoria')
def agregarCategoria():
  return render_template('agregar-categoria.html')

@app.route('/agregarDependiente')
def agregarDependiente():
  return render_template('agregar-dependiente.html')

@app.route('/agregarProducto')
def agregarProducto():
  return render_template('agregar-producto.html')

@app.route('/ventasPorFecha')
def ventasPorFecha():
  return render_template('ventas-por-fecha.html')

@app.route('/ventasPorFechas')
def ventasPorFechas():
  return render_template('ventas-por-fechas.html')

@app.route('/agregarOrden')
def agregarOrden():
  return render_template('agregar-orden.html')

@app.route('/agregarProductoOrden')
def agregarProductoOrden():
  return render_template('agregar-producto-orden.html')

@app.route('/generarFactura')
def generarFactura():
  return render_template('generar-factura.html')

# Falta implementar el HTML
@app.route('/mostrar_menu')
def mostrar_menu():
  try:
    #Parametros para coneccion a la base
    connection = psycopg2.connect(host=host,
                                  database=database,
                                  user=user,
                                  password=password)

    # Crear un cursor para ejecutar consultas
    cur = connection.cursor()

    #Instruccion a ejecutar en sintaxis postgres
    instruction = "SELECT * FROM restaurante.producto ORDER BY id_alimento;"
    #Los datos son las variables declaradas
    cur.execute(instruction)
    records = cur.fetchall()
    for record in records:
      print(record)
    cur.close()
    connection.close()

  except (Exception, psycopg2.Error) as error:
    print("Error al conectarse a la base de datos:", error)
  return render_template('mostrar-menu.html', datos=records)

@app.route('/agregar_empleado', methods=['POST'])
def agregar_empleado():
  if request.method == 'POST':
    #Variables para ingresar a la base
    ruta_destino = ""
    rfc = request.form['rfc']
    nombre = request.form['nombre']
    appat = request.form['appat']
    apmat = request.form['apmat']
    fechanac = request.form['fechanac']
    edad = request.form['edad']
    if 'foto' in request.files:
        imagen = request.files['foto']
        # Guardar la imagen en el sistema de archivos
        ruta_destino = 'static/images/' + imagen.filename
        imagen.save(ruta_destino)
    else:
      print("No se recibió ninguna imagen")
      return render_template('agregar-empleado.html', msg='Adjunte una imagen')
    with open(ruta_destino, 'rb') as file:
        imagen_bytes = file.read()
        # Insertar la imagen en la base de datos

    estado = request.form['estado']
    cp = request.form['cp']
    colonia = request.form['colonia']
    calle = request.form['calle']
    numero = request.form['numero']
    sueldo = request.form['sueldo']
    try:
      es_mesero = request.form['mesero']
      horario_entrada = request.form['horario_entrada']
      horario_salida = request.form['horario_salida']
      if horario_salida < horario_entrada:
        return render_template('agregar-empleado.html', msg='Horario inválido')
      horario = f"{horario_entrada} - {horario_salida}"
      es_mesero = True
    except:
      es_mesero = None
      horario = None
    try:
      es_cocinero = request.form['cocinero']
      especialidad = request.form['especialidad']
      es_cocinero = True
    except:
      es_cocinero = None
      especialidad = None
    try:
      es_admin = request.form['administrativo']
      rol = request.form['rol']
      es_admin = True
    except:
      es_admin = None
      rol = None
    
    tel = '{'
    telefonos = request.form.getlist('telefonos')
    for i, telefono in enumerate(telefonos):
      if i == len(telefonos) - 1:
        tel += telefono
      else:
        tel += telefono + ','
    tel += '}'


    
    # En este punto ya se tiene toda la información
    # Una vez obtenido esto, es necesario eliminar el archivo
    try:
      os.remove(ruta_destino)
      print(f'Archivo {ruta_destino} borrado con éxito.')
    except OSError as e:
      print(f'Error al borrar el archivo: {e}')
    
    # Hasta este punto va bien
    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = "CALL restaurante.agregar_empleado(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);"
      #Los datos son las variables declaradas
      data = (rfc, nombre, appat, apmat, fechanac, edad, estado, cp, colonia,
              calle, numero, es_mesero, horario, es_admin, rol, es_cocinero, especialidad, sueldo,
              psycopg2.Binary(imagen_bytes),tel)
      print(data)
      cur.execute(instruction, data)
      connection.commit()
      cur.close()
      connection.close()

    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
    return render_template('agregar-empleado.html', msg='Empleado agregado')
  else:
    return render_template('agregar-empleado.html',
                           msg='Metodo HTTP incorrecto')

@app.route('/agregar_producto_orden', methods=['POST'])
def agregar_producto_orden():
  if request.method == 'POST':
    #Variables para ingresar a la base
    folio_orden = request.form['folio']
    id_producto_agregado = request.form['id_prod']
    cantidad = request.form['cant']

    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres

      instruction = "DO $$ BEGIN PERFORM restaurante.agregar_producto_orden(%s,%s,%s); END $$;"
      #Los datos son las variables declaradas
      data = (folio_orden,id_producto_agregado,cantidad)

      #cur.execute para ejecutar la instrucción
      cur.execute(instruction, data)
      connection.commit()

      cur.close() 
      connection.close()

    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
      msg=str(error)
      posicion_palabra_clave = msg.find('CONTEXT')

      # Verifica si la palabra clave está presente
      if posicion_palabra_clave != -1:
          # Extrae la parte de la cadena antes de la palabra clave
          msg = msg[:posicion_palabra_clave]
      return render_template('agregar-producto-orden.html', msg = msg)
    return render_template('agregar-producto-orden.html')
  else:
    return render_template('agregar-producto-orden.html',
                           msg='Metodo HTTP incorrecto')

@app.route('/info_ordenes', methods=['POST'])
def info_ordenes():
  if request.method == 'POST':
    #Variables para ingresar a la base
    id_empleado = request.form['id_empleado']

    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = f"SELECT * FROM restaurante.info_ordenes(\'{id_empleado}\')"
      #Los datos son las variables declaradas

      #cur.execute para ejecutar la instrucción
      cur.execute(instruction)
      records = cur.fetchall()    
      # Se tiene la información de las órdenes que ha tomado el empleado.
      for record in records:
          print(record)

      
      cur.close()
      connection.close()
      numero, total = records[0]
      # Se renderiza la página con los valores
      return render_template('info-ordenes.html', msg='Se obtuvieron los siguientes datos para el empleado: ' ,numero=numero,total=total,datos=records)


    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
      # En este caso se deberá de mandar una alerta con el error
      if str(error) == 'string index out of range':
        return render_template('info-ordenes.html')
      # Encuentra la posición de la palabra clave
      msg=str(error)
      posicion_palabra_clave = msg.find('CONTEXT')

      # Verifica si la palabra clave está presente
      if posicion_palabra_clave != -1:
          # Extrae la parte de la cadena antes de la palabra clave
          msg = msg[:posicion_palabra_clave]
      else:
          # La palabra clave no se encontró, mantener la cadena original
          print(msg)
      return render_template('info-ordenes.html', msg=msg, tipo='error')

  else:
    return render_template('info-ordenes.html',
                           msg='Metodo HTTP incorrecto')


@app.route('/obtener_info_empleado', methods=['POST'])
def obtener_info_empleados():
  if request.method == 'POST':
    #Variables para ingresar a la base
    nombre_empleado = request.form['nombre']

    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = f"SELECT * FROM restaurante.obtener_info_empleados(\'{nombre_empleado}\');"
      #Los datos son las variables declaradas
      #cur.execute para ejecutar la instrucción
      cur.execute(instruction)
      # Recuperar los resultados de la consulta
      records = cur.fetchall()    
      # Se tiene el registro de todos los empleados que tienen dicho nombre. 
      for record in enumerate(records):
          datos_empleado.append(record)
      # Veamos el caso en que haya un solo empleado con dicho nombre
      if len(records) == 1:
        imagen = records[0][12] 
        output_image_path = 'static/images/empleado.jpg'
        datos_empleado.clear()
        # Crear una imagen desde los bytes
        image = Image.open(BytesIO(imagen))
        # Guardar la imagen
        image.save(output_image_path)
        # En este punto ya es posible utilizar la imagen
        cur.close()
        connection.close()
        # Para los teléfonos
        telefonos = records[0][20].split(',')
        return render_template('mostrar-info-empleado.html',ruta_imagen=output_image_path,datos=records[0],telefonos=telefonos)
      else:
        # Debemos mostrar la información de los empleados con el mismo nombre con la opción de seleccionar alguno
        cur.close()
        connection.close()
        # En datos_empleado se tienen todos los registros de los trabajadores. Estos los mandaremos para que se seleccione el deseado
        return render_template('obtener-info-empleado.html',datos=datos_empleado)

    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
    return render_template('obtener-info-empleado.html')
  else:
    return render_template('obtener-info-empleado.html',
                           msg='Metodo HTTP incorrecto')

# En caso de múltiples registros, se deberá de obtener el seleccionado
@app.route('/empleado_seleccionado', methods=['POST'])
def empleado_seleccionado():
  # Se debe de procesar la información del empleado
  indice = int(request.form['seleccion'])
  empleado = datos_empleado[indice][1]
  print(empleado)
  # Nada más tenemos que ver cómo eliminar la información de la variable global
  datos_empleado.clear()
  # return render_template('mostrar-info-empleado.html')
  imagen = empleado[12]
  output_image_path = 'static/images/empleado.jpg'
  datos_empleado.clear()
  imagen = Image.open(BytesIO(imagen))
  # Guardar la imagen
  imagen.save(output_image_path)
  telefonos = empleado[20].split(',')
  # En este punto ya es posible utilizar la imagen
  return render_template('mostrar-info-empleado.html',ruta_imagen=output_image_path,datos=empleado,telefonos=telefonos)

@app.route('/productos_no_disponibles')
def productos_no_disponibles():
  try:
    #Parametros para coneccion a la base
    connection = psycopg2.connect(host=host,
                                  database=database,
                                  user=user,
                                  password=password)
    #/

    # Crear un cursor para ejecutar consultas
    cur = connection.cursor()

    #Instruccion a ejecutar en sintaxis postgres
    instruction = "SELECT * FROM restaurante.productos_no_disponibles();"
    #Los datos son las variables declaradas
    data = ()

    #cur.execute para ejecutar la instrucción
    cur.execute(instruction, data)
    # Recuperar los resultados de la consulta
    records = cur.fetchall()    
    # Records contiene los productos que no están disponibles
    for record in records:
        print(record)
    cur.close()
    connection.close()
  except (Exception, psycopg2.Error) as error:
    print("Error al conectarse a la base de datos:", error)

  # Se manda al html de productos-no-disponibles los platillos que no están disponibles, los cuales se deberán de mostrar
  return render_template('productos-no-disponibles.html', msg='Formulario enviado',platillos=records)

@app.route('/ventas_por_fecha', methods=['POST'])
def ventas_por_fecha():
  if request.method == 'POST':
    fecha = request.form['fecha_inferior']
    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = f"SELECT * FROM restaurante.ventas_por_fecha(\'{fecha}\');"
      #Los datos son las variables declaradas
      data = (fecha)

      #cur.execute para ejecutar la instrucción
      cur.execute(instruction, data)
      # Recuperar los resultados de la consulta
      records = cur.fetchall()    
      # Records contiene las ventas generadas en la fecha seleccionada

      # SI obtienen que las ventas son 0, mandar un mensaje que diga eso
      # En caso contrario, muestran la información como en info-ordenes
      cur.close()
      connection.close()
      numero, total = records[0]
      if numero == 0:
        return render_template('ventas-por-fecha.html', msg='No hay ventas registradas en esa fecha')
    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
  else:
      return render_template('ventas_por_fecha.html')
  # Aquí debemos de renderizar las ventas generadas (parecido al de mesero)
  return render_template('ventas-por-fecha.html', msg='Se obtuvieron los siguientes datos para la fecha: ' ,numero=numero,total=total,datos=records)

@app.route('/ventas_por_fechas',methods=['POST'])
def ventas_por_fecha2():
    if request.method == 'POST':
      fechainferior = request.form['fecha_inferior']
      fechaSuperior = request.form['fecha_superior']
      try:
        #Parametros para coneccion a la base
        connection = psycopg2.connect(host=host,
                                      database=database,
                                      user=user,
                                      password=password)
        #/

        # Crear un cursor para ejecutar consultas
        cur = connection.cursor()

        #Instruccion a ejecutar en sintaxis postgres
        instruction = "SELECT * FROM restaurante.ventas_por_fecha(%s,%s);"
        #Los datos son las variables declaradas
        data = (fechainferior,fechaSuperior)

        #cur.execute para ejecutar la instrucción
        cur.execute(instruction, data)
        # Recuperar los resultados de la consulta
        records = cur.fetchall()    

        # Aquí se tienen las ventas dadas en el intervalo de fechas dado
        connection.commit()
        cur.close()
        connection.close()
        numero, total = records[0]
        if numero == 0:
          return render_template('ventas-por-fechas.html', msg='No hay ventas registradas en esa fecha')

      except (Exception, psycopg2.Error) as error:
        print("Error al conectarse a la base de datos:", error)
    else:
      return render_template('ventas-por-fechas.html', msg='Metodo HTTP incorrecto')  
    return render_template('ventas-por-fechas.html', msg='Se obtuvieron los siguientes datos para las fechas: ',numero=numero,total=total,datos=records)

@app.route('/agregar_categoria', methods=['POST'])
def agregar_categoria():
  if request.method == 'POST':
    #Variables para ingresar a la base
    nombre = request.form['nombre']
    descripcion = request.form['desc']

    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = "CALL restaurante.agregar_categoria(%s,%s);"
      #Los datos son las variables declaradas
      data = (nombre,descripcion)

      #cur.execute para ejecutar la instrucción
      cur.execute(instruction, data)
      connection.commit()
      cur.close()
      connection.close()
    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)

    return render_template('agregar-categoria.html', msg='Formulario enviado')
  else:
    return render_template('agregar-categoria.html',
                           msg='Metodo HTTP incorrecto')

@app.route('/agregar_cliente', methods=['POST'])
def agregar_cliente():
  if request.method == 'POST':
    #Variables para ingresar a la base
    folio_orden = request.form['folio']
    rfc = request.form['rfc']
    nombre = request.form['nombre']
    appat = request.form['appat']
    apmat = request.form['apmat']
    fechanac = request.form['fechanac']
    estado = request.form['estado']
    cp = request.form['cp']
    colonia = request.form['colonia']
    calle = request.form['calle']
    numero = request.form['numero']
    email = request.form['email']
    razon_social = request.form['razon']
    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = "CALL restaurante.agregar_cliente(%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s)"
      #Los datos son las variables declaradas
      data = (folio_orden,rfc, nombre, appat, apmat, fechanac, estado, cp, colonia,
              calle, numero, email,razon_social)

      #cur.execute para ejecutar la instrucción
      cur.execute(instruction, data)
      connection.commit()

      cur.close()
      connection.close()

    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
      return render_template('agregar-cliente.html',
                           msg='Error al agregar el cliente')

    return generar_factura(folio_orden)
  else:
    return render_template('agregar-cliente.html',
                           msg='Metodo HTTP incorrecto')

@app.route('/agregar_dependiente',methods=['POST'])
def agregar_dependiente():
  if request.method == 'POST':
    #Variables para ingresar a la base
    curp = request.form['curp']
    nombre = request.form['nombre']
    appat = request.form['appat']
    apmat = request.form['apmat']
    parentesco = request.form['parent']
    num_empleado = request.form['num_emp']

    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = "CALL restaurante.agregar_dependiente(%s, %s,%s, %s,%s, %s);"
      #Los datos son las variables declaradas
      data = (curp,nombre,appat,apmat,parentesco,num_empleado)

      #cur.execute para ejecutar la instrucción
      cur.execute(instruction, data)
      connection.commit()
      cur.close()
      connection.close()

    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)

    return render_template('agregar-dependiente.html', msg='Formulario enviado')
  else:
    return render_template('agregar-dependiente.html',
                           msg='Metodo HTTP incorrecto')

@app.route('/agregar_orden',methods=['POST'])
def agregar_orden():
  if request.method == 'POST':
    #Variables para ingresar a la base
    id_mesero = request.form['id_mesero']
    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = f"CALL restaurante.agregar_orden({id_mesero});"
      print(instruction)
      #Los datos son las variables declaradas
      #cur.execute para ejecutar la instrucción
      cur.execute(instruction)
      connection.commit()
      cur.close()
      connection.close()
      # En este punto ya se agregó el orden
    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
      return render_template('agregar-orden.html', msg='Ingrese un número de mesero válido.')
    return render_template('agregar-orden.html', msg='Se registró la orden. Ahora es posible registrar productos a dicha orden.')
  else:
    return render_template('agregar-orden.html',
                           msg='Metodo HTTP incorrecto')

@app.route('/agregar_producto',methods=['POST'])
def agregar_producto():
  if request.method == 'POST':
    #Variables para ingresar a la base
    nombre = request.form['nombre']
    descripcion = request.form['desc']
    precio = request.form['precio']
    try:
      disponibilidad = request.form['disp']
    except:
      disponibilidad = 'off'
    receta = request.form['receta']
    id_categoria = request.form['id_cat']

    if disponibilidad == 'on':
      disponibilidad = True
    else:
      disponibilidad = False

    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      instruction = "CALL restaurante.agregar_producto(%s,%s,%s,%s,%s,%s)"
      #Los datos son las variables declaradas
      data = (nombre,descripcion,precio,disponibilidad,receta,id_categoria)

      #cur.execute para ejecutar la instrucción
      cur.execute(instruction, data)
      connection.commit()

      cur.close()
      connection.close()

    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)

    return render_template('agregar-producto.html', msg='Formulario enviado')
  else:
    return render_template('agregar-producto.html',
                           msg='Metodo HTTP incorrecto')

def generar_factura(folio):
  try:
    #Parametros para coneccion a la base
    connection = psycopg2.connect(host=host,
                                  database=database,
                                  user=user,
                                  password=password)
    #/
  
    # Crear un cursor para ejecutar consultas
    cursor = connection.cursor()
    instruction = f"SELECT * FROM restaurante.generar_factura(\'{folio}\', 'Ref1', 'Ref2', 'Ref3');"
    # call a stored procedure
    cursor.execute(instruction)
    cursor.execute('FETCH ALL IN "Ref1";')
    tbl1 = cursor.fetchall()
    cursor.execute('CLOSE "Ref1";')
    print(tbl1) # Esto contiene los datos del cliente
    cursor.execute('FETCH ALL IN "Ref2";')
    tbl2 = cursor.fetchall() # El ticket
    cursor.execute('CLOSE "Ref2";')
    print(tbl2)
    cursor.execute('FETCH ALL IN "Ref3";')
    tbl3 = cursor.fetchall() # Contiene los datos de la orden
    cursor.execute('CLOSE "Ref3";')
    print(tbl3)
    # Cerrar el cursor y la conexión
    cursor.close()
    connection.close()
  except (Exception, psycopg2.Error) as error:
    print("Error al conectarse a la base de datos:", error)

  return render_template('mostrar-factura.html', msg='Formulario enviado',cliente=tbl1[0],ticket=tbl2,orden=tbl3[0],fecha=str(tbl3[0][1]).split('.')[0])

@app.route('/producto_mas_vendido')
def producto_mas_vendido():
  try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                      database=database,
                                      user=user,
                                      password=password)
      #/

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = "CALL restaurante.producto_mas_vendido();"

      #cur.execute para ejecutar la instrucción
      cur.execute(instruction)
      connection.commit()

      # Posteriormente es necesario obtener la vista para mostrar la información del platillo más vendido
      instruction = "SELECT * FROM restaurante.platillo_mas_vendido;"
      cur.execute(instruction)
      # En este caso se tiene la vista de las ventas. Puede darse el caso de que haya varios productos.

      records = cur.fetchall()    

      for record in records:
          print(record)
      # Se deben de mostrar todos los productos
      cur.close()
      connection.close()
  except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)

  return render_template('productos-mas-vendidos.html', msg='Formulario enviado',platillos=records)

# Para las facturas, primero se analizará si el RFC ya se encuentra registrado
@app.route('/buscar_orden', methods=['POST'])
def buscar_orden():
  if request.method == 'POST':
    #Variables para ingresar a la base
    folio = request.form['folio']

    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()

      #Instruccion a ejecutar en sintaxis postgres
      instruction = f"SELECT * FROM restaurante.orden WHERE folio = '{folio}';"
      #Los datos son las variables declaradas
      #cur.execute para ejecutar la instrucción
      cur.execute(instruction)
      records = cur.fetchall()    
      if len(records) == 0:
        # Se ingresó el orden de forma incorrecta
        cur.close()
        connection.close()
        return render_template('generar-factura.html')
      else:
        # Si existe la orden. Habrá que ver si ya se ha generado anteriormente o es necesario obtener la información del cliente
        if records[0][4] is not(None):
          print('Se tiene el rfc: ', records[0][4])
          # Ya se ha generado la factura anteriormente
          cur.close()
          connection.close()
          return generar_factura(folio)
        else: # Se debe de almacenar la información del cliente
          # En este caso valdría la pena revisar si el RFC ya está registrado para únicamente asociarlo a la respectiva orden
          cur.close()
          connection.close()
          return render_template('generar-factura.html', msg='Solicitar RFC',data=folio)

    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
      return render_template('generar-factura.html')
  else:
    return render_template('generar-factura.html')


@app.route('/buscar_rfc',methods=['POST'])
def obtener_rfc():
  if request.method == 'POST':
    #Variables para ingresar a la base
    folio = request.form['folio']
    rfc = request.form['rfc']
    try:
      #Parametros para coneccion a la base
      connection = psycopg2.connect(host=host,
                                    database=database,
                                    user=user,
                                    password=password)

      # Crear un cursor para ejecutar consultas
      cur = connection.cursor()
      print(folio,rfc)
      #Instruccion a ejecutar en sintaxis postgres
      instruction = f"SELECT * FROM restaurante.cliente WHERE rfc = \'{rfc}\';"
      #Los datos son las variables declaradas
      #cur.execute para ejecutar la instrucción
      cur.execute(instruction)
      records = cur.fetchall()    
      if len(records) == 0:
        # No hay ningún cliente registrado con dicho RFC
        cur.close()
        connection.close()
        return render_template('agregar-cliente.html',rfc=rfc,folio=folio)
      else:
        # Ya se ha registrado dicho cliente
        instruction = f'UPDATE restaurante.orden SET rfc_cliente = \'{rfc}\' WHERE folio = \'{folio}\';'
        cur.execute(instruction)
        connection.commit()
        cur.close()
        connection.close()
        return generar_factura(folio)
    except (Exception, psycopg2.Error) as error:
      print("Error al conectarse a la base de datos:", error)
      return render_template('generar-factura.html')
  else:
    return render_template('generar-factura.html')



if __name__ == '__main__':
  app.run(debug=True)
