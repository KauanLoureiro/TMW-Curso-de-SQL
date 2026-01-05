WITH
df_transact AS (
    SELECT 
        idCliente,
        IdTransacao,
        QtdePontos,
        datetime(substr(DtCriacao, 1, 19)) AS Data_hora,
        julianday('now') - julianday(DtCriacao) AS difftime
    
    FROM transacoes),


tb1 AS (
    SELECT
        idCliente,
        count(DISTINCT IdTransacao) AS Qtd_transact_Life,
        count(CASE WHEN difftime <= 56 THEN IdTransacao END) AS Qtd_transact_D56,
        count(CASE WHEN difftime <= 28 THEN IdTransacao END) AS Qtd_transact_D28,
        count(CASE WHEN difftime <= 14 THEN IdTransacao END) AS Qtd_transact_D14,
        count(CASE WHEN difftime <= 7 THEN IdTransacao END) AS Qtd_transact_D7,

        round(min(difftime), 1) AS dt_last_transact,

        sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS Pts_positivos_vida,
        sum(CASE WHEN QtdePontos > 0  AND difftime <= 56 THEN QtdePontos ELSE 0 END) AS Pts_positivos_D56,
        sum(CASE WHEN QtdePontos > 0  AND difftime <= 28 THEN QtdePontos ELSE 0 END) AS Pts_positivos_D28,
        sum(CASE WHEN QtdePontos > 0  AND difftime <= 14 THEN QtdePontos ELSE 0 END) AS Pts_positivos_D14,
        sum(CASE WHEN QtdePontos > 0  AND difftime <= 7 THEN QtdePontos ELSE 0 END) AS Pts_positivos_D7,

        sum(CASE WHEN QtdePontos < 0 THEN QtdePontos ELSE 0 END) AS Pts_negativos_vida,
        sum(CASE WHEN QtdePontos < 0  AND difftime <= 56 THEN QtdePontos ELSE 0 END) AS Pts_negativos_D56,
        sum(CASE WHEN QtdePontos < 0  AND difftime <= 28 THEN QtdePontos ELSE 0 END) AS Pts_negativos_D28,
        sum(CASE WHEN QtdePontos < 0  AND difftime <= 14 THEN QtdePontos ELSE 0 END) AS Pts_negativos_D14,
        sum(CASE WHEN QtdePontos < 0  AND difftime <= 7 THEN QtdePontos ELSE 0 END) AS Pts_negativos_D7
    FROM df_transact

    GROUP BY idCliente),

df_clientes AS (
    SELECT idCliente,
    QtdePontos,
    julianday('now') - julianday(DtCriacao) AS Life_time
    FROM clientes
),

DF1 AS (SELECT 
    T1.*,
    T2.qtdePontos,
    T2.Life_time
FROM tb1 AS T1

LEFT JOIN df_clientes AS T2
ON T1.idCliente = T2.idCliente),

tb3 AS (
SELECT t1.*, t2.idTransacaoProduto, t2.IdProduto
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
),

tb4 AS (
SELECT 
    IdCliente, 
    IdProduto, 

    count(IdProduto) AS qtd_produto_vida,
    count(CASE WHEN julianday('now') - julianday(DtCriacao) <= 56 THEN IdProduto END) AS qtd_produto_D56,
    count(CASE WHEN julianday('now') - julianday(DtCriacao) <= 28 THEN IdProduto END) AS qtd_produto_D28,
    count(CASE WHEN julianday('now') - julianday(DtCriacao) <= 14 THEN IdProduto END) AS qtd_produto_D14,
    count(CASE WHEN julianday('now') - julianday(DtCriacao) <= 7 THEN IdProduto END) AS qtd_produto_D7

FROM tb3

GROUP BY IdCliente, IdProduto),

tb5 AS (
    SELECT *,
    row_number() OVER (PARTITION BY IdCliente ORDER BY qtd_produto_vida DESC) AS rn_vida,
    row_number() OVER (PARTITION BY IdCliente ORDER BY qtd_produto_D56 DESC) AS rn_D56,
    row_number() OVER (PARTITION BY IdCliente ORDER BY qtd_produto_D28 DESC) AS rn_D28,
    row_number() OVER (PARTITION BY IdCliente ORDER BY qtd_produto_D14 DESC) AS rn_D14,
    row_number() OVER (PARTITION BY IdCliente ORDER BY qtd_produto_D7 DESC) AS rn_D7
    FROM tb4),

pdt_vida AS (
    SELECT 
    c1.idCliente, c2.DescNomeProduto AS produto_vida
    FROM tb5 AS c1

    LEFT JOIN produtos AS c2
    ON c1.IdProduto = c2.IdProduto
    WHERE rn_vida=1),

pdt_D56 AS (
    SELECT 
    c1.idCliente, c2.DescNomeProduto AS produto_D56
    FROM tb5 AS c1

    LEFT JOIN produtos AS c2
    ON c1.IdProduto = c2.IdProduto
    WHERE rn_D56=1),

pdt_D28 AS (
    SELECT 
    c1.idCliente, c2.DescNomeProduto AS produto_D28
    FROM tb5 AS c1

    LEFT JOIN produtos AS c2
    ON c1.IdProduto = c2.IdProduto
    WHERE rn_D28=1),

pdt_D14 AS (
    SELECT 
    c1.idCliente, c2.DescNomeProduto AS produto_D14
    FROM tb5 AS c1

    LEFT JOIN produtos AS c2
    ON c1.IdProduto = c2.IdProduto
    WHERE rn_D14=1),

pdt_D7 AS (
    SELECT 
    c1.idCliente, c2.DescNomeProduto AS produto_D7
    FROM tb5 AS c1

    LEFT JOIN produtos AS c2
    ON c1.IdProduto = c2.IdProduto
    WHERE rn_D7=1),

pdt_fim AS (
    SELECT a1.idCliente, a1.produto_vida, a2.produto_D56, a3.produto_D28, a4.produto_D14, a5.produto_D7
    FROM pdt_vida AS a1

    LEFT JOIN pdt_D56 AS a2
    ON a1.idCliente = a2.idCliente

    LEFT JOIN pdt_D28 AS a3
    ON a1.idCliente = a3.idCliente

    LEFT JOIN pdt_D14 AS a4
    ON a1.idCliente = a4.idCliente

    LEFT JOIN pdt_D7 AS a5
    ON a1.idCliente = a5.idCliente)

SELECT b1.*, b2.produto_vida, b2.produto_D56, b2.produto_D28, b2.produto_D14, b2.produto_D7
FROM DF1 AS b1

LEFT JOIN pdt_fim AS b2
ON b1.idCliente = b2.idCliente