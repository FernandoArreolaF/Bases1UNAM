-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2020 a las 23:10:09
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_pape`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `IdCategoria` int(11) NOT NULL,
  `NomCategoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`IdCategoria`, `NomCategoria`) VALUES
(6, 'HOJAS'),
(16, 'PLUMAS'),
(31, 'GOMAS'),
(34, 'Cuadernos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `IdCliente` int(244) NOT NULL,
  `Dni` int(11) NOT NULL,
  `Rs` varchar(244) NOT NULL,
  `Nombres` varchar(244) NOT NULL,
  `EdoCliente` varchar(20) NOT NULL,
  `ColCliente` varchar(20) NOT NULL,
  `CalleCliente` varchar(20) NOT NULL,
  `CpCliente` varchar(20) NOT NULL,
  `EmailCliente` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`IdCliente`, `Dni`, `Rs`, `Nombres`, `EdoCliente`, `ColCliente`, `CalleCliente`, `CpCliente`, `EmailCliente`) VALUES
(23, 17288, '1726382', 'Laura', 'Cuerna vaca', 'Pino suarez', 'Los azules', '1726382', 'diana@'),
(25, 7814, '17728', 'Andrew', 'Sinaloa', 'Azul', 'La Viga', '17728', 'an17@gmail.com'),
(26, 7813, '17728', 'Monse', 'CDMX', 'Azul', 'SailorMoon', '17728', 'mon@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `email`
--

CREATE TABLE `email` (
  `IdCliente` int(11) NOT NULL,
  `Email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `email`
--

INSERT INTO `email` (`IdCliente`, `Email`) VALUES
(2, ''),
(5, ''),
(16, 'Hola'),
(17, 'auj'),
(18, 'auj'),
(19, 'auj'),
(20, 'o'),
(21, 'j'),
(23, 'hahah'),
(24, 'h'),
(25, 'an17@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `IDI` int(11) NOT NULL,
  `CB` int(11) NOT NULL,
  `IdPro` int(11) NOT NULL,
  `PreCom` double NOT NULL,
  `PreVen` double NOT NULL,
  `Fecha` date NOT NULL,
  `Stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`IDI`, `CB`, `IdPro`, `PreCom`, `PreVen`, `Fecha`, `Stock`) VALUES
(1, 712662, 12, 266, 879, '2020-04-26', 3),
(2, 5, 11, 5, 6, '2020-04-26', -1),
(7, 8972, 78, 5, 5, '2020-04-29', 4),
(8, 672, 11, 7, 6, '2020-04-29', 8),
(9, 9999, 11, 1, 1, '2020-04-29', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `IdProducto` int(11) NOT NULL,
  `IdCategoria` int(11) NOT NULL,
  `IdProv` int(11) NOT NULL,
  `Marca` varchar(20) NOT NULL,
  `Descripcion` varchar(244) NOT NULL,
  `Precio` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`IdProducto`, `IdCategoria`, `IdProv`, `Marca`, `Descripcion`, `Precio`) VALUES
(14, 6, 50, 'Jelly Roll', 'Plumas', 5),
(15, 6, 50, 'Big', 'Pumas', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `IdProv` int(11) NOT NULL,
  `RsPro` varchar(244) NOT NULL,
  `NomPro` varchar(244) NOT NULL,
  `EdoPro` varchar(20) NOT NULL,
  `ColPro` varchar(20) NOT NULL,
  `CallePro` varchar(20) NOT NULL,
  `CpPro` varchar(20) NOT NULL,
  `TelPro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`IdProv`, `RsPro`, `NomPro`, `EdoPro`, `ColPro`, `CallePro`, `CpPro`, `TelPro`) VALUES
(43, 'A', 'Jesus', 'Coahuila', 'AMOR', 'AZULES', '197271', '111111'),
(48, 'B', 'Azul', 'Baja', 'DOMINGO', 'LOS PRADOS', '22222', '7172'),
(49, 'C', 'Dora', 'SONORA', 'GUAYABA', 'ZARAGOZA', '888', '817281'),
(50, 'D', 'FERANDA', 'Sinaloa', '78', '78', '862', '168289');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrar`
--

CREATE TABLE `registrar` (
  `IdRegistro` int(11) NOT NULL,
  `CodBarras` int(11) NOT NULL,
  `IdVentas` int(11) NOT NULL,
  `PrecioVenta` double NOT NULL,
  `Cantidad` int(40) NOT NULL,
  `Pago` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `registrar`
--

INSERT INTO `registrar` (`IdRegistro`, `CodBarras`, `IdVentas`, `PrecioVenta`, `Cantidad`, `Pago`) VALUES
(1, 5, 10, 5, 2, 10),
(2, 5, 10, 5, 2, 10),
(3, 5, 10, 5, 2, 10),
(4, 5, 10, 5, 2, 10),
(5, 5, 10, 5, 2, 10),
(6, 5, 10, 5, 2, 10),
(7, 5, 10, 5, 2, 10),
(8, 5, 17, 5, 2, 10),
(9, 5, 17, 5, 2, 10),
(10, 5, 17, 5, 2, 10),
(11, 5, 17, 5, 2, 10),
(12, 712662, 17, 266, 2, 532),
(13, 712662, 17, 266, 2, 532),
(14, 712662, 17, 266, 2, 532),
(15, 712662, 17, 266, 2, 532),
(16, 712662, 67, 266, 2, 532),
(17, 712662, 67, 266, 2, 532);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrarpago`
--

CREATE TABLE `registrarpago` (
  `IdReg` int(11) NOT NULL,
  `IdVenta` int(11) NOT NULL,
  `SubTotal` double NOT NULL,
  `IVA` double NOT NULL,
  `Total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `registrarpago`
--

INSERT INTO `registrarpago` (`IdReg`, `IdVenta`, `SubTotal`, `IVA`, `Total`) VALUES
(7, 5, 6, 9, 7),
(8, 10, 88, 88, 88),
(9, 17, 2, 4, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telpro`
--

CREATE TABLE `telpro` (
  `IdProv` int(11) NOT NULL,
  `TelProv` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `telpro`
--

INSERT INTO `telpro` (`IdProv`, `TelProv`) VALUES
(42, 'w'),
(43, 'w'),
(44, 'a'),
(45, 's'),
(46, 'd'),
(47, 'a'),
(48, '7172'),
(49, 'a');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedor`
--

CREATE TABLE `vendedor` (
  `IdVendedor` int(11) NOT NULL,
  `Dni` varchar(8) NOT NULL,
  `Nombres` varchar(244) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Estado` varchar(20) NOT NULL,
  `User` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vendedor`
--

INSERT INTO `vendedor` (`IdVendedor`, `Dni`, `Nombres`, `Telefono`, `Estado`, `User`) VALUES
(1, '123456', 'Empleado 0001', '', 'Seleccionar', 'emp01'),
(3, '003456', 'Nicolas', '55555', '0', 'Ni00'),
(6, '6666', 'Ivan', '6666', '1', 'Iv66');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `IdVenta` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL,
  `IdVendedor` int(11) NOT NULL,
  `Fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`IdVenta`, `IdCliente`, `IdVendedor`, `Fecha`) VALUES
(10, 2, 5, '2020-04-27'),
(11, 2, 2, '2020-04-27'),
(12, 23, 25, '2020-04-29'),
(13, 23, 1, '2020-04-29'),
(14, 10, 5, '2020-04-29'),
(15, 10, 45, '2020-04-29'),
(16, 10, 10, '2020-04-29'),
(17, 23, 2, '2020-04-29'),
(18, 23, 2, '2020-04-29'),
(19, 23, 1, '2020-04-29');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`IdCategoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indices de la tabla `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`IDI`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`IdProducto`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`IdProv`);

--
-- Indices de la tabla `registrar`
--
ALTER TABLE `registrar`
  ADD PRIMARY KEY (`IdRegistro`);

--
-- Indices de la tabla `registrarpago`
--
ALTER TABLE `registrarpago`
  ADD PRIMARY KEY (`IdReg`);

--
-- Indices de la tabla `telpro`
--
ALTER TABLE `telpro`
  ADD PRIMARY KEY (`IdProv`);

--
-- Indices de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`IdVendedor`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`IdVenta`),
  ADD UNIQUE KEY `IdVenta` (`IdVenta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `IdCliente` int(244) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `email`
--
ALTER TABLE `email`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `IDI` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `IdProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `IdProv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `registrar`
--
ALTER TABLE `registrar`
  MODIFY `IdRegistro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `registrarpago`
--
ALTER TABLE `registrarpago`
  MODIFY `IdReg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `telpro`
--
ALTER TABLE `telpro`
  MODIFY `IdProv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  MODIFY `IdVendedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `IdVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
