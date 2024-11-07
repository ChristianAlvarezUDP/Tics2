-- -----------------------------------------------------
-- Schema Subus
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `Subus` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Subus` ;


-- GENERAL --

-- -----------------------------------------------------
-- Table `AppVet`.`user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AppVet`.`user_group`;

CREATE TABLE IF NOT EXISTS `AppVet`.`user_group` (
  `name` VARCHAR(128) PRIMARY KEY NOT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `AppVet`.`app_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AppVet`.`app_user`;

CREATE TABLE IF NOT EXISTS `AppVet`.`app_user` (
  `email` VARCHAR(128) NOT NULL,
  `user_name` VARCHAR(128) NULL DEFAULT NULL,
  `password` VARCHAR(64) NOT NULL,
  `password_salt` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `AppVet`.`user_in_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AppVet`.`user_in_group`;

CREATE TABLE IF NOT EXISTS `AppVet`.`user_in_group` (
  `email_user` VARCHAR(128) NOT NULL,
  `name_group` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`email_in_user`, `name_group`),
  CONSTRAINT `user_group_ibfk_1`
    FOREIGN KEY (`email_user`)
    REFERENCES `AppVet`.`app_user` (`email`),
  CONSTRAINT `user_in_group_ibfk_2`
    FOREIGN KEY (`name_group`)
    REFERENCES `AppVet`.`user_group` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`patio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`patio`;

CREATE TABLE IF NOT EXISTS `Subus`.`patio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`auditor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`auditor`;

CREATE TABLE IF NOT EXISTS `Subus`.`auditor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rut` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`nivel_alerta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`nivel_alerta`;

CREATE TABLE IF NOT EXISTS `Subus`.`nivel_alerta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alerta` VARCHAR(128) NOT NULL,
  `color_hex` VARCHAR(12) NOT NULL,
  `prioridad` SMALLINT NOT NULL UNIQUE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- BUSES --

-- -----------------------------------------------------
-- Table `Subus`.`tipo_bus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`tipo_bus`;

CREATE TABLE IF NOT EXISTS `Subus`.`tipo_bus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`modelo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`modelo`;

CREATE TABLE IF NOT EXISTS `Subus`.`modelo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`carroceria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`carroceria`;

CREATE TABLE IF NOT EXISTS `Subus`.`carroceria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`modelo_carroceria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`modelo_carroceria`;

CREATE TABLE IF NOT EXISTS `Subus`.`modelo_carroceria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`propiedad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`propiedad`;

CREATE TABLE IF NOT EXISTS `Subus`.`propiedad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`bus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`bus`;

CREATE TABLE IF NOT EXISTS `Subus`.`bus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `n_interno` VARCHAR(8) NOT NULL,
  `id_modelo` INT NOT NULL,
  `id_tipo_bus` INT NOT NULL,
  `patente` VARCHAR(8) NOT NULL,
  `anio` SMALLINT NOT NULL,
  `chasis` VARCHAR(64) NOT NULL,
  `plazas` SMALLINT NOT NULL,
  `id_carroceria` INT NOT NULL,
  `id_modelo_carroceria` INT NOT NULL,
  `id_propiedad` INT NOT NULL,
  `id_patio` INT NOT NULL,
  `en_operacion` BOOL NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`id`),
  CONSTRAINT `bus_ibfk_1`
    FOREIGN KEY (`id_modelo`)
    REFERENCES `Subus`.`modelo` (`id`),
  CONSTRAINT `bus_ibfk_2`
    FOREIGN KEY (`id_tipo_bus`)
    REFERENCES `Subus`.`tipo_bus` (`id`),
  CONSTRAINT `bus_ibfk_3`
    FOREIGN KEY (`id_carroceria`)
    REFERENCES `Subus`.`carroceria` (`id`),
  CONSTRAINT `bus_ibfk_4`
    FOREIGN KEY (`id_modelo_carroceria`)
    REFERENCES `Subus`.`modelo_carroceria` (`id`),
  CONSTRAINT `bus_ibfk_5`
    FOREIGN KEY (`id_propiedad`)
    REFERENCES `Subus`.`propiedad` (`id`),
  CONSTRAINT `bus_ibfk_6`
    FOREIGN KEY (`id_patio`)
    REFERENCES `Subus`.`patio` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- AUDITORIAS --

-- -----------------------------------------------------
-- Table `Subus`.`tipo_auditoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`tipo_auditoria`;

