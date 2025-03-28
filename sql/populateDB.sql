USE Highpoint;
GO

-- First, clear all tables in reverse order of dependencies
-- Note: We need to disable constraints temporarily to clear the tables
ALTER TABLE alumnoPregunta NOCHECK CONSTRAINT ALL;
ALTER TABLE alumnoComenta NOCHECK CONSTRAINT ALL;
ALTER TABLE listaRespuesta NOCHECK CONSTRAINT ALL;
ALTER TABLE listaPregunta NOCHECK CONSTRAINT ALL;
ALTER TABLE listaComentario NOCHECK CONSTRAINT ALL;
ALTER TABLE grupoAlumno NOCHECK CONSTRAINT ALL;
ALTER TABLE periodoEscolar NOCHECK CONSTRAINT ALL;
ALTER TABLE profesor NOCHECK CONSTRAINT ALL;
ALTER TABLE grupo NOCHECK CONSTRAINT ALL;
ALTER TABLE materia NOCHECK CONSTRAINT ALL;

DELETE FROM alumnoPregunta;
DELETE FROM alumnoComenta;
DELETE FROM listaRespuesta;
DELETE FROM listaPregunta;
DELETE FROM listaComentario;
DELETE FROM grupoAlumno;
DELETE FROM periodoEscolar;
DELETE FROM alumno;
DELETE FROM profesor;
DELETE FROM grupo;
DELETE FROM materia;
DELETE FROM departamento;

-- Re-enable constraints
ALTER TABLE alumnoPregunta CHECK CONSTRAINT ALL;
ALTER TABLE alumnoComenta CHECK CONSTRAINT ALL;
ALTER TABLE listaRespuesta CHECK CONSTRAINT ALL;
ALTER TABLE listaPregunta CHECK CONSTRAINT ALL;
ALTER TABLE listaComentario CHECK CONSTRAINT ALL;
ALTER TABLE grupoAlumno CHECK CONSTRAINT ALL;
ALTER TABLE periodoEscolar CHECK CONSTRAINT ALL;
ALTER TABLE profesor CHECK CONSTRAINT ALL;
ALTER TABLE grupo CHECK CONSTRAINT ALL;
ALTER TABLE materia CHECK CONSTRAINT ALL;
GO

-- Insert departments first (no dependencies)
INSERT INTO departamento (idDepartamento, nombreDepartamento) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Engineering'),
(5, 'Business');
GO

-- Insert students (no dependencies)
INSERT INTO alumno (matriculaAlumno, nombre, apellidoPaterno, apellidoMaterno) VALUES
('A1001', 'Alice', 'Johnson', 'Smith'),
('A1002', 'Bob', 'Lee', 'Garcia'),
('A1003', 'Charlie', 'Brown', 'Williams'),
('A1004', 'Diana', 'Miller', 'Davis'),
('A1005', 'Ethan', 'Wilson', 'Martinez');
GO

-- Insert courses (materia) - depends only on department
INSERT INTO materia (clave, nombreMateria, idDepartamento, crn) VALUES
('CS101', 'Introduction to Programming', 1, NULL),
('MATH201', 'Calculus I', 2, NULL),
('PHYS301', 'Classical Mechanics', 3, NULL),
('ENG401', 'Electrical Circuits', 4, NULL),
('BUS501', 'Marketing Principles', 5, NULL);
GO

-- Insert professors (depends on department)
INSERT INTO profesor (matriculaMaestro, idDepartamento, nombre, apellidoPaterno, apellidoMaterno, crn) VALUES
('PROF001', 1, 'John', 'Smith', 'Johnson', NULL),
('PROF002', 2, 'Maria', 'Garcia', 'Lopez', NULL),
('PROF003', 3, 'Robert', 'Williams', 'Brown', NULL),
('PROF004', 4, 'Jennifer', 'Davis', 'Miller', NULL),
('PROF005', 5, 'Michael', 'Martinez', 'Jones', NULL);
GO

-- Now insert groups (depends on materia and profesor)
INSERT INTO grupo (crn, clave, matriculaMaestro) VALUES
('CRN1001', 'CS101', 'PROF001'),
('CRN1002', 'MATH201', 'PROF002'),
('CRN1003', 'PHYS301', 'PROF003'),
('CRN1004', 'ENG401', 'PROF004'),
('CRN1005', 'BUS501', 'PROF005');
GO

