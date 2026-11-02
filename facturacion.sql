-- CREAR (de padre a hija)
CREATE TABLE IF NOT EXISTS persona (
    id INT PRIMARY KEY,
    identificacion VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100) UNIQUE,
    direccion VARCHAR(255)
);
 
 CREATE TABLE IF NOT EXISTS compania (
    id_compania SMALLINT PRIMARY KEY,
    nit VARCHAR(20) UNIQUE NOT NULL,
    nombre_compania VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS termino (
    id_termino SMALLINT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS categoria (
    id_categoria SMALLINT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS producto (
    id_producto INT PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    precio_unitario DECIMAL(12,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    id_categoria SMALLINT,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);


CREATE TABLE IF NOT EXISTS factura (
    id_factura BIGINT PRIMARY KEY,
    id_persona INT,
    id_compania SMALLINT,
    id_termino SMALLINT,
    fecha_emision DATE NOT NULL,
    hora_emision TIME NOT NULL,
    CONSTRAINT fk_persona FOREIGN KEY (id_persona) REFERENCES persona(id),
    CONSTRAINT fk_compania FOREIGN KEY (id_compania) REFERENCES compania(id_compania),
    CONSTRAINT fk_termino FOREIGN KEY (id_termino) REFERENCES termino(id_termino)
);

CREATE TABLE IF NOT EXISTS detalle_factura (
    id_factura BIGINT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_factura, id_producto),
    CONSTRAINT fk_detalle_factura FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- 1. PERSONA
INSERT INTO persona (id, identificacion, nombre, apellido, fecha_nacimiento, telefono, correo_electronico, direccion) VALUES
(1, '123456789', 'Juan', 'Pérez', '1990-01-01', '555-1234', 'juan.perez@example.com', 'Calle 123 #45-67'),
(2, '987654321', 'María', 'Gómez', '1985-05-15', '555-5678', 'maria.gomez@example.com', 'Avenida 456 #78-90'),
(3, '1090111222', 'Carlos', 'Rodríguez', '1988-03-22', '3001112233', 'carlos.rodriguez@example.com', 'Calle 8 #12-34, Cúcuta'),
(4, '1090333444', 'Ana', 'Martínez', '1992-07-30', '3012223344', 'ana.martinez@example.com', 'Avenida 5 #20-15, Cúcuta'),
(5, '1090555666', 'Luis', 'Hernández', '1979-11-09', '3023334455', 'luis.hernandez@example.com', 'Carrera 4 #7-80, Cúcuta'),
(6, '1090777888', 'Sofía', 'Ramírez', '1995-02-14', '3034445566', 'sofia.ramirez@example.com', 'Calle 15 #3-45, Cúcuta'),
(7, '1090999000', 'Andrés', 'Torres', '1983-09-18', '3045556677', 'andres.torres@example.com', 'Avenida 2 #9-10, Cúcuta'),
(8, '1091112223', 'Laura', 'Díaz', '1990-12-05', '3056667788', 'laura.diaz@example.com', 'Carrera 7 #18-22, Cúcuta'),
(9, '1091334445', 'Jorge', 'Castro', '1975-04-27', '3067778899', 'jorge.castro@example.com', 'Calle 20 #6-31, Cúcuta'),
(10, '1091556667', 'Paola', 'Vargas', '1998-08-11', '3078889900', 'paola.vargas@example.com', 'Avenida 3 #14-50, Cúcuta')
ON CONFLICT DO NOTHING;

-- 2. COMPAÑÍA
INSERT INTO compania (id_compania, nit, nombre_compania) VALUES
(1, '900123456-1', 'Confecciones Alexis'),
(2, '900234567-2', 'Textiles del Norte'),
(3, '900345678-3', 'Moda Cúcuta SAS'),
(4, '900456789-4', 'Uniformes Andinos'),
(5, '900567890-5', 'Distribuidora El Telar'),
(6, '900678901-6', 'Dotaciones Frontera'),
(7, '900789012-7', 'Estilo y Costura'),
(8, '900890123-8', 'Industrias Norandina'),
(9, '900901234-9', 'Comercial La Aguja'),
(10, '901012345-0', 'Ropa y Diseño Ltda')
ON CONFLICT DO NOTHING;

-- 3. TÉRMINO
INSERT INTO termino (id_termino, descripcion) VALUES
(1, 'Contado'),
(2, 'Crédito 15 días'),
(3, 'Crédito 30 días'),
(4, 'Crédito 45 días'),
(5, 'Crédito 60 días'),
(6, 'Transferencia'),
(7, 'Tarjeta de crédito'),
(8, 'Tarjeta débito'),
(9, 'Abono 50%'),
(10, 'Pago contra entrega')
ON CONFLICT DO NOTHING;

-- 4. CATEGORÍA
INSERT INTO categoria (id_categoria, nombre) VALUES
(1, 'Camisetas'),
(2, 'Pantalones'),
(3, 'Chaquetas'),
(4, 'Vestidos'),
(5, 'Uniformes escolares'),
(6, 'Gorras'),
(7, 'Ropa deportiva'),
(8, 'Ropa infantil'),
(9, 'Accesorios'),
(10, 'Dotación industrial')
ON CONFLICT DO NOTHING;

-- 5. PRODUCTO (id_categoria debe existir en categoria)
INSERT INTO producto (id_producto, codigo, nombre, descripcion, precio_unitario, stock, id_categoria) VALUES
(1, 'P001', 'Camiseta', 'Camiseta de algodón', 15000, 50, 1),
(2, 'P002', 'Pantalón jean', 'Pantalón en jean clásico', 55000, 30, 2),
(3, 'P003', 'Chaqueta', 'Chaqueta impermeable', 85000, 20, 3),
(4, 'P004', 'Vestido', 'Vestido casual de verano', 65000, 25, 4),
(5, 'P005', 'Uniforme escolar', 'Conjunto de uniforme escolar', 70000, 40, 5),
(6, 'P006', 'Gorra', 'Gorra ajustable bordada', 12000, 60, 6),
(7, 'P007', 'Sudadera deportiva', 'Sudadera para entrenamiento', 48000, 35, 7),
(8, 'P008', 'Conjunto infantil', 'Conjunto de algodón para niños', 38000, 45, 8),
(9, 'P009', 'Cinturón', 'Cinturón de cuero sintético', 18000, 70, 9),
(10, 'P010', 'Overol de dotación', 'Overol de trabajo industrial', 90000, 15, 10)
ON CONFLICT DO NOTHING;

-- 6. FACTURA (persona, compañía y término deben existir)
INSERT INTO factura (id_factura, id_persona, id_compania, id_termino, fecha_emision, hora_emision) VALUES
(1, 1, 1, 1, '2026-11-01', '10:30:00'),
(2, 2, 2, 2, '2026-10-28', '09:15:00'),
(3, 3, 3, 3, '2026-10-29', '11:40:00'),
(4, 4, 4, 1, '2026-10-30', '14:05:00'),
(5, 5, 5, 6, '2026-10-30', '16:20:00'),
(6, 6, 6, 7, '2026-10-31', '08:50:00'),
(7, 7, 7, 8, '2026-10-31', '10:10:00'),
(8, 8, 8, 9, '2026-11-01', '09:00:00'),
(9, 9, 9, 10, '2026-11-01', '12:30:00'),
(10, 10, 10, 4, '2026-11-01', '15:45:00')
ON CONFLICT DO NOTHING;

-- 7. DETALLE_FACTURA (factura y producto deben existir)
INSERT INTO detalle_factura (id_factura, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 2, 15000),
(2, 2, 1, 55000),
(3, 3, 1, 85000),
(4, 4, 2, 65000),
(5, 5, 3, 70000),
(6, 6, 5, 12000),
(7, 7, 2, 48000),
(8, 8, 4, 38000),
(9, 9, 3, 18000),
(10, 10, 1, 90000)
ON CONFLICT DO NOTHING;