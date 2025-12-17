-- Qual dia da semana tem mais pedidos em 2025?
SELECT 
    count(*),
    CASE 
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '0' THEN 'DOMINGO'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '1' THEN 'SEGUNDA'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '2' THEN 'TERÇA'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '3' THEN 'QUARTA'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '4' THEN 'QUINTA'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '5' THEN 'SEXTA'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '6' THEN 'SABADO'
    END AS dia_semana
FROM transacoes

WHERE substr(DtCriacao, 1, 4) = '2025'

GROUP BY dia_semana

ORDER BY count(DtCriacao) DESC

LIMIT 1
