USE Highpoint;
GO

INSERT INTO alumno (matriculaAlumno, nombre, apellidoPaterno, apellidoMaterno) VALUES
('A001', 'Carlos', 'Gómez', 'López'),
('A002', 'María', 'Fernández', 'Martínez'),
('A003', 'Juan', 'Pérez', 'Hernández'),
('A004', 'Ana', 'Rodríguez', 'García'),
('A005', 'Luis', 'Sánchez', 'Ramírez'),
('A006', 'Elena', 'Torres', 'Díaz'),
('A007', 'Miguel', 'Hernández', 'Jiménez'),
('A008', 'Sofía', 'Ruiz', 'Morales'),
('A009', 'Fernando', 'Díaz', 'Ortega'),
('A010', 'Laura', 'Mendoza', 'Castillo');
GO

-- INSERT INTO departamento (idDepartamento, nombreDepartamento) VALUES
-- (1, 'Recursos Humanos'),
-- (2, 'Finanzas'),
-- (3, 'Tecnología'),
-- (4, 'Marketing'),
-- (5, 'Ventas'),
-- (6, 'Operaciones'),
-- (7, 'Atención al Cliente'),
-- (8, 'Investigación y Desarrollo'),
-- (9, 'Logística'),
-- (10, 'Legal');
-- GO

-- SELECT * FROM departamento;
-- GO

SELECT * FROM alumno;
GO