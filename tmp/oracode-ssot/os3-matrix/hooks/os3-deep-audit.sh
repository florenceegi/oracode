#!/usr/bin/env bash
# os3-deep-audit.sh — Scansione completa OS3 su tutti gli organi FlorenceEGI
# Uso: ./os3-deep-audit.sh [PROJECT] (default: tutti)
# Livello 3 del OS3 Audit System — generato report Markdown in EGI-DOC/audit/
# Invocabile manualmente o via cron
# v1.0.0 — 2026-03-27

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M')
DATE=$(date '+%Y-%m-%d')
REPORT_DIR="${ORACODE_DOC_ROOT:-$HOME/.oracode}/audit"
REPORT_FILE="$REPORT_DIR/OS3_AUDIT_$TIMESTAMP.md"

PROJECTS=(
  "${ORACODE_PROJECTS[0]:-}"
  "${ORACODE_PROJECTS[1]:-}"
  "${ORACODE_PROJECTS[2]:-}"
  "${ORACODE_PROJECTS[3]:-}"
  "${ORACODE_PROJECTS[4]:-}"
  "$HOME/EGI-INFO"
  "$HOME/EGI-STAT"
)

# Filtra su progetto specifico se passato come argomento
if [ -n "$1" ]; then
  PROJECTS=("$HOME/$1")
fi

TOTAL_ERRORS=0
TOTAL_WARNINGS=0

# ─── HEADER REPORT ──────────────────────────────────────────────────────────
cat > "$REPORT_FILE" <<EOF
# OS3 Audit Report — $DATE
> Generato da: os3-deep-audit.sh | FlorenceEGI Oracode System v3.0
> Path report: $REPORT_FILE

---

EOF

