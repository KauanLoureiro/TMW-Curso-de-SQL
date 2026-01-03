
WITH
tab1 AS 
    (SELECT 
    IdCliente,
    substr(DtCriacao, 1, 10) AS DIA,
    count(DISTINCT IdTransacao) AS qtdtransact

    FROM transacoes

    WHERE 
    DtCriacao >= '2025-08-25' AND
    DtCriacao < '2025-08-30'

    GROUP BY IdCliente, DIA)

SELECT 
*,
sum(qtdtransact) OVER (PARTITION BY IdCliente ORDER BY dia) AS Acumulado,
lag(qtdtransact) OVER (PARTITION BY IdCliente ORDER BY dia) AS lag

FROM tab1