# 🚀 Guía de Inicio Rápido

## Pasos para ejecutar el proyecto

### 1️⃣ Instalar dependencias
```bash
pnpm install
```

### 2️⃣ Configurar MySQL
Asegúrate de que MySQL esté ejecutándose con:
- **Usuario**: `root`
- **Contraseña**: `root`
- **Puerto**: `3306`

### 3️⃣ Crear la base de datos
```bash
cd mysql-script
generate-database-mysql.cmd
cd ..
```

### 4️⃣ Iniciar el servidor
```bash
pnpm run start:dev
```

Espera a que veas el mensaje:
```
Application is running on: http://[::1]:3000
```

## 🧪 Probar la API

### Opción 1: Usar el archivo test.http
1. Abre `test.http` en VS Code
2. Instala la extensión "REST Client" si no la tienes
3. Haz clic en "Send Request" sobre cada petición

### Opción 2: Usar cURL desde la terminal

```bash
# Listar usuarios
curl http://localhost:3000/users

# Obtener un usuario
curl http://localhost:3000/users/1

# Crear un usuario
curl -X POST http://localhost:3000/users ^
  -H "Content-Type: application/json" ^
  -d "{\"first\":\"Test\",\"last\":\"User\",\"email\":\"test@email.com\"}"

# Actualizar un usuario
curl -X PUT http://localhost:3000/users/1 ^
  -H "Content-Type: application/json" ^
  -d "{\"hobby\":\"Programación\"}"

# Eliminar un usuario
curl -X DELETE http://localhost:3000/users/5
```

### Opción 3: Usar Postman
1. Importa la colección desde `API_DOCUMENTATION.md`
2. Ejecuta las peticiones

## 📊 Estructura de Datos

### Crear Usuario (POST /users)
```json
{
  "first": "Nombre",           // Requerido
  "last": "Apellido",          // Requerido
  "email": "email@test.com",   // Requerido, único
  "phone": "555-1234",         // Opcional
  "location": "Ciudad, País",  // Opcional
  "hobby": "Hobby"             // Opcional
}
```

### Actualizar Usuario (PUT /users/:id)
```json
{
  "first": "Nuevo Nombre",     // Todos los campos
  "hobby": "Nuevo Hobby"       // son opcionales
}
```

## ✅ Endpoints Implementados

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/users` | Lista todos los usuarios |
| GET | `/users/:id` | Obtiene un usuario por ID |
| POST | `/users` | Crea un nuevo usuario |
| PUT | `/users/:id` | Actualiza un usuario |
| DELETE | `/users/:id` | Elimina un usuario |

## 🐛 Solución de Problemas

### Error: Cannot connect to MySQL
- Verifica que MySQL esté ejecutándose
- Verifica las credenciales en `src/app.module.ts`

### Error: Database 'crud_db' doesn't exist
- Ejecuta el script: `cd mysql-script && generate-database-mysql.cmd`

### Error: Port 3000 already in use
- Detén otros servidores en el puerto 3000
- O cambia el puerto en `src/main.ts`

## 📖 Documentación Completa

Ver [API_DOCUMENTATION.md](./API_DOCUMENTATION.md) para más detalles.