-- Now update materia with correct CRNs
UPDATE materia SET crn = 'CRN1001' WHERE clave = 'CS101';
UPDATE materia SET crn = 'CRN1002' WHERE clave = 'MATH201';
UPDATE materia SET crn = 'CRN1003' WHERE clave = 'PHYS301';
UPDATE materia SET crn = 'CRN1004' WHERE clave = 'ENG401';
UPDATE materia SET crn = 'CRN1005' WHERE clave = 'BUS501';
GO

-- Update professor records with correct CRNs
UPDATE profesor SET crn = 'CRN1001' WHERE matriculaMaestro = 'PROF001';
UPDATE profesor SET crn = 'CRN1002' WHERE matriculaMaestro = 'PROF002';
UPDATE profesor SET crn = 'CRN1003' WHERE matriculaMaestro = 'PROF003';
UPDATE profesor SET crn = 'CRN1004' WHERE matriculaMaestro = 'PROF004';
UPDATE profesor SET crn = 'CRN1005' WHERE matriculaMaestro = 'PROF005';
GO

-- Enroll students in groups (depends on grupo and alumno)
INSERT INTO grupoAlumno (crn, matriculaAlumno) VALUES
('CRN1001', 'A1001'),
('CRN1001', 'A1002'),
('CRN1002', 'A1002'),
('CRN1002', 'A1003'),
('CRN1003', 'A1003'),
('CRN1003', 'A1004'),
('CRN1004', 'A1004'),
('CRN1004', 'A1005'),
('CRN1005', 'A1005'),
('CRN1005', 'A1001');
GO

-- Add academic periods (depends on grupo)
INSERT INTO periodoEscolar (idPeriodo, fechaInicio, fechaFin, crn) VALUES
(1, '2023-01-10', '2023-05-15', 'CRN1001'),
(2, '2023-01-10', '2023-05-15', 'CRN1002'),
(3, '2023-01-10', '2023-05-15', 'CRN1003'),
(4, '2023-01-10', '2023-05-15', 'CRN1004'),
(5, '2023-01-10', '2023-05-15', 'CRN1005');
GO

-- Create some questions (depends on grupo)
INSERT INTO listaPregunta (idPregunta, pregunta, crn) VALUES
(1, 1, 'CRN1001'), -- Question 1 for CS101
(2, 2, 'CRN1001'), -- Question 2 for CS101
(3, 1, 'CRN1002'), -- Question 1 for MATH201
(4, 2, 'CRN1002'), -- Question 2 for MATH201
(5, 1, 'CRN1003'); -- Question 1 for PHYS301
GO

-- Create some answers (depends on listaPregunta and grupo)
INSERT INTO listaRespuesta (idRespuesta, respuesta, idPregunta, crn) VALUES
(1, 1, 1, 'CRN1001'), -- Answer 1 for Question 1
(2, 2, 1, 'CRN1001'), -- Answer 2 for Question 1
(3, 1, 2, 'CRN1001'), -- Answer 1 for Question 2
(4, 1, 3, 'CRN1002'), -- Answer 1 for Question 3
(5, 2, 4, 'CRN1002'); -- Answer 2 for Question 4
GO

-- Create some comments (depends on grupo)
INSERT INTO listaComentario (idComentario, comentario, crn) VALUES
(1, 'Great course!', 'CRN1001'),
(2, 'Very challenging', 'CRN1002'),
(3, 'Excellent professor', 'CRN1003'),
(4, 'Needs more examples', 'CRN1004'),
(5, 'Too much homework', 'CRN1005');
GO

-- Record student questions (depends on alumno, listaPregunta, grupo)
INSERT INTO alumnoPregunta (matriculaAlumno, idPregunta, crn, pregunta) VALUES
('A1001', 1, 'CRN1001', 1),
('A1002', 2, 'CRN1001', 2),
('A1002', 3, 'CRN1002', 1),
('A1003', 4, 'CRN1002', 2),
('A1004', 5, 'CRN1003', 1);
GO

-- Record student comments (depends on alumno, listaComentario, grupo)
INSERT INTO alumnoComenta (matriculaAlumno, idComentario, crn, comentario) VALUES
('A1001', 1, 'CRN1001', 'Great course!'),
('A1002', 2, 'CRN1002', 'Very challenging'),
('A1003', 3, 'CRN1003', 'Excellent professor'),
('A1004', 4, 'CRN1004', 'Needs more examples'),
('A1005', 5, 'CRN1005', 'Too much homework');
GO

PRINT 'Database populated successfully with all constraints satisfied!';