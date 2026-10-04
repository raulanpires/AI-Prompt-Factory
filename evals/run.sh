#!/usr/bin/env bash
# Monta uma corrida: worktree no commit base, só o prompt.md dentro, etiqueta cega.
#
#   bash evals/run.sh t03-pr6523 [A|B|C]
#
# NÃO corre o agente. Isso é teu — abres o Claude Code na worktree que isto
# imprime. O hook registra o resto.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TASK="${1:?uso: run.sh <pasta-da-tarefa> [etiqueta]}"
LABEL="${2:-A}"
DIR="$ROOT/evals/tasks/$TASK"
CLONES="${BENCH_CLONES:-$ROOT/.bench-clones}"
WT_ROOT="${FACTORY_WT:-${TMPDIR:-/tmp}/factory-wt}"

[ -d "$DIR" ] || { echo "tarefa inexistente: $DIR" >&2; exit 1; }
[ -f "$DIR/prompt.md" ] || { echo "falta prompt.md em $DIR" >&2; exit 1; }

meta() { grep -m1 "^\*\*$1:\*\*" "$DIR/expected.md" | sed "s/^\*\*$1:\*\* *//; s/\`//g"; }
BENCH="$(meta Banco)"
BASE="$(meta 'Commit base')"
[ -n "$BENCH" ] || { echo "expected.md sem **Banco:**" >&2; exit 1; }

REPO="$CLONES/$BENCH"
[ -d "$REPO/.git" ] || { echo "clone ausente: $REPO — corre bench/setup.sh" >&2; exit 1; }

# Armadilhas não fixam PR: usam o pin do banco.
case "$BASE" in
  ""|*"pin"*) BASE="$(awk -v b="$BENCH" '$1==b{print $2}' "$ROOT/bench/pins.txt")" ;;
esac
[ -n "$BASE" ] || { echo "sem commit base nem pin para $BENCH" >&2; exit 1; }

WT="$WT_ROOT/$TASK-$LABEL"
rm -rf "$WT"; mkdir -p "$WT_ROOT"
git -C "$REPO" worktree prune
git -C "$REPO" worktree add -q --detach "$WT" "$BASE"

# SÓ o prompt. O expected.md fica onde está.
cp "$DIR/prompt.md" "$WT/PEDIDO.md"

cat <<TXT

  corrida   $TASK  etiqueta $LABEL
  banco     $BENCH @ ${BASE:0:9}
  worktree  $WT

  1. cd "$WT"  (instalar deps se for a primeira vez neste banco)
  2. abre o Claude Code aí e passa-lhe o conteúdo de PEDIDO.md
  3. quando terminar:  bash evals/score.sh $TASK $LABEL

  Não abras o expected.md antes de pontuar.

TXT
