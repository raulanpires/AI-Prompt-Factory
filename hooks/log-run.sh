#!/usr/bin/env bash
# Instrumentação. Serve três linhas da rúbrica e o protocolo de contaminação.
#
# Registo por sessão em $FACTORY_RUNS (default ~/.factory-runs):
#   <sid>.skills  skills que dispararam
#   <sid>.files   ficheiros tocados
#   <sid>.cmds    comandos Bash corridos
#   <sid>.env     hash e contagem do conjunto de skills instalado
#   <sid>.json    consolidado, no Stop
#
# Registar no mesmo script para SessionStart, PostToolUse e Stop.
set -uo pipefail

input=$(cat)
ev=$(printf '%s' "$input" | jq -r '.hook_event_name // "?"')
sid=$(printf '%s' "$input" | jq -r '.session_id // "none"')
out="${FACTORY_RUNS:-$HOME/.factory-runs}"
mkdir -p "$out"
b="$out/$sid"

case "$ev" in
  SessionStart)
    # Hash do conjunto instalado: mudança = evento de re-baseline.
    list=$(find "$HOME/.agents/skills" "$HOME/.claude/skills" -maxdepth 1 -mindepth 1 \
             2>/dev/null | sort | sed 's#.*/##' | sort -u)
    printf '%s' "$list" | sha256sum | cut -c1-12 > "$b.env"
    printf '%s' "$list" | grep -c . >> "$b.env"
    printf '%s' "$input" | jq -r '.cwd // ""' >> "$b.env"
    printf '%s' "$input" | jq -r '.transcript_path // ""' >> "$b.env"
    ;;
  PostToolUse)
    tool=$(printf '%s' "$input" | jq -r '.tool_name // ""')
    case "$tool" in
      Skill) printf '%s' "$input" | jq -r '.tool_input.skill // empty' >> "$b.skills" ;;
      Edit|Write|NotebookEdit)
             printf '%s' "$input" | jq -r '.tool_input.file_path // empty' >> "$b.files" ;;
      Bash)  printf '%s' "$input" | jq -r '.tool_input.command // empty' >> "$b.cmds" ;;
    esac
    ;;
  Stop)
    jq -n \
      --arg sid "$sid" \
      --arg ts "$(date -u +%FT%TZ)" \
      --arg envhash "$(sed -n 1p "$b.env" 2>/dev/null)" \
      --arg skillcount "$(sed -n 2p "$b.env" 2>/dev/null)" \
      --arg cwd "$(sed -n 3p "$b.env" 2>/dev/null)" \
      --arg transcript "$(printf '%s' "$input" | jq -r '.transcript_path // empty')" \
      --argjson skills "$(sort -u "$b.skills" 2>/dev/null | jq -Rsc 'split("\n")-[""]')" \
      --argjson files  "$(sort -u "$b.files"  2>/dev/null | jq -Rsc 'split("\n")-[""]')" \
      --argjson cmds   "$(cat "$b.cmds" 2>/dev/null | jq -Rsc 'split("\n")-[""]')" \
      '{session:$sid, at:$ts, cwd:$cwd, transcript:$transcript,
        env:{skillset_hash:$envhash, skills_installed:($skillcount|tonumber?)},
        skills_fired:$skills, files_touched:$files, commands:$cmds}' > "$b.json"
    ;;
esac
exit 0
