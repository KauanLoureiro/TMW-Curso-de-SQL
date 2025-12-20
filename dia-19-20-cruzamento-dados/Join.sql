-- Entendendo os conceitos iniciais de join 

SELECT  t1.*,
        t2.qtdePontos

FROM clientes AS t1

LEFT JOIN transacoes AS t2  
ON t1.idCliente = t2.idCliente

LIMIT 10