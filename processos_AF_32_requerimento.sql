SELECT
	a.F04461 AS pasta,
	MAX(d.F14474) AS dossie,
	MAX(e.F01062) AS criado_em,
	MAX(
	CASE
		WHEN f.F25017 = 1 THEN 'Ativo'
		WHEN f.F25017 = 2 THEN 'Encerrado'
		WHEN f.F25017 = 3 THEN 'Acordo'
		WHEN f.F25017 = 4 THEN 'Em encerramento'
		ELSE 'Em precatório (Ativo)'
	END)  AS situacao,
	MAX(s.F00227) AS desdobramento_nome,
	MAX(m.F01130) AS carteira,
	MAX(
		CASE
			WHEN d.F47441 = 1 THEN 'E1'
			WHEN d.F47441 = 2 THEN 'PF'
			WHEN d.F47441 = 3 THEN 'E2 Risco menor que 500K'
			WHEN d.F47441 = 4 THEN 'E2 Risco maior que 500K'
			WHEN d.F47441 = 5 THEN 'E3'
			WHEN d.F47441 = 6 THEN 'GIU'
			WHEN d.F47441 = 7 THEN 'FAMPE'
			WHEN d.F47441 = 8 THEN 'PRIVATE'
		END ) AS segmento,
	MAX(h.F00162) AS fase,
	MAX(g.F43686) AS subfase,
	MAX(f.F34969) AS tipo_acao,
	MAX(f.F00179) AS valor_causa,
	MAX(i.F00091) AS advogado_interno,
	MAX(ab.F00075) AS estado,
	MAX(k.F02568) AS comarca,
	MAX(n.F00091) AS adverso,
	MAX(
		CASE
			WHEN n.F00148 = 1 THEN 'PF'
			WHEN n.F00148 = 2 THEN 'PJ'
			WHEN n.F00148 = 3 THEN 'Espólio'
		END) AS tipo_pessoa,
	MAX(n.F27086) AS cpf_cnpj,
	MAX(
		CASE
			WHEN j.F01132 = 'AF 3.2 - Decurso do Prazo para Purgação da Mora' THEN j.F01132
			ELSE NULL
		END) AS evento_AF_32,
	MAX(
		CASE
			WHEN j.F01132 = 'AF 3.2 - Decurso do Prazo para Purgação da Mora' THEN a.F00385
			ELSE NULL
		END) AS data_AF_32,
	MAX(
		CASE
			WHEN j.F01132 = 'AF 3.2 - Decurso do Prazo para Purgação da Mora' THEN b.F00689
			ELSE NULL
		END) AS advoado_AF_32,
	MAX(
		CASE
			WHEN j.F01132 = 'AF 3.2.2. - Calculadora de consolidação aprovada' THEN j.F01132
			ELSE NULL
		END) AS evento_AF_322,
	MAX(
		CASE
			WHEN j.F01132 = 'AF 3.2.2. - Calculadora de consolidação aprovada' THEN a.F00385
			ELSE NULL
		END) AS data_AF_322,
	MAX(
		CASE
			WHEN j.F01132 = 'AF 3.2.2. - Calculadora de consolidação aprovada' THEN b.F00689
			ELSE NULL
		END) AS advoado_AF_322,
	MAX(
		CASE
			WHEN j.F01132 = 'Requerimento de Consolidação de Propriedade' THEN j.F01132
			ELSE NULL
		END) AS evento_requerimento,
	MAX(
		CASE
			WHEN j.F01132 = 'Requerimento de Consolidação de Propriedade' THEN a.F00385
			ELSE NULL
		END) AS data_requerimento,
	MAX(
		CASE
			WHEN j.F01132 = 'Requerimento de Consolidação de Propriedade' THEN b.F00689
			ELSE NULL
		END) AS advogado_requerimento,
	MAX(
		CASE
			WHEN j.F01132 = 'AF 12.9 - Ônus na matrícula' THEN a.F00385
			ELSE NULL
		END) AS data_AF_129
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
LEFT JOIN [ramaprod].[dbo].T00049 AS aa ON k.F02568 = aa.F00230
LEFT JOIN [ramaprod].[dbo].T00023 AS ab ON aa.F00232 = ab.ID
GROUP BY a.F04461
ORDER BY criado_em DESC;