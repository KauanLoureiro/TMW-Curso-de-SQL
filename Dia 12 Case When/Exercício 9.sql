SELECT 
    IdTransacao,
    QtdePontos,
    CASE
        WHEN QtdePontos < 10 THEN 'BAIXO'
        WHEN QtdePontos < 500 THEN 'MEDIO'
        WHEN QtdePontos >= 500 THEN 'ALTO'
    END AS Classificacao
FROM transacoes
ORDER BY QtdePontos DESC