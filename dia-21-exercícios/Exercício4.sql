--Clientes mais antigos, tem mais frequência de transação?
SELECT t1.idCliente,
        round(julianday('now') - julianday(t1.DtCriacao), 2) AS dias_criacao,
        count(DISTINCT t2.IdTransacao)

FROM clientes AS t1

LEFT JOIN transacoes AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t1.idCliente

ORDER BY count(DISTINCT t2.IdTransacao) DESC
