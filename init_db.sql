-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'grupo'
-- 
-- ---

DROP TABLE IF EXISTS `grupo`;
		
CREATE TABLE `grupo` (
  `crn` VARCHAR(15) NOT NULL,
  `clave` VARCHAR(15) NOT NULL,
  `matriculaMaestro` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`crn`)
);

-- ---
-- Table 'alumno'
-- 
-- ---

DROP TABLE IF EXISTS `alumno`;
		
CREATE TABLE `alumno` (
  `matriculaAlumno` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  `apellidoPaterno` VARCHAR(30) NOT NULL,
  `apellidoMaterno` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`matriculaAlumno`)
);

-- ---
-- Table 'listaPregunta'
-- 
-- ---

DROP TABLE IF EXISTS `listaPregunta`;
		
CREATE TABLE `listaPregunta` (
  `idPregunta` INTEGER(10) NOT NULL,
  `pregunta` INTEGER(10) NOT NULL,
  `crn` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idPregunta`)
);

-- ---
-- Table 'alumnoPregunta'
-- 
-- ---

DROP TABLE IF EXISTS `alumnoPregunta`;
		
CREATE TABLE `alumnoPregunta` (
  `matriculaAlumno` VARCHAR(10) NOT NULL,
  `idPregunta` INTEGER(10) NOT NULL,
  `crn` VARCHAR(15) NOT NULL,
  `pregunta` INTEGER(10) NOT NULL,
  PRIMARY KEY (`matriculaAlumno`)
);

-- ---
-- Table 'alumnoComenta'
-- 
-- ---

DROP TABLE IF EXISTS `alumnoComenta`;
		
CREATE TABLE `alumnoComenta` (
  `matriculaAlumno` VARCHAR(10) NOT NULL,
  `idComentario` INTEGER(10) NOT NULL,
  `crn` VARCHAR(15) NOT NULL,
  `comentario` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`matriculaAlumno`)
);

-- ---
-- Table 'materia'
-- 
-- ---

DROP TABLE IF EXISTS `materia`;
		
CREATE TABLE `materia` (
  `clave` VARCHAR(15) NOT NULL,
  `nombreMateria` VARCHAR(30) NOT NULL,
  `idDepartamento` INTEGER(2) NOT NULL,
  `crn` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`clave`)
);

-- ---
-- Table 'departamento'
-- 
-- ---

DROP TABLE IF EXISTS `departamento`;
		
CREATE TABLE `departamento` (
  `idDepartamento` INTEGER(10) NOT NULL,
  `nombreDepartamento` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idDepartamento`)
);

-- ---
-- Table 'listaComentario'
-- 
-- ---

DROP TABLE IF EXISTS `listaComentario`;
		
CREATE TABLE `listaComentario` (
  `idComentario` INTEGER(10) NOT NULL,
  `comentario` VARCHAR(15) NOT NULL,
  `crn` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idComentario`)
);

-- ---
-- Table 'listaRespuesta'
-- 
-- ---

DROP TABLE IF EXISTS `listaRespuesta`;
		
CREATE TABLE `listaRespuesta` (
  `idRespuesta` INTEGER(10) NOT NULL,
  `respuesta` INTEGER(10) NOT NULL,
  `idPregunta` INTEGER(10) NOT NULL,
  `crn` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idRespuesta`)
);

-- ---
-- Table 'grupoAlumno'
-- 
-- ---

DROP TABLE IF EXISTS `grupoAlumno`;
		
CREATE TABLE `grupoAlumno` (
  `crn` VARCHAR(15) NOT NULL,
  `matriculaAlumno` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`crn`)
);

-- ---
-- Table 'periodoEscolar'
-- 
-- ---

DROP TABLE IF EXISTS `periodoEscolar`;
		
CREATE TABLE `periodoEscolar` (
  `idPeriodo` INTEGER NOT NULL,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFin` DATETIME NOT NULL,
  `crn` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idPeriodo`)
);

-- ---
-- Table 'profesor'
-- 
-- ---

DROP TABLE IF EXISTS `profesor`;
		
