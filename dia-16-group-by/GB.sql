-- SELECT 
--     IdProduto,
--     count(*)
-- FROM transacao_produto
-- GROUP BY IdProduto

SELECT 
    IdCliente,
    sum(QtdePontos) AS tot_pts,
    count(IdTransacao) AS tot_transacts
FROM transacoes

WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-1'

GROUP BY QtdePontos

ORDER BY tot_pts DESC

LIMIT 10


