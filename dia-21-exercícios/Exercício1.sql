-- Quais clientes mais perderam pontos por Lover?


SELECT t1.IdCliente,
        sum(t2.vlProduto),
        t3.DescCategoriaProduto

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t1.QtdePontos < 0 AND t3.DescCategoriaProduto = 'lovers'

GROUP BY IdCliente

ORDER BY sum(t2.vlProduto)	 

LIMIT 5