SELECT * FROM relatorio_diario_acumulado;

UPDATE relatorio_diario_acumulado
SET qtd_transact = 'Aqui foi alterado'
WHERE dia = '2024-03-13';

SELECT * FROM relatorio_diario_acumulado
WHERE dia = '2024-03-13';