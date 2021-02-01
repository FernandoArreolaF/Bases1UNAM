"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Telefono_Proveedor = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Telefono_Proveedor = /*#__PURE__*/function () {
  function Telefono_Proveedor(id_telefono_proveedor, id_telefono, id_proveedor) {
    _classCallCheck(this, Telefono_Proveedor);

    this.id_telefono_proveedor = id_telefono_proveedor;
    this.id_telefono = id_telefono;
    this.id_proveedor = id_proveedor;
  }

  _createClass(Telefono_Proveedor, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_telefono_proveedor': this.id_telefono_proveedor,
        'id_telefono': this.id_telefono,
        'id_proveedor': this.id_proveedor
      };
    }
  }]);

  return Telefono_Proveedor;
}();

exports.Telefono_Proveedor = Telefono_Proveedor;