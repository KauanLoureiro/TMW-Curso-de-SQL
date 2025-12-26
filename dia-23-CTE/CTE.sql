-- Dos clientes que começaram SQL no primeiro dia, quantos chegaram ao 5o dia?

WITH 

clientes_primeiro_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'),

clientes_segundo_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-29'),

tb_join AS (
    SELECT t1.IdCliente AS prim_cliente,
           t2.IdCliente AS seg_cliente

    FROM clientes_primeiro_dia AS t1

    LEFT JOIN clientes_segundo_dia AS t2
    ON t1.IdCliente = t2.IdCliente)

SELECT 
count(prim_cliente),
count(seg_cliente),
1. *count(seg_cliente)/count(prim_cliente) AS razao

FROM tb_join
