import sql from 'mssql'

const config = ({
  user: 'sa', 
  password: 'YourPassword123!',
  server: 'localhost', 
  database: 'TestDB',
  trustServerCertificate: true
});


async function readDB () {
  const conection = await sql.connect(config);
  const content =  await conection.query("select * from Productos");
  return content;
}

readDB().then(data =>{
  console.log(data);
})