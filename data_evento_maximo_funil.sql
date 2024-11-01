WITH eventos AS (
    SELECT
        d.F14474 AS dossie,
        d.F01062 AS criado_em,
        a.F04461 AS pasta,
        j.F01132 AS evento,
        n.F27086 AS cpf_cnpj,
        aa.F00156 AS tipo_acao,
        CASE
            WHEN f.F25017 = 1 THEN 'Ativo'
            WHEN f.F25017 = 2 THEN 'Encerrado'
            WHEN f.F25017 = 3 THEN 'Acordo'
            WHEN f.F25017 = 4 THEN 'Em encerramento'
            ELSE 'Em precatório (Ativo)'
        END AS situacao,
        h.F00162 AS fase,
        CAST(a.F00385 AS DATE) AS data_evento
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
    LEFT JOIN [ramaprod].[dbo].T02913 AS t ON d.F47450 = t.ID
    LEFT JOIN [ramaprod].[dbo].T00030 AS v ON f.F05220 = v.ID
    LEFT JOIN [ramaprod].[dbo].T02913 AS x ON v.F47449 = x.ID
    LEFT JOIN [ramaprod].[dbo].T02676 AS z ON d.F43645 = z.ID
    LEFT JOIN [ramaprod].[dbo].T02678 AS w ON d.F43647 = w.ID
    LEFT JOIN [ramaprod].[dbo].T02677 AS y ON d.F43646 = y.ID
    LEFT JOIN [ramaprod].[dbo].T00034 AS aa ON d.F01122 = aa.ID
        WHERE 
        j.F01132 IN (
    'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI', 
    'AF 1.1 - Distribuição via CRI', 
    'AF 2.1 - Intimação Positiva - Alienação', 
    'AF 2.8 - Todas as Intimações Positivas', 
    'AF 3.2.2 - Calculadora de consolidação aprovada',  
    'AF 4.1 - Pagamento de Débitos Imóvel', 
    'AF 5.1 - Consolidação da Propriedade',  
    'AF 6.2 - Documentação Aceita'
    ) 
        AND CAST(a.F00385 AS DATE) >= '2022-08-01'
)
SELECT
    dossie,
    MAX(evento) AS evento_max,
    MAX(data_evento) AS data_max
FROM eventos
GROUP BY dossie