CREATE TABLE `profesor` (
  `matriculaMaestro` VARCHAR(10) NOT NULL,
  `idDepartamento` INTEGER(10) NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  `apellidoPaterno` VARCHAR(30) NOT NULL,
  `apellidoMaterno` VARCHAR(30) NOT NULL,
  `crn` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`matriculaMaestro`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `grupo` ADD FOREIGN KEY (crn) REFERENCES `grupoAlumno` (`crn`);
ALTER TABLE `grupo` ADD FOREIGN KEY (clave) REFERENCES `materia` (`clave`);
ALTER TABLE `listaPregunta` ADD FOREIGN KEY (crn) REFERENCES `grupo` (`crn`);
ALTER TABLE `alumnoPregunta` ADD FOREIGN KEY (matriculaAlumno) REFERENCES `alumno` (`matriculaAlumno`);
ALTER TABLE `alumnoPregunta` ADD FOREIGN KEY (idPregunta) REFERENCES `listaPregunta` (`idPregunta`);
ALTER TABLE `alumnoPregunta` ADD FOREIGN KEY (crn) REFERENCES `grupo` (`crn`);
ALTER TABLE `alumnoComenta` ADD FOREIGN KEY (matriculaAlumno) REFERENCES `alumno` (`matriculaAlumno`);
ALTER TABLE `alumnoComenta` ADD FOREIGN KEY (idComentario) REFERENCES `listaComentario` (`idComentario`);
ALTER TABLE `alumnoComenta` ADD FOREIGN KEY (crn) REFERENCES `grupo` (`crn`);
ALTER TABLE `materia` ADD FOREIGN KEY (idDepartamento) REFERENCES `departamento` (`idDepartamento`);
ALTER TABLE `materia` ADD FOREIGN KEY (crn) REFERENCES `grupo` (`crn`);
ALTER TABLE `listaComentario` ADD FOREIGN KEY (comentario) REFERENCES `grupo` (`crn`);
ALTER TABLE `listaRespuesta` ADD FOREIGN KEY (idPregunta) REFERENCES `listaPregunta` (`idPregunta`);
ALTER TABLE `listaRespuesta` ADD FOREIGN KEY (crn) REFERENCES `grupo` (`crn`);
ALTER TABLE `grupoAlumno` ADD FOREIGN KEY (matriculaAlumno) REFERENCES `alumno` (`matriculaAlumno`);
ALTER TABLE `periodoEscolar` ADD FOREIGN KEY (crn) REFERENCES `grupo` (`crn`);
ALTER TABLE `profesor` ADD FOREIGN KEY (idDepartamento) REFERENCES `departamento` (`idDepartamento`);
ALTER TABLE `profesor` ADD FOREIGN KEY (crn) REFERENCES `grupo` (`crn`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `grupo` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `alumno` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `listaPregunta` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `alumnoPregunta` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `alumnoComenta` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `materia` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `departamento` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `listaComentario` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `listaRespuesta` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `grupoAlumno` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `periodoEscolar` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `profesor` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `grupo` (`crn`,`clave`,`matriculaMaestro`) VALUES
-- ('','','');
-- INSERT INTO `alumno` (`matriculaAlumno`,`nombre`,`apellidoPaterno`,`apellidoMaterno`) VALUES
-- ('','','','');
-- INSERT INTO `listaPregunta` (`idPregunta`,`pregunta`,`crn`) VALUES
-- ('','','');
-- INSERT INTO `alumnoPregunta` (`matriculaAlumno`,`idPregunta`,`crn`,`pregunta`) VALUES
-- ('','','','');
-- INSERT INTO `alumnoComenta` (`matriculaAlumno`,`idComentario`,`crn`,`comentario`) VALUES
-- ('','','','');
-- INSERT INTO `materia` (`clave`,`nombreMateria`,`idDepartamento`,`crn`) VALUES
-- ('','','','');
-- INSERT INTO `departamento` (`idDepartamento`,`nombreDepartamento`) VALUES
-- ('','');
-- INSERT INTO `listaComentario` (`idComentario`,`comentario`,`crn`) VALUES
-- ('','','');
-- INSERT INTO `listaRespuesta` (`idRespuesta`,`respuesta`,`idPregunta`,`crn`) VALUES
-- ('','','','');
-- INSERT INTO `grupoAlumno` (`crn`,`matriculaAlumno`) VALUES
-- ('','');
-- INSERT INTO `periodoEscolar` (`idPeriodo`,`fechaInicio`,`fechaFin`,`crn`) VALUES
-- ('','','','');
-- INSERT INTO `profesor` (`matriculaMaestro`,`idDepartamento`,`nombre`,`apellidoPaterno`,`apellidoMaterno`,`crn`) VALUES
-- ('','','','','','');