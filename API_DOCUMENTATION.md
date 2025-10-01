# API REST - CRUD de Usuarios

## Descripción
API REST desarrollada con NestJS para la gestión de usuarios (CRUD completo) con base de datos MySQL.

## Base de Datos

### Estructura
- **Base de datos**: `crud_db`
- **Tabla**: `Users`

### Columnas de la tabla Users:
- `id` (INT, PK, autoincremental)
- `first` (VARCHAR 100) - Nombre
- `last` (VARCHAR 100) - Apellido
- `email` (VARCHAR 150, UNIQUE) - Correo electrónico
- `phone` (VARCHAR 20) - Teléfono
- `location` (VARCHAR 200) - Ubicación
- `hobby` (VARCHAR 150) - Pasatiempo

## Configuración e Instalación

### 1. Instalar dependencias
```bash
pnpm install
```

### 2. Configurar MySQL
Asegúrate de tener MySQL instalado y ejecutándose con las siguientes credenciales:
- **Usuario**: root
- **Contraseña**: root
- **Puerto**: 3306

Si tus credenciales son diferentes, edita `src/app.module.ts` en la configuración de TypeORM.

### 3. Crear la base de datos
Ejecuta el script de generación de base de datos:
```bash
cd mysql-script
generate-database-mysql.cmd
```

Este script:
- Elimina la base de datos `crud_db` si existe
- Crea una nueva base de datos `crud_db`
- Crea la tabla `Users` con la estructura requerida
- Inserta 5 usuarios de ejemplo

### 4. Iniciar el servidor
```bash
pnpm run start:dev
```

El servidor estará disponible en: `http://localhost:3000`

## Endpoints REST

### 1. GET /users
**Descripción**: Listar todos los usuarios

**Request**:
```http
GET http://localhost:3000/users
```

**Response** (200 OK):
```json
[
  {
    "id": 1,
    "first": "Juan",
    "last": "Pérez",
    "email": "juan.perez@email.com",
    "phone": "555-0123",
    "location": "Lima, Perú",
    "hobby": "Fotografía"
  },
  {
    "id": 2,
    "first": "María",
    "last": "González",
    "email": "maria.gonzalez@email.com",
    "phone": "555-0456",
    "location": "Buenos Aires, Argentina",
    "hobby": "Cocina"
  }
]
```

---

### 2. GET /users/:id
**Descripción**: Obtener un usuario por ID

**Request**:
```http
GET http://localhost:3000/users/1
```

**Response** (200 OK):
```json
{
  "id": 1,
  "first": "Juan",
  "last": "Pérez",
  "email": "juan.perez@email.com",
  "phone": "555-0123",
  "location": "Lima, Perú",
  "hobby": "Fotografía"
}
```

**Response** (404 Not Found) - Usuario no encontrado:
```json
{
  "statusCode": 404,
  "message": "Usuario con ID 99 no encontrado",
  "error": "Not Found"
}
```

---

### 3. POST /users
**Descripción**: Agregar un nuevo usuario

**Request**:
```http
POST http://localhost:3000/users
Content-Type: application/json

{
  "first": "Pedro",
  "last": "Sánchez",
  "email": "pedro.sanchez@email.com",
  "phone": "555-9999",
  "location": "Barcelona, España",
  "hobby": "Ciclismo"
}
```

**Campos requeridos**:
- `first` (string, máx. 100 caracteres)
- `last` (string, máx. 100 caracteres)
- `email` (string válido, máx. 150 caracteres, único)

**Campos opcionales**:
- `phone` (string, máx. 20 caracteres)
- `location` (string, máx. 200 caracteres)
- `hobby` (string, máx. 150 caracteres)

**Response** (201 Created):
```json
{
  "id": 6,
  "first": "Pedro",
  "last": "Sánchez",
  "email": "pedro.sanchez@email.com",
  "phone": "555-9999",
  "location": "Barcelona, España",
  "hobby": "Ciclismo"
}
```

**Response** (400 Bad Request) - Validación fallida:
```json
{
  "statusCode": 400,
  "message": [
    "first should not be empty",
    "email must be an email"
  ],
  "error": "Bad Request"
}
```

---

### 4. PUT /users/:id
**Descripción**: Editar un usuario existente

**Request**:
```http
PUT http://localhost:3000/users/1
Content-Type: application/json

{
  "first": "Juan Carlos",
  "location": "Cusco, Perú",
  "hobby": "Fotografía de naturaleza"
}
```

