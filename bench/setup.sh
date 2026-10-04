#!/usr/bin/env bash
# Clona os repositórios do banco e fixa o commit base de cada um.
# Correr uma vez. Voltar a correr NÃO atualiza os pins.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLONES="${BENCH_CLONES:-$ROOT/.bench-clones}"
PINS="$ROOT/bench/pins.txt"

REPOS=(
  "tanstack-table|https://github.com/TanStack/table.git"
  "drizzle-orm|https://github.com/drizzle-team/drizzle-orm.git"
  "excalidraw|https://github.com/excalidraw/excalidraw.git"
)

mkdir -p "$CLONES"
touch "$PINS"

for entry in "${REPOS[@]}"; do
  name="${entry%%|*}"; url="${entry#*|}"
  dir="$CLONES/$name"

  if [ -d "$dir/.git" ]; then
    echo "já existe: $name"
  else
    echo "clonando: $name"
    git clone -q "$url" "$dir"
  fi

  if grep -q "^$name " "$PINS" 2>/dev/null; then
    echo "  pin já fixado: $(grep "^$name " "$PINS")"
  else
    sha="$(git -C "$dir" rev-parse HEAD)"
    echo "$name $sha" >> "$PINS"
    echo "  pin fixado: $sha"
  fi
done

echo
echo "Clones em: $CLONES"
echo "Pins em:   $PINS"
echo "Worktree para uma tarefa:"
echo "  git -C \"$CLONES/tanstack-table\" worktree add /tmp/t01 <sha do pin>"
