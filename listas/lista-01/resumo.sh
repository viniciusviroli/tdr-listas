#!/usr/bin/env bash
set -euo pipefail

# Verifica argumentos
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 arquivo.csv numero_da_coluna" >&2
    exit 1
fi

arquivo="$1"
coluna="$2"

# Nome da coluna (primeira linha)
nome_coluna=$(head -n 1 "$arquivo" | awk -F, -v c="$coluna" '{print $c}')

# Número de observações (descontando o cabeçalho)
observacoes=$(tail -n +2 "$arquivo" | wc -l)

# Quantos valores NA na coluna
nas=$(tail -n +2 "$arquivo" | awk -F, -v c="$coluna" '$c=="NA"{cont++} END{print cont+0}')

# Média por mês + número de dias medidos
medias=$(tail -n +2 "$arquivo" |
    awk -F, -v c="$coluna" '
        $c != "NA" {
            soma[$5] += $c
            dias[$5]++
        }
        END {
            for (m in soma)
                printf "Mês %s: média %.2f (%d dias)\n", m, soma[m]/dias[m], dias[m]
        }')

# Impressão final
echo "Coluna: $nome_coluna"
echo "Observações: $observacoes"
echo "Valores NA: $nas"
echo "$medias"
