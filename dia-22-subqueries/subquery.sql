--Resolvendo o seguinte exercício por subquery: Quais clientes transacionaram o produto "Resgatar ponei?"


SELECT DISTINCT t3.IdCliente
FROM transacoes AS t3
WHERE t3.IdTransacao IN (
    
    SELECT t1.IdTransacao
    FROM transacao_produto AS t1
    WHERE t1.IdProduto IN (

        SELECT t2.IdProduto
        FROM produtos AS t2
        WHERE DescCategoriaProduto = 'ponei'
        
        )
    )
