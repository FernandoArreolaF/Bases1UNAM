"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Producto = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Producto = /*#__PURE__*/function () {
  function Producto(codigobBarras, precio_venta, tipo_articulo, nombre) {
    _classCallCheck(this, Producto);

    this.codigo_barras = codigobBarras;
    this.precio_venta = precio_venta;
    this.tipo_articulo = tipo_articulo;
    this.nombre = nombre;
  }

  _createClass(Producto, [{
    key: "toJson",
    value: function toJson() {
      return {
        'codigo_barras': this.codigobBarras,
        'precio_venta': this.precio_venta,
        'tipo_articulo': this.tipo_articulo,
        'nombre': this.nombre
      };
    }
  }]);

  return Producto;
}();

exports.Producto = Producto;