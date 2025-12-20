-- Em 2024, quantas transações de lovers tivemos?

SELECT  count(DISTINCT t2.IdTransacao)
      
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto


WHERE substr(t1.DtCriacao, 1, 4) = '2024' AND
        t3.DescCategoriaProduto = 'lovers'

