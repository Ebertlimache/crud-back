-- Eliminar tabla si existe
DROP TABLE IF EXISTS Users;

-- Crear tabla Users
CREATE TABLE Users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first VARCHAR(100) NOT NULL,
  last VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(20),
  location VARCHAR(200),
  hobby VARCHAR(150)
);

-- Insertar datos de ejemplo
INSERT INTO Users (first, last, email, phone, location, hobby) VALUES
  ('Juan', 'Pérez', 'juan.perez@email.com', '555-0123', 'Lima, Perú', 'Fotografía'),
  ('María', 'González', 'maria.gonzalez@email.com', '555-0456', 'Buenos Aires, Argentina', 'Cocina'),
  ('Carlos', 'López', 'carlos.lopez@email.com', '555-0789', 'Ciudad de México, México', 'Música'),
  ('Ana', 'Martínez', 'ana.martinez@email.com', '555-0321', 'Madrid, España', 'Deportes'),
  ('Luis', 'Rodríguez', 'luis.rodriguez@email.com', '555-0654', 'Bogotá, Colombia', 'Lectura');