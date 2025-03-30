# CRUD-Equipo5

REST API para operaciones CRUD utilizando Node y Express.js

Método de utilización
1) Inicializar un nuevo codespace (tambien se puede realizar de manera local luego de clonar el repositorio)

2) Inicializar las dependencias de npm
```sh
npm install
```

3) Crear una instancia de SQL Server con Docker  
```sh
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourPassword123!' \
    -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2022-latest
```
4) Instalar sqlcmd
```sh
sudo apt update
sudo apt install mssql-tools unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
```

5) Inicializar la base de datos utilizando sqlcmd y initDB.sql
```sh
sqlcmd -S localhost -U sa -P YourPassword123! -i initDB.sql
```
Si todo sale bien, deberiamos de ver un mensaje como el siguiente
```sh 
Changed database context to 'Highpoint'.
```
Asi mismo, podemos utilizar sqlcmd para verificar que nuestra base de 
datos se haya creado de manera exitosa dentro de nuestra instancia de docker
```sh
sqlcmd -S localhost -U sa -P YourPassword123!
> SELECT name FROM sys.databases;
> GO
```
Deberiamos de obtener un resultado similar a lo siguiente
```sh
master                                                                                                                          
tempdb                                                                                                                          
model                                                                                                                           
msdb                                                                                                                            
Highpoint

(5 rows affected)     
```
