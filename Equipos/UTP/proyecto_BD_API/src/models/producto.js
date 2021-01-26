export class Producto {
  constructor(codigobBarras, precio_venta, tipo_articulo, nombre) {
    this.codigo_barras = codigobBarras;
    this.precio_venta = precio_venta;
    this.tipo_articulo = tipo_articulo;
    this.nombre = nombre;
  }

  toJson() {
    return {
      'codigo_barras': this.codigobBarras,
      'precio_venta': this.precio_venta,
      'tipo_articulo': this.tipo_articulo,
      'nombre': this.nombre
    };
  }
}