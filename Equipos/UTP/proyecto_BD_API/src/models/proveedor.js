export class Proveedor {
  constructor(id_proveedor, nombre, ap_pat, ap_mat, razon_social) {
    this.id_proveedor = id_proveedor;
    this.nombre = nombre;
    this.ap_pat = ap_pat;
    this.ap_mat = ap_mat;
    this.razon_social = razon_social;
  }

  toJson() {
    return {
      'id_proveedor': this.id_proveedor,
      'nombre': this.nombre,
      'ap_pat': this.ap_pat,
      'ap_mat': this.ap_mat,
      'razon_social': this.razon_social
    };
  }
}