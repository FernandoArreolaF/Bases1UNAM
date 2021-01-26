"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Cliente = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Cliente = /*#__PURE__*/function () {
  function Cliente(id_cliente, nombre, ap_pat, ap_mat, razon_social, email) {
    _classCallCheck(this, Cliente);

    this.id_cliente = id_cliente;
    this.nombre = nombre;
    this.ap_pat = ap_pat;
    this.ap_mat = ap_mat;
    this.razon_social = razon_social;
    this.email = email;
  }

  _createClass(Cliente, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_cliente': this.id_cliente,
        'nombre': this.nombre,
        'ap_pat': this.ap_pat,
        'ap_mat': this.ap_mat,
        'razon_social': this.razon_social,
        'email': this.email
      };
    }
  }]);

  return Cliente;
}();

exports.Cliente = Cliente;