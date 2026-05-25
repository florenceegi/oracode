#!/usr/bin/env bash
# hardcoded-strings-guard.sh — PreToolUse hook: blocca stringhe hardcoded in PHP senza translation keys
# Matcher: Write|Edit
# Pattern coperto: INCIDENT V-06 — P0-9 i18n violato

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty' 2>/dev/null)

if [ -z "$FILE" ] || [ -z "$CONTENT" ]; then
  exit 0
fi

# Solo file PHP
if [[ "$FILE" != *.php ]]; then
  exit 0
fi

# Cerca stringhe hardcoded in contesti response/errore (pattern comuni)
# es: 'message' => 'testo hardcoded', 'error' => 'testo', throw new Exception('testo')
VIOLATIONS=""

# Pattern: 'message' => 'stringa' (non usa __())
if echo "$CONTENT" | grep -qP "'(message|error|success|warning|status)'\s*=>\s*'[^']{5,}'"; then
  VIOLATIONS="$VIOLATIONS\n- 'message'/'error' => 'stringa hardcoded' trovato"
fi

# Pattern: return response()->json(['message' => 'stringa'])
if echo "$CONTENT" | grep -qP "response\(\)->json\(\[.*'[^']{5,}'"; then
  VIOLATIONS="$VIOLATIONS\n- response()->json() con stringhe hardcoded trovato"
fi

# Pattern: throw new \Exception('stringa hardcoded') — non usa __()
if echo "$CONTENT" | grep -qP "new \\\\?Exception\('[^']{5,}'"; then
  VIOLATIONS="$VIOLATIONS\n- new Exception() con stringa hardcoded trovato"
fi

if [ -n "$VIOLATIONS" ]; then
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"⚠️ STRINGHE HARDCODED RILEVATE in %s\n%s\n\nRegola OS3 P0-9: tutte le stringhe visibili allutente devono usare __(\"key\") con file lang in 6 lingue: it/en/de/es/fr/pt\n\nCorreggi le stringhe hardcoded prima di procedere, oppure conferma se hai già preparato le translation keys."},"systemMessage":"hardcoded-strings-guard: possibili stringhe hardcoded in %s"}' \
    "$(basename "$FILE")" "$VIOLATIONS" "$(basename "$FILE")"
  exit 0
fi

exit 0
