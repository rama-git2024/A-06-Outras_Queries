SELECT
	a.F04461 AS pasta,
	d.F14474 AS dossie,
	MAX(a.F01544) AS criado_em,
	MAX(CASE
		WHEN f.F25017 = 1 THEN 'Ativo'
		WHEN f.F25017 = 2 THEN 'Encerrado'
		WHEN f.F25017 = 3 THEN 'Acordo'
		WHEN f.F25017 = 4 THEN 'Em encerramento'
		ELSE 'Em precatório (Ativo)'
	END)  AS situacao,
	MAX(CASE
		WHEN e.F01187 = 32 THEN 'IMOB - Home Equity PF'
		WHEN e.F01187 = 35 THEN 'IMOB - Home Equity PJ'
		WHEN e.F01187 = 34 THEN 'IMOB - Financiamento'
		WHEN e.F01187 = 36 THEN 'IMOB - Hipoteca'
		ELSE 'Crédito Imobiliário'
	END)  AS produto,
	MAX(h.F00162) AS fase,
	MAX(g.F43686) AS subfase,
	MAX(CASE WHEN c.F01132 = 'AF 12.9 - Ônus na matrícula' THEN a.F00385 ELSE NULL END) AS 'AF_129',
	MAX(i.F00091) AS advogado_interno,
	MAX(CASE
		WHEN l.F02571 LIKE '%Grande do sul%' THEN 'Rio Grande do Sul'
		WHEN l.F02571 LIKE '%Paraná%' THEN 'Paraná'
		ELSE 'Santa Catarina'
	END) AS estado
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
GROUP BY d.F14474, a.F04461
HAVING(
	MAX(e.F01187) IN (32,34,14,36,35) AND
	MAX(h.F00162) = 'AF 12. SUSPENSÃO PROCESSO' AND
	MAX(g.F43686) = 'AF 12 - Ônus da Matrícula' AND
	MAX(CASE
		WHEN f.F25017 = 1 THEN 'Ativo'
		WHEN f.F25017 = 2 THEN 'Encerrado'
		WHEN f.F25017 = 3 THEN 'Acordo'
		WHEN f.F25017 = 4 THEN 'Em encerramento'
		ELSE 'Em precatório (Ativo)'
	END) IN ('Ativo', 'Em precatório (Ativo)')
	)
	OR
	(
	MAX(CASE
		WHEN f.F25017 = 1 THEN 'Ativo'
		WHEN f.F25017 = 2 THEN 'Encerrado'
		WHEN f.F25017 = 3 THEN 'Acordo'
		WHEN f.F25017 = 4 THEN 'Em encerramento'
		ELSE 'Em precatório (Ativo)'
	END) IN ('Ativo', 'Em precatório (Ativo)') AND
	MAX(CASE WHEN c.F01132 = 'AF 12.9 - Ônus na matrícula' THEN a.F00385 ELSE NULL END) IS NOT NULL
	)