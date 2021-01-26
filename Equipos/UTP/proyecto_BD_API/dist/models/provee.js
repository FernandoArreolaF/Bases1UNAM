"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Provee = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Provee = /*#__PURE__*/function () {
  function Provee(id_provee, id_proveedor, codigo_barras, cant_compra, precio_compra, fecha_compra) {
    _classCallCheck(this, Provee);

    this.id_provee = id_provee;
    this.id_proveedor = id_proveedor;
    this.codigo_barras = codigo_barras;
    this.cant_compra = cant_compra;
    this.precio_compra = precio_compra;
    this.fecha_compra = fecha_compra;
  }

  _createClass(Provee, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_provee': this.id_provee,
        'id_proveedor': this.id_proveedor,
        'codigo_barras': this.codigo_barras,
        'cant_compra': this.cant_compra,
        'precio_compra': this.precio_compra,
        'fecha_compra': this.fecha_compra
      };
    }
  }]);

  return Provee;
}();

exports.Provee = Provee;