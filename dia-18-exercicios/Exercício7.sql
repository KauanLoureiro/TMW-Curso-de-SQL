-- Qual o produto mais transacionado?
SELECT 
    count(idTransacaoProduto),
    IdProduto
FROM transacao_produto

WHERE IdProduto IS NOT NULL

GROUP BY IdProduto

ORDER BY count(idTransacaoProduto) DESC