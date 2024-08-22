SELECT
    d.F14474 AS dossie,
    MONTH(MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END)) AS mes_entrada,
    MAX(m.F01130) AS carteira,
    MAX(i.F00091) AS advogado_interno,
    MAX(k.F02568) AS comarca,
    MAX(SUBSTRING(l.F02571, CHARINDEX('/', l.F02571 + '/') + 1, LEN(l.F02571)) + '-' + k.F02568) AS comarca_cartorio,
    MAX(CASE
        WHEN l.F02571 LIKE '%Grande do sul%' THEN 'Rio Grande do Sul'
        WHEN l.F02571 LIKE '%Paraná%' THEN 'Paraná'
        WHEN l.F02571 LIKE '%Catarina%' THEN 'Santa Catarina'
        WHEN l.F02571 LIKE '%Distrito%' THEN 'Distrito Federal'
        WHEN l.F02571 LIKE '%Paulo%' THEN 'São Paulo'
        WHEN l.F02571 LIKE '%Janeiro%' THEN 'Rio de Janeiro'
        WHEN l.F02571 LIKE '%Bahia%' THEN 'Bahia'
        WHEN l.F02571 LIKE '%Cear%' THEN 'Ceará'
        WHEN l.F02571 LIKE '%Mato Grosso do Sul%' THEN 'Mato Grosso do Sul'
        WHEN l.F02571 LIKE '%Goiás%' THEN 'Goiás'
        WHEN l.F02571 LIKE '%Pern%' THEN 'Pernambuco'
        WHEN l.F02571 LIKE '%Rond%' THEN 'Rondônia'
        ELSE 'Outro'
    END) AS estado,
    DATEDIFF(DAY,
    	MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END),
    	MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita'  OR c.F01132 = 'DP 1.5.2 - Documentação aceita' OR c.F01132 = 'AF 7.1 - Operação Liquidada' THEN a.F00385 ELSE NULL END)
    ) AS tempo,
    MAX(CASE WHEN c.F01132 = 'AF 12.9 - Ônus na matrícula' THEN 1 ELSE 0 END) AS onus_matricula
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
LEFT JOIN [ramaprod].[dbo].T00035 AS m ON f.F01187 = m.ID
LEFT JOIN [ramaprod].[dbo].T00030 AS n ON f.F05220 = n.ID
LEFT JOIN [ramaprod].[dbo].T00045 AS o ON f.F00217 = o.ID
LEFT JOIN [ramaprod].[dbo].T01777 AS p ON f.F34969 = p.ID
LEFT JOIN [ramaprod].[dbo].T00035 AS q ON p.F24930 = q.ID
LEFT JOIN [ramaprod].[dbo].T00083 AS r ON f.F14465 = r.ID
LEFT JOIN [ramaprod].[dbo].T00046 AS s ON r.F00488 = s.ID
GROUP BY d.F14474
HAVING 
	MAX(e.F01187) IN (32,34,14,36,35) AND 
	DATEDIFF(DAY,
    	MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END),
    	MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita'  OR c.F01132 = 'DP 1.5.2 - Documentação aceita' OR c.F01132 = 'AF 7.1 - Operação Liquidada' THEN a.F00385 ELSE NULL END)
    ) IS NOT NULL
ORDER BY MAX(e.F01062) DESC;


análise de regressão linear não funciona para estes dados 
tentar análise de regressão logística para prever se o imóvel será retomada ou não


