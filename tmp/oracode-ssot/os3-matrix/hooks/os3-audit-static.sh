#!/usr/bin/env bash
# os3-audit-static.sh — PostToolUse hook: analisi statica OS3 su ogni file modificato
# Trigger: PostToolUse Write|Edit
# Livello 1 del OS3 Audit System — zero AI cost, istantaneo
# v1.0.0 — 2026-03-27

AUDIT_LOG="${ORACODE_AUDIT_DIR:-$HOME/.oracode/audit/}os3_live_findings.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
  exit 0
fi

EXT="${FILE##*.}"
BASENAME=$(basename "$FILE")

# Solo file di codice
IS_CODE=0
case "$EXT" in
  php|py|ts|tsx|js|jsx) IS_CODE=1 ;;
esac
echo "$BASENAME" | grep -q '\.blade\.php$' && IS_CODE=1

if [ "$IS_CODE" -eq 0 ]; then
  exit 0
fi

FINDINGS=()
PROJECT=$(echo "$FILE" | sed 's|$HOME/||' | cut -d'/' -f1)

# ─── CHECK PHP ──────────────────────────────────────────────────────────────
if [ "$EXT" = "php" ]; then

  # UEM: controller PHP senza errorManager
  if echo "$FILE" | grep -q 'Controllers/' && ! grep -q 'errorManager\|ErrorManager\|handleError\|UlmErrorManager' "$FILE" 2>/dev/null; then
    FINDINGS+=("⚠️  UEM mancante — nessun errorManager in controller: $BASENAME")
  fi

  # env() nei controller (deve essere config())
  if echo "$FILE" | grep -q 'Controllers/' && grep -q "env('" "$FILE" 2>/dev/null; then
    COUNT=$(grep -c "env('" "$FILE")
    FINDINGS+=("🔴 env() in controller ($COUNT occorrenze) — usa config(): $BASENAME")
  fi

  # Stringhe hardcoded in risposta JSON (response()->json con stringa letterale)
  if grep -qE "response\(\)->json\(\[.*'[A-Z][a-z]" "$FILE" 2>/dev/null; then
    FINDINGS+=("⚠️  Possibile stringa hardcoded in json response — verifica __() : $BASENAME")
  fi

  # GDPR: operazioni su dati personali senza audit trail
  if grep -qiE "personal_data|email|nome|cognome|tax_code|fiscal" "$FILE" 2>/dev/null; then
    if ! grep -q 'gdpr\|GdprAudit\|audit_log\|consent' "$FILE" 2>/dev/null; then
      FINDINGS+=("🔒 GDPR: file manipola dati personali senza audit trail evidente: $BASENAME")
    fi
  fi

  # Firma OS3 mancante in classi nuove
  if grep -q 'class ' "$FILE" 2>/dev/null && ! grep -q '@author\|Padmin\|OS3' "$FILE" 2>/dev/null; then
    FINDINGS+=("📝 Firma OS3 mancante (@author Padmin D. Curtis): $BASENAME")
  fi

fi

# ─── CHECK PYTHON ───────────────────────────────────────────────────────────
if [ "$EXT" = "py" ]; then

  # MongoDBService diretto (P0-10)
  if grep -q 'MongoDBService\|mongodb_service' "$FILE" 2>/dev/null; then
    FINDINGS+=("🔴 P0-10 VIOLATO: MongoDBService diretto — usa get_db_service(): $BASENAME")
  fi

  # LLM call senza timeout (P1)
  if grep -qE 'await.*llm|anthropic\.|openai\.' "$FILE" 2>/dev/null; then
    if ! grep -q 'wait_for\|timeout' "$FILE" 2>/dev/null; then
      FINDINGS+=("⚠️  LLM call senza asyncio.wait_for(timeout=30): $BASENAME")
    fi
  fi

fi

# ─── CHECK TYPESCRIPT ───────────────────────────────────────────────────────
if echo "$EXT" | grep -qE '^(ts|tsx|js|jsx)$'; then

  # innerHTML senza sanitize
  if grep -q 'innerHTML' "$FILE" 2>/dev/null && ! grep -q 'DOMPurify\|sanitize' "$FILE" 2>/dev/null; then
    FINDINGS+=("🔴 XSS risk: innerHTML senza DOMPurify.sanitize(): $BASENAME")
  fi

  # Alpine.js o Livewire nel TS (P0-0)
  if grep -qE 'Alpine\.|x-data|wire:' "$FILE" 2>/dev/null; then
    FINDINGS+=("🔴 P0-0 VIOLATO: Alpine.js/Livewire in file TS: $BASENAME")
  fi

fi

# ─── OUTPUT ─────────────────────────────────────────────────────────────────
if [ ${#FINDINGS[@]} -gt 0 ]; then
  # Stderr — visibile all'agente in sessione
  >&2 echo "━━━ OS3 AUDIT STATIC [$PROJECT/$BASENAME] ━━━━━━━━━━━━━━━━━━━━━━━━"
  for F in "${FINDINGS[@]}"; do
    >&2 echo "  $F"
  done
  >&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # Append al log persistente
  {
    echo "## [$TIMESTAMP] $PROJECT — $BASENAME"
    for F in "${FINDINGS[@]}"; do
      echo "- $F"
    done
    echo ""
  } >> "$AUDIT_LOG" 2>/dev/null
fi

exit 0
