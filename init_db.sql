CREATE DATABASE TestDB;
GO

USE TestDB;
GO

CREATE TABLE Productos (
    ID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(50) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL
);
GO

INSERT INTO Productos (Nombre, Precio) VALUES ('Laptop', 1500.00);
INSERT INTO Productos (Nombre, Precio) VALUES ('Mouse', 25.50);
GO

SELECT * FROM Productos;
GO
