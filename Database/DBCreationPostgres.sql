-- -----------------------------------------------------
-- Schema Subus
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS Subus;
SET search_path TO Subus;


-- GENERAL --

-- -----------------------------------------------------
-- Table Subus.user_group
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.user_group;

CREATE TABLE IF NOT EXISTS Subus.user_group (
  name VARCHAR(128) PRIMARY KEY NOT NULL);


-- -----------------------------------------------------
-- Table Subus.app_user
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.app_user;

CREATE TABLE IF NOT EXISTS Subus.app_user (
  email VARCHAR(128) NOT NULL,
  user_name VARCHAR(128) NULL DEFAULT NULL,
  password VARCHAR(64) NOT NULL,
  password_salt VARCHAR(64) NOT NULL,
  PRIMARY KEY (email));


-- -----------------------------------------------------
-- Table Subus.user_in_group
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.user_in_group;

CREATE TABLE IF NOT EXISTS Subus.user_in_group (
  user_email VARCHAR(128) NOT NULL,
  groud_name VARCHAR(128) NOT NULL,
  PRIMARY KEY (user_email, groud_name),
  CONSTRAINT user_group_ibfk_1
    FOREIGN KEY (user_email)
    REFERENCES Subus.app_user (email),
  CONSTRAINT user_in_group_ibfk_2
    FOREIGN KEY (groud_name)
    REFERENCES Subus.user_group (name));
	

-- -----------------------------------------------------
-- Table Subus.patio
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.patio;

