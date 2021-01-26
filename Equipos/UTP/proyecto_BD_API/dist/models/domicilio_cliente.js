"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Domicilio_Cliente = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Domicilio_Cliente = /*#__PURE__*/function () {
  function Domicilio_Cliente(id_domicilio_cliente, id_cliente, id_domicilio) {
    _classCallCheck(this, Domicilio_Cliente);

    this.id_domicilio_cliente = id_domicilio_cliente;
    this.id_cliente = id_cliente;
    this.id_domicilio = id_domicilio;
  }

  _createClass(Domicilio_Cliente, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_domicilio_cliente': this.id_domicilio_cliente,
        'id_cliente': this.id_cliente,
        'id_domicilio': this.id_domicilio
      };
    }
  }]);

  return Domicilio_Cliente;
}();

exports.Domicilio_Cliente = Domicilio_Cliente;