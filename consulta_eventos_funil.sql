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

    'AF 0.2 - Pend. Doc: Contrato sem Registro ou Matrícula AF', 
    'AF 0.3 - Pend. Doc: Sem Imagem do Contrato ou Matrícula', 
    'AF 0.4 - Pend. Doc: Outros Documentos', 
    'AF 0.5 - Impedimento Cobrança / Jurídico', 
    'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI', 

    'AF 1.1 - Distribuição via CRI', 
    'AF 1.1.1 - Intimação CRI Em Processamento / Diligência',

    'AF 2.1 - Intimação Positiva - Alienação', 
    'AF 2.11 - Intimação Negativa - Endereço MS', 
    'AF 2.2 - Intimação Positiva - Coobrigado', 
    'AF 2.3 - Intimação Negativa - 01ª Tentativa', 
    'AF 2.4 - Intimação Negativa - 02ª Tentativa', 
    'AF 2.5 - Intimação por Hora Certa', 
    'AF 2.6 - Intimação Positiva - Edital Alienação', 
    'AF 2.7 - Intimação via Notificação Judicial', 
    'AF 2.7.1 - Notificação Judicial Concluída', 
    'AF 2.8 - Todas as Intimações Positivas', 
    'AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)',

    'AF 3.1 - Purgação da Mora', 
    'AF 3.2 - Decurso do Prazo para Purgação da Mora', 
    'AF 3.2.1 - Levantamento dos Débitos do imóvel junto a Prefeitura e/ou Condomínio', 
    'AF 3.2.2 - Calculadora de consolidação aprovada',  

    'AF 4.1 - Pagamento de Débitos Imóvel', 

    'AF 5.1 - Consolidação da Propriedade', 

    'AF 6.1 - Envio do Imóvel ao Real Estate', 
    'AF 6.2 - Documentação Aceita', 
    'AF 6.3 - Documentação Recusada', 

    'AF 7.1 - Operação Liquidada', 
    'AF 7.2 - Estorno de Consolidação', 

    'AF 8.1 - Notificação Devedor Positiva', 
    'AF 8.2 - Notificação Coobrigado Positiva', 
    'AF 8.3 - Notificação Negativa', 
    'AF 8.4 - Notificação por Edital', 
    'AF 8.5 - Todas as Notificações Enviadas',

    'AF 9.1 - Arrematação', 
    'AF 9.2 - Sobejo de Valores', 
    'AF 9.3 - Leilão Negativo', 
    'AF 9.4 - Exercício do Direito de Preferência',

    'AF 10.1 - Arrematação', 
    'AF 10.2 - Sobejo de Valores', 
    'AF 10.3 - Leilão Negativo', 
    'AF 10.4 - Averbação',

    'AF 11.2 - Prestação de Contas Arrematação/Real Estate', 
    'AF 11.3 - Restituição do Sobejo',

    'AF 13.1 - Solicitação de HO'

    ) 
        AND CAST(a.F00385 AS DATE) >= '2022-08-01'
),

sub AS (
    SELECT
        d.F14474 as dossie_max,
        a.F04461 AS pasta_max,
        MAX(d.F01062) AS criado_em_max,
        MAX(ef.evento) AS ultimo_evento,
        MAX(ef.data_evento) AS data_max,
        MAX(n.F27086) AS documento,
        MAX(ef.situacao) AS situacao_max,
        MAX(h.F00162) AS fase_max,
        MAX(aa.F00156) AS tipo_acao_max
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
    LEFT JOIN eventos AS ef ON d.F14474 = ef.dossie
    GROUP BY a.F04461, d.F14474
    HAVING MAX(ef.evento) is not null

), 

