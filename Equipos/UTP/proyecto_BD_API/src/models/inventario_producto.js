export class Inventario_Producto {
  constructor(id_inventario_producto, id_inventario, codigo_barras, descripcion, cantidad, marca) {
    this.id_inventario_producto = id_inventario_producto;
    this.id_inventario = id_inventario;
    this.codigo_barras = codigo_barras;
    this.descripcion = descripcion;
    this.cantidad = cantidad;
    this.marca = marca;
  }

  toJson() {
    return {
      'id_inventario_producto': this.id_inventario_producto,
      'id_inventario': this.id_inventario,
      'codigo_barras': this.codigo_barras,
      'descripcion': this.descripcion,
      'cantidad': this.cantidad,
      'marca': this.marca
    };
  }
}