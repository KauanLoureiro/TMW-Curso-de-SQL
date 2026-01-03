--Média de recorrência por cliente

WITH 
cliente_dia AS 
    (SELECT
        DISTINCT IdCliente,
        substr(DtCriacao, 1, 10) AS DIA
    FROM transacoes

    WHERE substr(DtCriacao, 1, 4) = '2025'

    ORDER BY IdCliente, DIA),

lag_tab AS 
    (SELECT *,
    lag(DIA) OVER (PARTITION BY IdCliente ORDER BY DIA) AS lagday
    FROM cliente_dia),

rec AS 
    (SELECT *,
    julianday(DIA)-julianday(lagday) AS recorrencia
    FROM lag_tab)

SELECT 
IdCliente,
avg(recorrencia) AS recorrencia_media

FROM rec

GROUP BY IdCliente