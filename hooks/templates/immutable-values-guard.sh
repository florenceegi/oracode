#!/usr/bin/env bash
# oracode immutable-values-guard — blocks modification of business-critical values
# Trigger: PreToolUse Write|Edit
# Config: reads immutable values from .oracode/config.json

CONFIG="{{ORACODE_DIR}}/config.json"
INPUT=$(cat)

FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
OLD_CONTENT=$(echo "$INPUT" | jq -r '.tool_input.old_string // empty' 2>/dev/null)
NEW_CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty' 2>/dev/null)

[ -z "$FILE" ] && exit 0
[ ! -f "$CONFIG" ] && exit 0

# Read immutable values from config
IMMUTABLES=$(jq -r '.immutable_values[]? | "\(.pattern)|\(.description)"' "$CONFIG" 2>/dev/null)
[ -z "$IMMUTABLES" ] && exit 0

# Check both: old_string being replaced (Edit) and full content being written (Write)
# Also check if the target file already contains the pattern and would be overwritten
CHECK_CONTENT="${OLD_CONTENT}${NEW_CONTENT}"
if [ -z "$CHECK_CONTENT" ]; then
  exit 0
fi

# For Write tool (full file replace), check if file has immutable value and content changes it
if [ -z "$OLD_CONTENT" ] && [ -f "$FILE" ]; then
  FILE_CONTENT=$(cat "$FILE" 2>/dev/null)
fi

BLOCKED=""
while IFS='|' read -r PATTERN DESC; do
  [ -z "$PATTERN" ] && continue
  # Case 1: Edit tool — old_string contains the immutable pattern (someone is replacing it)
  if [ -n "$OLD_CONTENT" ] && echo "$OLD_CONTENT" | grep -qF "$PATTERN"; then
    BLOCKED="${BLOCKED}\n  - ${DESC} (pattern: ${PATTERN})"
  fi
  # Case 2: Write tool — file contains pattern but new content doesn't (would erase it)
  if [ -n "$FILE_CONTENT" ] && echo "$FILE_CONTENT" | grep -qF "$PATTERN"; then
    if [ -n "$NEW_CONTENT" ] && ! echo "$NEW_CONTENT" | grep -qF "$PATTERN"; then
      BLOCKED="${BLOCKED}\n  - ${DESC} (pattern: ${PATTERN}) — would be removed by full file write"
    fi
  fi
done <<< "$IMMUTABLES"

if [ -n "$BLOCKED" ]; then
  echo "ORACODE IMMUTABLE-GUARD: this edit touches protected values:${BLOCKED}"
  echo ""
  echo "These values require explicit approval before modification."
  exit 2
fi

exit 0
