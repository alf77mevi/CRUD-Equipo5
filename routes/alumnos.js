import DBconfig from "../src/index.js";
import express from "express";
import sql from "mssql";

const router = express.Router();

router.get("/", async (req, res) => {
    try{
        await sql.connect(DBconfig);
        const result = await sql.query("SELECT * FROM alumno");
        res.send(result.recordset);
    } catch(err){
        console.error(err);
    }
});

export default router;