
-------------------------------------------------------
--  Sobre la base de datos Ventas_Tech_DB creada en M3. 
--------------------------------------------------------
USE Ventas_Tech_DB;
GO

-------------------------------------------------------------------------------------------------------------------------------
-- Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
--
--              Calcular el total como cantidad * precio_unitario. Usar alias descriptivos en español y agrupar por mes. 
-------------------------------------------------------------------------------------------------------------------------------

select MONTH(fecha_venta) mes, 
       FORMAT(fecha_venta, 'MM/yyyy') AS MesAnio,
       sum(cantidad * precio_unitario) total_facturado, 
       count(*) cantidad_pedidos,  
       avg(cantidad * precio_unitario) ticket_promedio
from ventas 
group by MONTH(fecha_venta), FORMAT(fecha_venta, 'MM/yyyy');

-------------------------------------------------------------------------------------------------------------------------------
-- Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) 
--              y el total generado. Usar GROUP BY id_producto, ORDER BY y TOP 5.
-------------------------------------------------------------------------------------------------------------------------------

 select top 5 id_producto, sum(cantidad) unidades_vendidas, sum(cantidad * precio_unitario) total_facturado
 from ventas
 group by id_producto
 order by 3 desc;

---------------------------------------------------------------------------------------------------------------------------------
-- Consulta 3 — Clientes recurrentes. id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y 
--                                    el total gastado. Usar GROUP BY id_cliente y HAVING COUNT(*) > 1. 
---------------------------------------------------------------------------------------------------------------------------------

select id_cliente, COUNT(*) cantidad_pedidos, sum(cantidad * precio_unitario) total_gastado, sum(cantidad) unidades_vendidas
from ventas
group by id_cliente
having COUNT(*) > 1
order by 3 desc;

---------------------------------------------------------------------------------------------------------------------------------
-- Consulta 4 — Productos por encima/por debajo del promedio Total facturado por id_producto, con una columna adicional que etiquete con 
--              CASE WHEN si ese producto quedó 'Por encima' o 'Por debajo' del promedio de facturación por producto. 
--              Ojo: es el promedio de los totales por producto, no el promedio de las filas de ventas. 
--              Resolverlo con WITH y una subconsulta, como en el ejemplo de meses de la unidad "Ordenar, resumir y agrupar resultados".
---------------------------------------------------------------------------------------------------------------------------------

with productos as (
   select id_producto, 
          avg(precio_unitario * cantidad) promedio_facturado, 
          sum(precio_unitario * cantidad) total_facturado
   from ventas
   group by id_producto)
select id_producto, 
       promedio_facturado,
       total_facturado,
       case 
        when total_facturado > promedio_facturado then
           'Por Encima'
        else
            'Por Debajo'
        end as comparacion
from productos

---------------------------------------------------------------------------------------------------------------------------------
-- Bloque de cierre con 3 hallazgos concretos que encontraste al revisar los resultados. Por ejemplo: "El producto 1 concentra el 40% de la facturación del trimestre.
---------------------------------------------------------------------------------------------------------------------------------

-- HALLAZGOS:
--
--  * Alta concentración de la facturación en el producto principal: 
--    El Producto 1 (Laptop Pro 15) concentra el 55.86% de la facturación total del período analizado (marzo de 2024), 
--    con $3,600 sobre un total general de $6,444, lo que evidencia una fuerte dependencia del artículo.
--    
--  * El producto con id 1 fue el más vendido del mes de Marzo 2024 teniendo en cuenta el total facturado ($3.600), 
--    pero en unidades vendidas el mayor fue el de id 2 con 13 unidades vendidas
--
--  * Comportamiento 100% recurrente en la cartera de clientes activa:
--    Todos los clientes que registraron transacciones en el período son clientes recurrentes, ya que hicieron exactamente 2 pedidos cada uno, 
--    lo que evidencia una constancia uniforme en las compras.
--
--  * La cantidad de pedidos por cliente en el mes es 2 en todos los casos, pero el id_cliente 1 gastó el importe mayor ($2.640) y
--    los clientes con id 2 y 3, compraron más unidades (9).
--
--   * Dominio del Top 2 de productos sobre los ingresos:
--     Los dos productos con mayor facturación (Laptop Pro 15 y Monitor 4K 27) representan en conjunto el 76.81% de los ingresos totales 
--     de la compañía ($4,950 de $6,444), destacando que las categorías de computación y visualización lideran holgadamente frente a los 
--     accesorios y periféricos de menor valor unitario.



