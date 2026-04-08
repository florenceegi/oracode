#!/usr/bin/env bash
# oracode legacy-guard — warns before modifying files marked as legacy
# Trigger: PreToolUse Write|Edit
# Config: reads legacy file patterns from .oracode/config.json

CONFIG="{{ORACODE_DIR}}/config.json"
INPUT=$(cat)

FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
[ -z "$FILE" ] && exit 0
[ ! -f "$CONFIG" ] && exit 0

# Read legacy patterns from config
LEGACY_FILES=$(jq -r '.legacy_files[]?' "$CONFIG" 2>/dev/null)
[ -z "$LEGACY_FILES" ] && exit 0

BASENAME=$(basename "$FILE")
MATCHED=""
while IFS= read -r PATTERN; do
  [ -z "$PATTERN" ] && continue
  if echo "$FILE" | grep -qE "$PATTERN"; then
    MATCHED="$PATTERN"
    break
  fi
done <<< "$LEGACY_FILES"

if [ -n "$MATCHED" ]; then
  echo "ORACODE LEGACY-GUARD: ${BASENAME} is marked as LEGACY."
  echo "Pattern matched: ${MATCHED}"
  echo ""
  echo "Legacy files require an approved plan before modification."
  echo "Read the file first, understand the full impact, then proceed with caution."
  # Exit 0 = warning only. Change to exit 2 for hard block.
  exit 0
fi

exit 0
