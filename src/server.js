import express from "express";
import sql from "mssql";

// Configuración de 
const config = ({
    user: 'sa', 
    password: 'YourPassword123!',
    server: 'localhost', 
    database: 'Highpoint',
    trustServerCertificate: true
});

// Crear la conexión a la base de datos
const poolPromise = new sql.ConnectionPool(config)
  .connect()
  .then(pool => {
    console.log("conectado a sql");
    return pool;
  })
  .catch(err => console.error("error: ", err));

const app = express();
const puerto = 3000;
app.use(express.json()); 

//Funciones para el manejo de operaciones con los departamentos (obtener todos, agregar uno nuevo...)
app.get("/departamentos", async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query("SELECT * FROM departamento");
    res.json(result.recordset);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//Lo mismo pero para alumnos
app.get("/alumnos", async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query("SELECT * FROM alumno");
    res.json(result.recordset);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


// Iniciar el servidor
app.listen(puerto, () => console.log(`Servidor en localhost:${puerto}`));
