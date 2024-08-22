WITH subquery AS (
    SELECT
        d.F14474 AS dossie,
        CAST(MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita' OR c.F01132 = 'DP 1.5.2 - Documentação aceita' THEN a.F00385 ELSE NULL END) AS DATE) AS AF_62
    FROM [ramaprod].[dbo].T00069 AS a
    LEFT JOIN [ramaprod].[dbo].T00003 AS b ON a.F08501 = b.ID
    LEFT JOIN [ramaprod].[dbo].T00064 AS c ON a.F01133 = c.ID
    LEFT JOIN [ramaprod].[dbo].T00041 AS d ON a.F02003 = d.ID
    LEFT JOIN [ramaprod].[dbo].T00041 AS e ON a.F02003 = e.ID
    LEFT JOIN [ramaprod].[dbo].T00041 AS f ON a.F02003 = f.ID
    LEFT JOIN [ramaprod].[dbo].T02682 AS g ON f.F43687 = g.ID
    LEFT JOIN [ramaprod].[dbo].T00037 AS h ON f.F00177 = h.ID
    LEFT JOIN [ramaprod].[dbo].T00030 AS i ON f.F11578 = i.ID
    LEFT JOIN [ramaprod].[dbo].T00064 AS j ON a.F01133 = j.ID
    LEFT JOIN [ramaprod].[dbo].T00041 AS k ON a.F02003 = k.ID
    LEFT JOIN [ramaprod].[dbo].T00041 AS l ON a.F02003 = l.ID
    GROUP BY d.F14474
    HAVING
        MAX(e.F01187) IN (32, 34, 14, 36, 35)
        AND (MAX(h.F00162) LIKE '%AF%' OR MAX(h.F00162) LIKE '%DP%' OR MAX(h.F00162) LIKE '%Alienação%')
        AND CAST(MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita' OR c.F01132 = 'DP 1.5.2 - Documentação aceita' THEN a.F00385 ELSE NULL END) AS DATE) IS NOT NULL
)
SELECT
    COUNT(dossie) AS quantidade_dossies,
    YEAR(AF_62) AS ano,
    MONTH(AF_62) AS mes
FROM subquery
GROUP BY YEAR(AF_62), MONTH(AF_62)
ORDER BY ano, mes;
