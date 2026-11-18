#!/usr/bin/env bash
# Compara TB_DADOS2 com datasets/novo_dataset.csv dentro do container.
# Uso: docker compose up -d --wait && ./scripts/verifica.sh
set -euo pipefail

resultado=$(docker compose exec -T mysql \
  mysql -h127.0.0.1 -uroot -proot --batch --skip-column-names \
  < tests/verifica_resultado.sql 2>/dev/null)

read -r linhas_resultado linhas_esperadas so_no_resultado so_no_esperado <<< "$resultado"

echo "Linhas em TB_DADOS2:              $linhas_resultado"
echo "Linhas em novo_dataset.csv:       $linhas_esperadas"
echo "Linhas só no resultado:           $so_no_resultado"
echo "Linhas só no arquivo exportado:   $so_no_esperado"

if [[ "$linhas_resultado" == "286" && "$linhas_esperadas" == "286" \
   && "$so_no_resultado" == "0" && "$so_no_esperado" == "0" ]]; then
  echo "OK: o script reproduz o dataset exportado."
else
  echo "ERRO: o resultado do script difere de datasets/novo_dataset.csv." >&2
  exit 1
fi
