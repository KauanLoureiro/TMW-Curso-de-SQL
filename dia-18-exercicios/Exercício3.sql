--Qual cliente fez mais transações no ano de 2024?
SELECT 
    IdCliente,
    count(IdTransacao) AS qtd_transact

FROM transacoes

GROUP BY IdCliente

ORDER BY qtd_transact DESC

LIMIT 1
