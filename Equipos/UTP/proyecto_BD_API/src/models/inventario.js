export class Inventario {
  constructor(id_inventario, nombre) {
    this.id_inventario = id_inventario;
    this.nombre = nombre;
  }

  toJson() {
    return {
      'id_inventario': this.id_inventario,
      'nombre': this.nombre,
    };
  }
}