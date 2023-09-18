CREATE SCHEMA IF NOT EXISTS `lyonDB` DEFAULT CHARACTER SET utf8 ;

-- Creación de la tabla TiposDocumentos
CREATE TABLE IF NOT EXISTS `lyonDB`.`TiposDocumentos` (
  `idTipoDocumento` TINYINT NOT NULL AUTO_INCREMENT COMMENT 'Llave foranea de tipo de identificacion de Usuario (Este campo es obligatorio).',
  `tipoDocumento` VARCHAR(4) NOT NULL COMMENT 'Expresa en siglas o abreviaciones el tipo de documento que posee el Usuario (Este campo es obligatorio).',
  PRIMARY KEY (`idTipoDocumento`)
) ENGINE = InnoDB;

-- Creación de la tabla Roles
CREATE TABLE IF NOT EXISTS `lyonDB`.`Roles` (
  `idRol` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de Rol con sus correspondientes permisos (Este campo es obligatorio).',
  `rol` VARCHAR(45) NOT NULL COMMENT 'Función o conjunto de funciones que desempeña cada Usuario en el software (Este campo es obligatorio).',
  PRIMARY KEY (`idRol`)
) ENGINE = InnoDB;

-- Creación de la tabla Usuarios
CREATE TABLE IF NOT EXISTS `lyonDB`.`Usuarios` (
  `documento` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de Usuario con el cual se podrá acceder al sistema.',
  `fechaNacimiento` DATE NOT NULL COMMENT 'Valor numérico que representa la cantidad de años vividos de un Usuario (este campo es obligatorio).',
  `nombre1` VARCHAR(45) NOT NULL COMMENT 'Palabra asignada para distinguir al usuario de manera genérica (este campo es obligatorio).',
  `nombre2` VARCHAR(45) NULL COMMENT 'Segunda palabra asignada para distinguir al usuario de manera genérica.',
  `apellido1` VARCHAR(45) NOT NULL COMMENT 'Nombre de pila de una persona que se transmite de padre a hijo (este campo es obligatorio).',
  `apellido2` VARCHAR(45) NULL COMMENT 'Nombre de pila de una persona que se transmite de padre a hijo.',
  `email` VARCHAR(100) NOT NULL COMMENT 'Dirección de correo electrónico con la que el usuario ingresará al sistema (este campo es obligatorio).',
  `telefono_fijo` INT NULL COMMENT 'Número de contacto al domicilio en el que reside el Usuario.',
  `telefono_celular` BIGINT NOT NULL COMMENT 'Número de contacto directo del Usuario (Este campo es obligatorio).',
  `contrasenia` VARCHAR(15) NOT NULL COMMENT 'Serie de caracteres encriptados que permiten al Usuario el acceso al sistema (Este campo es obligatorio).',
  `urlFoto` VARCHAR(50) NULL,
  `Tipo_idTipoDocumento` TINYINT NOT NULL COMMENT 'Llave foranea de tipo de identificación de Usuario (Este campo es obligatorio).',
  `Rol_idRol` INT NOT NULL COMMENT 'Llave foranea de tabla Rol (Este campo es obligatorio).',
  `Estado` TINYINT NOT NULL,
  PRIMARY KEY (`documento`),
  UNIQUE INDEX `email_UNIQUE` (`email`),
  INDEX `fk_Usuario_TipoDocumento_idx` (`Tipo_idTipoDocumento`),
  INDEX `fk_Usuario_Rol1_idx` (`Rol_idRol`),
  CONSTRAINT `fk_Usuario_TipoDocumento`
    FOREIGN KEY (`Tipo_idTipoDocumento`)
    REFERENCES `lyonDB`.`TiposDocumentos` (`idTipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Rol1`
    FOREIGN KEY (`Rol_idRol`)
    REFERENCES `lyonDB`.`Roles` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Creación de la tabla Grados
CREATE TABLE IF NOT EXISTS `lyonDB`.`Grados` (
  `numero` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador en forma de presentación numérica o alfanumérica que muestra el nivel en el que está clasificado el Estudiante (Este campo es obligatorio).',
  `salonAsignado` INT NOT NULL COMMENT 'Espacio designado para la instrucción de Profesor a Estudiante (Este campo es obligatorio).',
  `cantidadEstudiantes` TINYINT NOT NULL COMMENT 'Conjunto expresado de manera cuantitativa el número de Estudiantes (Este campo es obligatorio).',
  `nombre` VARCHAR(5) NOT NULL,
  `anio` VARCHAR(4) NULL,
  `director` INT NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Grado_Usuario1_idx` (`director`),
  CONSTRAINT `fk_Grado_Usuario1`
    FOREIGN KEY (`director`)
    REFERENCES `lyonDB`.`Usuarios` (`documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Creación de la tabla Observaciones
CREATE TABLE IF NOT EXISTS `lyonDB`.`Observaciones` (
  `IdObservacion` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador no repetible del registro en la tabla Observacion (Este campo es obligatorio).',
  `informe` VARCHAR(1000) NOT NULL COMMENT 'Representación escrita detallada sobre el o los hechos representativos sobre circunstancias de Estudiante (Este campo es obligatorio).',
  `Usuario_documento` INT NOT NULL COMMENT 'Llave primaria foranea de la tabla Usuario (Este campo es obligatorio).',
  PRIMARY KEY (`IdObservacion`),
  INDEX `fk_Observacion_Usuario1_idx` (`Usuario_documento`),
  CONSTRAINT `fk_Observacion_Usuario1`
    FOREIGN KEY (`Usuario_documento`)
    REFERENCES `lyonDB`.`Usuarios` (`documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Creación de la tabla Horarios
CREATE TABLE IF NOT EXISTS `lyonDB`.`Horarios` (
  `idHorario` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de horario',
  `urlHorario` VARCHAR(50) NULL COMMENT 'Carga la imagen de cada horario',
  `numero` INT NOT NULL,
  PRIMARY KEY (`idHorario`),
  INDEX `fk_Horario_Grado1_idx` (`numero`),
  CONSTRAINT `fk_Horario_Grado1`
    FOREIGN KEY (`numero`)
    REFERENCES `lyonDB`.`Grados` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Creación de la tabla Matriculas
CREATE TABLE IF NOT EXISTS `lyonDB`.`Matriculas` (
  `Usuario_documento` INT NOT NULL,
  `Grado_numero` INT NOT NULL,
  `estado` TINYINT NOT NULL,
  PRIMARY KEY (`Usuario_documento`, `Grado_numero`),
  INDEX `fk_Usuario_has_Grado_Grado1_idx` (`Grado_numero`),
  INDEX `fk_Usuario_has_Grado_Usuario1_idx` (`Usuario_documento`),
  CONSTRAINT `fk_Usuario_has_Grado_Usuario1`
    FOREIGN KEY (`Usuario_documento`)
    REFERENCES `lyonDB`.`Usuarios` (`documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Grado_Grado1`
    FOREIGN KEY (`Grado_numero`)
    REFERENCES `lyonDB`.`Grados` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;
