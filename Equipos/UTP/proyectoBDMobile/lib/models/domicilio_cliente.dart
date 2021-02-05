class Domiclio_Cliente {
  int id_domiclio_cliente;
  int id_domicilio;
  int id_cliente;

  Domiclio_Cliente({this.id_domiclio_cliente, this.id_domicilio, this.id_cliente});

  Domiclio_Cliente.fromJson(Map<String, dynamic> json) {
    this.id_domiclio_cliente = json['id_domiclio_cliente'];
    this.id_domicilio = json['id_domicilio'];
    this.id_cliente = json['id_cliente'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_domiclio_cliente': this.id_domiclio_cliente,
      'id_domicilio': this.id_domicilio,
      'id_cliente': this.id_cliente,
    };
  }
}