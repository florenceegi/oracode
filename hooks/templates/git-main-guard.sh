#!/usr/bin/env bash
# git-main-guard.sh — PreToolUse hook: blocca force push verso main/master
# Matcher: Bash

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Solo comandi git push
if ! echo "$COMMAND" | grep -qE '\bgit\b.*\bpush\b'; then
  exit 0
fi

# Controlla --force o -f
HAS_FORCE=$(echo "$COMMAND" | grep -qE '\s(--force|-f)(\s|$)' && echo "yes" || echo "no")

# Controlla se il target branch è main o master
HAS_MAIN=$(echo "$COMMAND" | grep -qE '\b(main|master)\b' && echo "yes" || echo "no")

if [ "$HAS_FORCE" = "yes" ] && [ "$HAS_MAIN" = "yes" ]; then
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"BLOCCO git-main-guard: git push --force verso main/master è vietato — sovrascrive la storia condivisa. Usa un branch feature oppure richiedi approvazione esplicita."},"systemMessage":"🛑 git-main-guard: force push su main/master BLOCCATO"}'
  exit 2
fi

exit 0
