"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Venta = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Venta = /*#__PURE__*/function () {
  function Venta(id_venta, id_cliente, cant_art_total, precio_total, fecha_venta) {
    _classCallCheck(this, Venta);

    this.id_venta = id_venta;
    this.id_cliente = id_cliente;
    this.cant_art_total = cant_art_total;
    this.precio_total = precio_total;
    this.fecha_venta = fecha_venta;
  }

  _createClass(Venta, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_venta': this.id_venta,
        'id_cliente': this.id_cliente,
        'cant_art_total': this.cant_art_total,
        'precio_total': this.precio_total,
        'fecha_venta': this.fecha_venta
      };
    }
  }]);

  return Venta;
}();

exports.Venta = Venta;