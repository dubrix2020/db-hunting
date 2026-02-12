-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-02-2026 a las 21:15:20
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `grupohdb`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spTotalMayorAcumulado` ()   SELECT 	C.NOMBRE as NOMBRE,
		SUM(V.MONTO) AS TOTAL_VENTAS        
FROM CLIENTES C
	INNER JOIN VENTAS V ON C.id = V.cliente_id
GROUP BY V.cliente_id
ORDER BY TOTAL_VENTAS DESC
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTotalVentasRegion` ()   SELECT 	R.NOMBRE AS NOMBRE,
		SUM(V.MONTO) AS TOTAL_VENTAS
FROM 	REGIONES R
	INNER JOIN VENTAS V ON V.region_id = R.id
GROUP BY V.region_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spVentasFechas` (IN `fechaInicio` DATE, IN `fechaFin` DATE)   SELECT 	C.NOMBRE as NOMBRE,
		V.MONTO AS TOTAL_VENTAS,
        V.FECHA AS FECHA
FROM CLIENTES C
	INNER JOIN VENTAS V ON C.id = V.cliente_id
WHERE V.FECHA BETWEEN fechaInicio AND fechaFin$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(1, 'Empresa A', '2026-02-12 13:38:24', '2026-02-12 13:38:24'),
(2, 'Empresa B', '2026-02-12 13:38:30', '2026-02-12 13:38:30'),
(3, 'Empresa C', '2026-02-12 13:38:37', '2026-02-12 13:38:37'),
(4, 'Empresa D', '2026-02-12 13:38:42', '2026-02-12 13:38:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `regiones`
--

CREATE TABLE `regiones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `regiones`
--

INSERT INTO `regiones` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(1, 'Metropolitana', '2026-02-12 13:43:56', '2026-02-12 13:43:56'),
(2, 'Valparaíso', '2026-02-12 13:44:04', '2026-02-12 13:44:04'),
(3, 'Biobío', '2026-02-12 13:44:11', '2026-02-12 13:44:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `cliente_id`, `region_id`, `monto`, `fecha`) VALUES
(1, 1, 1, 150000.00, '2025-01-10'),
(2, 2, 2, 230000.00, '2025-01-12'),
(3, 3, 1, 99000.00, '2025-01-15'),
(4, 1, 3, 180000.00, '2025-02-02'),
(5, 4, 1, 450000.00, '2025-02-10');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `regiones`
--
ALTER TABLE `regiones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `region_id` (`region_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `regiones`
--
ALTER TABLE `regiones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`region_id`) REFERENCES `regiones` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
