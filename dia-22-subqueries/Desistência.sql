-- Dos clientes que começaram SQL no primeiro dia, quantos chegaram ao 5o dia?

SELECT count(DISTINCT IdCliente)
FROM transacoes
WHERE 
    substr(DtCriacao, 1, 10) = '2025-08-29' AND
    IdCliente IN (
        SELECT DISTINCT IdCliente
        FROM transacoes
        WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
    )

