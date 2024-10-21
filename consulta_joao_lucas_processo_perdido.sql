SELECT
	d.F14474 AS dossie,
	MAX(a.F01544) AS criado_em,
	MAX(m.F00689) AS criado_por,
	MAX(f.F35249) AS data_atualizacao_benner,
	MAX(a.F04461) AS pasta,
	MAX(n.F00091) AS adverso,
	MAX(n.F27086) AS cpf_cnpj,
	MAX(
		CASE
			WHEN f.F25017 = 1 THEN 'Ativo'
			WHEN f.F25017 = 2 THEN 'Encerrado'
			WHEN f.F25017 = 3 THEN 'Acordo'
			WHEN f.F25017 = 4 THEN 'Em encerramento'
			ELSE 'Em precatório (Ativo)'
		END
	) AS situacao,
	MAX(
		CASE
			WHEN e.F01187 = 32 THEN 'IMOB - Home Equity PF'
			WHEN e.F01187 = 35 THEN 'IMOB - Home Equity PJ'
			WHEN e.F01187 = 34 THEN 'IMOB - Financiamento'
			WHEN e.F01187 = 36 THEN 'IMOB - Hipoteca'
			ELSE 'Crédito Imobiliário'
		END
	) AS produto,
	MAX(h.F00162) AS fase,
	MAX(g.F43686) AS subfase,
	MAX(j.F01132) AS ultimo_evento,
	MAX(i.F00091) AS advogado_interno,
	MAX(k.F02568) AS comarca,
    MAX(p.F00075) AS estado,
	MAX(p.F00074) AS UF,
	MAX(k.F02568) + '-' + MAX(p.F00074) AS comarca_UF,
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' OR c.F01132 = 'Na esteira de ajuizamento com kit OK' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 0.7',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 1.1',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 12.1 - Pagamento' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 12.1'
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
	MAX(e.F01187) IN (32, 34, 14, 36, 35)
	AND (
		MAX(h.F00162) LIKE '%AF%'
		OR MAX(h.F00162) LIKE '%DP%'
		OR MAX(h.F00162) LIKE '%Alienação%'
	)
	AND CAST(MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' OR c.F01132 = 'Na esteira de ajuizamento com kit OK' THEN a.F00385 ELSE NULL END) AS DATE) IS NOT NULL
	AND CAST(MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' THEN a.F00385 ELSE NULL END) AS DATE) IS NULL
	AND CAST(MAX(a.F01544) AS DATE) > '2024-09-01'
	AND CAST(MAX(CASE WHEN c.F01132 = 'AF 12.1 - Pagamento' THEN a.F00385 ELSE NULL END) AS DATE) IS NOT NULL
ORDER BY CAST(MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' THEN a.F00385 ELSE NULL END) AS DATE) DESC;
