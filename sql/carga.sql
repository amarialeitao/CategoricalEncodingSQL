# Carga dos dados originais em TB_DADOS
# Equivale ao Table Data Import Wizard do MySQL Workbench.
# O arquivo precisa estar no diretório definido em secure_file_priv
# (no container, /var/lib/mysql-files, para onde docker/copia_dados.sh
# copia os CSVs).

LOAD DATA INFILE '/var/lib/mysql-files/breast-cancer.csv'
INTO TABLE db.TB_DADOS
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
