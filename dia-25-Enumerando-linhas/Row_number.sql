--13. Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?

WITH
    Prim_dia AS (SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'),


    Engajamento_geral AS (SELECT IdCliente, 
    substr(DtCriacao, 1, 10) AS dia,
    count(DISTINCT IdTransacao) AS qtd_transact,
    CAST(IdCliente AS TEXT)||CAST(substr(DtCriacao, 1, 10) AS TEXT) AS uniao
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) >= '2025-08-25' AND
    substr(DtCriacao, 1, 10) <= '2025-08-29'
    GROUP BY uniao
    ORDER BY IdCliente, dia),

    Window_fct AS (SELECT t1.IdCliente, 
    t2.dia,
    t2.qtd_transact,
    row_number() OVER (PARTITION BY t1.IdCliente ORDER BY t2.qtd_transact DESC) AS rn

    FROM Prim_dia AS t1

    LEFT JOIN Engajamento_geral AS t2
    ON t1.IdCliente = t2.IdCliente)

SELECT * 
FROM Window_fct
WHERE rn = 1
