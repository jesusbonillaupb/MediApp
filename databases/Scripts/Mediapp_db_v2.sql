-- MySQL Script generated by MySQL Workbench
-- Thu Apr 11 09:43:20 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `us_Nombre` VARCHAR(45) NOT NULL,
  `us_Password` VARCHAR(255) NOT NULL,
  `us_Correo` VARCHAR(32) NOT NULL,
  `us_Celular` VARCHAR(45) NOT NULL,
  `us_Edad` INT NOT NULL,
  PRIMARY KEY (`id_Usuario`));


-- -----------------------------------------------------
-- Table `mydb`.`Medicamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medicamentos` (
  `idMedicicamentos` INT NOT NULL,
  `med_Nombre` VARCHAR(45) NOT NULL,
  `med_Tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMedicicamentos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recordatorios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recordatorios` (
  `idRecordatorio` INT NOT NULL,
  `re_DiaSemana` VARCHAR(45) NOT NULL,
  `re_Hora` TIME NOT NULL,
  `FK_Medicamento` INT NOT NULL,
  `FK_Usuario` INT NOT NULL,
  PRIMARY KEY (`idRecordatorio`),
  INDEX `fk_Recordatorios_Medicamentos1_idx` (`FK_Medicamento` ASC) VISIBLE,
  INDEX `fk_Recordatorios_Usuarios1_idx` (`FK_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Recordatorios_Medicamentos1`
    FOREIGN KEY (`FK_Medicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicicamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recordatorios_Usuarios1`
    FOREIGN KEY (`FK_Usuario`)
    REFERENCES `mydb`.`Usuarios` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;