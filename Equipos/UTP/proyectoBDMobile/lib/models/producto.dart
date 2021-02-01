class Producto {
  String codigo_barras;
  String precio_venta;
  String tipo_articulo;
  String nombre;
  int cantidad;

  Producto({this.codigo_barras, this.precio_venta, this.tipo_articulo, this.nombre});

  Producto.fromJson(Map<String, dynamic> json) {
    this.codigo_barras = json['codigo_barras'];
    this.precio_venta = json['precio_venta'];
    this.tipo_articulo = json['tipo_articulo'];
    this.nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo_barras': this.codigo_barras,
      'precio_venta': this.precio_venta,
      'tipo_articulo': this.tipo_articulo,
      'nombre': this.nombre,
    };
  }
}