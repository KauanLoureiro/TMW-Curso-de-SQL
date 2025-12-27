--Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?

WITH 

clientes_1_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'),

presente_data AS (
    SELECT  
        IdCliente, 
        count(DISTINCT substr(DtCriacao, 1, 10)) AS qtd_dias
       

    FROM transacoes

    WHERE substr(DtCriacao, 1, 10) >= '2025-08-25' AND 
    substr(DtCriacao, 1, 10) <= '2025-08-29'

    GROUP BY IdCliente),

join_tb AS (
    SELECT * 
    FROM clientes_1_dia AS t1

    LEFT JOIN presente_data AS t2
    ON t1.IdCliente = t2.IdCliente)

SELECT round(avg(qtd_dias), 2)
FROM join_tb
