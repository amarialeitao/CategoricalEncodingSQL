# Verifica se TB_DADOS2 é idêntica ao arquivo exportado datasets/novo_dataset.csv
# Retorna uma linha com quatro contagens; o teste passa quando:
#   linhas_resultado = 286, linhas_esperadas = 286,
#   so_no_resultado = 0 e so_no_esperado = 0.

DROP TABLE IF EXISTS db.TB_ESPERADO;
CREATE TABLE db.TB_ESPERADO LIKE db.TB_DADOS2;

LOAD DATA INFILE '/var/lib/mysql-files/novo_dataset.csv'
INTO TABLE db.TB_ESPERADO
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

# EXCEPT ALL compara as tabelas linha a linha, inclusive linhas repetidas,
# sem depender da ordem.
SELECT
    (SELECT COUNT(*) FROM db.TB_DADOS2) AS linhas_resultado,
    (SELECT COUNT(*) FROM db.TB_ESPERADO) AS linhas_esperadas,
    (SELECT COUNT(*) FROM (TABLE db.TB_DADOS2 EXCEPT ALL TABLE db.TB_ESPERADO) AS a) AS so_no_resultado,
    (SELECT COUNT(*) FROM (TABLE db.TB_ESPERADO EXCEPT ALL TABLE db.TB_DADOS2) AS b) AS so_no_esperado;

DROP TABLE db.TB_ESPERADO;
