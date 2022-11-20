-- MySQL Workbench Synchronization
-- Generated: 2022-11-13 19:08
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: clara

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

CREATE TABLE IF NOT EXISTS `Optica`.`clients` (
  `id_client` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `codi_postal` INT(11) NOT NULL,
  `telefon` INT(11) NOT NULL,
  `correu` VARCHAR(45) NOT NULL,
  `data_registre` DATE NOT NULL,
  `recomenacio` VARCHAR(45) NULL DEFAULT NULL,
  `id_venedor` VARCHAR(45) NOT NULL,
  `ventas_enero_id_ventas_enero` INT(11) NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_clients_ventas_enero1_idx` (`ventas_enero_id_ventas_enero` ASC) VISIBLE,
  CONSTRAINT `fk_clients_ventas_enero1`
    FOREIGN KEY (`ventas_enero_id_ventas_enero`)
    REFERENCES `Optica`.`ventas` (`id_ventas`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `Optica`.`empleats` (
  `id_empleats` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NOT NULL,
  `ventas_id_ventas` INT(11) NOT NULL,
  PRIMARY KEY (`id_empleats`),
  INDEX `fk_empleats_ventas_enero1_idx` (`ventas_id_ventas` ASC) VISIBLE,
  CONSTRAINT `fk_empleats_ventas_enero1`
    FOREIGN KEY (`ventas_id_ventas`)
    REFERENCES `Optica`.`ventas` (`id_ventas`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `Optica`.`proveidor` (
  `id_proveidor` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `direccio` VARCHAR(200) NOT NULL,
  `telefon` INT(11) NOT NULL,
  `fax` INT(11) NULL DEFAULT NULL,
  `nif` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_proveidor`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `Optica`.`ulleres` (
  `id_ulleres` INT(11) NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `graduacioR` FLOAT(11) NOT NULL,
  `graduacioL` FLOAT(11) NOT NULL,
  `muntura` ENUM('flotant', 'pasta', 'metalica') NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `color_vidreR` VARCHAR(45) NOT NULL,
  `color_vidreL` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  `proveidor_id_proveidor` INT(11) NOT NULL,
  `ventas_id_ventas` INT(11) NOT NULL,
  PRIMARY KEY (`id_ulleres`),
  INDEX `fk_ulleres_proveidor_idx` (`proveidor_id_proveidor` ASC) VISIBLE,
  INDEX `fk_ulleres_ventas_enero1_idx` (`ventas_id_ventas` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_proveidor`
    FOREIGN KEY (`proveidor_id_proveidor`)
    REFERENCES `Optica`.`proveidor` (`id_proveidor`),
  CONSTRAINT `fk_ulleres_ventas_enero1`
    FOREIGN KEY (`ventas_id_ventas`)
    REFERENCES `Optica`.`ventas` (`id_ventas`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `Optica`.`ventas` (
  `id_ventas` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `client` VARCHAR(45) NOT NULL,
  `empleado_id` INT(11) NOT NULL,
  `gafa_id` INT(11) NOT NULL,
  `clients_id_client` INT(11) NOT NULL,
  PRIMARY KEY (`id_ventas`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -------------------------
-- Busquedas ejercicio
/*use optica;
-- Llista el total de factures d'un client/a en un període determinat.
SELECT *
FROM ventas
WHERE client LIKE 'Pedro Jimenez Diaz' AND fecha BETWEEN '1987-01-01' AND '2021-10-25';
-- Llista els diferents models d'ulleres que ha venut un empleat/da durant un any.
SELECT ulleres.marca
FROM ulleres INNER JOIN ventas ON ventas.gafa_id = ulleres.id_ulleres
WHERE ventas.empleado_id = 1
AND YEAR(ventas.fecha ) = 2000;
-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
SELECT DISTINCT proveidor.nom
FROM proveidor INNER JOIN ulleres ON ulleres.proveidor_id_proveidor = proveidor.id_proveidor
INNER JOIN ventas ON ventas.gafa_id = ulleres.id_ulleres;*/