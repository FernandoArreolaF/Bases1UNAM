"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Compra = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Compra = /*#__PURE__*/function () {
  function Compra(id_compra, id_venta, cant_art, codigo_barras) {
    _classCallCheck(this, Compra);

    this.id_compra = id_compra;
    this.id_venta = id_venta;
    this.cant_art = cant_art;
    this.codigo_barras = codigo_barras;
  }

  _createClass(Compra, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_compra': this.id_compra,
        'id_venta': this.id_venta,
        'cant_art': this.cant_art,
        'codigo_barras': this.codigo_barras
      };
    }
  }]);

  return Compra;
}();

exports.Compra = Compra;