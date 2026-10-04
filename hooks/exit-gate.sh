#!/usr/bin/env bash
# Stop — recusa terminar enquanto o portão de saída não passar.
#
# Comando lido de .factory/gate.sh do repositório. Sem esse ficheiro, não bloqueia.
# Contador de 3 tentativas: ao fim delas deixa passar com aviso, para não entrar
# em luta infinita com o agente.
set -uo pipefail

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // "."')
sid=$(printf '%s' "$input" | jq -r '.session_id // "none"')
gate="$cwd/.factory/gate.sh"
[ -f "$gate" ] || exit 0

tries="${TMPDIR:-/tmp}/factory-gate-$sid"
n=$(cat "$tries" 2>/dev/null || echo 0)

if out=$(bash "$gate" 2>&1); then
  rm -f "$tries"
  exit 0
fi

n=$((n + 1))
echo "$n" > "$tries"

if [ "$n" -ge 3 ]; then
  rm -f "$tries"
  jq -n --arg m "Portão de saída falhou 3 vezes; a passar com aviso." \
    '{systemMessage:$m}'
  exit 0
fi

printf 'Portão de saída falhou (tentativa %s/3):\n%s\n' "$n" "$(printf '%s' "$out" | tail -25)" >&2
exit 2
