export class Domicilio_Inventario {
  constructor(id_domicilio_inventario, id_inventario, id_domicilio) {
    this.id_domicilio_inventario = id_domicilio_inventario;
    this.id_inventario = id_inventario;
    this.id_domicilio = id_domicilio;
  }

  toJson() {
    return {
      'id_domicilio_inventario': this.id_domicilio_inventario,
      'id_inventario': this.id_inventario,
      'id_domicilio': this.id_domicilio
    };
  }
}