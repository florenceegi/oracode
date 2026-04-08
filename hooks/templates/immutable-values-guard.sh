#!/usr/bin/env bash
# oracode immutable-values-guard — blocks modification of business-critical values
# Trigger: PreToolUse Write|Edit
# Config: reads immutable values from .oracode/config.json

CONFIG="{{ORACODE_DIR}}/config.json"
INPUT=$(cat)

FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
NEW_CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty' 2>/dev/null)

[ -z "$FILE" ] || [ -z "$NEW_CONTENT" ] && exit 0
[ ! -f "$CONFIG" ] && exit 0

# Read immutable values from config
IMMUTABLES=$(jq -r '.immutable_values[]? | "\(.pattern)|\(.description)"' "$CONFIG" 2>/dev/null)
[ -z "$IMMUTABLES" ] && exit 0

BLOCKED=""
while IFS='|' read -r PATTERN DESC; do
  [ -z "$PATTERN" ] && continue
  if echo "$NEW_CONTENT" | grep -q "$PATTERN"; then
    BLOCKED="${BLOCKED}\n  - ${DESC} (pattern: ${PATTERN})"
  fi
done <<< "$IMMUTABLES"

if [ -n "$BLOCKED" ]; then
  echo "ORACODE IMMUTABLE-GUARD: this edit touches protected values:${BLOCKED}"
  echo ""
  echo "These values require explicit approval before modification."
  exit 2
fi

exit 0
