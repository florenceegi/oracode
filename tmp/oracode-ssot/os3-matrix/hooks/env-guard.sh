#!/usr/bin/env bash
# env-guard.sh — PreToolUse hook: blocca comandi che espongono secrets da .env o variabili AWS/DB
# Matcher: Bash

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Blocca cat/less/more/head/tail su file .env (ma non .env.example o .env.testing)
if echo "$COMMAND" | grep -qE '(cat|less|more|head|tail)\s+[^ ]*\.env(\s|$)' \
  && ! echo "$COMMAND" | grep -qE '\.env\.(example|testing|sample|dist)'; then
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"env-guard: stai leggendo un file .env che potrebbe contenere secrets (AWS keys, DB passwords, API keys). Assicurati che l output non venga loggato o esposto."},"systemMessage":"⚠️ env-guard: lettura .env rilevata — conferma richiesta"}'
  exit 0
fi

# Blocca echo/print di variabili secrets note
if echo "$COMMAND" | grep -qE 'echo\s+\$(AWS_SECRET|AWS_ACCESS|DB_PASSWORD|APP_KEY|SECRET_KEY|PRIVATE_KEY|API_KEY)'; then
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"BLOCCO env-guard: tentativo di stampare una variabile secret (%s). Non esporre mai secrets in output/log."},"systemMessage":"🛑 env-guard: stampa di variabile secret BLOCCATA"}' \
    "$(echo "$COMMAND" | grep -oE '\$(AWS_SECRET|AWS_ACCESS|DB_PASSWORD|APP_KEY|SECRET_KEY|PRIVATE_KEY|API_KEY)[A-Z_]*' | head -1)"
  exit 2
fi

exit 0
