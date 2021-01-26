export class Domicilio_Proveedor {
  constructor(id_domicilio_proveedor, id_proveedor, id_domicilio) {
    this.id_domicilio_proveedor = id_domicilio_proveedor;
    this.id_proveedor = id_proveedor;
    this.id_domicilio = id_domicilio;
  }

  toJson() {
    return {
      'id_domicilio_proveedor': this.id_domicilio_proveedor,
      'id_proveedor': this.id_proveedor,
      'id_domicilio': this.id_domicilio
    };
  }
}