**Nota**: Todos los campos son opcionales en la actualización. Solo se actualizan los campos enviados.

**Response** (200 OK):
```json
{
  "id": 1,
  "first": "Juan Carlos",
  "last": "Pérez",
  "email": "juan.perez@email.com",
  "phone": "555-0123",
  "location": "Cusco, Perú",
  "hobby": "Fotografía de naturaleza"
}
```

**Response** (404 Not Found) - Usuario no encontrado:
```json
{
  "statusCode": 404,
  "message": "Usuario con ID 99 no encontrado",
  "error": "Not Found"
}
```

---

### 5. DELETE /users/:id
**Descripción**: Eliminar un usuario

**Request**:
```http
DELETE http://localhost:3000/users/1
```

**Response** (204 No Content):
Sin contenido en la respuesta.

**Response** (404 Not Found) - Usuario no encontrado:
```json
{
  "statusCode": 404,
  "message": "Usuario con ID 99 no encontrado",
  "error": "Not Found"
}
```

## Ejemplos con cURL

### Listar todos los usuarios
```bash
curl http://localhost:3000/users
```

### Obtener un usuario
```bash
curl http://localhost:3000/users/1
```

### Crear un usuario
```bash
curl -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d "{\"first\":\"Pedro\",\"last\":\"Sánchez\",\"email\":\"pedro.sanchez@email.com\",\"phone\":\"555-9999\",\"location\":\"Barcelona, España\",\"hobby\":\"Ciclismo\"}"
```

### Actualizar un usuario
```bash
curl -X PUT http://localhost:3000/users/1 \
  -H "Content-Type: application/json" \
  -d "{\"first\":\"Juan Carlos\",\"hobby\":\"Fotografía de naturaleza\"}"
```

### Eliminar un usuario
```bash
curl -X DELETE http://localhost:3000/users/1
```

## Validaciones Implementadas

La API incluye validaciones automáticas para:

- **first**: String requerido, máximo 100 caracteres
- **last**: String requerido, máximo 100 caracteres
- **email**: Email válido requerido, máximo 150 caracteres, debe ser único
- **phone**: String opcional, máximo 20 caracteres
- **location**: String opcional, máximo 200 caracteres
- **hobby**: String opcional, máximo 150 caracteres

## Tecnologías Utilizadas

- **NestJS**: Framework de Node.js
- **TypeORM**: ORM para TypeScript
- **MySQL2**: Driver de MySQL
- **class-validator**: Validación de DTOs
- **class-transformer**: Transformación de objetos

## Estructura del Proyecto

```
problema1-backend/
├── mysql-script/
│   ├── generate-database-mysql.cmd  # Script para crear la BD
│   └── script-mysql.sql             # Script SQL
├── src/
│   ├── dto/
│   │   ├── create-user.dto.ts       # DTO para crear usuario
│   │   └── update-user.dto.ts       # DTO para actualizar usuario
│   ├── entities/
│   │   └── user.entity.ts           # Entidad User de TypeORM
│   ├── users/
│   │   ├── users.controller.ts      # Controlador REST
│   │   ├── users.service.ts         # Lógica de negocio
│   │   └── users.module.ts          # Módulo de usuarios
│   ├── app.module.ts                # Módulo principal
│   └── main.ts                      # Punto de entrada
├── package.json
└── README.md
```

## Notas Importantes

1. **Sincronización de TypeORM**: Está configurada como `synchronize: false` para usar el esquema de la base de datos existente creado por el script SQL.

2. **CORS**: Está habilitado para permitir peticiones desde cualquier origen.

3. **Validación Global**: Implementada con `ValidationPipe` para validar automáticamente todos los DTOs.

4. **Transformación de datos**: Habilitada para convertir automáticamente los parámetros de ruta (como `:id`) a números.

## Solución de Problemas

### Error de conexión a MySQL
- Verifica que MySQL esté ejecutándose
- Verifica las credenciales en `src/app.module.ts`
- Verifica que la base de datos `crud_db` exista

### Error "Usuario con ID X no encontrado"
- Verifica que el ID exista en la base de datos
- Asegúrate de haber ejecutado el script SQL inicial

### Error de validación
- Verifica que todos los campos requeridos estén presentes
- Verifica que el formato del email sea válido
- Verifica que no se exceda el tamaño máximo de los campos

