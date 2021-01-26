class Cliente {
  int id_cliente;
  String nombre;
  String ap_pat;
  String ap_mat;
  String razon_social;
  String email;

  Cliente({this.id_cliente, this.nombre, this.ap_pat, this.ap_mat, this.email, this.razon_social});

  Cliente.fromJson(Map<String, dynamic> json) {
    this.id_cliente = json['id_cliente'];
    this.nombre = json['nombre'];
    this.ap_pat = json['ap_pat'];
    this.ap_mat = json['ap_mat'];
    this.razon_social = json['razon_social'];
    this.email = json['email'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': this.id_cliente,
      'nombre': this.nombre,
      'ap_pat': this.ap_pat,
      'ap_mat': this.ap_mat,
      'razon_social': this.razon_social,
      'email': this.email,
    };
  }
}
