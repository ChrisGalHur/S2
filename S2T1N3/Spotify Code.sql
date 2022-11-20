-- MySQL Workbench Synchronization
-- Generated: 2022-11-14 20:20
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: clara

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `spotify`.`usuarix` (
  `id_usuarix` INT(11) NOT NULL AUTO_INCREMENT,
  `premium` ENUM('si') NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `naixement` DATE NOT NULL,
  `sexe` ENUM('h', 'd', 'o') NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codi_postal` INT(11) NOT NULL,
  PRIMARY KEY (`id_usuarix`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`subsripcio` (
  `id_subsripcio` INT(11) NOT NULL AUTO_INCREMENT,
  `data_inici` DATE NOT NULL,
  `data_fi` DATE NOT NULL,
  `pagament` ENUM('targeta', 'paypal') NOT NULL,
  `usuarix_id_usuarix` INT(11) NOT NULL,
  PRIMARY KEY (`id_subsripcio`),
  INDEX `fk_subsripcio_usuarix1_idx` (`usuarix_id_usuarix` ASC) VISIBLE,
  CONSTRAINT `fk_subsripcio_usuarix1`
    FOREIGN KEY (`usuarix_id_usuarix`)
    REFERENCES `spotify`.`usuarix` (`id_usuarix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`targeta` (
  `id_targeta` INT(11) NOT NULL AUTO_INCREMENT,
  `numero_targeta` INT(11) NOT NULL,
  `any_caducitat` TINYINT(2) NOT NULL,
  `mes_caducitat` TINYINT(2) NOT NULL,
  `codi_seguretat` TINYINT(3) NOT NULL,
  `usuarix_id_usuarix` INT(11) NOT NULL,
  `pagaments_id_pagaments(numero_ordre)` INT(11) NOT NULL,
  PRIMARY KEY (`id_targeta`),
  INDEX `fk_targeta_usuarix_idx` (`usuarix_id_usuarix` ASC) VISIBLE,
  INDEX `fk_targeta_pagaments1_idx` (`pagaments_id_pagaments(numero_ordre)` ASC) VISIBLE,
  CONSTRAINT `fk_targeta_usuarix`
    FOREIGN KEY (`usuarix_id_usuarix`)
    REFERENCES `spotify`.`usuarix` (`id_usuarix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_targeta_pagaments1`
    FOREIGN KEY (`pagaments_id_pagaments(numero_ordre)`)
    REFERENCES `spotify`.`pagaments` (`id_pagaments(numero_ordre)`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `id_paypal` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_paypal` VARCHAR(45) NOT NULL,
  `usuarix_id_usuarix` INT(11) NOT NULL,
  `pagaments_id_pagaments(numero_ordre)` INT(11) NOT NULL,
  PRIMARY KEY (`id_paypal`),
  INDEX `fk_paypal_usuarix1_idx` (`usuarix_id_usuarix` ASC) VISIBLE,
  INDEX `fk_paypal_pagaments1_idx` (`pagaments_id_pagaments(numero_ordre)` ASC) VISIBLE,
  CONSTRAINT `fk_paypal_usuarix1`
    FOREIGN KEY (`usuarix_id_usuarix`)
    REFERENCES `spotify`.`usuarix` (`id_usuarix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paypal_pagaments1`
    FOREIGN KEY (`pagaments_id_pagaments(numero_ordre)`)
    REFERENCES `spotify`.`pagaments` (`id_pagaments(numero_ordre)`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`pagaments` (
  `id_pagaments(numero_ordre)` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `total` FLOAT(11) NOT NULL,
  PRIMARY KEY (`id_pagaments(numero_ordre)`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `id_playlist` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `cuantitat` INT(11) NOT NULL,
  `data_creada` DATETIME NOT NULL,
  `eliminada` ENUM('eliminada') NULL DEFAULT NULL,
  `data_eliminacio` DATETIME NULL DEFAULT NULL,
  `usuarix_id_usuarix` INT(11) NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_playlist_usuarix1_idx` (`usuarix_id_usuarix` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuarix1`
    FOREIGN KEY (`usuarix_id_usuarix`)
    REFERENCES `spotify`.`usuarix` (`id_usuarix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`afegir` (
  `id_afegir` INT(11) NOT NULL AUTO_INCREMENT,
  `usuarix` VARCHAR(45) NOT NULL,
  `data_afegiment` DATETIME NOT NULL,
  `playlist_id_playlist` INT(11) NOT NULL,
  PRIMARY KEY (`id_afegir`),
  INDEX `fk_afegir_playlist1_idx` (`playlist_id_playlist` ASC) VISIBLE,
  CONSTRAINT `fk_afegir_playlist1`
    FOREIGN KEY (`playlist_id_playlist`)
    REFERENCES `spotify`.`playlist` (`id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`canco` (
  `id_canco` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `durada` TIME NOT NULL,
  `reproduccions` DOUBLE NOT NULL,
  `album_id_album` INT(11) NOT NULL,
  `favorits_id_favorits` INT(11) NOT NULL,
  PRIMARY KEY (`id_canco`),
  INDEX `fk_canco_album1_idx` (`album_id_album` ASC) VISIBLE,
  INDEX `fk_canco_favorits1_idx` (`favorits_id_favorits` ASC) VISIBLE,
  CONSTRAINT `fk_canco_album1`
    FOREIGN KEY (`album_id_album`)
    REFERENCES `spotify`.`album` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canco_favorits1`
    FOREIGN KEY (`favorits_id_favorits`)
    REFERENCES `spotify`.`favorits` (`id_favorits`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `id_album` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `any_publicacio` YEAR NOT NULL,
  `portada` VARCHAR(45) NOT NULL,
  `artista_id_artista` INT(11) NOT NULL,
  `favorits_id_favorits` INT(11) NOT NULL,
  PRIMARY KEY (`id_album`),
  INDEX `fk_album_artista1_idx` (`artista_id_artista` ASC) VISIBLE,
  INDEX `fk_album_favorits1_idx` (`favorits_id_favorits` ASC) VISIBLE,
  CONSTRAINT `fk_album_artista1`
    FOREIGN KEY (`artista_id_artista`)
    REFERENCES `spotify`.`artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_album_favorits1`
    FOREIGN KEY (`favorits_id_favorits`)
    REFERENCES `spotify`.`favorits` (`id_favorits`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`artista` (
  `id_artista` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `llista_seguiment_id_llista_seguiment` INT(11) NOT NULL,
  PRIMARY KEY (`id_artista`),
  INDEX `fk_artista_llista_seguiment1_idx` (`llista_seguiment_id_llista_seguiment` ASC) VISIBLE,
  CONSTRAINT `fk_artista_llista_seguiment1`
    FOREIGN KEY (`llista_seguiment_id_llista_seguiment`)
    REFERENCES `spotify`.`llista_seguiment` (`id_llista_seguiment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`favorits` (
  `id_favorits` INT(11) NOT NULL AUTO_INCREMENT,
  `canco` VARCHAR(45) NULL DEFAULT NULL,
  `artista` VARCHAR(45) NULL DEFAULT NULL,
  `playlist_id_playlist` INT(11) NOT NULL,
  PRIMARY KEY (`id_favorits`),
  INDEX `fk_favorits_playlist1_idx` (`playlist_id_playlist` ASC) VISIBLE,
  CONSTRAINT `fk_favorits_playlist1`
    FOREIGN KEY (`playlist_id_playlist`)
    REFERENCES `spotify`.`playlist` (`id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`llista_seguiment` (
  `id_llista_seguiment` INT(11) NOT NULL AUTO_INCREMENT,
  `artistes` VARCHAR(45) NULL DEFAULT NULL,
  `afegir_id_afegir` INT(11) NOT NULL,
  PRIMARY KEY (`id_llista_seguiment`),
  INDEX `fk_llista_seguiment_afegir1_idx` (`afegir_id_afegir` ASC) VISIBLE,
  CONSTRAINT `fk_llista_seguiment_afegir1`
    FOREIGN KEY (`afegir_id_afegir`)
    REFERENCES `spotify`.`afegir` (`id_afegir`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`artista_has_artista` (
  `artista_id_artista` INT(11) NOT NULL,
  `artista_id_artista1` INT(11) NOT NULL,
  `tipus_de_musica` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`artista_id_artista`, `artista_id_artista1`),
  INDEX `fk_artista_has_artista_artista2_idx` (`artista_id_artista1` ASC) VISIBLE,
  INDEX `fk_artista_has_artista_artista1_idx` (`artista_id_artista` ASC) VISIBLE,
  CONSTRAINT `fk_artista_has_artista_artista1`
    FOREIGN KEY (`artista_id_artista`)
    REFERENCES `spotify`.`artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artista_has_artista_artista2`
    FOREIGN KEY (`artista_id_artista1`)
    REFERENCES `spotify`.`artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
