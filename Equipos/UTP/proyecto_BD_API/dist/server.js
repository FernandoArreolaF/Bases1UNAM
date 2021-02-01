"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = _interopRequireDefault(require("express"));

var _index = _interopRequireDefault(require("./routes/index.routes"));

var _cliente = _interopRequireDefault(require("./routes/cliente.routes"));

var _compra = _interopRequireDefault(require("./routes/compra.routes"));

var _domicilio_cliente = _interopRequireDefault(require("./routes/domicilio_cliente.routes"));

var _domicilio_inventario = _interopRequireDefault(require("./routes/domicilio_inventario.routes"));

var _domicilio_proveedor = _interopRequireDefault(require("./routes/domicilio_proveedor.routes"));

var _domicilio = _interopRequireDefault(require("./routes/domicilio.routes"));

var _inventario_producto = _interopRequireDefault(require("./routes/inventario_producto.routes"));

var _inventario = _interopRequireDefault(require("./routes/inventario.routes"));

var _producto = _interopRequireDefault(require("./routes/producto.routes"));

var _proveedor = _interopRequireDefault(require("./routes/proveedor.routes"));

var _provee = _interopRequireDefault(require("./routes/provee.routes"));

var _telefono_proveedor = _interopRequireDefault(require("./routes/telefono_proveedor.routes"));

var _telefono = _interopRequireDefault(require("./routes/telefono.routes"));

var _venta = _interopRequireDefault(require("./routes/venta.routes"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

var app = (0, _express["default"])();
var apiRoute = ''; //Routes

//Setings
app.set('port', process.env.PORT || 3000);
app.use(_express["default"].json());
app.use(apiRoute, _index["default"]);
app.use(apiRoute + '/cliente', _cliente["default"]);
app.use(apiRoute + '/compra', _compra["default"]);
app.use(apiRoute + '/domicilio_cliente', _domicilio_cliente["default"]);
app.use(apiRoute + '/domicilio_inventario', _domicilio_inventario["default"]);
app.use(apiRoute + '/domicilio_proveedor', _domicilio_proveedor["default"]);
app.use(apiRoute + '/domicilio', _domicilio["default"]);
app.use(apiRoute + '/inventario_producto', _inventario_producto["default"]);
app.use(apiRoute + '/inventario', _inventario["default"]);
app.use(apiRoute + '/producto', _producto["default"]);
app.use(apiRoute + '/proveedor', _proveedor["default"]);
app.use(apiRoute + '/provee', _provee["default"]);
app.use(apiRoute + '/telefono_proveedor', _telefono_proveedor["default"]);
app.use(apiRoute + '/telefono', _telefono["default"]);
app.use(apiRoute + '/venta', _venta["default"]);
var _default = app;
exports["default"] = _default;