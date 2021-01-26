class Venta {
  String id_venta;
  int cant_art_total;
  double precio_total;
  String fecha_venta;

  Venta({this.id_venta, this.cant_art_total, this.precio_total, this.fecha_venta});

  Venta.fromJson(Map<String, dynamic> json) {
    this.id_venta = json['id_venta'];
    this.cant_art_total = json['cant_art_total'];
    this.precio_total = json['precio_total'];
    this.fecha_venta = json['fecha_venta'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_venta': this.id_venta,
      'cant_art_total': this.cant_art_total,
      'precio_total': this.precio_total,
      'fecha_venta': this.fecha_venta,
    };
  }
}