"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Telefono = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Telefono = /*#__PURE__*/function () {
  function Telefono(id_telefono, num_telefono) {
    _classCallCheck(this, Telefono);

    this.id_telefono = id_telefono;
    this.num_telefono = num_telefono;
  }

  _createClass(Telefono, [{
    key: "toJson",
    value: function toJson() {
      return {
        'id_telefono': this.id_telefono,
        'num_telefono': this.num_telefono
      };
    }
  }]);

  return Telefono;
}();

exports.Telefono = Telefono;