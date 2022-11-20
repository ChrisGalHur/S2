-- MySQL Workbench Synchronization
-- Generated: 2022-11-14 19:34
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: clara

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `youtube`.`usuarix` (
  `id_usuarix` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `data_naixement` VARCHAR(45) NOT NULL,
  `sexe` ENUM('h', 'd', 'o') NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codi_postal` INT(11) NOT NULL,
  PRIMARY KEY (`id_usuarix`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `id_video` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(200) NOT NULL,
  `descripcio` VARCHAR(200) NOT NULL,
  `grandaria` FLOAT(11) NOT NULL,
  `nom_arxiu` VARCHAR(45) NOT NULL,
  `durada` TIME NOT NULL,
  `thumbnail` VARCHAR(45) NOT NULL,
  `reproduccions` INT(11) NOT NULL,
  `likes` INT(11) NOT NULL,
  `dislikes` INT(11) NOT NULL,
  `estado` ENUM('public', 'privat', 'ocult') NOT NULL,
  `canal_id_canal` INT(11) NOT NULL,
  `canal_id_canal1` INT(11) NOT NULL,
  PRIMARY KEY (`id_video`, `canal_id_canal`),
  INDEX `fk_video_canal1_idx` (`canal_id_canal1` ASC) VISIBLE,
  CONSTRAINT `fk_video_canal1`
    FOREIGN KEY (`canal_id_canal1`)
    REFERENCES `youtube`.`canal` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `youtube`.`canal` (
  `id_canal` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcio` VARCHAR(200) NOT NULL,
  `data_creacio` DATE NOT NULL,
  `usuarix_id_usuarix` INT(11) NOT NULL,
  PRIMARY KEY (`id_canal`),
  INDEX `fk_canal_usuarix1_idx` (`usuarix_id_usuarix` ASC) VISIBLE,
  CONSTRAINT `fk_canal_usuarix1`
    FOREIGN KEY (`usuarix_id_usuarix`)
    REFERENCES `youtube`.`usuarix` (`id_usuarix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `id_playlist` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `data_creacio` DATETIME NOT NULL,
  `estat` ENUM('publica', 'privada') NOT NULL,
  `usuarix_id_usuarix` INT(11) NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_playlist_usuarix1_idx` (`usuarix_id_usuarix` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuarix1`
    FOREIGN KEY (`usuarix_id_usuarix`)
    REFERENCES `youtube`.`usuarix` (`id_usuarix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `youtube`.`comentaris` (
  `id_comentaris` INT(11) NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(200) NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `video_id_video` INT(11) NOT NULL,
  `video_canal_id_canal` INT(11) NOT NULL,
  `usuarix_id_usuarix` INT(11) NOT NULL,
  PRIMARY KEY (`id_comentaris`),
  INDEX `fk_comentari_video1_idx` (`video_id_video` ASC, `video_canal_id_canal` ASC) VISIBLE,
  INDEX `fk_comentaris_usuarix1_idx` (`usuarix_id_usuarix` ASC) VISIBLE,
  CONSTRAINT `fk_comentari_video1`
    FOREIGN KEY (`video_id_video` , `video_canal_id_canal`)
    REFERENCES `youtube`.`video` (`id_video` , `canal_id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentaris_usuarix1`
    FOREIGN KEY (`usuarix_id_usuarix`)
    REFERENCES `youtube`.`usuarix` (`id_usuarix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `youtube`.`etiquetes` (
  `id_etiquetes` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `video_id_video` INT(11) NOT NULL,
  PRIMARY KEY (`id_etiquetes`),
  INDEX `fk_etiquetes_video1_idx` (`video_id_video` ASC) VISIBLE,
  CONSTRAINT `fk_etiquetes_video1`
    FOREIGN KEY (`video_id_video`)
    REFERENCES `youtube`.`video` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `youtube`.`like_dislike` (
  `id_like_dislike` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari` VARCHAR(45) NOT NULL,
  `opcio` ENUM('like', 'dislike') NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `video_id_video` INT(11) NOT NULL,
  `video_canal_id_canal` INT(11) NOT NULL,
  `usuarix_id_usuarix` INT(11) NOT NULL,
  PRIMARY KEY (`id_like_dislike`),
  INDEX `fk_like_dislike_video1_idx` (`video_id_video` ASC, `video_canal_id_canal` ASC) VISIBLE,
  INDEX `fk_like_dislike_usuarix1_idx` (`usuarix_id_usuarix` ASC) VISIBLE,
  CONSTRAINT `fk_like_dislike_video1`
    FOREIGN KEY (`video_id_video` , `video_canal_id_canal`)
    REFERENCES `youtube`.`video` (`id_video` , `canal_id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_like_dislike_usuarix1`
    FOREIGN KEY (`usuarix_id_usuarix`)
    REFERENCES `youtube`.`usuarix` (`id_usuarix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `youtube`.`agrada_noagrada` (
  `id_agrada_noagrada` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari` FLOAT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_agrada_noagrada`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
