CREATE DATABASE Ventas_Tech_DB;
GO

USE Ventas_Tech_DB;
GO

----------------------------
-- Sección 1 — DROP TABLES
----------------------------
--

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS territorios;

----------------------------
-- Sección 2 — CREATE TABLES
----------------------------
-- 
CREATE TABLE [Clientes] (
  [id_cliente] int PRIMARY KEY,
  [nombre] varchar(100),
  [email] varchar(150) UNIQUE,
  [ciudad] varchar(100),
  [fecha_registro] datetime
)
GO

CREATE TABLE [Categorias] (
  [id_categoria] int PRIMARY KEY,
  [nombre_categoria] varchar(100),
  [descripcion] varchar(500)
)
GO

CREATE TABLE [Productos] (
  [id_producto] int PRIMARY KEY,
  [nombre_producto] varchar(150),
  [id_categoria] int NOT NULL,
  [precio] decimal(12,2),
  [costo] decimal(12,2)
)
GO

CREATE TABLE [Territorios] (
  [id_territorio] int PRIMARY KEY,
  [region] varchar(50),
  [pais] varchar(50),
  [zona] varchar(60)
)
GO

CREATE TABLE [Ventas] (
  [id_venta] int PRIMARY KEY,
  [fecha_venta] datetime,
  [id_cliente] int NOT NULL,
  [id_producto] int NOT NULL,
  [cantidad] int,
  precio_unitario decimal(12,2),
  [canal] varchar(50),
  [id_territorio] int NOT NULL
)
GO

ALTER TABLE [Productos] ADD FOREIGN KEY ([id_categoria]) REFERENCES [Categorias] ([id_categoria])
GO

ALTER TABLE [Ventas] ADD FOREIGN KEY ([id_cliente]) REFERENCES [Clientes] ([id_cliente])
GO

ALTER TABLE [Ventas] ADD FOREIGN KEY ([id_producto]) REFERENCES [Productos] ([id_producto])
GO

ALTER TABLE [Ventas] ADD FOREIGN KEY ([id_territorio]) REFERENCES [Territorios] ([id_territorio])
GO


----------------------------
-- Sección 3 — INSERT DATA
----------------------------
-- 
-- Deshabilitar constraint checks
ALTER TABLE [Categorias] NOCHECK CONSTRAINT ALL;
GO
ALTER TABLE [Clientes] NOCHECK CONSTRAINT ALL;
GO
ALTER TABLE [Productos] NOCHECK CONSTRAINT ALL;
GO
ALTER TABLE [Territorios] NOCHECK CONSTRAINT ALL;
GO
ALTER TABLE [Ventas] NOCHECK CONSTRAINT ALL;
GO


-- Insertar datos
INSERT INTO [Categorias] ([id_categoria], [nombre_categoria], [descripcion])
VALUES
  (1, 'Computación', 'Laptops, PCs y monitores'),
  (2, 'Accesorios', 'Periféricos y complementos'),
  (3, 'Audio', 'Auriculares y parlantes'),
  (4, 'Almacenamiento', 'Discos y memorias');
GO
INSERT INTO [Clientes] ([id_cliente], [nombre], [email], [ciudad], [fecha_registro])
VALUES
  (1, 'María López', 'maria@mail.com', 'Buenos Aires', '2024-01-05'),
  (2, 'Carlos Ruiz', 'carlos@mail.com', 'Córdoba', '2024-01-10'),
  (3, 'Ana Gómez', 'ana@mail.com', 'Rosario', '2024-02-01'),
  (4, 'Pedro Sanz', 'pedro@mail.com', 'Mendoza', '2024-02-15'),
  (5, 'Laura Torres', 'laura@mail.com', 'Tucumán', '2024-03-01');
GO
INSERT INTO [Productos] ([id_producto], [nombre_producto], [id_categoria], [precio], [costo])
VALUES
  (1, 'Laptop Pro 15', 1, 1200, 15),
  (2, 'Mouse Inalámbrico', 2, 28, 80),
  (3, 'Monitor 4K 27', 1, 450, 12),
  (4, 'Auriculares BT Pro', 3, 120, 35),
  (5, 'SSD Externo 1TB', 4, 130, 18),
  (6, 'Teclado Mecánico', 2, 95, 40);
GO
INSERT INTO [Territorios] ([id_territorio], [region], [pais], [zona])
VALUES
  (1, 'Norte', 'Argentina', 'NOA'),
  (2, 'Norte', 'Argentina', 'NEA'),
  (3, 'Centro', 'Argentina', 'AMBA'),
  (4, 'Centro', 'Argentina', 'Pampeana'),
  (5, 'Oeste', 'Argentina', 'Cuyo'),
  (6, 'Sur', 'Argentina', 'atagonia Norte'),
  (7, 'Sur', 'Argentina', 'Patagonia Sur'),
  (8, 'Centro', 'Argentina', 'Centro');
GO
INSERT INTO [Ventas] ([id_venta], [id_cliente], [id_producto], [cantidad], precio_unitario, [fecha_venta], [canal], [id_territorio])
VALUES
  (1, 1, 1, 2, 1200, '2024-03-05', 'Online', 1),
  (2, 2, 2, 5, 28, '2024-03-06', 'Online', 5),
  (3, 3, 3, 1, 450, '2024-03-07', 'Online', 3),
  (4, 1, 4, 2, 120, '2024-03-08', 'Tienda', 4),
  (5, 4, 5, 3, 130, '2024-03-10', 'Corporativo', 5),
  (6, 2, 6, 4, 95, '2024-03-11', 'Online', 6),
  (7, 5, 1, 1, 1200, '2024-03-12', 'Tienda', 5),
  (8, 3, 2, 8, 28, '2024-03-13', 'Online', 8),
  (9, 4, 4, 1, 120, '2024-03-14', 'Online', 7),
  (10, 5, 3, 2, 450, '2024-03-15', 'Tienda', 5);
GO

-- Habilitar constraint checks
ALTER TABLE [Categorias] WITH CHECK CHECK CONSTRAINT ALL;
GO
ALTER TABLE [Clientes] WITH CHECK CHECK CONSTRAINT ALL;
GO
ALTER TABLE [Productos] WITH CHECK CHECK CONSTRAINT ALL;
GO
ALTER TABLE [Territorios] WITH CHECK CHECK CONSTRAINT ALL;
GO
ALTER TABLE [Ventas] WITH CHECK CHECK CONSTRAINT ALL;
GO

----------------------------
-- Sección 4 — VALIDACIÓN
----------------------------
-- 
select * from ventas;
select * from productos;
select * from categorias;
select * from clientes;
select * from territorios;