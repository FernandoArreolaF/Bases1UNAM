from Producto import Producto
from Modelo import Modelo

#Hara la conexiones necesarias y las solicitudes a 
# la bd para obtener y mandar datos 

class Controlador():
  def __init__(self, modelo: Modelo) -> None:
    
    self.modelo: Modelo = modelo

  def obtener_productos(self):
    return self.modelo.obtener_productos()

  def enviar_orden(self, orden, id_empleado):
    return self.modelo.subir_orden(orden, id_empleado)

  def enviar_orden_factura(self, orden, id_empleado, rfc_cliente):
    return self.modelo.subir_orden_factura(orden, id_empleado, rfc_cliente)
