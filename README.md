# CRUD-Equipo5

REST API para operaciones CRUD utilizando Node y Express.js

Método de utilización
1) Inicializar un nuevo codespace (tambien se puede realizar de manera local luego de clonar el repositorio)

2) Inicializar las dependencias de npm <br>
``` $ npm install ``` <br>

3) Crear una instancia de SqlServer con docker <br>
``` docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourPassword123!' \
   -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2022-latest ```