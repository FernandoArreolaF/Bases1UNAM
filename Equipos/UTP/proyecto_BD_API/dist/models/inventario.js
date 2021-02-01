"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Inventario = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Inventario = /*#__PURE__*/function () {
  function Inventario(id_inventario, nombre) {
    _classCallCheck(this, Inventario);

    this.id_inventario = id_inventario;
    this.nombre = nombre;
  }

  _createClass(Inventario, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_inventario': this.id_inventario,
        'nombre': this.nombre
      };
    }
  }]);

  return Inventario;
}();

exports.Inventario = Inventario;