--Quais clientes assinaram a lista de presença no dia 2025/08/25?

SELECT DISTINCT t1.IdCliente,
        t3.DescNomeProduto,
        t1.DtCriacao

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE substr(DtCriacao, 1, 10) = '2025-08-25' AND 
DescNomeProduto = 'Lista de presença'
