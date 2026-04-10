#!/usr/bin/env bash
# ssot-living-check.sh — Layer 3 AUTONOMO del Sistema Nervoso Documentale LSO
# Script invocabile da cron o manualmente.
# Legge SSOT_REGISTRY.json e produce un report rapido di drift basato su timestamp.
# Per verifica semantica profonda, usare l'agente ssot-living-agent.
# v1.0.0 — 2026-04-07
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @purpose Verifica autonoma leggera: confronta last_verified e updated_at dei doc con i commit recenti

set -euo pipefail

REGISTRY="${ORACODE_SSOT_REGISTRY:-$HOME/.oracode/ssot-registry.json}"
MISSION_REG="${ORACODE_MISSION_REGISTRY:-$HOME/.oracode/mission-registry.json}"
AUDIT_DIR="${ORACODE_AUDIT_DIR:-$HOME/.oracode/audit/}drift"
TIMESTAMP=$(date '+%Y-%m-%d_%H%M')
REPORT="${AUDIT_DIR}/ssot_drift_${TIMESTAMP}.txt"

# Colori per output terminale
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Argomenti
SCOPE="${1:-all}" # all | NATAN_LOC | EGI | ecosistema | ...
VERBOSE="${2:-false}"

# Verifica prerequisiti
if [ ! -f "$REGISTRY" ]; then
  echo -e "${RED}ERRORE: SSOT_REGISTRY.json non trovato in ${REGISTRY}${NC}"
  exit 1
fi

if ! command -v jq &>/dev/null; then
  echo -e "${RED}ERRORE: jq richiesto ma non installato${NC}"
  exit 1
fi

mkdir -p "$AUDIT_DIR"

echo "=============================================="
echo "  SSOT Living Check — Sistema Nervoso LSO"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "  Scope: ${SCOPE}"
echo "=============================================="
echo ""

TOTAL_DOCS=0
DRIFT_COUNT=0
STALE_COUNT=0
OK_COUNT=0
FINDINGS=""

# Itera sui documenti nel registry
DOC_COUNT=$(jq '.documents | length' "$REGISTRY")

for i in $(seq 0 $((DOC_COUNT - 1))); do
  SSOT_ID=$(jq -r ".documents[$i].ssot_id" "$REGISTRY")
  TITLE=$(jq -r ".documents[$i].title" "$REGISTRY")
  DOC_PATH=$(jq -r ".documents[$i].path" "$REGISTRY")
  ORGAN=$(jq -r ".documents[$i].organ" "$REGISTRY")
  PRIORITY=$(jq -r ".documents[$i].priority" "$REGISTRY")
  LAST_VERIFIED=$(jq -r ".documents[$i].last_verified // \"never\"" "$REGISTRY")
  KNOWN_DRIFT=$(jq -r ".documents[$i].known_drift // [] | length" "$REGISTRY")

  # Filtra per scope
  if [ "$SCOPE" != "all" ] && [ "$ORGAN" != "$SCOPE" ]; then
    continue
  fi

  TOTAL_DOCS=$((TOTAL_DOCS + 1))
  FULL_PATH="${ORACODE_DOC_ROOT:-$HOME/.oracode}/${DOC_PATH}"

  # Verifica che il doc esista
  if [ ! -f "$FULL_PATH" ]; then
    DRIFT_COUNT=$((DRIFT_COUNT + 1))
    FINDINGS="${FINDINGS}\n  ${RED}MISSING${NC} [${PRIORITY}] ${TITLE} — file non trovato: ${DOC_PATH}"
    continue
  fi

  # Leggi updated_at dal frontmatter del doc
  DOC_UPDATED=$(grep -m1 'updated_at:' "$FULL_PATH" 2>/dev/null | sed "s/.*updated_at: *'\\?\\([0-9-]*\\).*/\\1/" || echo "unknown")

  # Controlla se ci sono commit recenti nei file watchati
  REPOS=$(jq -r ".documents[$i].watches.repos // [] | .[]" "$REGISTRY" 2>/dev/null)
  PATHS=$(jq -r ".documents[$i].watches.paths // [] | .[]" "$REGISTRY" 2>/dev/null)

  RECENT_CHANGES=0
  for REPO in $REPOS; do
    REPO_PATH="$HOME/${REPO}"
    if [ ! -d "$REPO_PATH/.git" ]; then
      continue
    fi

    for WPATH in $PATHS; do
      # Conta commit negli ultimi 7 giorni che toccano file watchati
      COMMITS=$(cd "$REPO_PATH" && git log --oneline --since="7 days ago" -- "$WPATH" 2>/dev/null | wc -l)
      RECENT_CHANGES=$((RECENT_CHANGES + COMMITS))
    done
  done

  # Valuta stato
  if [ "$KNOWN_DRIFT" -gt 0 ]; then
    DRIFT_COUNT=$((DRIFT_COUNT + 1))
    FINDINGS="${FINDINGS}\n  ${RED}DRIFT${NC}   [${PRIORITY}] ${TITLE} — ${KNOWN_DRIFT} drift noti nel registry"
  elif [ "$RECENT_CHANGES" -gt 0 ] && [ "$LAST_VERIFIED" = "never" ] || [ "$LAST_VERIFIED" = "null" ]; then
    STALE_COUNT=$((STALE_COUNT + 1))
    FINDINGS="${FINDINGS}\n  ${YELLOW}STALE${NC}   [${PRIORITY}] ${TITLE} — ${RECENT_CHANGES} commit recenti, mai verificato"
  elif [ "$RECENT_CHANGES" -gt 0 ]; then
    STALE_COUNT=$((STALE_COUNT + 1))
    FINDINGS="${FINDINGS}\n  ${YELLOW}STALE${NC}   [${PRIORITY}] ${TITLE} — ${RECENT_CHANGES} commit recenti, verificato: ${LAST_VERIFIED}"
  else
    OK_COUNT=$((OK_COUNT + 1))
    if [ "$VERBOSE" = "true" ]; then
      FINDINGS="${FINDINGS}\n  ${GREEN}OK${NC}      [${PRIORITY}] ${TITLE} — aggiornato: ${DOC_UPDATED}"
    fi
  fi
