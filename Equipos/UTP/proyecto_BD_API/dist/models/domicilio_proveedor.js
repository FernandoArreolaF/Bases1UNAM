"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Domicilio_Proveedor = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Domicilio_Proveedor = /*#__PURE__*/function () {
  function Domicilio_Proveedor(id_domicilio_proveedor, id_proveedor, id_domicilio) {
    _classCallCheck(this, Domicilio_Proveedor);

    this.id_domicilio_proveedor = id_domicilio_proveedor;
    this.id_proveedor = id_proveedor;
    this.id_domicilio = id_domicilio;
  }

  _createClass(Domicilio_Proveedor, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_domicilio_proveedor': this.id_domicilio_proveedor,
        'id_proveedor': this.id_proveedor,
        'id_domicilio': this.id_domicilio
      };
    }
  }]);

  return Domicilio_Proveedor;
}();

exports.Domicilio_Proveedor = Domicilio_Proveedor;