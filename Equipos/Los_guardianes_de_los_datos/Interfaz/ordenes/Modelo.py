from Producto import Producto
import psycopg2 as psy

class Modelo():

  BASE_DATOS = "restaurante"

  def __init__(self) -> None:
    self.lista_productos = []
    self.coneccion_base()
  
  def coneccion_base(self):
    try: 
    #conectandose a la BD  
      self.connection = psy.connect(
        host='localhost',
        user='postgres',
        password='postgres',
        database=self.BASE_DATOS
      )
    except Exception as ex:
      print(ex)

    #cursor para mejorar el performance de las consultas
    self.cursor = self.connection.cursor()
    
    # Obtenemos datos iniciales de la base
    self.cursor.execute("select * from producto where disponibilidad = True;")
    productos = self.cursor.fetchall()
    for p in productos: 
      self.lista_productos.append(
          Producto(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7])
        )

  def obtener_mesero(self, id):  
    
    self.cursor.execute(
        "select count(*) from empleado where numero_empleado = %s and es_mesero = True;", 
        (id, )
      )

    count = self.cursor.fetchone()[0]

    if count == 0:
      return False
    else:
      return True

  def obtener_cliente(self, rfc):  
    
    self.cursor.execute(
        "select count(*) from cliente where rfc = %s", 
        (rfc, )
      )

    count = self.cursor.fetchone()[0]

    if count == 0:
      return False
    else:
      return True

  def obtener_productos(self):
    return self.lista_productos
  
  def subir_orden(self, orden, id_empleado):
    
    done = self.obtener_mesero(id_empleado)

    if done:
       
      self.cursor.execute("select folio_orden()")
      folio_orden = self.cursor.fetchone()[0]
      try:
        self.cursor.execute(
            "insert into orden values(%s, now(), null, null, %s, null);", 
            (folio_orden, id_empleado)
          )

        # variable para la interfaz
        total_pagar = 0

        for p in orden:
          self.cursor.execute(
            "insert into incluye values(%s, %s, %s);",
            (folio_orden, p.id, p.cantidad)
          )
          
          total_pagar = total_pagar + (p.cantidad * p.precio)

        self.connection.commit()

        return [True, f"Todo correcto, total a pagar: {total_pagar} MXN"]
      except psy.OperationalError as e: 
        self.connection.rollback()
        return [False, "Hubo un error con el registro de la orden en la BD."]
    else:
      return [False, "No hay ningun mesero registrado con ese numero."]

  def subir_orden_factura(self, orden, id_empleado, rfc_cliente):

    done_mesero = self.obtener_mesero(id_empleado)
    done_cliente = self.obtener_cliente(rfc_cliente)

    if done_mesero:
      if done_cliente:
        self.cursor.execute("select folio_orden()")
        folio_orden = self.cursor.fetchone()[0]
        try:
          self.cursor.execute(
              "insert into orden values(%s, now(), null, null, %s, %s)", 
              (folio_orden, id_empleado, rfc_cliente)
            )

          # variable para la interfaz
          total_pagar = 0

          for p in orden:
            self.cursor.execute(
              "insert into incluye values(%s, %s, %s);",
              (folio_orden, p.id, p.cantidad)
            )

            total_pagar = total_pagar + (p.cantidad * p.precio)

          self.connection.commit()

          return [True, f"Todo correcto, total a pagar: {total_pagar} MXN"]
        except psy.OperationalError as e: 
          self.connection.rollback()
          return [False, "Hubo un error con el registro de la orden en la BD."]
      else: 
        return [False, "No hay ningun cliente registrado con el RFC proporcionado."]
    else:
      return [False, "No hay ningun mesero registrado con ese numero."]