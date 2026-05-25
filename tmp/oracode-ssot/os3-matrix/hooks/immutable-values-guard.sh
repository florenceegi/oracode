#!/usr/bin/env bash
# immutable-values-guard.sh — PreToolUse hook: blocca modifica valori immutabili ecosistema
# Matcher: Write|Edit

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)

if [ "$TOOL" = "Write" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty' 2>/dev/null)
elif [ "$TOOL" = "Edit" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty' 2>/dev/null)
else
  exit 0
fi

if [ -z "$CONTENT" ]; then
  exit 0
fi

VIOLATIONS=""

# Funzione: verifica che un valore immutabile non sia cambiato
check_immutable() {
  local name="$1"
  local expected="$2"
  # Cerca assegnazioni del nome con un valore diverso dall'atteso
  local wrong
  wrong=$(echo "$CONTENT" | grep -iE "${name}\s*[=:]\s*[0-9][0-9.]*" | grep -vE "${name}\s*[=:]\s*${expected}(\s|$|[^0-9.])")
  if [ -n "$wrong" ]; then
    VIOLATIONS="${VIOLATIONS}${name}(atteso:${expected}); "
  fi
}

check_immutable "tokens_per_egili"              "80"
check_immutable "MIN_SIMILARITY"                "0\.45"
check_immutable "advisory_elapsed_threshold"    "180"
check_immutable "MIN_QUERY_CONFIDENCE"          "0\.1"
check_immutable "egili_per_query"               "296"
check_immutable "REASONABLE_LIMIT"              "5000"

if [ -n "$VIOLATIONS" ]; then
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"BLOCCO valori immutabili: %s— questi valori NON si modificano senza approvazione esplicita di Fabio. Vedi CLAUDE.md sezione Valori Immutabili."},"systemMessage":"🛑 immutable-values-guard: tentativo di modifica valori immutabili — BLOCCATO"}' \
    "$VIOLATIONS"
  exit 2
fi

exit 0
