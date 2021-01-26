"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Inventario_Producto = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Inventario_Producto = /*#__PURE__*/function () {
  function Inventario_Producto(id_inventario_producto, id_inventario, codigo_barras, descripcion, cantidad, marca) {
    _classCallCheck(this, Inventario_Producto);

    this.id_inventario_producto = id_inventario_producto;
    this.id_inventario = id_inventario;
    this.codigo_barras = codigo_barras;
    this.descripcion = descripcion;
    this.cantidad = cantidad;
    this.marca = marca;
  }

  _createClass(Inventario_Producto, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_inventario_producto': this.id_inventario_producto,
        'id_inventario': this.id_inventario,
        'codigo_barras': this.codigo_barras,
        'descripcion': this.descripcion,
        'cantidad': this.cantidad,
        'marca': this.marca
      };
    }
  }]);

  return Inventario_Producto;
}();

exports.Inventario_Producto = Inventario_Producto;