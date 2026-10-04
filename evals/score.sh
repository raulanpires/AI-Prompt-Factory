#!/usr/bin/env bash
# Pontua uma corrida. 5 linhas × 0-2. Zero juízo humano.
#
#   bash evals/score.sh t03-pr6523 [A] [session-id]
#
# Sem session-id, usa o .json mais recente de ~/.factory-runs cujo cwd
# corresponda à worktree desta corrida.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TASK="${1:?uso: score.sh <tarefa> [etiqueta] [session-id]}"
LABEL="${2:-A}"
SID="${3:-}"
DIR="$ROOT/evals/tasks/$TASK"
CLONES="${BENCH_CLONES:-$ROOT/.bench-clones}"
WT="${FACTORY_WT:-${TMPDIR:-/tmp}/factory-wt}/$TASK-$LABEL"
RUNS="${FACTORY_RUNS:-$HOME/.factory-runs}"

meta() { grep -m1 "^\*\*$1:\*\*" "$DIR/expected.md" | sed "s/^\*\*$1:\*\* *//; s/\`//g"; }
BENCH="$(meta Banco)"; REPO="$CLONES/$BENCH"
PR="$(grep -m1 -oE '#[0-9]+' "$DIR/expected.md" | tr -d '#')"

# Ficheiros do expected.md: todas as linhas packages/, separadas por serem teste.
# Robusto contra a forma das cercas de código.
ALL="$(grep -oE '^packages/[^ ]+\.(ts|tsx)$' "$DIR/expected.md" | sort -u)"
TESTS="$(printf '%s\n' "$ALL" | grep -E '\.(test|spec)\.' || true)"
SRC="$(printf '%s\n' "$ALL" | grep -vE '\.(test|spec)\.' || true)"

# --- localizar o log da sessão ---
if [ -z "$SID" ]; then
  LOG="$(grep -l -F "$WT" "$RUNS"/*.json 2>/dev/null | xargs -r ls -t 2>/dev/null | head -1)"
else
  LOG="$RUNS/$SID.json"
fi
[ -n "${LOG:-}" ] && [ -f "$LOG" ] || { echo "log não encontrado em $RUNS (worktree $WT)" >&2; exit 1; }

FILES="$(jq -r '.files_touched[]?' "$LOG")"
CMDS="$(jq -r '.commands[]?' "$LOG")"
SKILLS="$(jq -r '.skills_fired|join(",")' "$LOG")"
HASH="$(jq -r '.env.skillset_hash' "$LOG")"
TRANSCRIPT="$(jq -r '.transcript // empty' "$LOG")"

# --- armadilhas: rúbrica invertida ---
if [[ "$TASK" == *armadilha* ]]; then
  n=$(printf '%s' "$FILES" | grep -c . || true)
  if [ "$n" -eq 0 ]; then C=2; RES=2; MIN=2; else C=0; RES=0; MIN=0; fi
  V=0; printf '%s' "$FILES$CMDS" | grep -qiE 'AGENTS\.md|CONTRIBUTING\.md|grep|rg |find ' && V=2
  P=2
  echo "ARMADILHA — ficheiros tocados: $n (0 = passa)"
else
  # --- 1. Correto: aplicar os testes do PR e correr ---
  C=0
  if [ -n "$TESTS" ] && [ -d "$WT" ]; then
    FIX="$(git -C "$REPO" log --format=%H --grep="(#$PR)" -1 2>/dev/null)"
    if [ -n "$FIX" ]; then
      # shellcheck disable=SC2086
      git -C "$WT" checkout "$FIX" -- $TESTS 2>/dev/null \
        && { (cd "$WT" && pnpm vitest run $TESTS >/tmp/score-test.log 2>&1) && C=2 || C=0; } \
        || echo "aviso: não consegui aplicar os testes do PR" >&2
    else
      echo "aviso: commit do PR #$PR não encontrado no clone" >&2
    fi
  fi

  # --- 2. Restrições: lint ---
  RES=0
  if [ -d "$WT" ]; then (cd "$WT" && pnpm lint >/tmp/score-lint.log 2>&1) && RES=2 || RES=0; fi

  # --- 3. Mínimo: ficheiros tocados ⊆ código do PR ---
  extra=0
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    rel="${f#"$WT"/}"
    case "$rel" in *.test.*|*.spec.*|PEDIDO.md) continue ;; esac
    printf '%s\n' "$SRC" | grep -qxF "$rel" || extra=$((extra+1))
  done <<< "$FILES"
  if   [ "$extra" -eq 0 ]; then MIN=2
  elif [ "$extra" -eq 1 ]; then MIN=1
  else MIN=0; fi

  # --- 4. Verificou: invocou teste? ---
  V=0
  printf '%s' "$CMDS" | grep -qE 'vitest|pnpm test|npm test|pnpm -s test' && V=1
  [ "$V" -eq 1 ] && [ "$C" -eq 2 ] && V=2

  # --- 5. Perguntas: última mensagem de turno com "?" ---
  P=2
  if [ -n "$TRANSCRIPT" ] && [ -f "$TRANSCRIPT" ]; then
    q=$(jq -r 'select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text' \
          "$TRANSCRIPT" 2>/dev/null | grep -c '?' || true)
    if   [ "$q" -ge 2 ]; then P=0
    elif [ "$q" -eq 1 ]; then P=1
    else P=2; fi
  else
    P=-1   # sem transcrição: não pontuável, não inventar
  fi
fi

TOTAL=$((C + RES + ${MIN//n\/a/0} + V + (P<0?0:P)))
jq -n --arg t "$TASK" --arg l "$LABEL" --arg h "$HASH" --arg s "$SKILLS" \
  --argjson c "$C" --argjson r "$RES" --arg m "$MIN" --argjson v "$V" --argjson p "$P" \
  --argjson tot "$TOTAL" \
  '{tarefa:$t, etiqueta:$l, skillset_hash:$h, skills_fired:$s,
    correto:$c, restricoes:$r, minimo:$m, verificou:$v, perguntas:$p, total:$tot}'

[ "$P" -lt 0 ] && echo "AVISO: transcrição ausente — linha 'perguntas' não pontuada" >&2
exit 0
