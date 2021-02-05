export class Telefono {
  constructor(id_telefono, num_telefono) {
    this.id_telefono = id_telefono;
    this.num_telefono = num_telefono;
  }

  toJson() {
    return {
      'id_telefono': this.id_telefono,
      'num_telefono': this.num_telefono
    };
  }
}