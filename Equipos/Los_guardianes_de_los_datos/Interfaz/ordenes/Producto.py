class Producto(): 

  def __init__(self, id, nombre, receta, precio, descripcion, 
  disponibilidad, tipo, id_categoria) -> None:
    self.id = id
    self.nombre = nombre
    self.receta = receta 
    self.precio = precio 
    self.descripcion = descripcion
    self.disponibilidad = disponibilidad
    self.tipo = tipo
    self.id_categoria = id_categoria
    self.cantidad = 0

  def __str__(self) -> str:
    return self.nombre