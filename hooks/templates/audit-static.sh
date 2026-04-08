#!/usr/bin/env bash
# oracode audit-static — static analysis on every file written by AI
# Trigger: PostToolUse Write|Edit
# Checks: missing error handling, hardcoded strings, security patterns

AUDIT_LOG="{{ORACODE_DIR}}/audit.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

[ -z "$FILE" ] || [ ! -f "$FILE" ] && exit 0

EXT="${FILE##*.}"
BASENAME=$(basename "$FILE")
FINDINGS=()

# Only audit code files
case "$EXT" in
  php|py|ts|tsx|js|jsx) ;;
  *) echo "$BASENAME" | grep -q '\.blade\.php$' || exit 0 ;;
esac

# Check: hardcoded secrets
if grep -qE '(password|secret|api_key|token)\s*=\s*["\x27][^"\x27]{8,}' "$FILE" 2>/dev/null; then
  FINDINGS+=("SECURITY: possible hardcoded secret in ${BASENAME}")
fi

# Check: console.log / var_dump left in code
if grep -qE '(console\.log|var_dump|dd\(|print_r)' "$FILE" 2>/dev/null; then
  FINDINGS+=("CLEANUP: debug statement found in ${BASENAME}")
fi

# Check: TODO/FIXME/HACK
TODO_COUNT=$(grep -cE '(TODO|FIXME|HACK|XXX):' "$FILE" 2>/dev/null || echo 0)
if [ "$TODO_COUNT" -gt 0 ]; then
  FINDINGS+=("INFO: ${TODO_COUNT} TODO/FIXME markers in ${BASENAME}")
fi

# Check PHP: raw SQL without parameterization
if [ "$EXT" = "php" ] && grep -qE 'DB::raw\(|->whereRaw\(' "$FILE" 2>/dev/null; then
  FINDINGS+=("SECURITY: raw SQL detected in ${BASENAME} — verify parameterization")
fi

# Check TS/JS: innerHTML without sanitization
if echo "$EXT" | grep -qE 'ts|tsx|js|jsx' && grep -qE '\.innerHTML\s*=' "$FILE" 2>/dev/null; then
  if ! grep -q 'DOMPurify\|sanitize' "$FILE" 2>/dev/null; then
    FINDINGS+=("SECURITY: innerHTML without sanitization in ${BASENAME}")
  fi
fi

# Output findings
if [ ${#FINDINGS[@]} -gt 0 ]; then
  echo "ORACODE AUDIT (${BASENAME}):"
  for f in "${FINDINGS[@]}"; do
    echo "  $f"
    echo "${TIMESTAMP} | ${f}" >> "$AUDIT_LOG" 2>/dev/null
  done
fi

exit 0
