SELECT * FROM clientes LEFT JOIN transacoes  ON clientes.idCliente = transacoes.idCliente

LIMIT 10