consulta AS (
SELECT
    pasta_max,
    dossie_max,
    criado_em_max,
    documento,
    fase_max,
    situacao_max,
    ultimo_evento,
    tipo_acao_max,
    (CASE

        WHEN ultimo_evento IN ('AF 0.2 - Pend. Doc: Contrato sem Registro ou Matrícula AF', 'AF 0.3 - Pend. Doc: Sem Imagem do Contrato ou Matrícula', 
            'AF 0.4 - Pend. Doc: Outros Documentos', 'AF 0.5 - Impedimento Cobrança / Jurídico') THEN 'FASE 0 - PRÉ DISTRIBUIÇÃO'

        WHEN ultimo_evento IN ('AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI') THEN 'FASE 1 - DISTRIBUIÇÃO'

        WHEN  ultimo_evento IN ('AF 1.1 - Distribuição via CRI', 'AF 1.1.1 - Intimação CRI Em Processamento / Diligência', 'AF 2.1 - Intimação Positiva - Alienação', 'AF 2.11 - Intimação Negativa - Endereço MS', 
            'AF 2.2 - Intimação Positiva - Coobrigado', 'AF 2.3 - Intimação Negativa - 01ª Tentativa', 'AF 2.4 - Intimação Negativa - 02ª Tentativa', 'AF 2.5 - Intimação por Hora Certa', 
            'AF 2.6 - Intimação Positiva - Edital Alienação', 'AF 2.7 - Intimação via Notificação Judicial') THEN 'FASE 2 - NOTOTIFICAÇÃO VIA CRI'

        WHEN ultimo_evento IN ('AF 2.8 - Todas as Intimações Positivas', 'AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)', 'AF 3.1 - Purgação da Mora', 'AF 3.2 - Decurso do Prazo para Purgação da Mora', 
            'AF 3.2.1 - Levantamento dos Débitos do imóvel junto a Prefeitura e/ou Condomínio') THEN 'FASE 3 - PURGAÇÃO DA MORA'

        WHEN ultimo_evento IN ('AF 3.2.2 - Calculadora de consolidação aprovada') THEN 'FASE 4 - PEDIDO DE CONSOLIDAÇÃO'

        WHEN ultimo_evento IN ('AF 4.1 - Pagamento de Débitos Imóvel') THEN 'FASE 5 - REGISTRO DA CONSOLIDAÇÃO'

        WHEN ultimo_evento IN ('AF 5.1 - Consolidação da Propriedade', 'AF 6.1 - Envio do Imóvel ao Real Estate') THEN 'FASE 6 - INTERNALIZAÇÃO DO BEM'

        WHEN ultimo_evento IN ('AF 6.2 - Documentação Aceita', 'AF 6.3 - Documentação Recusada', 'AF 7.1 - Operação Liquidada', 'AF 7.2 - Estorno de Consolidação', 
            'AF 8.1 - Notificação Devedor Positiva', 'AF 8.2 - Notificação Coobrigado Positiva', 'AF 8.3 - Notificação Negativa', 'AF 8.4 - Notificação por Edital', 'AF 8.5 - Todas as Notificações Enviadas',
            'AF 9.1 - Arrematação', 'AF 9.2 - Sobejo de Valores', 'AF 9.3 - Leilão Negativo', 'AF 9.4 - Exercício do Direito de Preferência', 'AF 10.1 - Arrematação', 'AF 10.2 - Sobejo de Valores', 
            'AF 10.3 - Leilão Negativo', 'AF 10.4 - Averbação', 'AF 11.2 - Prestação de Contas Arrematação/Real Estate', 'AF 11.3 - Restituição do Sobejo', 
            'AF 13.1 - Solicitação de HO') THEN 'FASE 7,8,9,10 - LIQUIDADO/LEILÃO'

        ELSE NULL
    END) AS fase_af,
    data_max
FROM sub),

consulta_2 AS (
SELECT
        d.F14474 AS dossie,
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
        'AF 12.1 - Pagamento', 
        'AF 12.10 - Impedimento Cobrança / Jurídico', 
        'AF 12.2 - Ação Contrária em Curso', 
        'AF 12.3 - Incidente Instaurado', 
        'AF 12.4 - Ação Contrária com Liminar Atribuída', 
        'AF 12.5 - Ação contrária Julgada', 
        'AF 12.8 - Inviabilidade de Consolidação (Calculadora Negativa)', 
        'AF 12.9 - Ônus na matrícula'
    ) 
        AND CAST(a.F00385 AS DATE) >= '2022-08-01'
),
consulta_3 AS (
    SELECT
        dossie AS dossie_2,
        MAX(CASE WHEN evento = 'AF 12.1 - Pagamento' THEN data_evento END) AS pagamento,
        MAX(CASE WHEN evento IN ('AF 12.10 - Impedimento Cobrança / Jurídico', 'AF 12.2 - Ação Contrária em Curso', 'AF 12.3 - Incidente Instaurado', 'AF 12.4 - Ação Contrária com Liminar Atribuída', 
            'AF 12.5 - Ação contrária Julgada', 'AF 12.8 - Inviabilidade de Consolidação (Calculadora Negativa)','AF 12.9 - Ônus na matrícula') THEN data_evento END) AS suspenso
    FROM consulta_2
    GROUP BY dossie
)
SELECT
    c.pasta_max,
    CASE WHEN c.dossie_max IS NULL THEN c3.dossie_2 ELSE c.dossie_max END AS dossie_final,
    c.criado_em_max AS criado_em_final,
    c.documento AS documento_final,
    c.fase_max AS fase_final,
    c.situacao_max AS situacao_final,
    c.ultimo_evento AS evento_final,
    c.tipo_acao_max AS acao_final,
    c.fase_af AS af_final,
    c.data_max AS data_af_final,
    c3.pagamento AS pagamento_final,
    c3.suspenso AS suspenso_final
FROM consulta AS c
FULL OUTER JOIN consulta_3 AS c3 ON c3.dossie_2 = c.dossie_max
