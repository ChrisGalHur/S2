-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`botiga` (
  `id_botiga` INT NOT NULL AUTO_INCREMENT,
  `direccio` VARCHAR(45) NOT NULL,
  `CP` INT NOT NULL,
  PRIMARY KEY (`id_botiga`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `id_provincia` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localitat` (
  `id_localitat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `provincia_id_provincia` INT NOT NULL,
  PRIMARY KEY (`id_localitat`),
  INDEX `fk_localitat_provincia_idx` (`provincia_id_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_localitat_provincia`
    FOREIGN KEY (`provincia_id_provincia`)
    REFERENCES `pizzeria`.`provincia` (`id_provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognoms` VARCHAR(45) NOT NULL,
  `direccio` VARCHAR(200) NOT NULL,
  `CP` INT NOT NULL,
  `telefon` INT NOT NULL,
  `provincia_id_provincia` INT NOT NULL,
  `localitat_id_localitat` INT NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_client_provincia1_idx` (`provincia_id_provincia` ASC) VISIBLE,
  INDEX `fk_client_localitat1_idx` (`localitat_id_localitat` ASC) VISIBLE,
  CONSTRAINT `fk_client_localitat1`
    FOREIGN KEY (`localitat_id_localitat`)
    REFERENCES `pizzeria`.`localitat` (`id_localitat`),
  CONSTRAINT `fk_client_provincia1`
    FOREIGN KEY (`provincia_id_provincia`)
    REFERENCES `pizzeria`.`provincia` (`id_provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comanda` (
  `id_comanda` INT NOT NULL AUTO_INCREMENT,
  `datahora` DATETIME NOT NULL,
  `tipo` ENUM('domicili', 'recollir') NOT NULL,
  `cantpizza` INT NULL DEFAULT NULL,
  `canthamburguesa` INT NULL DEFAULT NULL,
  `cantbebida` INT NULL DEFAULT NULL,
  `preu` FLOAT NOT NULL,
  `client_id_client` INT NOT NULL,
  `botiga_id_botiga` INT NOT NULL,
  PRIMARY KEY (`id_comanda`),
  INDEX `fk_comanda_client1_idx` (`client_id_client` ASC) VISIBLE,
  INDEX `fk_comanda_botiga1_idx` (`botiga_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_botiga1`
    FOREIGN KEY (`botiga_id_botiga`)
    REFERENCES `pizzeria`.`botiga` (`id_botiga`),
  CONSTRAINT `fk_comanda_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `pizzeria`.`client` (`id_client`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`beguda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`beguda` (
  `id_beguda` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(45) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `comanda_id_comanda` INT NOT NULL,
  PRIMARY KEY (`id_beguda`),
  INDEX `fk_beguda_comanda1_idx` (`comanda_id_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_beguda_comanda1`
    FOREIGN KEY (`comanda_id_comanda`)
    REFERENCES `pizzeria`.`comanda` (`id_comanda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleat` (
  `id_empleat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognoms` VARCHAR(45) NOT NULL,
  `nif` INT NOT NULL,
  `telefon` INT NOT NULL,
  `lloc` ENUM('cuiner', 'repartidor') NOT NULL,
  `botiga_id_botiga` INT NOT NULL,
  PRIMARY KEY (`id_empleat`),
  INDEX `fk_empleat_botiga1_idx` (`botiga_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_empleat_botiga1`
    FOREIGN KEY (`botiga_id_botiga`)
    REFERENCES `pizzeria`.`botiga` (`id_botiga`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesa` (
  `id_hamburguesa` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(45) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `preu` FLOAT NOT NULL,
  `comanda_id_comanda` INT NOT NULL,
  PRIMARY KEY (`id_hamburguesa`),
  INDEX `fk_hamburguesa_comanda1_idx` (`comanda_id_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_hamburguesa_comanda1`
    FOREIGN KEY (`comanda_id_comanda`)
    REFERENCES `pizzeria`.`comanda` (`id_comanda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `id_pizza` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(45) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `preu` FLOAT NOT NULL,
  `comanda_id_comanda` INT NOT NULL,
  PRIMARY KEY (`id_pizza`),
  INDEX `fk_pizza_comanda1_idx` (`comanda_id_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_comanda1`
    FOREIGN KEY (`comanda_id_comanda`)
    REFERENCES `pizzeria`.`comanda` (`id_comanda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_categoria` (
  `id_pizza_categoria` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `pizza_id_pizza` INT NOT NULL,
  PRIMARY KEY (`id_pizza_categoria`),
  INDEX `fk_pizza_categoria_pizza1_idx` (`pizza_id_pizza` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_categoria_pizza1`
    FOREIGN KEY (`pizza_id_pizza`)
    REFERENCES `pizzeria`.`pizza` (`id_pizza`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
