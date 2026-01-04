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
)

SELECT 
    T1.*,
    T2.qtdePontos,
    T2.Life_time
FROM tb1 AS T1

LEFT JOIN df_clientes AS T2
ON T1.idCliente = T2.idCliente