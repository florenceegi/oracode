#!/usr/bin/env bash
# cross-project-guard.sh — PreToolUse hook: forza lettura CLAUDE.md prima di modificare file in qualsiasi progetto FlorenceEGI
# Matcher: Write|Edit
# Pattern coperto: INCIDENT V-01/V-11 — agente lavora in progetto senza leggere il suo CLAUDE.md
# v2.0.0 — 2026-03-27: copertura estesa a TUTTI gli organi ecosistema + CLAUDE_ECOSYSTEM_CORE.md

ECOSYSTEM_CORE="${ORACODE_DOC_ROOT:-$HOME/.oracode}/CLAUDE_ECOSYSTEM_CORE.md"

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ]; then
  exit 0
fi

# Trova il root del progetto (directory con CLAUDE.md)
PROJECT_ROOT=""
SEARCH_DIR=$(dirname "$FILE")
while [ "$SEARCH_DIR" != "/" ] && [ "$SEARCH_DIR" != "/home" ] && [ "$SEARCH_DIR" != "$HOME" ]; do
  if [ -f "$SEARCH_DIR/CLAUDE.md" ]; then
    PROJECT_ROOT="$SEARCH_DIR"
    break
  fi
  SEARCH_DIR=$(dirname "$SEARCH_DIR")
done

if [ -z "$PROJECT_ROOT" ]; then
  exit 0
fi

PROJECT_NAME=$(basename "$PROJECT_ROOT")

# Tutti gli organi dell'ecosistema FlorenceEGI — richiedono lettura CLAUDE.md + CLAUDE_ECOSYSTEM_CORE.md
ECOSYSTEM_PROJECTS=(
  "NATAN_LOC"
  "EGI-Credential"
  "EGI"
  "EGI-HUB"
  "EGI-HUB-HOME-REACT"
  "EGI-INFO"
  "EGI-STAT"
  "EGI-DOC"
  "EGI-Proof"
)

for PROJ in "${ECOSYSTEM_PROJECTS[@]}"; do
  if [ "$PROJECT_NAME" = "$PROJ" ]; then
    CLAUDE_MD="$PROJECT_ROOT/CLAUDE.md"
    printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"🛑 ORGANISMO FLORENCEEGI — Progetto: %s\n\nPrima di scrivere codice devi aver letto:\n  1. %s\n  2. %s (caricato automaticamente via @ include)\n\nP0-1: MAI operare senza aver letto il CLAUDE.md del progetto.\nStrategie Delta: nuovo codice = TUTTE le regole OS3 senza eccezioni.\n\nSe li hai già letti: conferma e procedi.\nSe non li hai letti: STOP — leggi prima."},"systemMessage":"cross-project-guard v2: stai modificando file in %s — verifica CLAUDE.md + CLAUDE_ECOSYSTEM_CORE.md"}' \
      "$PROJECT_NAME" "$CLAUDE_MD" "$ECOSYSTEM_CORE" "$PROJECT_NAME"
    exit 0
  fi
done

exit 0
