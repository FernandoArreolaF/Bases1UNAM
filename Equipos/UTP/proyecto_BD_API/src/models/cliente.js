export class Cliente {
  constructor(id_cliente, nombre, ap_pat, ap_mat, razon_social, email) {
    this.id_cliente = id_cliente;
    this.nombre = nombre;
    this.ap_pat = ap_pat;
    this.ap_mat = ap_mat;
    this.razon_social = razon_social;
    this.email = email;
  }

  toJson() {
    return {
      'id_cliente': this.id_cliente,
      'nombre': this.nombre,
      'ap_pat': this.ap_pat,
      'ap_mat': this.ap_mat,
      'razon_social': this.razon_social,
      'email': this.email
    };
  }
}