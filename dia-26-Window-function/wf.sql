WITH 
    tab_1 AS

    
    (SELECT 
    substr(DtCriacao, 1, 10) AS dia,
    count(DISTINCT IdTransacao) AS qtdtransact

    FROM transacoes
    WHERE 
            DtCriacao >= '2025-08-25' AND
            DtCriacao < '2025-08-30'

    GROUP BY substr(DtCriacao, 1, 10))

SELECT *,
sum(qtdtransact) OVER (ORDER BY dia) AS Acumulado

FROM tab_1
