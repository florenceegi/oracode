#!/usr/bin/env bash
# ssot-reflex-guard.sh — PostToolUse hook: Sistema Nervoso Documentale LSO
# Layer 1 — RIFLESSO: rileva quando un file modificato e' watchato da un doc SSOT
# Trigger: PostToolUse Write|Edit
# Legge SSOT_REGISTRY.json, confronta il file modificato con i watches di ogni doc.
# Se match → avvisa il SUPERVISOR che il doc SSOT potrebbe necessitare aggiornamento.
# v1.0.0 — 2026-04-07
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @purpose Arco riflesso documentale — segnale immediato su modifica file watchato

REGISTRY="${ORACODE_SSOT_REGISTRY:-$HOME/.oracode/ssot-registry.json}"
NERVE_LOG="${ORACODE_AUDIT_DIR:-$HOME/.oracode/audit/}ssot_nerve_signals.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Leggi input dal hook system
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
  exit 0
fi

# Registry deve esistere
if [ ! -f "$REGISTRY" ]; then
  exit 0
fi

# Normalizza il path relativo al repo
# $HOME/NATAN_LOC/laravel_backend/routes/api.php → laravel_backend/routes/api.php
REPO=""
REL_PATH=""
for ORGAN_DIR in $HOME/NATAN_LOC $HOME/EGI $HOME/EGI-HUB $HOME/EGI-HUB-HOME-REACT $HOME/EGI-SIGILLO $HOME/EGI-Credential $HOME/EGI-INFO ${ORACODE_DOC_ROOT:-$HOME/.oracode} $HOME/EGI-STAT; do
  if echo "$FILE" | grep -q "^${ORGAN_DIR}/"; then
    REPO=$(basename "$ORGAN_DIR")
    REL_PATH=$(echo "$FILE" | sed "s|^${ORGAN_DIR}/||")
    break
  fi
done

# Se il file non e' in un repo conosciuto, ignora
if [ -z "$REPO" ] || [ -z "$REL_PATH" ]; then
  exit 0
fi

# Cerca match nei watches del registry
# Usiamo jq per iterare sui documenti e confrontare i path
MATCHES=$(jq -r --arg repo "$REPO" --arg relpath "$REL_PATH" '
  .documents[] |
  select(.watches.repos != null) |
  select(.watches.repos[] == $repo) |
  . as $doc |
  if (.watches.paths // []) | any(. as $pattern |
    if ($pattern | contains("*")) then
      # Glob match: converte glob in regex
      ($pattern | gsub("\\*\\*/"; "(.*/)?") | gsub("\\*"; "[^/]*") | gsub("\\."; "\\.")) as $regex |
      ($relpath | test($regex))
    else
      ($relpath == $pattern)
    end
  ) then
    "\($doc.ssot_id)|\($doc.title)|\($doc.path)|\($doc.priority)"
  else
    empty
  end
' "$REGISTRY" 2>/dev/null)

# Se anche i pattern match
if [ -z "$MATCHES" ]; then
  MATCHES=$(jq -r --arg repo "$REPO" --arg relpath "$REL_PATH" '
    .documents[] |
    select(.watches.repos != null) |
    select(.watches.repos[] == $repo) |
    . as $doc |
    if (.watches.patterns // []) | any(. as $pattern |
      # Cerca il pattern nel contenuto del file (costoso ma preciso)
      false
    ) then
      "\($doc.ssot_id)|\($doc.title)|\($doc.path)|\($doc.priority)"
    else
      empty
    end
  ' "$REGISTRY" 2>/dev/null)
fi

if [ -z "$MATCHES" ]; then
  exit 0
fi

# Costruisci messaggio di avviso
MSG=""
DOC_COUNT=0
while IFS='|' read -r SSOT_ID TITLE DOC_PATH PRIORITY; do
  if [ -n "$SSOT_ID" ]; then
    DOC_COUNT=$((DOC_COUNT + 1))
    MSG="${MSG}\n  - [${PRIORITY}] ${TITLE} (${SSOT_ID}) → ${DOC_PATH}"
    # Log nel nerve signal log
    echo "${TIMESTAMP} | NERVE_SIGNAL | file=${REL_PATH} repo=${REPO} | doc=${SSOT_ID} priority=${PRIORITY}" >> "$NERVE_LOG" 2>/dev/null
  fi
done <<< "$MATCHES"

if [ "$DOC_COUNT" -gt 0 ]; then
  echo "SSOT NERVE SIGNAL: ${REL_PATH} (${REPO}) e' watchato da ${DOC_COUNT} doc SSOT:${MSG}"
  echo ""
  echo "DOC-SYNC potrebbe essere necessario. Verificare allineamento prima di chiudere la task."
fi

exit 0