done

# Missioni non verificate
UNVERIFIED_MISSIONS=0
if [ -f "$MISSION_REG" ]; then
  UNVERIFIED_MISSIONS=$(jq '[.missions[] | select(.stato == "completed" and (.doc_verified == false or .doc_verified == null))] | length' "$MISSION_REG" 2>/dev/null || echo 0)
fi

# Output
echo "--- RISULTATI ---"
echo ""
echo -e "  Documenti verificati: ${TOTAL_DOCS}"
echo -e "  ${GREEN}OK:${NC}    ${OK_COUNT}"
echo -e "  ${YELLOW}Stale:${NC} ${STALE_COUNT}"
echo -e "  ${RED}Drift:${NC} ${DRIFT_COUNT}"
echo -e "  Missioni non verificate: ${UNVERIFIED_MISSIONS}"
echo ""

if [ -n "$FINDINGS" ]; then
  echo "--- FINDINGS ---"
  echo -e "$FINDINGS"
  echo ""
fi

if [ "$UNVERIFIED_MISSIONS" -gt 0 ]; then
  echo "--- MISSIONI DA VERIFICARE ---"
  jq -r '.missions[] | select(.stato == "completed" and (.doc_verified == false or .doc_verified == null)) | "  \(.mission_id) — \(.titolo) [\(.organi_coinvolti | join(", "))]"' "$MISSION_REG" 2>/dev/null
  echo ""
fi

# Score complessivo
if [ "$TOTAL_DOCS" -gt 0 ]; then
  HEALTH=$((OK_COUNT * 100 / TOTAL_DOCS))
  if [ "$HEALTH" -ge 80 ]; then
    echo -e "SSOT Health Score: ${GREEN}${HEALTH}%${NC}"
  elif [ "$HEALTH" -ge 50 ]; then
    echo -e "SSOT Health Score: ${YELLOW}${HEALTH}%${NC}"
  else
    echo -e "SSOT Health Score: ${RED}${HEALTH}%${NC}"
  fi
fi

# Salva report su file (senza colori)
{
  echo "SSOT Drift Report — $(date '+%Y-%m-%d %H:%M:%S')"
  echo "Scope: ${SCOPE}"
  echo "Documenti: ${TOTAL_DOCS} | OK: ${OK_COUNT} | Stale: ${STALE_COUNT} | Drift: ${DRIFT_COUNT}"
  echo "Missioni non verificate: ${UNVERIFIED_MISSIONS}"
  echo "Health Score: ${HEALTH:-0}%"
  echo ""
  echo "$FINDINGS" | sed 's/\\033\[[0-9;]*m//g'
} > "$REPORT" 2>/dev/null

echo ""
echo "Report salvato in: ${REPORT}"
