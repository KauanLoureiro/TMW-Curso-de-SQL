-- Ordene do mais antigo e com mais ponto os usuários que tenham twitch

SELECT * 
FROM clientes
WHERE 
        flTwitch = 1 

ORDER BY 
        DtCriacao ASC,
        qtdePontos DESC