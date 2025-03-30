IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Highpoint')
BEGIN
    CREATE DATABASE Highpoint;
END;
GO

USE Highpoint;
GO

-- Tabla grupo
DROP TABLE IF EXISTS grupo;
CREATE TABLE grupo (
  crn VARCHAR(15) NOT NULL PRIMARY KEY,
  clave VARCHAR(15) NOT NULL,
  matriculaMaestro VARCHAR(10) NOT NULL
);
  
-- Tabla alumno
DROP TABLE IF EXISTS alumno;
CREATE TABLE alumno (
  matriculaAlumno VARCHAR(10) NOT NULL PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  apellidoPaterno VARCHAR(30) NOT NULL,
  apellidoMaterno VARCHAR(30) NOT NULL
);

-- Tabla listaPregunta
DROP TABLE IF EXISTS listaPregunta;
CREATE TABLE listaPregunta (
  idPregunta INT NOT NULL PRIMARY KEY,
  pregunta INT NOT NULL,
  crn VARCHAR(15) NOT NULL
);

-- Tabla alumnoPregunta
DROP TABLE IF EXISTS alumnoPregunta;
CREATE TABLE alumnoPregunta (
  matriculaAlumno VARCHAR(10) NOT NULL,
  idPregunta INT NOT NULL,
  crn VARCHAR(15) NOT NULL,
  pregunta INT NOT NULL,
  PRIMARY KEY (matriculaAlumno, idPregunta)
);

-- Tabla alumnoComenta
DROP TABLE IF EXISTS alumnoComenta;
CREATE TABLE alumnoComenta (
  matriculaAlumno VARCHAR(10) NOT NULL,
  idComentario INT NOT NULL,
  crn VARCHAR(15) NOT NULL,
  comentario VARCHAR(250) NOT NULL,
  PRIMARY KEY (matriculaAlumno, idComentario)
);

-- Tabla materia
DROP TABLE IF EXISTS materia;
CREATE TABLE materia (
  clave VARCHAR(15) NOT NULL PRIMARY KEY,
  nombreMateria VARCHAR(30) NOT NULL,
  idDepartamento INT NOT NULL,
  crn VARCHAR(15) NOT NULL
);

-- Tabla departamento
DROP TABLE IF EXISTS departamento;
CREATE TABLE departamento (
  idDepartamento INT NOT NULL PRIMARY KEY,
  nombreDepartamento VARCHAR(30) NOT NULL
);

-- Tabla listaComentario
DROP TABLE IF EXISTS listaComentario;
CREATE TABLE listaComentario (
  idComentario INT NOT NULL PRIMARY KEY,
  comentario VARCHAR(15) NOT NULL,
  crn VARCHAR(15) NOT NULL
);

-- Tabla listaRespuesta
DROP TABLE IF EXISTS listaRespuesta;
CREATE TABLE listaRespuesta (
  idRespuesta INT NOT NULL PRIMARY KEY,
  respuesta INT NOT NULL,
  idPregunta INT NOT NULL,
  crn VARCHAR(15) NOT NULL
);

-- Tabla grupoAlumno
DROP TABLE IF EXISTS grupoAlumno;
CREATE TABLE grupoAlumno (
  crn VARCHAR(15) NOT NULL,
  matriculaAlumno VARCHAR(10) NOT NULL,
  PRIMARY KEY (crn, matriculaAlumno)
);

-- Tabla periodoEscolar
DROP TABLE IF EXISTS periodoEscolar;
CREATE TABLE periodoEscolar (
  idPeriodo INT NOT NULL PRIMARY KEY,
  fechaInicio DATETIME NOT NULL,
  fechaFin DATETIME NOT NULL,
  crn VARCHAR(15) NOT NULL
);

-- Tabla profesor
DROP TABLE IF EXISTS profesor;
CREATE TABLE profesor (
  matriculaMaestro VARCHAR(10) NOT NULL PRIMARY KEY,
  idDepartamento INT NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  apellidoPaterno VARCHAR(30) NOT NULL,
  apellidoMaterno VARCHAR(30) NOT NULL,
  crn VARCHAR(15) NOT NULL
);

-- Foreign Keys
ALTER TABLE grupo ADD FOREIGN KEY (clave) REFERENCES materia (clave);
ALTER TABLE listaPregunta ADD FOREIGN KEY (crn) REFERENCES grupo (crn);
ALTER TABLE alumnoPregunta ADD FOREIGN KEY (matriculaAlumno) REFERENCES alumno (matriculaAlumno);
ALTER TABLE alumnoPregunta ADD FOREIGN KEY (idPregunta) REFERENCES listaPregunta (idPregunta);
ALTER TABLE alumnoPregunta ADD FOREIGN KEY (crn) REFERENCES grupo (crn);
ALTER TABLE alumnoComenta ADD FOREIGN KEY (matriculaAlumno) REFERENCES alumno (matriculaAlumno);
ALTER TABLE alumnoComenta ADD FOREIGN KEY (idComentario) REFERENCES listaComentario (idComentario);
ALTER TABLE alumnoComenta ADD FOREIGN KEY (crn) REFERENCES grupo (crn);
ALTER TABLE materia ADD FOREIGN KEY (idDepartamento) REFERENCES departamento (idDepartamento);
ALTER TABLE materia ADD FOREIGN KEY (crn) REFERENCES grupo (crn);
ALTER TABLE listaRespuesta ADD FOREIGN KEY (idPregunta) REFERENCES listaPregunta (idPregunta);
ALTER TABLE listaRespuesta ADD FOREIGN KEY (crn) REFERENCES grupo (crn);
ALTER TABLE grupoAlumno ADD FOREIGN KEY (matriculaAlumno) REFERENCES alumno (matriculaAlumno);
ALTER TABLE periodoEscolar ADD FOREIGN KEY (crn) REFERENCES grupo (crn);
ALTER TABLE profesor ADD FOREIGN KEY (idDepartamento) REFERENCES departamento (idDepartamento);
ALTER TABLE profesor ADD FOREIGN KEY (crn) REFERENCES grupo (crn);
