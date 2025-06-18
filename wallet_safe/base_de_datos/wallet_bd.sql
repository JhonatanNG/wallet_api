-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 18, 2025 at 10:56 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wallet_safe`
--

-- --------------------------------------------------------

--
-- Table structure for table `asignacion_presupuesto`
--

CREATE TABLE `asignacion_presupuesto` (
  `id` int(11) NOT NULL,
  `monto_asignado` decimal(10,2) DEFAULT NULL,
  `perfil_asignado_id` int(11) DEFAULT NULL,
  `rubro` varchar(100) DEFAULT NULL,
  `perfil_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cuenta`
--

CREATE TABLE `cuenta` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contrasena` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `cuenta`
--
DELIMITER $$
CREATE TRIGGER `perfil_titular` AFTER INSERT ON `cuenta` FOR EACH ROW BEGIN
INSERT INTO perfil(nombre,titular,cuenta_id)
VALUES(NEW.nombre,1,NEW.id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detalle_presupuesto`
--

CREATE TABLE `detalle_presupuesto` (
  `id` int(11) NOT NULL,
  `asignacion_id` int(11) DEFAULT NULL,
  `perfil_id` int(11) NOT NULL,
  `rubro` varchar(100) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `estadisticas`
--

CREATE TABLE `estadisticas` (
  `id` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `gastos_totales` decimal(10,2) DEFAULT NULL,
  `ingresos_totales` decimal(10,2) DEFAULT NULL,
  `perfil_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gastos`
--

CREATE TABLE `gastos` (
  `id` int(11) NOT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `automatico` tinyint(1) DEFAULT NULL,
  `tipo` enum('Fijo','Variable') DEFAULT NULL,
  `rubro` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `perfil_id` int(11) DEFAULT NULL,
  `descripcion` varchar(1000) DEFAULT NULL,
  `detalle_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ingresos`
--

CREATE TABLE `ingresos` (
  `id` int(11) NOT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `automatico` tinyint(1) DEFAULT NULL,
  `tipo` enum('Fijo','Variable') DEFAULT NULL,
  `rubro` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `perfil_id` int(11) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `perfil`
--

CREATE TABLE `perfil` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `cuenta_id` int(11) DEFAULT NULL,
  `titular` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `token_notificaciones`
--

CREATE TABLE `token_notificaciones` (
  `id` int(11) NOT NULL,
  `perfil_id` int(11) NOT NULL,
  `token` text NOT NULL,
  `creado_en` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asignacion_presupuesto`
--
ALTER TABLE `asignacion_presupuesto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `perfil_id` (`perfil_id`);

--
-- Indexes for table `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indexes for table `detalle_presupuesto`
--
ALTER TABLE `detalle_presupuesto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asignacion_id` (`asignacion_id`),
  ADD KEY `perfil_id` (`perfil_id`);

--
-- Indexes for table `estadisticas`
--
ALTER TABLE `estadisticas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `perfil_id` (`perfil_id`);

--
-- Indexes for table `gastos`
--
ALTER TABLE `gastos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `perfil_id` (`perfil_id`),
  ADD KEY `fk_detalle_presupuesto` (`detalle_id`);

--
-- Indexes for table `ingresos`
--
ALTER TABLE `ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `perfil_id` (`perfil_id`);

--
-- Indexes for table `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuenta_id` (`cuenta_id`);

--
-- Indexes for table `token_notificaciones`
--
ALTER TABLE `token_notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `perfil_id` (`perfil_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asignacion_presupuesto`
--
ALTER TABLE `asignacion_presupuesto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cuenta`
--
ALTER TABLE `cuenta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detalle_presupuesto`
--
ALTER TABLE `detalle_presupuesto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `estadisticas`
--
ALTER TABLE `estadisticas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ingresos`
--
ALTER TABLE `ingresos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `token_notificaciones`
--
ALTER TABLE `token_notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asignacion_presupuesto`
--
ALTER TABLE `asignacion_presupuesto`
  ADD CONSTRAINT `asignacion_presupuesto_ibfk_1` FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

--
-- Constraints for table `detalle_presupuesto`
--
ALTER TABLE `detalle_presupuesto`
  ADD CONSTRAINT `detalle_presupuesto_ibfk_1` FOREIGN KEY (`asignacion_id`) REFERENCES `asignacion_presupuesto` (`id`),
  ADD CONSTRAINT `detalle_presupuesto_ibfk_2` FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

--
-- Constraints for table `estadisticas`
--
ALTER TABLE `estadisticas`
  ADD CONSTRAINT `estadisticas_ibfk_1` FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

--
-- Constraints for table `gastos`
--
ALTER TABLE `gastos`
  ADD CONSTRAINT `fk_detalle_presupuesto` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_presupuesto` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `gastos_ibfk_1` FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

--
-- Constraints for table `ingresos`
--
ALTER TABLE `ingresos`
  ADD CONSTRAINT `ingresos_ibfk_1` FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

--
-- Constraints for table `perfil`
--
ALTER TABLE `perfil`
  ADD CONSTRAINT `perfil_ibfk_1` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`id`);

--
-- Constraints for table `token_notificaciones`
--
ALTER TABLE `token_notificaciones`
  ADD CONSTRAINT `token_notificaciones_ibfk_1` FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
