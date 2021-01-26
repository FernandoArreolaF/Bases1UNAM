export class Venta {
    constructor(id_venta, id_cliente, cant_art_total, precio_total, fecha_venta) {
      this.id_venta = id_venta;
      this.id_cliente = id_cliente;
      this.cant_art_total = cant_art_total;
      this.precio_total = precio_total;
      this.fecha_venta = fecha_venta;
    }
  
    toJson() {
      return {
        'id_venta': this.id_venta,
        'id_cliente': this.id_cliente,
        'cant_art_total': this.cant_art_total,
        'precio_total': this.precio_total,
        'fecha_venta': this.fecha_venta
      };
    }
  }