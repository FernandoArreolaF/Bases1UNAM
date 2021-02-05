export class Provee {
  constructor(id_provee, id_proveedor, codigo_barras, cant_compra, precio_compra, fecha_compra) {
    this.id_provee = id_provee;
    this.id_proveedor = id_proveedor;
    this.codigo_barras = codigo_barras;
    this.cant_compra = cant_compra;
    this.precio_compra = precio_compra;
    this.fecha_compra = fecha_compra;
  }

  toJson() {
    return {
      'id_provee': this.id_provee,
      'id_proveedor': this.id_proveedor,
      'codigo_barras': this.codigo_barras,
      'cant_compra': this.cant_compra,
      'precio_compra': this.precio_compra,
      'fecha_compra': this.fecha_compra
    };
  }
}