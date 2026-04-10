#!/usr/bin/env bash
# mica-guard.sh — PreToolUse hook: blocca pattern di conversione EUR↔Egili (violazione MiCA)
# Matcher: Write|Edit

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

# Escludi file di contratto/documentazione (elencano pattern vietati per proibirli)
if echo "$FILE" | grep -qE '(contracts/.*\.json|docs/.*\.md|CLAUDE.*\.md|\.sh$)'; then
  exit 0
fi

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

# Pattern MiCA-unsafe: conversioni dirette EUR↔Egili
# Non si attiva su file di documentazione/contratti (già esclusi sopra)
if echo "$CONTENT" | grep -qiE \
  'eur_per_egili|credits_per_eur|egili_to_eur|eur_to_egili|CREDITS_PER_EUR|egili_eur_rate|eur_egili_rate|->toEur\(\)|->fromEur\(\)|toEuroValue|egiliToEuro|euroToEgili|fiat.*egili|egili.*fiat'; then

  MATCHES=$(echo "$CONTENT" | grep -iE 'eur_per_egili|credits_per_eur|egili_to_eur|eur_to_egili|CREDITS_PER_EUR|egili_eur_rate|eur_egili_rate|->toEur\(\)|->fromEur\(\)|toEuroValue|egiliToEuro|euroToEgili|fiat.*egili|egili.*fiat' | head -3 | tr '\n' ' ' | sed 's/"/\\"/g')

  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"BLOCCO MiCA-GUARD: pattern di conversione EUR/Egili rilevati: [%s]. MAI creare tassi diretti EUR↔Egili — viola MiCA. Gli Egili non hanno valore monetario. Vedi CLAUDE.md sezione Egili."},"systemMessage":"🚨 mica-guard: pattern EUR/Egili vietato rilevato nel codice — BLOCCATO"}' \
    "$MATCHES"
  exit 2
fi

exit 0
