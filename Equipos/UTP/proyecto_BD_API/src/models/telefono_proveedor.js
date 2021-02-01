export class Telefono_Proveedor {
  constructor(id_telefono_proveedor, id_telefono, id_proveedor) {
    this.id_telefono_proveedor = id_telefono_proveedor;
    this.id_telefono = id_telefono;
    this.id_proveedor = id_proveedor;
  }

  toJson() {
    return {
      'id_telefono_proveedor': this.id_telefono_proveedor,
      'id_telefono': this.id_telefono,
      'id_proveedor': this.id_proveedor
    };
  }
}