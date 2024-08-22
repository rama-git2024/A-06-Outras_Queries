
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Passo 1: Agrupar todos os eventos que ocorrem em um único dossie em uma única string usando XML PATH
WITH DossieEventos AS (
    SELECT 
        b.F14474 AS dossie,
        MAX(b.F01187) AS produto,
        MAX(b.F35249) AS data_benner,
        MAX (
            CASE
                WHEN b.F25017 = 1 THEN 'Ativo'
                WHEN b.F25017 = 2 THEN 'Encerrado'
                WHEN b.F25017 = 3 THEN 'Acordo'
                WHEN b.F25017 = 4 THEN 'Em encerramento'
                ELSE 'Em precatório (Ativo)'
            END 
            ) AS situacao,
        MAX(d.F00162) AS fase,
        MAX(c.F00091) AS adverso_nome,
        MAX(c.F27086) AS cpf,
        STUFF((
            SELECT ', ' + c.F01132
            FROM [ramaprod].[dbo].T00069 AS a1
            LEFT JOIN [ramaprod].[dbo].T00064 AS c ON a1.F01133 = c.ID
            WHERE a1.F02003 = b.ID
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS eventos
    FROM 
        [ramaprod].[dbo].T00041 AS b
    LEFT JOIN 
        [ramaprod].[dbo].T00069 AS a ON a.F02003 = b.ID
    LEFT JOIN 
        [ramaprod].[dbo].T00030 AS c ON b.F05220 = c.ID
    LEFT JOIN 
        [ramaprod].[dbo].T00037 AS d ON b.F00177 = d.ID
    GROUP BY 
        b.F14474, b.ID
)
SELECT 
    dossie,
    eventos,
    fase,
    produto,
    situacao,
    adverso_nome,
    cpf,
    data_benner,
    CASE
        WHEN fase =  'AF 12. SUSPENSÃO PROCESSO' THEN 'Proc. Suspenso'
        WHEN situacao = 'Ativo' AND eventos NOT LIKE '%AF%' THEN 'Ação Distribuida'
        WHEN situacao = 'Encerrado' THEN 'Proc. Suspenso' 
        WHEN (CHARINDEX('AF 1.1 - Distribuição via CRI', eventos) > 0 OR CHARINDEX('AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI', eventos) > 0)
             AND CHARINDEX('AF 3.1 - Purgação da Mora', eventos) = 0 
             AND CHARINDEX('AF 12.1 - Pagamento', eventos) = 0 
             AND CHARINDEX('AF 2.3 - Intimação Negativa - 01ª Tentativa', eventos) = 0 
             AND CHARINDEX('AF 2.4 - Intimação Negativa - 02ª Tentativa', eventos) = 0 
             AND CHARINDEX('AF 2.1 - Intimação Positiva - Alienação', eventos) = 0 
             AND CHARINDEX('AF 2.2 - Intimação Positiva - Coobrigado', eventos) = 0 
             AND CHARINDEX('AF 2.5 - Intimação por Hora Certa', eventos) = 0 
             AND CHARINDEX('AF 2.6 - Intimação Positiva - Edital Alienação', eventos) = 0
             AND CHARINDEX('AF 2.7 - Intimação via Notificação Judicial', eventos) = 0
             AND CHARINDEX('AF 2.8 - Todas as Intimações Positivas', eventos) = 0
             AND CHARINDEX('AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)', eventos) = 0 
             AND CHARINDEX('AF 0.2 - Pend. Doc: Contrato sem Registro ou Matrícula AF', eventos) = 0 
             AND CHARINDEX('AF 0.3 - Sem Imagem do Contrato ou Matrícula', eventos) = 0 
             AND CHARINDEX('AF 0.5 - Impedimento Cobrança / Jurídico', eventos) = 0 
             AND CHARINDEX('AF 7.2. Estorno de Consolidação', eventos) = 0 
             AND CHARINDEX('AF 12.2 - Ação Contrária em Curso', eventos) = 0 
             AND CHARINDEX('AF 12.4 - Ação Contrária com Liminar Atribuída', eventos) = 0 
             AND CHARINDEX('AF 12.8 - Inviabilidade de Consolidação (Calculadora Negativa)', eventos) = 0 
             AND CHARINDEX('AF 12.9 - Ônus na matrícula', eventos) = 0 
             AND CHARINDEX('AF 12.10 - Impedimento Cobrança / Jurídico', eventos) = 0 
             THEN 'Ação Distribuida'
        WHEN CHARINDEX('AF 3.1 - Purgação da Mora', eventos) > 0 THEN 'Purgação da Mora'
        WHEN CHARINDEX('AF 12.1 - Pagamento', eventos) > 0 THEN 'Purgação da Mora'
        WHEN (CHARINDEX('AF 2.3 - Intimação Negativa - 01ª Tentativa', eventos) > 0 OR CHARINDEX('AF 2.4 - Intimação Negativa - 02ª Tentativa', eventos) > 0)
            AND CHARINDEX('AF 2.1 - Intimação Positiva - Alienação', eventos) = 0 
            AND CHARINDEX('AF 2.2 - Intimação Positiva - Coobrigado', eventos) = 0 
            AND CHARINDEX('AF 2.5 - Intimação por Hora Certa', eventos) = 0 
            AND CHARINDEX('AF 2.6 - Intimação Positiva - Edital Alienação', eventos) = 0 
            AND CHARINDEX('AF 2.7 - Intimação via Notificação Judicial', eventos) = 0 
            AND CHARINDEX('AF 2.8 - Todas as Intimações Positivas', eventos) = 0 
            AND CHARINDEX('AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)', eventos) = 0 
            THEN 'Citação Neg./Tentativa'
        WHEN CHARINDEX('AF 2.1 - Intimação Positiva - Alienação', eventos) > 0 THEN 'Citação Positiva'
        WHEN CHARINDEX('AF 2.2 - Intimação Positiva - Coobrigado', eventos) > 0 THEN 'Citação Positiva'
        WHEN CHARINDEX('AF 2.5 - Intimação por Hora Certa', eventos) > 0 THEN 'Citação Positiva'
        WHEN CHARINDEX('AF 2.6 - Intimação Positiva - Edital Alienação', eventos) > 0 THEN 'Citação Positiva'
        WHEN CHARINDEX('AF 2.7 - Intimação via Notificação Judicial', eventos) > 0 THEN 'Citação Positiva'
        WHEN CHARINDEX('AF 2.8 - Todas as Intimações Positivas', eventos) > 0 THEN 'Citação Positiva'
        WHEN CHARINDEX('AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)', eventos) > 0 THEN 'Citação Positiva'
        WHEN (CHARINDEX('AF 0.2 - Pend. Doc: Contrato sem Registro ou Matrícula AF', eventos) > 0
            OR CHARINDEX('AF 0.3 - Pend. Doc: Sem Imagem do Contrato ou Matrícula', eventos) > 0
            OR CHARINDEX('AF 0.5 - Impedimento Cobrança / Jurídico', eventos) > 0)
            AND CHARINDEX('AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI', eventos) = 0
            THEN 'Proc. Suspenso'
        WHEN CHARINDEX('AF 7.2. Estorno de Consolidação', eventos) > 0
            AND CHARINDEX('AF 6.1 - Envio do Imóvel ao Real Estate', eventos) = 0
            THEN 'Proc. Suspenso'
        WHEN (CHARINDEX('AF 12.2 - Ação Contrária em Curso', eventos) > 0
            OR CHARINDEX('AF 12.4 - Ação Contrária com Liminar Atribuída', eventos) > 0
            OR CHARINDEX('AF 12.8 - Inviabilidade de Consolidação (Calculadora Negativa)', eventos) > 0
            OR CHARINDEX('AF 12.9 - Ônus na matrícula', eventos) > 0
            OR CHARINDEX('AF 12.10 - Impedimento Cobrança / Jurídico', eventos) > 0 )
            AND CHARINDEX('AF 5.1 - Consolidação da Propriedade', eventos) = 0
            AND CHARINDEX('AF 4.1 - Pagamento de Débitos Imóvel', eventos) = 0
            AND CHARINDEX('AF 6.1 - Envio do Imóvel ao Real Estate', eventos) = 0
            THEN 'Proc. Suspenso'
        ELSE 'Outro Status'
    END AS status
FROM 
    DossieEventos
ORDER BY 
    data_benner DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Produtos filtrados (32, 34, 14, 36, 35)




