SELECT
	d.F14474 AS dossie,
	MAX(a.F01544) AS criado_em,
	MAX(m.F00689) AS criado_por,
	MAX(f.F35249) AS data_atualizacao_benner,
	MAX(a.F04461) AS pasta,
	MAX(n.F00091) AS adverso,
	MAX(n.F27086) AS cpf_cnpj,
	MAX (
		CASE
			WHEN f.F25017 = 1 THEN 'Ativo'
			WHEN f.F25017 = 2 THEN 'Encerrado'
			WHEN f.F25017 = 3 THEN 'Acordo'
			WHEN f.F25017 = 4 THEN 'Em encerramento'
			ELSE 'Em precatório (Ativo)'
		END ) AS situacao,
	MAX (
		CASE
			WHEN e.F01187 = 32 THEN 'IMOB - Home Equity PF'
			WHEN e.F01187 = 35 THEN 'IMOB - Home Equity PJ'
			WHEN e.F01187 = 34 THEN 'IMOB - Financiamento'
			WHEN e.F01187 = 36 THEN 'IMOB - Hipoteca'
			ELSE 'Crédito Imobiliário'
		END ) AS produto,
	MAX (h.F00162) AS fase,
	MAX (g.F43686) AS subfase,
	MAX(j.F01132) AS ultimo_evento,
	MAX (i.F00091) AS advogado_interno,
	MAX(k.F02568) AS comarca,
    MAX(p.F00075) AS estado,
	CAST (MAX(CASE WHEN c.F01132 = 'AF 9.2 - Sobejo de Valores' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 9.2',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 10.2 - Sobejo de Valores' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 10.2'
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
LEFT JOIN [ramaprod].[dbo].T00003 AS m ON d.F01061 = m.ID
LEFT JOIN [ramaprod].[dbo].T00030 AS n ON f.F05220 = n.ID
LEFT JOIN [ramaprod].[dbo].T00049 AS o ON k.F02568 = o.F00230
LEFT JOIN [ramaprod].[dbo].T00023 AS p ON o.F00232 = p.ID
GROUP BY a.F04461, d.F14474
HAVING
    (
        CAST(MAX(CASE WHEN c.F01132 = 'AF 9.2 - Sobejo de Valores' THEN a.F00385 ELSE NULL END) AS DATE) IS NOT NULL OR
        CAST(MAX(CASE WHEN c.F01132 = 'AF 10.2 - Sobejo de Valores' THEN a.F00385 ELSE NULL END) AS DATE) IS NOT NULL
    ) AND
    MAX(f.F25017) <> 2
ORDER BY (MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' THEN a.F00385 ELSE NULL END)) DESC;