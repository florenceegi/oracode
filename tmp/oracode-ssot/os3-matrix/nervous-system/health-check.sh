#!/usr/bin/env bash
# oracode health-check — checks documentation alignment with codebase
# Reads the SSOT registry and reports drift based on recent git activity.
# Usage: oracode health [scope]

set -euo pipefail

ORACODE_DIR="${ORACODE_DIR:-.oracode}"
REGISTRY="${ORACODE_DIR}/ssot-registry.json"
TIMESTAMP=$(date '+%Y-%m-%d_%H%M')

SCOPE="${1:-all}"

if [ ! -f "$REGISTRY" ]; then
  echo "No SSOT registry found at ${REGISTRY}"
  echo "Run 'oracode init' first, then add documents to the registry."
  exit 1
fi

if ! command -v jq &>/dev/null; then
  echo "Error: jq is required. Install it with: apt install jq / brew install jq"
  exit 1
fi

echo "=================================="
echo "  Oracode Health Check"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "  Scope: ${SCOPE}"
echo "=================================="
echo ""

TOTAL=0
DRIFT=0
STALE=0
OK=0

DOC_COUNT=$(jq '.documents | length' "$REGISTRY")

for i in $(seq 0 $((DOC_COUNT - 1))); do
  SSOT_ID=$(jq -r ".documents[$i].ssot_id" "$REGISTRY")
  TITLE=$(jq -r ".documents[$i].title" "$REGISTRY")
  DOC_PATH=$(jq -r ".documents[$i].path" "$REGISTRY")
  PROJECT=$(jq -r ".documents[$i].project" "$REGISTRY")
  PRIORITY=$(jq -r ".documents[$i].priority" "$REGISTRY")
  LAST_VERIFIED=$(jq -r ".documents[$i].last_verified // \"never\"" "$REGISTRY")

  if [ "$SCOPE" != "all" ] && [ "$PROJECT" != "$SCOPE" ]; then
    continue
  fi

  TOTAL=$((TOTAL + 1))

  if [ ! -f "$DOC_PATH" ]; then
    DRIFT=$((DRIFT + 1))
    echo "  MISSING  [${PRIORITY}] ${TITLE} — file not found: ${DOC_PATH}"
    continue
  fi

  # Check for recent commits in watched files
  REPOS=$(jq -r ".documents[$i].watches.repos // [] | .[]" "$REGISTRY" 2>/dev/null)
  PATHS=$(jq -r ".documents[$i].watches.paths // [] | .[]" "$REGISTRY" 2>/dev/null)

  RECENT=0
  for REPO_DIR in $REPOS; do
    [ ! -d "${REPO_DIR}/.git" ] && continue
    for WPATH in $PATHS; do
      COMMITS=$(cd "$REPO_DIR" && git log --oneline --since="7 days ago" -- "$WPATH" 2>/dev/null | wc -l)
      RECENT=$((RECENT + COMMITS))
    done
  done

  if [ "$RECENT" -gt 0 ] && [ "$LAST_VERIFIED" = "never" ] || [ "$LAST_VERIFIED" = "null" ]; then
    STALE=$((STALE + 1))
    echo "  STALE    [${PRIORITY}] ${TITLE} — ${RECENT} recent commits, never verified"
  elif [ "$RECENT" -gt 0 ]; then
    STALE=$((STALE + 1))
    echo "  STALE    [${PRIORITY}] ${TITLE} — ${RECENT} recent commits since ${LAST_VERIFIED}"
  else
    OK=$((OK + 1))
  fi
done

echo ""
echo "--- Results ---"
echo "  Documents: ${TOTAL} | OK: ${OK} | Stale: ${STALE} | Drift: ${DRIFT}"

if [ "$TOTAL" -gt 0 ]; then
  HEALTH=$((OK * 100 / TOTAL))
  echo "  Health Score: ${HEALTH}%"
fi
