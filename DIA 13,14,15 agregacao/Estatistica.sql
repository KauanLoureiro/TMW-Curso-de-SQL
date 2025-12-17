SELECT 
    sum(QtdePontos),

    sum(CASE
        WHEN QtdePontos > 0 THEN QtdePontos
    END) AS Pontos_positivos,

    sum(CASE
        WHEN QtdePontos < 0 THEN QtdePontos
    END) AS Pontos_negativos,

    count(CASE
        WHEN QtdePontos < 0 THEN QtdePontos
    END) AS Quant_neg,

    round(avg(qtdePontos),2) AS media_pts,

    max(qtdePontos) AS maior_cart
FROM transacoes

WHERE 
    DtCriacao >= '2025-02-01' AND
    DtCriacao < '2025-03-01'

ORDER BY DtCriacao DESC
