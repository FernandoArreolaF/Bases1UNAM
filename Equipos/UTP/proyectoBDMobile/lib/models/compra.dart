class Compra {
  int id_compra;
  int id_venta;
  int id_cliente;
  int id_producto;

  Compra({this.id_compra, this.id_venta, this.id_cliente, this.id_producto});

  Compra.fromJson(Map<String, dynamic> json) {
    this.id_compra = json['id_compra'];
    this.id_venta = json['id_venta'];
    this.id_cliente = json['id_cliente'];
    this.id_producto = json['id_producto'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_compra': this.id_compra,
      'id_venta': this.id_venta,
      'id_cliente': this.id_cliente,
      'id_producto': this.id_producto,
    };
  }
}