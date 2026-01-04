-- Agora é o ciclo completo = criação + atualização

DROP TABLE IF EXISTS df1;

CREATE TABLE IF NOT EXISTS df1(
    idCliente varchar(250) PRIMARY KEY,
    qtd_transact INT

);

INSERT INTO df1

SELECT IdCliente,
count (DISTINCT IdTransacao) AS qtd_transact
FROM transacoes
GROUP BY IdCliente;

SELECT * FROM df1;