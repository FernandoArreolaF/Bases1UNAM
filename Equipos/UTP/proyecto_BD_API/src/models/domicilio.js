export class Domicilio {
  constructor(id_domicilio, estado, colonia, calle, numero, cp) {
    this.id_domicilio = id_domicilio;
    this.estado = estado;
    this.colonia = colonia;
    this.calle = calle;
    this.numero = numero;
    this.cp = cp;
  }

  toJson() {
    return {
      'id_domicilio': this.id_domicilio,
      'estado': this.estado,
      'colonia': this.colonia,
      'calle': this.calle,
      'numero': this.numero,
      'cp': this.cp
    };
  }
}