# ─── FUNZIONE DI CHECK PER PROGETTO ────────────────────────────────────────
audit_project() {
  local PROJECT_PATH="$1"
  local PROJECT_NAME=$(basename "$PROJECT_PATH")
  local ERRORS=0
  local WARNINGS=0
  local FINDINGS=""

  if [ ! -d "$PROJECT_PATH" ]; then
    return
  fi

  echo "## $PROJECT_NAME" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"

  # ── PHP Controllers ──────────────────────────────────────────────────────

  # UEM: controller senza errorManager
  CTRL_NO_UEM=$(find "$PROJECT_PATH" -path "*/Controllers/*.php" -not -name "*.blade.php" 2>/dev/null | while read F; do
    if ! grep -q 'errorManager\|ErrorManager\|handleError\|UlmErrorManager' "$F" 2>/dev/null; then
      echo "  - $(basename $F)"
    fi
  done)
  if [ -n "$CTRL_NO_UEM" ]; then
    echo "### 🔴 UEM Mancante (Ultra Error Manager)" >> "$REPORT_FILE"
    echo "Controller senza gestione errori OS3:" >> "$REPORT_FILE"
    echo "$CTRL_NO_UEM" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    ERRORS=$((ERRORS + $(echo "$CTRL_NO_UEM" | wc -l)))
  fi

  # env() nei controller
  ENV_IN_CTRL=$(grep -rl "env('" "$PROJECT_PATH" --include="*.php" 2>/dev/null | grep 'Controllers/' | while read F; do
    COUNT=$(grep -c "env('" "$F")
    echo "  - $(basename $F) ($COUNT occorrenze)"
  done)
  if [ -n "$ENV_IN_CTRL" ]; then
    echo "### 🔴 env() in Controller (usa config())" >> "$REPORT_FILE"
    echo "$ENV_IN_CTRL" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    ERRORS=$((ERRORS + $(echo "$ENV_IN_CTRL" | wc -l)))
  fi

  # Stringhe hardcoded in response JSON
  HARDCODED=$(grep -rl "response()->json" "$PROJECT_PATH" --include="*.php" 2>/dev/null | while read F; do
    if grep -qE "json\(\[.*'[A-Z][a-z]{2,}" "$F" 2>/dev/null; then
      echo "  - $(basename $F)"
    fi
  done)
  if [ -n "$HARDCODED" ]; then
    echo "### ⚠️  Possibili Stringhe Hardcoded (P0-2)" >> "$REPORT_FILE"
    echo "$HARDCODED" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    WARNINGS=$((WARNINGS + $(echo "$HARDCODED" | wc -l)))
  fi

  # i18n: verifica che esistano tutti e 6 i file per ogni dominio lang
  LANG_DIR=$(find "$PROJECT_PATH" -type d -name "lang" 2>/dev/null | head -1)
  if [ -n "$LANG_DIR" ]; then
    REQUIRED_LANGS="it en de es fr pt"
    MISSING_LANGS=""
    for LANG in $REQUIRED_LANGS; do
      if [ ! -d "$LANG_DIR/$LANG" ]; then
        MISSING_LANGS="$MISSING_LANGS $LANG"
      fi
    done
    if [ -n "$MISSING_LANGS" ]; then
      echo "### 🔴 i18n Incompleta (P0-9) — Lingue mancanti:$MISSING_LANGS" >> "$REPORT_FILE"
      echo "" >> "$REPORT_FILE"
      ERRORS=$((ERRORS + 1))
    fi
  fi

  # ── Python ───────────────────────────────────────────────────────────────

  # MongoDBService diretto (P0-10)
  MONGO_DIRECT=$(grep -rl 'MongoDBService\|from.*mongodb_service import' "$PROJECT_PATH" --include="*.py" 2>/dev/null | while read F; do
    echo "  - $(basename $F)"
  done)
  if [ -n "$MONGO_DIRECT" ]; then
    echo "### 🔴 P0-10: MongoDBService Diretto (usa get_db_service())" >> "$REPORT_FILE"
    echo "$MONGO_DIRECT" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    ERRORS=$((ERRORS + $(echo "$MONGO_DIRECT" | wc -l)))
  fi

  # LLM senza timeout
  LLM_NO_TIMEOUT=$(grep -rl 'await.*anthropic\|await.*openai\|await.*llm' "$PROJECT_PATH" --include="*.py" 2>/dev/null | while read F; do
    if ! grep -q 'wait_for\|timeout' "$F" 2>/dev/null; then
      echo "  - $(basename $F)"
    fi
  done)
  if [ -n "$LLM_NO_TIMEOUT" ]; then
    echo "### ⚠️  LLM Call senza Timeout (asyncio.wait_for 30s)" >> "$REPORT_FILE"
    echo "$LLM_NO_TIMEOUT" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    WARNINGS=$((WARNINGS + $(echo "$LLM_NO_TIMEOUT" | wc -l)))
  fi

  # ── TypeScript ───────────────────────────────────────────────────────────

  # innerHTML senza DOMPurify
  INNER_HTML=$(grep -rl 'innerHTML' "$PROJECT_PATH" --include="*.ts" --include="*.tsx" --include="*.js" 2>/dev/null | while read F; do
    if ! grep -q 'DOMPurify\|sanitize' "$F" 2>/dev/null; then
      echo "  - $(basename $F)"
    fi
  done)
  if [ -n "$INNER_HTML" ]; then
    echo "### 🔴 XSS Risk: innerHTML senza DOMPurify" >> "$REPORT_FILE"
    echo "$INNER_HTML" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    ERRORS=$((ERRORS + $(echo "$INNER_HTML" | wc -l)))
  fi

  # ── Riepilogo progetto ───────────────────────────────────────────────────
  STATUS="✅ CONFORME"
  if [ "$ERRORS" -gt 0 ]; then STATUS="🔴 NON CONFORME ($ERRORS errori, $WARNINGS warning)"; fi
  if [ "$ERRORS" -eq 0 ] && [ "$WARNINGS" -gt 0 ]; then STATUS="⚠️  PARZIALMENTE CONFORME ($WARNINGS warning)"; fi

  # Inserisci il riepilogo subito dopo l'header del progetto
  sed -i "s|## $PROJECT_NAME|## $PROJECT_NAME\n**Stato: $STATUS**\n|" "$REPORT_FILE" 2>/dev/null

  TOTAL_ERRORS=$((TOTAL_ERRORS + ERRORS))
  TOTAL_WARNINGS=$((TOTAL_WARNINGS + WARNINGS))

  echo "---" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"

  echo "  [$PROJECT_NAME] Errori: $ERRORS | Warning: $WARNINGS"
}

# ─── ESEGUI AUDIT SU TUTTI I PROGETTI ───────────────────────────────────────
echo "OS3 Deep Audit avviato — $TIMESTAMP"
echo ""

for PROJECT in "${PROJECTS[@]}"; do
  audit_project "$PROJECT"
done

# ─── SOMMARIO FINALE ────────────────────────────────────────────────────────
cat >> "$REPORT_FILE" <<EOF
## Sommario Globale

| Metrica | Valore |
|---------|--------|
| Progetti scansionati | ${#PROJECTS[@]} |
| Errori totali | $TOTAL_ERRORS |
| Warning totali | $TOTAL_WARNINGS |
| Data audit | $DATE |
| Report | $REPORT_FILE |

> Prossimo step: verificare i finding più critici e aprire task di remediation.
> Riferimento regole: \`${ORACODE_DOC_ROOT:-$HOME/.oracode}/CLAUDE_ECOSYSTEM_CORE.md\`
EOF

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "OS3 AUDIT COMPLETATO"
echo "Errori: $TOTAL_ERRORS | Warning: $TOTAL_WARNINGS"
echo "Report: $REPORT_FILE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
