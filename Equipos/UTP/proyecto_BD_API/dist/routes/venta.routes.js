"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = require("express");

var _database = _interopRequireDefault(require("../database"));

var _venta = require("../models/venta");

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
            return _database["default"].query('SELECT * FROM VENTA;');

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
    var venta, response;
    return regeneratorRuntime.wrap(function _callee2$(_context2) {
      while (1) {
        switch (_context2.prev = _context2.next) {
          case 0:
            venta = new _venta.Venta(null, req.body.id_cliente, req.body.cant_art_total, req.body.precio_total, req.body.fecha_venta);
            _context2.next = 3;
            return _database["default"].query('INSERT INTO VENTA(id_cliente, cant_art_total, precio_total, fecha_venta) VALUES ($1, $2, $3, $4);', [venta.id_cliente, venta.cant_art_total, venta.precio_total, venta.fecha_venta]);

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
router.post('/new', /*#__PURE__*/function () {
  var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req, res) {
    var venta, response, response_id_venta;
    return regeneratorRuntime.wrap(function _callee3$(_context3) {
      while (1) {
        switch (_context3.prev = _context3.next) {
          case 0:
            venta = new _venta.Venta(null, req.body.id_cliente, 0, 0, '2021-01-21');
            _context3.next = 3;
            return _database["default"].query('INSERT INTO VENTA(id_cliente, cant_art_total, precio_total, fecha_venta) VALUES ($1, $2, $3, $4);', [venta.id_cliente, venta.cant_art_total, venta.precio_total, venta.fecha_venta]);

          case 3:
            response = _context3.sent;
            _context3.next = 6;
            return _database["default"].query('SELECT id_venta FROM venta ORDER BY id_venta DESC LIMIT 1');

          case 6:
            response_id_venta = _context3.sent;
            res.json(response_id_venta.rows);

          case 8:
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
    var venta, response;
    return regeneratorRuntime.wrap(function _callee4$(_context4) {
      while (1) {
        switch (_context4.prev = _context4.next) {
          case 0:
            venta = new _venta.Venta(null, req.body.cant_art_total, req.body.precio_total, req.body.fecha_venta);
            _context4.next = 3;
            return _database["default"].query('SELECT id_Venta FROM VENTA WHERE cant_art_total = $1 AND precio_total = $2 AND fecha_venta = $3;', [venta.cant_art_total, venta.precio_total, venta.fecha_venta]);

          case 3:
            response = _context4.sent;
            //response.body = domicilio.toJson();
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
var _default = router;
exports["default"] = _default;