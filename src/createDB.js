import sql from 'mssql'

const config = ({
  user: 'sa', 
  password: 'YourPassword123!',
  server: 'localhost', 
  database: 'TestDB',
  trustServerCertificate: true
});

async function readTable(table) {
  try{
    const conection = await sql.connect(config); 
    const result = await conection.query(`SELECT * FROM ${table}`); 
    conection.close();
    return result.recordset; 
  } catch (err){
    console.error(err);
    conection.close();
  }
}

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

customQuery("INSERT INTO Productos (Nombre, Precio) VALUES ('Laptop', 1500.00)")
let test = await customQuery("Select * from Productos");
console.log(test);  