"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Proveedor = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Proveedor = /*#__PURE__*/function () {
  function Proveedor(id_proveedor, nombre, ap_pat, ap_mat, razon_social) {
    _classCallCheck(this, Proveedor);

    this.id_proveedor = id_proveedor;
    this.nombre = nombre;
    this.ap_pat = ap_pat;
    this.ap_mat = ap_mat;
    this.razon_social = razon_social;
  }

  _createClass(Proveedor, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_proveedor': this.id_proveedor,
        'nombre': this.nombre,
        'ap_pat': this.ap_pat,
        'ap_mat': this.ap_mat,
        'razon_social': this.razon_social
      };
    }
  }]);

  return Proveedor;
}();

exports.Proveedor = Proveedor;