--Qual cliente juntou mais pontos positivos em 2025-05?
SELECT 
    IdCliente AS cliente,
    sum(QtdePontos) AS pts_acumulados

FROM transacoes

WHERE DtCriacao LIKE '2024-05%'

GROUP BY QtdePontos

ORDER BY QtdePontos DESC

LIMIT 1