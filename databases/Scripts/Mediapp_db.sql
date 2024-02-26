-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roles` (
  `id_Rol` INT NOT NULL AUTO_INCREMENT,
  `rol_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Rol`));

-- Insertar roles
INSERT INTO `mydb`.`Roles` (`id_Rol`, `rol_Nombre`) VALUES (1, 'Paciente');
INSERT INTO `mydb`.`Roles` (`id_Rol`, `rol_Nombre`) VALUES (2, 'Cuidador');

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
  `FK_Rol` INT NOT NULL,
  PRIMARY KEY (`id_Usuario`),
  INDEX `fk_Usuarios_Roles_idx` (`FK_Rol` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Roles`
    FOREIGN KEY (`FK_Rol`)
    REFERENCES `mydb`.`Roles` (`id_Rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
