
DROP TABLE IF EXISTS relatorio_diario_acumulado;

CREATE TABLE IF NOT EXISTS relatorio_diario_acumulado AS

WITH
tab1 AS
    (SELECT
    substr(DtCriacao, 1, 10) AS dia,
    count(DISTINCT IdTransacao) AS qtd_transact
    FROM transacoes
    GROUP BY dia
    ORDER BY dia)

SELECT *,
sum(qtd_transact) OVER (ORDER BY dia) AS acumulado
FROM tab1;

.tables
