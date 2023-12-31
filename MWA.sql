-- MySQL Script generated by MySQL Workbench
-- Tue 28 Nov 2023 11:31:02 AM EET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema wma
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `wma` ;

-- -----------------------------------------------------
-- Schema wma
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wma` DEFAULT CHARACTER SET utf8 ;
USE `wma` ;

-- -----------------------------------------------------
-- Table `wma`.`orchestra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wma`.`orchestra` ;

CREATE TABLE IF NOT EXISTS `wma`.`orchestra` (
  `OC_NAME` INT NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `COUNTRY` VARCHAR(45) NOT NULL,
  `DIRECTOR` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`OC_NAME`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wma`.`musicians`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wma`.`musicians` ;

CREATE TABLE IF NOT EXISTS `wma`.`musicians` (
  `MUSICIAN_NO` INT NOT NULL,
  `NAME` VARCHAR(45) NOT NULL,
  `INSTRUMENT` VARCHAR(45) NOT NULL,
  `SALARY` DOUBLE NOT NULL,
  `orchestra_OC_NAME` INT NOT NULL,
  PRIMARY KEY (`MUSICIAN_NO`),
  INDEX `fk_musicians_orchestra_idx` (`orchestra_OC_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_musicians_orchestra`
    FOREIGN KEY (`orchestra_OC_NAME`)
    REFERENCES `wma`.`orchestra` (`OC_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wma`.`degree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wma`.`degree` ;

CREATE TABLE IF NOT EXISTS `wma`.`degree` (
  `DEGREE` VARCHAR(45) NOT NULL,
  `MUSICIAN_NO` INT NOT NULL,
  `UNIVERSITYl` VARCHAR(45) NOT NULL,
  `YEAR` YEAR(4) NOT NULL,
  PRIMARY KEY (`DEGREE`, `MUSICIAN_NO`),
  INDEX `fk_musicians_to_degree_idx` (`MUSICIAN_NO` ASC) VISIBLE,
  CONSTRAINT `fk_musicians_to_degree`
    FOREIGN KEY (`MUSICIAN_NO`)
    REFERENCES `wma`.`musicians` (`MUSICIAN_NO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wma`.`Composer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wma`.`Composer` ;

CREATE TABLE IF NOT EXISTS `wma`.`Composer` (
  `ComposerName` VARCHAR(45) NOT NULL,
  `COUNTRY` VARCHAR(45) NOT NULL,
  `DoB` DATE NOT NULL,
  PRIMARY KEY (`ComposerName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wma`.`Composition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wma`.`Composition` ;

CREATE TABLE IF NOT EXISTS `wma`.`Composition` (
  `CompName` VARCHAR(45) NOT NULL,
  `ComposerName` VARCHAR(45) NOT NULL,
  `Year` YEAR(4) NOT NULL,
  `Composer_ComposerName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CompName`, `ComposerName`),
  INDEX `fk_Composition_Composer1_idx` (`Composer_ComposerName` ASC) VISIBLE,
  CONSTRAINT `fk_Composition_Composer1`
    FOREIGN KEY (`Composer_ComposerName`)
    REFERENCES `wma`.`Composer` (`ComposerName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wma`.`recordingds`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wma`.`recordingds` ;

CREATE TABLE IF NOT EXISTS `wma`.`recordingds` (
  `OC_NAME` INT NOT NULL,
  `CompName` VARCHAR(45) NOT NULL,
  `ComposerName` VARCHAR(45) NOT NULL,
  `Year` YEAR(4) NOT NULL,
  `Price` DOUBLE NOT NULL,
  `orchestra_OC_NAME` INT NOT NULL,
  `Composition_CompName` VARCHAR(45) NOT NULL,
  `Composition_ComposerName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`OC_NAME`, `CompName`, `ComposerName`),
  INDEX `fk_recordingds_orchestra1_idx` (`orchestra_OC_NAME` ASC) VISIBLE,
  INDEX `fk_recordingds_Composition1_idx` (`Composition_CompName` ASC, `Composition_ComposerName` ASC) VISIBLE,
  CONSTRAINT `fk_recordingds_orchestra1`
    FOREIGN KEY (`orchestra_OC_NAME`)
    REFERENCES `wma`.`orchestra` (`OC_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recordingds_Composition1`
    FOREIGN KEY (`Composition_CompName` , `Composition_ComposerName`)
    REFERENCES `wma`.`Composition` (`CompName` , `ComposerName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
