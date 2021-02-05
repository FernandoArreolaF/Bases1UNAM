"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Domicilio = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Domicilio = /*#__PURE__*/function () {
  function Domicilio(id_domicilio, estado, colonia, calle, numero, cp) {
    _classCallCheck(this, Domicilio);

    this.id_domicilio = id_domicilio;
    this.estado = estado;
    this.colonia = colonia;
    this.calle = calle;
    this.numero = numero;
    this.cp = cp;
  }

  _createClass(Domicilio, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_domicilio': this.id_domicilio,
        'estado': this.estado,
        'colonia': this.colonia,
        'calle': this.calle,
        'numero': this.numero,
        'cp': this.cp
      };
    }
  }]);

  return Domicilio;
}();

exports.Domicilio = Domicilio;