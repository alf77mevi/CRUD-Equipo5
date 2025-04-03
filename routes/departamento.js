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

router.get("/:id", async (req, res) => {
  let transaction;
  try {
    await sql.connect(DBconfig);
    const idQuery = parseInt(req.params.id);

    if (!idQuery) {
      res.send("ID NO VALIDO");
    } else {
      transaction = new sql.Transaction();
      await transaction.begin();
      const request = new sql.Request(transaction);
      request.input("searchID", sql.Int, idQuery);

      const result = await request.query(
        "SELECT * FROM departamento WHERE idDepartamento = @searchID",
      );
      if (result.recordset.length) {
        res.send(result.recordset);
      } else {
        res.send("EL ID NO EXISTE");
      }
      await transaction.commit();
    }
  } catch (error) {
    console.error("No se ejecuto la transaccion:", error);
    await transaction.rollback();
  } finally {
    sql.close();
  }
});

router.post("/", async (req, res) => {
  let transaction;
  try {
    await sql.connect(DBconfig);
    const dpto = req.body;
    res.send(
      `Agregando el departamento: ${dpto.nombreDepartamento} con ID: ${dpto.idDepartamento}`,
    );

    transaction = new sql.Transaction();
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

router.delete("/:id", async (req, res) => {
  let transaction;
  try {
    await sql.connect(DBconfig);
    const idQuery = parseInt(req.params.id);

    if (!idQuery) {
      res.send("ID NO VALIDO");
    } else {
      transaction = new sql.Transaction();

      await transaction.begin();
      const request = new sql.Request(transaction);
      request.input("searchID", sql.Int, idQuery);

      const depToDelete = await request.query(
        "SELECT * FROM departamento WHERE idDepartamento = @searchID",
      );
      if (depToDelete.recordset.length) {
        const result = await request.query(
          "DELETE FROM departamento WHERE idDepartamento = @searchID",
        );
        res.send(`Se elimino el departamento con id ${idQuery}`);
      } else {
        res.send(`No existe un departamento con id ${idQuery}`);
      }

      await transaction.commit();
    }
  } catch (error) {
    console.error("No se ejecuto la transaccion:", error);
    await transaction.rollback();
  } finally {
    sql.close();
  }
});

router.patch("/:id", async (req, res) => {
  let transaction;
  try {
    await sql.connect(DBconfig);
    const idQuery = parseInt(req.params.id);

    if (!idQuery) {
      res.send("ID NO VALIDO");
    } else {
      transaction = new sql.Transaction();
      await transaction.begin();
      const request = new sql.Request(transaction);
      request.input("searchID", sql.Int, idQuery);

      let user = await request.query(
        "SELECT * FROM departamento WHERE idDepartamento = @searchID",
      );

      if (user.recordset.length) {
        const { nombreDepartamento } = req.body;
        request.input("nombreDepartamento", sql.VarChar, nombreDepartamento);
        await request.query(
          "UPDATE departamento SET nombreDepartamento = @nombreDepartamento WHERE idDepartamento = @searchID",
        );
        user = await request.query(
          "SELECT * FROM departamento WHERE idDepartamento = @searchID",
        );
        res.send(user.recordset);
      } else {
        res.send("ID INVALIDO");
      }
      await transaction.commit();
    }
  } catch (error) {
    console.error("No se ejecuto la transaccion:", error);
    await transaction.rollback();
  } finally {
    sql.close();
  }
});

export default router;