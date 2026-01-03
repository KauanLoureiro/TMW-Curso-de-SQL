--Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH
cadastro AS (
    SELECT 
    substr(DtCriacao, 1, 10) AS dia,
    count(DISTINCT idCliente) AS absoluto
    FROM clientes

    GROUP BY dia
    ORDER BY dia),

Acumulado_Absoluto AS (
    SELECT *,
    sum(absoluto) OVER (ORDER BY dia) AS acumulado
    FROM cadastro)

SELECT *
FROM Acumulado_Absoluto
