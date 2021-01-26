export class Compra {
  constructor(id_compra, id_venta, cant_art, codigo_barras) {
    this.id_compra = id_compra;
    this.id_venta = id_venta;
    this.cant_art = cant_art;
    this.codigo_barras = codigo_barras;
  }

  toJson() {
    return {
      'id_compra': this.id_compra,
      'id_venta': this.id_venta,
      'cant_art': this.cant_art,
      'codigo_barras': this.codigo_barras
    };
  }
}