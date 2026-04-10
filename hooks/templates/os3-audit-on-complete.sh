#!/usr/bin/env bash
# os3-audit-on-complete.sh — PostToolUse hook: audit OS3 quando un task viene completato
# Trigger: PostToolUse TodoWrite
# Livello 2 del OS3 Audit System — aggregazione findings per task
# v1.0.0 — 2026-03-27

AUDIT_LOG="${ORACODE_AUDIT_DIR:-$HOME/.oracode/audit/}os3_live_findings.log"
SESSION_LOG="/tmp/os3_session_audit.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

INPUT=$(cat)

# Controlla se almeno un todo è appena passato a "completed"
HAS_COMPLETED=$(echo "$INPUT" | jq -r '
  .tool_input.todos[]? |
  select(.status == "completed") |
  .content
' 2>/dev/null | head -1)

if [ -z "$HAS_COMPLETED" ]; then
  exit 0
fi

TASK_NAME="$HAS_COMPLETED"

# Leggi findings accumulati nella sessione (da os3-audit-static)
if [ -f "$SESSION_LOG" ] && [ -s "$SESSION_LOG" ]; then
  FINDINGS_COUNT=$(wc -l < "$SESSION_LOG")

  >&2 echo ""
  >&2 echo "━━━ OS3 AUDIT REPORT — Task completato ━━━━━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo "  Task: $TASK_NAME"
  >&2 echo "  Findings accumulati in questa sessione: $FINDINGS_COUNT righe"
  >&2 echo "  Log completo: $AUDIT_LOG"
  >&2 echo ""
  >&2 cat "$SESSION_LOG"
  >&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # Archivia nel log persistente con header task
  {
    echo "### TASK COMPLETED: $TASK_NAME — $TIMESTAMP"
    cat "$SESSION_LOG"
    echo "---"
  } >> "$AUDIT_LOG" 2>/dev/null

  # Pulisci log di sessione
  > "$SESSION_LOG"

else
  >&2 echo "━━━ OS3 AUDIT — Task: $TASK_NAME ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo "  Nessun finding OS3 rilevato in questa sessione."
  >&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

exit 0
