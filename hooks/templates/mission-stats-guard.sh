#!/usr/bin/env bash
# mission-stats-guard.sh — PostToolUse hook: BLOCCA push se missione senza stats
# Trigger: PostToolUse Bash (su git push di EGI-DOC)
# Verifica: tutte le mission completed devono avere il campo stats
# v2.0.0 — 2026-04-09 (M-039: da warning a bloccante)

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

[ -z "$CMD" ] && exit 0

# Solo su git push
echo "$CMD" | grep -q 'git push' || exit 0

REGISTRY="${ORACODE_MISSION_REGISTRY:-$HOME/.oracode/mission-registry.json}"
[ ! -f "$REGISTRY" ] && exit 0

# Solo se siamo in contesto EGI-DOC
CWD=$(echo "$INPUT" | jq -r '.tool_input.cwd // empty' 2>/dev/null)
if [ -n "$CWD" ]; then
  echo "$CWD" | grep -q "EGI-DOC" || exit 0
fi

# Controlla mission completate senza stats
MISSING=$(jq -r '.missions[] | select(.stato == "completed" and .stats == null and .titolo != null) | .mission_id' "$REGISTRY" 2>/dev/null)

if [ -n "$MISSING" ]; then
  COUNT=$(echo "$MISSING" | wc -l)
  >&2 echo ""
  >&2 echo "━━━ 🛑 MISSION STATS GUARD — BLOCCO ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo "${COUNT} missione/i completata/e senza stats:"
  echo "$MISSING" | while read mid; do >&2 echo "  - $mid"; done
  >&2 echo ""
  >&2 echo "AZIONE OBBLIGATORIA (Fase 6c protocollo /mission):"
  >&2 echo "  oracode stats (or run your stats enrichment script)"
  >&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo ""
  exit 2
fi

exit 0
