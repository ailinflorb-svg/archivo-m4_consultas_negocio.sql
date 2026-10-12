SELECT

    MONTH(fecha_venta) AS mes,

    SUM(cantidad * precio_unitario) AS total_facturado,

    COUNT(*) AS cantidad_pedidos,

    AVG(cantidad * precio_unitario) AS ticket_promedio

FROM ventas

GROUP BY MONTH(fecha_venta)

ORDER BY mes;


SELECT TOP 5

    id_producto,

    SUM(cantidad) AS unidades_vendidas,

    SUM(cantidad * precio_unitario) AS total_facturado

FROM ventas

GROUP BY id_producto

ORDER BY total_facturado DESC;

SELECT

    id_cliente,

    COUNT(*) AS cantidad_pedidos,

    SUM(cantidad * precio_unitario) AS total_gastado

FROM ventas

GROUP BY id_cliente

HAVING COUNT(*) > 1;

;WITH ventas_mensuales AS (
  
    SELECT 

        MONTH(fecha_venta) AS mes,

        SUM(cantidad * precio_unitario) AS total_mes

    FROM ventas

    GROUP BY MONTH(fecha_venta)

    )

    SELECT 

    mes,

    total_mes,

    ROUND((SELECT AVG(total_mes) FROM ventas_mensuales), 2) AS promedio_general,

    CASE 

        WHEN total_mes >= (SELECT AVG(total_mes) FROM ventas_mensuales)
        
        THEN 'Por encima'

        ELSE 'Por debajo'

    END AS rendimiento_mes

FROM ventas_mensuales

ORDER BY mes ASC;


-- =============================================
-- BLOQUE DE CIERRE: HALLAZGOS DEL NEGOCIO
-- =============================================

-- Hallazgo 1: El producto que más unidades se vendió fue el Mause Inalámbrico con 13 unidades vendidas.

-- Hallazgo 2: El producto que generó mayor facturación fue la Laptop Pro 15, con un total de $3600.

-- Hallazgo 3: La cliente que tuvo más gasto fue María Lopez que gastó un total de $2640.
