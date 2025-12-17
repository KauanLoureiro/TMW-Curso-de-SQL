--Qual o valor médio de pontos positivos por dia?

SELECT
    substr(DtCriacao , 1 , 10) AS Dia,
    round(avg(QtdePontos), 2) AS media_pts_dia
FROM transacoes

WHERE QtdePontos > 0 

GROUP BY Dia