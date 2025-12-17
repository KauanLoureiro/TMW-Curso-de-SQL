SELECT 
    count(IdTransacao) AS quant_transacoes_julho,
    count(DISTINCT idCliente) AS quant_clientes_transact_jul

FROM transacoes

WHERE 
    DtCriacao >= '2025-07-01' AND
    DtCriacao < '2025-08-01'

ORDER BY DtCriacao DESC