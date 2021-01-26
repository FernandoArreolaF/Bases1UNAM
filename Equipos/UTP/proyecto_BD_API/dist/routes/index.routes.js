"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = require("express");

var router = (0, _express.Router)();
router.get('/', function (req, res) {
  res.json({
    body: 'This is a API of Proyect of DataBase'
  });
});
var _default = router;
exports["default"] = _default;