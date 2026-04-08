#!/usr/bin/env bash
# oracode gate — pre-push validation against contracts
# Trigger: PreToolUse Bash (on git push commands)
# Checks the current diff against contract rules before allowing push.

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

[ -z "$CMD" ] && exit 0

# Only trigger on git push
echo "$CMD" | grep -qE 'git\s+push' || exit 0

CONFIG="{{ORACODE_DIR}}/config.json"
[ ! -f "$CONFIG" ] && exit 0

# Check for uncommitted changes
UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l)
if [ "$UNCOMMITTED" -gt 0 ]; then
  echo "ORACODE GATE: ${UNCOMMITTED} uncommitted changes detected."
  echo "Commit or stash changes before pushing."
  # Warning only — exit 0
fi

# Check: are there files > max_lines?
MAX_LINES=$(jq -r '.max_file_lines // 500' "$CONFIG" 2>/dev/null)
DIFF_FILES=$(git diff --name-only HEAD~1 2>/dev/null || git diff --name-only --cached 2>/dev/null)
OVERSIZED=""
for F in $DIFF_FILES; do
  [ ! -f "$F" ] && continue
  LINES=$(wc -l < "$F" 2>/dev/null || echo 0)
  if [ "$LINES" -gt "$MAX_LINES" ]; then
    OVERSIZED="${OVERSIZED}\n  - ${F}: ${LINES} lines (max: ${MAX_LINES})"
  fi
done

if [ -n "$OVERSIZED" ]; then
  echo "ORACODE GATE WARNING: oversized files in this push:${OVERSIZED}"
fi

echo "ORACODE GATE: pre-push check passed."
exit 0
