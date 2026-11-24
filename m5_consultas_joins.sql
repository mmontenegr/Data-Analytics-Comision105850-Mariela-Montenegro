-------------------------------------------------------
--  Cruzando tablas para enriquecer el análisis
--------------------------------------------------------

--------------------------------------------------------
-- Contexto: Base Ventas_Tech_DB
-- orden de corrida:
--   - ventas_tech_db 1.1.sql
--    - m4_consultas_negocio.sql
--    - m5_consultas_joins.sql
USE Ventas_Tech_DB;
GO

--------------------------------------------------------
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Propósito: Agregar informacion descriptiva a la tabla de ventas
--------------------------------------------------------
SELECT v.id_venta, v.fecha_venta, c.id_cliente, c.nombre, 
       p.id_producto, p.nombre_producto, p.costo,  p.id_categoria, ca.nombre_categoria, ca.descripcion descripcion_categoria,
       v.precio_unitario, v.cantidad, v.cantidad * v.precio_unitario total_venta, 
       v.canal, t.region, t.zona, t.pais
FROM Ventas v 
INNER JOIN Clientes c
ON v.id_cliEnte = c.id_cliente
INNER JOIN Productos AS p 
ON v.id_producto = p.id_producto
INNER JOIN Territorios t
ON v.id_territorio = t.id_territorio
INNER JOIN Categorias ca
ON  p.id_categoria = ca.id_categoria;

-- Hallazgos: se listan todos las ventas registradas con información adicional de nombre del cliente, nombre, costo y categoria del producto, y region, zona y pais del territorio donde se realizaron cada venta

--------------------------------------------------------
-- Consulta 2 — Clientes sin ventas (LEFT JOIN) 
-- Propósito: Detectar aquellos clientes que no realizaron ninguna venta
--------------------------------------------------------
SELECT nombre, email, fecha_registro
FROM Clientes c
LEFT JOIN Ventas v
ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- Hallazgos: todos los clientes registrados hicieron alguna compra. La consulta no muestra registros

--------------------------------------------------------
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Propósito: Detectar aquellos productos que no fueron comprados
--------------------------------------------------------

SELECT p.nombre_producto, p.id_categoria, c.nombre_categoria, p.precio
FROM Productos p
INNER JOIN Categorias c
    ON p.id_categoria = c.id_categoria
LEFT JOIN Ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- Hallazgos: Todos los productos fueron comprados en el período informado. La consulta no muestra registros

--------------------------------------------------------
--Consulta 4 — Consolidado por canal (UNION ALL)
-- Propósito: Consolidar el total de ventas por canal, redefiniendo el canal asociado a la venta según 2 criterios al azar
--------------------------------------------------------
SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Online' AS canal
    FROM ventas WHERE canal = 'Online'
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Presencial' AS canal
    FROM ventas WHERE canal IN ('Tienda', 'Corporativo')
) AS consolidado
GROUP BY canal;

-- Hallazgos: El total de ventas hechas en forma Online ($3.714) representan el 57.6% del total. Las ventas en forma presencial suman un total de $2.730.
