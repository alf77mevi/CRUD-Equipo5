import DBconfig from "../src/index.js";
import express from "express";
import sql from "mssql";

const router = express.Router();

router.get("/", async (req, res) => {
  try {
    await sql.connect(DBconfig);
    const result = await sql.query("SELECT * FROM departamento");
    res.send(result.recordset);
  } catch (err) {
    console.error(err);
  }
});

router.post("/", async (req, res) => {
  try {
    await sql.connect(DBconfig);
    const dpto = req.body;
    res.send(
      `Agregando el departamento: ${dpto.nombreDepartamento} con ID: ${dpto.idDepartamento}`,
    );

    const transaction = new sql.Transaction();
    await transaction.begin();

    const request = transaction.request();
    request.input("idDepartamento", sql.Int, dpto.idDepartamento);
    request.input("nombreDepartamento", sql.NVarChar, dpto.nombreDepartamento);

    await request.query(
      "INSERT INTO departamento (idDepartamento, nombreDepartamento) VALUES (@idDepartamento, @nombreDepartamento)",
    );
    await transaction.commit();
  } catch (error) {
    console.error("No se ejecuto la transaccion:", error);
    await transaction.rollback();
  } finally {
    sql.close();
  }
});

export default router;
