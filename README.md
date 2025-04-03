# CRUD-Equipo5 - REST API para operaciones CRUD utilizando Node y Express.js

## Método de utilización (utilizando la ruta de departamento como ejemplo)

### 1) Inicializar un nuevo codespace (tambien se puede realizar de manera local luego de clonar el repositorio)

### 2) Inicializar las dependencias de npm a travez de la terminal

```sh
npm install
```

### 3) Crear una instancia de SQL Server con Docker

```sh
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourPassword123!' \
    -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2022-latest
```

### 4) Instalar sqlcmd

```sh
sudo apt update
sudo apt install mssql-tools unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
```

### 5) Inicializar la base de datos utilizando sqlcmd y initDB.sql

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

### 6) Inicializar datos dentro de la base de datos

```sh
sqlcmd -S localhost -U sa -P YourPassword123! -i insertTest.sql
```

Este script de sql llena la base de datos de alumno y departamento con datos dummmy,
podemos revisar que todo este en orden utilizando sqlcmd nuevamente

```sh
sqlcmd -S localhost -U sa -P YourPassword123!
> USE Highpoint
> SELECT * FROM departamento
> SELECT * FROM alumno
> GO
```

Deberiamos de poder ver los nuevos datos dentro de la base de datos

### 7) Iniciar el servidor

```sh
npm run start
```

Esperando el mensaje en terminal

```sh
Servidor activo en http://localhost:3000
```

Si realizamos una petición GET a travez de nuestro navegador, visitando el enlace `http://localhost:3000/departamentos` 
deberiamos de poder observar los datos que acabamos de insertar.
```sh
[
    {
    "idDepartamento": 1,
    "nombreDepartamento": "Mathematics"
    },
    {
    "idDepartamento": 2,
    "nombreDepartamento": "Computer Science"
    },
    {
    "idDepartamento": 3,
    "nombreDepartamento": "Physics"
    }
]
```
### Operaciones CRUD
Para estos ejemplos se tomara como url de nuestro API `http://localhost:3000/departamentos`, sin embargo tambien funciona si
nuestro puesto es publico, solo hay que tener el link correcto de nuestra base de datos, asegurandonos de utilizar el router `/departamentos`

Dentro del repositorio se encuentra un directorio `/ejemplosUso`
donde el archivo `peticiones.js` cuenta con un caso de uso cual emplea multiples funciones para crear, leer, eliminar y actualizar departamentos
para correrlo, debemos de tener nuestro servidor activo, y dentro de otra terminal ejecutamos `node ejemplosUso/peticiones.js ` deberiamos de obtener
un output similar al siguiente:
```sh
Leyendo todos los departamentos:
[
  { idDepartamento: 1, nombreDepartamento: 'Mathematics' },
  { idDepartamento: 2, nombreDepartamento: 'Computer Science' },
  { idDepartamento: 3, nombreDepartamento: 'Physics' }
]
Creando un nuevo departamento...
Respuesta del servidor: Agregando el departamento: Departamento de Innovación con ID: 10
Leyendo los departamentos después de la creación:
[
  { idDepartamento: 1, nombreDepartamento: 'Mathematics' },
  { idDepartamento: 2, nombreDepartamento: 'Computer Science' },
  { idDepartamento: 3, nombreDepartamento: 'Physics' },
  {
    idDepartamento: 10,
    nombreDepartamento: 'Departamento de Innovación'
  }
]
Actualizando el departamento...
http://localhost:3000/departamentos//10
Respuesta del servidor: [{"idDepartamento":10,"nombreDepartamento":"Innovación y Desarrollo"}]
Leyendo los departamentos después de la actualización:
[
  { idDepartamento: 1, nombreDepartamento: 'Mathematics' },
  { idDepartamento: 2, nombreDepartamento: 'Computer Science' },
  { idDepartamento: 3, nombreDepartamento: 'Physics' },
  { idDepartamento: 10, nombreDepartamento: 'Innovación y Desarrollo' }
]
Eliminando el departamento...
http://localhost:3000/departamentos//10
Respuesta del servidor: Se elimino el departamento con id 10
Leyendo los departamentos después de la eliminación:
[
  { idDepartamento: 1, nombreDepartamento: 'Mathematics' },
  { idDepartamento: 2, nombreDepartamento: 'Computer Science' },
  { idDepartamento: 3, nombreDepartamento: 'Physics' }
]
```
