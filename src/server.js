import sql from 'mssql';
import dotenv from 'dotenv';
dotenv.config();

const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  trustServerCertificate: true, 
};

async function customQuery(customQuery) {
  try{
    const conection = await sql.connect(config); 
    const q = await conection.query(customQuery); 
    conection.close();
    return q.recordsets;
  } catch (err){
    console.error(err);
    conection.close();
  }
}
let test = await customQuery("Select * from grupo");
console.log(test);  