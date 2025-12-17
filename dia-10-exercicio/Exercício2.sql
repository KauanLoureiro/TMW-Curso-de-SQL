-- Lista de pedidos realizados no fim de semana

SELECT  
        IdTransacao , 
        IdCliente,
        QtdePontos,
        DescSistemaOrigem,
        datetime(substr(DtCriacao, 1, 19)) as 'Momento da transação',
        strftime('%w' , datetime(substr(DtCriacao, 1, 10))) as 'Dia da semana'

FROM transacoes

WHERE 
        -- strftime('%w' , datetime(substr(DtCriacao, 1, 10))) = '0' OR
        -- strftime('%w' , datetime(substr(DtCriacao, 1, 10))) = '5' OR
        -- strftime('%w' , datetime(substr(DtCriacao, 1, 10))) = '6'
        strftime('%w' , datetime(substr(DtCriacao, 1, 10))) IN ('0', '5', '6')


