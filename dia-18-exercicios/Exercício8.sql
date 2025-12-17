--Qual o produto com mais pontos transacionados?
SELECT IdProduto,
    sum(QtdeProduto * vlProduto) AS Pontuacao

FROM transacao_produto

GROUP BY IdProduto	

ORDER BY Pontuacao DESC