"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = require("express");

var _cliente = require("../models/cliente");

var _domicilio = require("../models/domicilio");

var _domicilio_cliente = require("../models/domicilio_cliente");

var _database = _interopRequireDefault(require("../database"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function asyncGeneratorStep(gen, resolve, reject, _next, _throw, key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { Promise.resolve(value).then(_next, _throw); } }

function _asyncToGenerator(fn) { return function () { var self = this, args = arguments; return new Promise(function (resolve, reject) { var gen = fn.apply(self, args); function _next(value) { asyncGeneratorStep(gen, resolve, reject, _next, _throw, "next", value); } function _throw(err) { asyncGeneratorStep(gen, resolve, reject, _next, _throw, "throw", err); } _next(undefined); }); }; }

var router = (0, _express.Router)();
router.get('/', /*#__PURE__*/function () {
  var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req, res) {
    var response;
    return regeneratorRuntime.wrap(function _callee$(_context) {
      while (1) {
        switch (_context.prev = _context.next) {
          case 0:
            _context.next = 2;
            return _database["default"].query('SELECT * FROM CLIENTE;');

          case 2:
            response = _context.sent;
            res.json(response.rows);

          case 4:
          case "end":
            return _context.stop();
        }
      }
    }, _callee);
  }));

  return function (_x, _x2) {
    return _ref.apply(this, arguments);
  };
}());
router.post('/', /*#__PURE__*/function () {
  var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req, res) {
    var cliente, response;
    return regeneratorRuntime.wrap(function _callee2$(_context2) {
      while (1) {
        switch (_context2.prev = _context2.next) {
          case 0:
            cliente = new _cliente.Cliente(null, req.body.nombre, req.body.ap_pat, req.body.ap_mat, req.body.razon_social, req.body.email);
            _context2.next = 3;
            return _database["default"].query('INSERT INTO CLIENTE(nombre, ap_pat, ap_mat, razon_social, email) VALUES ($1, $2, $3, $4, $5);', [cliente.nombre, cliente.ap_pat, cliente.ap_mat, cliente.razon_social, cliente.email]);

          case 3:
            response = _context2.sent;
            res.json(response);

          case 5:
          case "end":
            return _context2.stop();
        }
      }
    }, _callee2);
  }));

  return function (_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}());
router.post('/domicilio', /*#__PURE__*/function () {
  var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req, res) {
    var cliente, domicilio, response_cliente, response_domicilio, response_id_cliente, response_id_domicilio, domicilio_cliente, response_domicilio_cliente;
    return regeneratorRuntime.wrap(function _callee3$(_context3) {
      while (1) {
        switch (_context3.prev = _context3.next) {
          case 0:
            cliente = new _cliente.Cliente(null, req.body.nombre, req.body.ap_pat, req.body.ap_mat, req.body.razon_social, req.body.email);
            domicilio = new _domicilio.Domicilio(null, req.body.estado, req.body.colonia, req.body.calle, req.body.numero, req.body.cp);
            _context3.next = 4;
            return _database["default"].query('INSERT INTO CLIENTE(nombre, ap_pat, ap_mat, razon_social, email) VALUES ($1, $2, $3, $4, $5);', [cliente.nombre, cliente.ap_pat, cliente.ap_mat, cliente.razon_social, cliente.email]);

          case 4:
            response_cliente = _context3.sent;
            _context3.next = 7;
            return _database["default"].query('INSERT INTO DOMICILIO(estado, colonia, calle, numero, cp) VALUES ($1, $2, $3, $4, $5);', [domicilio.estado, domicilio.colonia, domicilio.calle, domicilio.numero, domicilio.cp]);

          case 7:
            response_domicilio = _context3.sent;
            _context3.next = 10;
            return _database["default"].query('SELECT id_Cliente FROM CLIENTE WHERE nombre = $1 AND ap_pat = $2 AND ap_mat = $3 AND email = $4;', [cliente.nombre, cliente.ap_pat, cliente.ap_mat, cliente.email]);

          case 10:
            response_id_cliente = _context3.sent;
            _context3.next = 13;
            return _database["default"].query('SELECT id_Domicilio FROM DOMICILIO WHERE estado = $1 AND colonia = $2 AND calle = $3 AND numero = $4 AND cp = $5;', [domicilio.estado, domicilio.colonia, domicilio.calle, domicilio.numero, domicilio.cp]);

          case 13:
            response_id_domicilio = _context3.sent;
            domicilio_cliente = new _domicilio_cliente.Domicilio_Cliente(null, response_id_cliente.rows[0].id_cliente, response_id_domicilio.rows[0].id_domicilio);
            _context3.next = 17;
            return _database["default"].query('INSERT INTO DOMICILIO_CLIENTE(id_cliente, id_domicilio) VALUES($1, $2);', [domicilio_cliente.id_cliente, domicilio_cliente.id_domicilio]);

          case 17:
            response_domicilio_cliente = _context3.sent;
            res.json(domicilio_cliente.toJson());

          case 19:
          case "end":
            return _context3.stop();
        }
      }
    }, _callee3);
  }));

  return function (_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}());
router.patch('/', /*#__PURE__*/function () {
  var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(req, res) {
    var cliente, response;
    return regeneratorRuntime.wrap(function _callee4$(_context4) {
      while (1) {
        switch (_context4.prev = _context4.next) {
          case 0:
            cliente = new _cliente.Cliente(null, req.body.nombre, req.body.ap_pat, req.body.ap_mat, req.body.razon_social, req.body.email);
            _context4.next = 3;
            return _database["default"].query('SELECT id_Cliente FROM CLIENTE WHERE nombre = $1 AND ap_pat = $2 AND ap_mat = $3 AND email = $4;', [cliente.nombre, cliente.ap_pat, cliente.ap_mat, cliente.email]);

          case 3:
            response = _context4.sent;
            res.json(response.rows);

          case 5:
          case "end":
            return _context4.stop();
        }
      }
    }, _callee4);
  }));

  return function (_x7, _x8) {
    return _ref4.apply(this, arguments);
  };
}());
router.patch('/getID', /*#__PURE__*/function () {
  var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5(req, res) {
    var cliente, response;
    return regeneratorRuntime.wrap(function _callee5$(_context5) {
      while (1) {
        switch (_context5.prev = _context5.next) {
          case 0:
            cliente = new _cliente.Cliente(null, req.body.nombre, req.body.ap_pat, req.body.ap_mat, null, null);
            _context5.next = 3;
            return _database["default"].query('SELECT id_Cliente FROM CLIENTE WHERE nombre = $1 AND ap_pat = $2 AND ap_mat = $3;', [cliente.nombre, cliente.ap_pat, cliente.ap_mat]);

          case 3:
            response = _context5.sent;
            res.json(response.rows);

          case 5:
          case "end":
            return _context5.stop();
        }
      }
    }, _callee5);
  }));

  return function (_x9, _x10) {
    return _ref5.apply(this, arguments);
  };
}());
var _default = router;
exports["default"] = _default;