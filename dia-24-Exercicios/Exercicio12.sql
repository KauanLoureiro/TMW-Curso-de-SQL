--12. Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

WITH 
Clientes_janeiro AS (SELECT DISTINCT IdCliente
FROM transacoes
WHERE substr(DtCriacao, 1, 7) = '2025-01'),

Clientes_curso AS (SELECT 
DISTINCT IdCliente,
Substr(DtCriacao, 1 , 10) AS dia_curso
FROM transacoes
WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-30')

SELECT 
t2.dia_curso,
count(DISTINCT t1.IdCliente)


FROM Clientes_janeiro AS t1

LEFT JOIN Clientes_curso AS t2
ON t1.IdCliente = t2.IdCliente

GROUP BY t2.dia_curso

ORDER BY dia_curso DESC