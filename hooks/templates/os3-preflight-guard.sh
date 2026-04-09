#!/usr/bin/env bash
# os3-preflight-guard.sh — PreToolUse hook: ENFORCEMENT P0 su file di codice
# Matcher: Write|Edit
# v2.0.0 — 2026-04-09
# CAMBIAMENTO v2: da reminder passivo (exit 0) a enforcement attivo (exit 2 su violazioni)
#
# BLOCCA (exit 2):
# - File PHP nuovo (Write) senza firma OS3
# - File PHP nuovo senza UEM ($errorManager)
# - File PHP con env() in controller
# - File Python con MongoDBService diretto (P0-10)
# - File > 500 righe (P2 ma bloccante su Write di file nuovi)
#
# WARN (exit 0 con messaggio stderr):
# - Reminder regole per tipo di file

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ]; then
  exit 0
fi

EXT="${FILE##*.}"
BASENAME=$(basename "$FILE")

IS_CODE=0
case "$EXT" in
  php|py|ts|tsx|js|jsx) IS_CODE=1 ;;
esac
echo "$BASENAME" | grep -q '\.blade\.php$' && IS_CODE=1

if [ "$IS_CODE" -eq 0 ]; then
  exit 0
fi

# Estrai contenuto
if [ "$TOOL" = "Write" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty' 2>/dev/null)
  IS_NEW_FILE=1
elif [ "$TOOL" = "Edit" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty' 2>/dev/null)
  IS_NEW_FILE=0
else
  exit 0
fi

BLOCKS=()

# Skip file di test/seed/migration
if echo "$FILE" | grep -qiE 'test|spec|mock|seed|factory|migration'; then
  IS_NEW_FILE=0  # non applicare check stretti su questi
fi

# ─── ENFORCEMENT PHP (solo su file nuovi) ──────────────────────────────────
if [ "$EXT" = "php" ] && [ "$IS_NEW_FILE" -eq 1 ]; then

  # Firma OS3 mancante
  if ! echo "$CONTENT" | grep -q '@author.*Padmin\|@author.*OS3' 2>/dev/null; then
    BLOCKS+=("P1 BLOCK: Firma OS3 mancante (@author Padmin D. Curtis)")
  fi

  # Controller senza UEM
  if echo "$FILE" | grep -q 'Controllers/' && ! echo "$CONTENT" | grep -q 'errorManager\|ErrorManagerInterface' 2>/dev/null; then
    BLOCKS+=("P0-5 BLOCK: Controller senza ErrorManager — usa \$errorManager->handle()")
  fi

  # env() in controller
  if echo "$FILE" | grep -q 'Controllers/' && echo "$CONTENT" | grep -q "env('" 2>/dev/null; then
    BLOCKS+=("P1 BLOCK: env() in controller — usa config()")
  fi

  # File > 500 righe
  LINECOUNT=$(echo "$CONTENT" | wc -l)
  if [ "$LINECOUNT" -gt 500 ]; then
    BLOCKS+=("P2 BLOCK: File nuovo con $LINECOUNT righe (max 500) — proponi split modulare")
  fi
fi

# ─── ENFORCEMENT PYTHON (solo su file nuovi) ──────────────────────────────
if [ "$EXT" = "py" ] && [ "$IS_NEW_FILE" -eq 1 ]; then

  # MongoDBService diretto (P0-10)
  if echo "$CONTENT" | grep -q 'MongoDBService\|mongodb_service' 2>/dev/null; then
    BLOCKS+=("P0-10 BLOCK: MongoDBService diretto — usa get_db_service() da db_factory.py")
  fi

  # File > 500 righe
  LINECOUNT=$(echo "$CONTENT" | wc -l)
  if [ "$LINECOUNT" -gt 500 ]; then
    BLOCKS+=("P2 BLOCK: File nuovo con $LINECOUNT righe (max 500) — proponi split modulare")
  fi
fi

# ─── ENFORCEMENT TS (solo su file nuovi) ───────────────────────────────────
if echo "$EXT" | grep -qE '^(ts|tsx|js|jsx)$' && [ "$IS_NEW_FILE" -eq 1 ]; then

  # Alpine/Livewire (P0-0) — solo su organi dove vietato
  if echo "$FILE" | grep -qiE 'NATAN_LOC|natan' && echo "$CONTENT" | grep -qE 'Alpine\.|x-data|wire:' 2>/dev/null; then
    BLOCKS+=("P0-0 BLOCK: Alpine.js/Livewire in file NATAN_LOC")
  fi

  # innerHTML senza DOMPurify
  if echo "$CONTENT" | grep -q 'innerHTML' 2>/dev/null && ! echo "$CONTENT" | grep -q 'DOMPurify\|sanitize' 2>/dev/null; then
    BLOCKS+=("P1 BLOCK: innerHTML senza DOMPurify.sanitize() — rischio XSS")
  fi
fi

# ─── OUTPUT ────────────────────────────────────────────────────────────────
if [ ${#BLOCKS[@]} -gt 0 ]; then
  >&2 echo ""
  >&2 echo "━━━ BLOCCO OS3 PREFLIGHT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo "File: $FILE"
  >&2 echo ""
  for B in "${BLOCKS[@]}"; do
    >&2 echo "  $B"
  done
  >&2 echo ""
  >&2 echo "Correggi le violazioni prima di scrivere il file."
  >&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  exit 2
fi

# ─── REMINDER (non bloccante) ──────────────────────────────────────────────
REMINDER=""
case "$EXT" in
  php)
    REMINDER="PHP OS3: __('key') P0-2 | \$errorManager->handle() P0-5 | GDPR audit P1 | TenantScope P1 | DocBlock+@purpose P1 | config() not env() P1"
    ;;
  py)
    REMINDER="Python OS3: wait_for(timeout=30) P1 | get_db_service() P0-10 | MAI dedurre P0-1 | max 500 righe P2"
    ;;
  ts|tsx|js|jsx)
    REMINDER="TS OS3: DOMPurify.sanitize() P1 | ARIA P2 | verifica bundle natan/ vs citizen/"
    ;;
esac

if [ -n "$REMINDER" ]; then
  >&2 echo "[OS3] $REMINDER"
fi

exit 0
