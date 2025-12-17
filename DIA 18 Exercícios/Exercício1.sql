--Quantos clientes tem email cadastrado?

SELECT count(*) AS Emails_cadastrados

FROM clientes

WHERE flEmail = 1