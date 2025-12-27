-- 10. Como foi a curva de Churn do Curso de SQL?
-- Fazendo por subquery

SELECT 
    Substr(DtCriacao, 1 , 10) AS dia, 
    count(DISTINCT IdCliente) AS qtdclientes,
    1.* count(DISTINCT IdCliente)/(
        SELECT count(DISTINCT IdCliente)
        FROM transacoes 
        WHERE substr(DtCriacao, 1 , 10) = '2025-08-25'
        ) AS pctDeRetencao

FROM transacoes

WHERE 
    DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-30' AND

    IdCliente IN
        (SELECT DISTINCT IdCliente
        FROM transacoes
        WHERE substr(DtCriacao, 1 , 10) = '2025-08-25')

GROUP BY dia

