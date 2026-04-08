#!/usr/bin/env bash
# oracode env-guard — blocks exposure of secrets in code
# Trigger: PreToolUse Bash
# Prevents: .env files, credentials, API keys from being echoed/catted/committed

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

[ -z "$CMD" ] && exit 0

# Block cat/echo of .env files
if echo "$CMD" | grep -qE '(cat|head|tail|less|more|echo|printf).*\.env'; then
  echo "ORACODE ENV-GUARD: blocked access to .env file. Secrets must never be exposed."
  echo "If you need a value, ask the user to provide it."
  exit 2
fi

# Block git add of .env
if echo "$CMD" | grep -qE 'git\s+add.*\.env'; then
  echo "ORACODE ENV-GUARD: blocked git add of .env file. Secrets must never be committed."
  exit 2
fi

exit 0
