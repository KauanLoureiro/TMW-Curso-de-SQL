--Quantos produtos são de rpg?
SELECT count(*)

FROM produtos

GROUP BY DescCategoriaProduto

HAVING DescCategoriaProduto = 'rpg'
