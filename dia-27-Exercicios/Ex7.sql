-- Qual o dia da semana mais ativo de cada usuário?
WITH
qtd_transact AS (
    SELECT

    substr(DtCriacao, 1, 10) AS dia,
    IdCliente,
    count(DISTINCT IdTransacao)	AS qtd_transact_dia

    FROM transacoes

    GROUP BY IdCliente, dia),

semana AS (
    SELECT 

    IdCliente,
    strftime('%w' , datetime(dia)) AS dia_semana,
    sum(qtd_transact_dia) AS transact_diasemana

    FROM qtd_transact

    GROUP BY IdCliente, dia_semana),

Ordenacao AS (
    SELECT *,
    row_number() OVER (PARTITION BY IdCliente ORDER BY transact_diasemana DESC) AS rn
    FROM semana)

SELECT IdCliente, transact_diasemana, dia_semana
FROM Ordenacao
WHERE rn = 1