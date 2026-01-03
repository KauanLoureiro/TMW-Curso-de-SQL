--Saldo de pontos acumulado de cada usuário
WITH
tb1 AS (
    SELECT
    IdCliente,
    substr(DtCriacao, 1, 10) AS dia,
    sum(QtdePontos) AS pts_abs
    FROM transacoes
    GROUP BY IdCliente, dia)

SELECT *,
sum(pts_abs) OVER (PARTITION BY IdCliente ORDER BY dia) AS acumulado
FROM tb1