CREATE TABLE IF NOT EXISTS Subus.patio (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.auditor
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.auditor;

CREATE TABLE IF NOT EXISTS Subus.auditor (
  id SERIAL NOT NULL,
  rut VARCHAR(15) NOT NULL,
  nombre VARCHAR(128) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.nivel_alerta
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.nivel_alerta;

CREATE TABLE IF NOT EXISTS Subus.nivel_alerta (
  id SERIAL NOT NULL ,
  alerta VARCHAR(128) NOT NULL,
  color_hex VARCHAR(12) NOT NULL,
  prioridad SMALLINT NOT NULL UNIQUE,
  PRIMARY KEY (id));
 

-- BUSES --

-- -----------------------------------------------------
-- Table Subus.tipo_bus
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.tipo_bus;

CREATE TABLE IF NOT EXISTS Subus.tipo_bus (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.modelo
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.modelo;

CREATE TABLE IF NOT EXISTS Subus.modelo (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.carroceria
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.carroceria;

CREATE TABLE IF NOT EXISTS Subus.carroceria (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.modelo_carroceria
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.modelo_carroceria;

CREATE TABLE IF NOT EXISTS Subus.modelo_carroceria (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.propiedad
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.propiedad;

CREATE TABLE IF NOT EXISTS Subus.propiedad (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.bus
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.bus;

CREATE TABLE IF NOT EXISTS Subus.bus (
  id SERIAL NOT NULL ,
  n_interno VARCHAR(8) NOT NULL,
  id_modelo INT NOT NULL,
  id_tipo_bus INT NOT NULL,
  patente VARCHAR(8) NOT NULL,
  anio SMALLINT NOT NULL,
  chasis VARCHAR(64) NOT NULL,
  plazas SMALLINT NOT NULL,
  id_carroceria INT NOT NULL,
  id_modelo_carroceria INT NOT NULL,
  id_propiedad INT NOT NULL,
  id_patio INT NOT NULL,
  en_operacion BOOL NOT NULL DEFAULT TRUE,
  PRIMARY KEY (id),
  CONSTRAINT bus_ibfk_1
    FOREIGN KEY (id_modelo)
    REFERENCES Subus.modelo (id),
  CONSTRAINT bus_ibfk_2
    FOREIGN KEY (id_tipo_bus)
    REFERENCES Subus.tipo_bus (id),
  CONSTRAINT bus_ibfk_3
    FOREIGN KEY (id_carroceria)
    REFERENCES Subus.carroceria (id),
  CONSTRAINT bus_ibfk_4
    FOREIGN KEY (id_modelo_carroceria)
    REFERENCES Subus.modelo_carroceria (id),
  CONSTRAINT bus_ibfk_5
    FOREIGN KEY (id_propiedad)
    REFERENCES Subus.propiedad (id),
  CONSTRAINT bus_ibfk_6
    FOREIGN KEY (id_patio)
    REFERENCES Subus.patio (id));


-- AUDITORIAS --

-- -----------------------------------------------------
-- Table Subus.tipo_auditoria
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.tipo_auditoria;

CREATE TABLE IF NOT EXISTS Subus.tipo_auditoria (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.ubicacion_bus
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.ubicacion_bus;

CREATE TABLE IF NOT EXISTS Subus.ubicacion_bus (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.estado_inspeccion
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.estado_inspeccion;

CREATE TABLE IF NOT EXISTS Subus.estado_inspeccion (
  id SERIAL NOT NULL ,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table Subus.auditoria
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.auditoria;

CREATE TABLE IF NOT EXISTS Subus.auditoria (
  id SERIAL NOT NULL ,
  marca_temporal TIMESTAMP NOT NULL,
  fecha TIMESTAMP NOT NULL,
  id_patio INT NOT NULL,
  id_tipo_auditoria INT NOT NULL,
  id_auditor INT NOT NULL,
  id_ubicacion_bus INT NOT NULL,
  id_estado_inspeccion INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT auditoria_ibfk_1
    FOREIGN KEY (id_patio)
    REFERENCES Subus.patio (id),
  CONSTRAINT auditoria_ibfk_2
    FOREIGN KEY (id_tipo_auditoria)
    REFERENCES Subus.tipo_auditoria (id),
  CONSTRAINT auditoria_ibfk_3
    FOREIGN KEY (id_auditor)
    REFERENCES Subus.auditor (id),
  CONSTRAINT auditoria_ibfk_4
    FOREIGN KEY (id_ubicacion_bus)
    REFERENCES Subus.ubicacion_bus (id),
  CONSTRAINT auditoria_ibfk_5
    FOREIGN KEY (id_estado_inspeccion)
    REFERENCES Subus.estado_inspeccion (id));


-- -----------------------------------------------------
-- Table Subus.grupo_campos
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.grupo_campos;

CREATE TABLE IF NOT EXISTS Subus.grupo_campos (
  id SERIAL NOT NULL ,
  id_grupo_padre INT NOT NULL,
  nombre VARCHAR(64) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT grupo_campo_ibfk_1
    FOREIGN KEY (id_grupo_padre)
    REFERENCES Subus.grupo_campos (id));


-- -----------------------------------------------------
-- Table Subus.campo_auditoria
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.campo_auditoria;

CREATE TABLE IF NOT EXISTS Subus.campo_auditoria (
  id SERIAL NOT NULL ,
  id_grupo INT NOT NULL,
  titulo VARCHAR(128) NOT NULL,
  descripcion VARCHAR(512),
  PRIMARY KEY (id),
  CONSTRAINT campo_auditoria_ibfk_1
    FOREIGN KEY (id_grupo)
    REFERENCES Subus.grupo_campos (id));


-- -----------------------------------------------------
-- Table Subus.campo_opcion
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.campo_opcion;

CREATE TABLE IF NOT EXISTS Subus.campo_opcion (
  id SERIAL NOT NULL ,
  id_campo_auditoria INT NOT NULL,
  valor VARCHAR(128) NOT NULL,
  abreviacion VARCHAR(32),
  id_nivel_alerta INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT campo_opcion_ibfk_1
    FOREIGN KEY (id_campo_auditoria)
    REFERENCES Subus.campo_auditoria (id),
  CONSTRAINT campo_opcion_ibfk_2
    FOREIGN KEY (id_nivel_alerta)
    REFERENCES Subus.nivel_alerta (id));


-- -----------------------------------------------------
-- Table Subus.opcion_en_auditoria
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subus.opcion_en_auditoria;

CREATE TABLE IF NOT EXISTS Subus.opcion_en_auditoria (
  id_auditoria INT NOT NULL ,
  id_campo_opcion INT NOT NULL,
  PRIMARY KEY (id_auditoria, id_campo_opcion),
  CONSTRAINT opcion_en_auditoria_ibfk_1
    FOREIGN KEY (id_auditoria)
    REFERENCES Subus.auditoria (id),
  CONSTRAINT opcion_en_auditoria_ibfk_2
    FOREIGN KEY (id_campo_opcion)
    REFERENCES Subus.campo_opcion (id));
