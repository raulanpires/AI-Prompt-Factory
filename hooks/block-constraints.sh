#!/usr/bin/env bash
# PreToolUse — nega edições que violem as restrições duras do projeto.
#
# Guiado por dados, não por projeto: lê .factory/forbidden.txt do repositório
# onde está a correr. Um glob por linha; # comenta.
#
#   src/generated/**        ficheiro que nunca se edita à mão
#   !grep:<padrão>          texto que não pode aparecer no conteúdo escrito
#
# Sem esse ficheiro, não bloqueia nada e sai limpo.
set -uo pipefail

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // "."')
rules="$cwd/.factory/forbidden.txt"
[ -f "$rules" ] || exit 0

path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')
content=$(printf '%s' "$input" | jq -r '.tool_input.content // .tool_input.new_string // empty')

deny() {
  jq -n --arg r "$1" '{hookSpecificOutput:{
    hookEventName:"PreToolUse",
    permissionDecision:"deny",
    permissionDecisionReason:$r}}'
  exit 0
}

while IFS= read -r rule || [ -n "$rule" ]; do
  case "$rule" in ''|'#'*) continue ;; esac

  if [ "${rule#!grep:}" != "$rule" ]; then
    pat="${rule#!grep:}"
    [ -n "$content" ] && printf '%s' "$content" \
      | grep -qF -- "$pat" && deny "Restrição dura: o conteúdo não pode conter '$pat'."
    continue
  fi

  rel="${path#"$cwd"/}"
  # shellcheck disable=SC2254
  case "$rel" in
    $rule) deny "Restrição dura: '$rule' não é editável neste projeto." ;;
  esac
done < "$rules"

exit 0
