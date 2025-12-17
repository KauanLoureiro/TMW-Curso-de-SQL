SELECT 
    idCliente,
    qtdePontos,
    CASE 
        WHEN qtdePontos <= 500 THEN 'Iniciante'
        WHEN qtdePontos <= 1000 THEN 'Aprendiz'
        WHEN qtdePontos <= 5000 THEN 'Intermediário'
        WHEN qtdePontos <= 10000 THEN 'Avançado'
        ELSE 'Mestre'
    END AS class

FROM clientes
ORDER BY qtdePontos DESC