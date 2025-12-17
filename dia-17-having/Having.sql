SELECT 
    IdCliente,
    sum(QtdePontos) AS tot_pts,
    count(IdTransacao) AS tot_transacts
FROM transacoes

WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-1'

GROUP BY QtdePontos

HAVING tot_pts > 5000 

ORDER BY tot_pts DESC


