export class Domicilio_Cliente {
  constructor(id_domicilio_cliente, id_cliente, id_domicilio) {
    this.id_domicilio_cliente = id_domicilio_cliente;
    this.id_cliente = id_cliente;
    this.id_domicilio = id_domicilio;
  }

  toJson() {
    return {
      'id_domicilio_cliente': this.id_domicilio_cliente,
      'id_cliente': this.id_cliente,
      'id_domicilio': this.id_domicilio
    };
  }
}