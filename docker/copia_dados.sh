#!/bin/bash
# Executado pelo entrypoint do MySQL antes dos scripts SQL.
# Copia os CSVs (montados como somente leitura em /datasets) para o diretório
# de secure_file_priv, de onde LOAD DATA INFILE pode ler.
cp /datasets/*.csv /var/lib/mysql-files/
