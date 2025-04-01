import express from "express";
import bodyParser from "body-parser";
import departamentos from "../routes/departamento.js";

const app = express();
const PUERTO = 3000; 

app.use(bodyParser.json()); 
app.use('/departamentos', departamentos)
app.listen(PUERTO, () => console.log(`Servidor activo en http://localhost:${PUERTO}`));

const DBconfig = ({
  user: 'sa', 
  password: 'YourPassword123!',
  server: 'localhost', 
  database: 'Highpoint',
  trustServerCertificate: true
});
export default DBconfig;