CREATE TABLE IF NOT EXISTS `Subus`.`tipo_auditoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`ubicacion_bus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`ubicacion_bus`;

CREATE TABLE IF NOT EXISTS `Subus`.`ubicacion_bus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`estado_inspeccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`estado_inspeccion`;

CREATE TABLE IF NOT EXISTS `Subus`.`estado_inspeccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`auditoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`auditoria`;

CREATE TABLE IF NOT EXISTS `Subus`.`auditoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca_temporal` DATETIME NOT NULL,
  `fecha` DATETIME NOT NULL,
  `id_patio` INT NOT NULL,
  `id_tipo_auditoria` INT NOT NULL,
  `id_auditor` INT NOT NULL,
  `id_ubicacion_bus` INT NOT NULL,
  `id_estado_inspeccion` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `auditoria_ibfk_1`
    FOREIGN KEY (`id_patio`)
    REFERENCES `Subus`.`patio` (`id`),
  CONSTRAINT `auditoria_ibfk_2`
    FOREIGN KEY (`id_tipo_auditoria`)
    REFERENCES `Subus`.`tipo_auditoria` (`id`),
  CONSTRAINT `auditoria_ibfk_3`
    FOREIGN KEY (`id_auditor`)
    REFERENCES `Subus`.`auditor` (`id`),
  CONSTRAINT `auditoria_ibfk_4`
    FOREIGN KEY (`id_ubicacion_bus`)
    REFERENCES `Subus`.`ubicacion_bus` (`id`),
  CONSTRAINT `auditoria_ibfk_5`
    FOREIGN KEY (`id_estado_inspeccion`)
    REFERENCES `Subus`.`estado_inspeccion` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`grupo_campos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`grupo_campos`;

CREATE TABLE IF NOT EXISTS `Subus`.`grupo_campos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_grupo_padre` INT NOT NULL,
  `nombre` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `grupo_campo_ibfk_1`
    FOREIGN KEY (`id_grupo_padre`)
    REFERENCES `Subus`.`grupo_campos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`campo_auditoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`campo_auditoria`;

CREATE TABLE IF NOT EXISTS `Subus`.`campo_auditoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_grupo` INT NOT NULL,
  `titulo` VARCHAR(128) NOT NULL,
  `descripcion` VARCHAR(512),
  PRIMARY KEY (`id`),
  CONSTRAINT `campo_auditoria_ibfk_1`
    FOREIGN KEY (`id_grupo`)
    REFERENCES `Subus`.`grupo_campos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`campo_opcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`campo_opcion`;

CREATE TABLE IF NOT EXISTS `Subus`.`campo_opcion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_campo_auditoria` INT NOT NULL,
  `valor` VARCHAR(128) NOT NULL,
  `abreviacion` VARCHAR(32),
  `id_nivel_alerta` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `campo_opcion_ibfk_1`
    FOREIGN KEY (`id_campo_auditoria`)
    REFERENCES `Subus`.`campo_auditoria` (`id`),
  CONSTRAINT `campo_opcion_ibfk_2`
    FOREIGN KEY (`id_nivel_alerta`)
    REFERENCES `Subus`.`nivel_alerta` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Subus`.`opcion_en_auditoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subus`.`opcion_en_auditoria`;

CREATE TABLE IF NOT EXISTS `Subus`.`opcion_en_auditoria` (
  `id_auditoria` INT NOT NULL AUTO_INCREMENT,
  `id_campo_opcion` INT NOT NULL,
  PRIMARY KEY (`id_auditoria`, `id_campo_opcion`),
  CONSTRAINT `opcion_en_auditoria_ibfk_1`
    FOREIGN KEY (`id_auditoria`)
    REFERENCES `Subus`.`auditoria` (`id`),
  CONSTRAINT `opcion_en_auditoria_ibfk_2`
    FOREIGN KEY (`id_campo_opcion`)
    REFERENCES `Subus`.`campo_opcion` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
