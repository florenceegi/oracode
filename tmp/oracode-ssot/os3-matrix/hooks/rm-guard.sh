#!/usr/bin/env bash
# rm-guard.sh — PreToolUse hook: blocca rm su file sorgente se esistono riferimenti attivi
# Applicato a: .php .ts .tsx .blade.php .py
# Cerca in: $HOME/EGI  $HOME/EGI-HUB  $HOME/NATAN_LOC

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Passa se non è un comando rm
if ! echo "$COMMAND" | grep -qE '(^|\s|\||\;|&&)rm(\s|$)'; then
  exit 0
fi

# Estrai tutti i file sorgente dal comando
ALL_FILES=$(echo "$COMMAND" | grep -oE '[^[:space:]"'"'"']+\.(php|ts|tsx|py)' 2>/dev/null)

if [ -z "$ALL_FILES" ]; then
  exit 0
fi

PROJECTS="$HOME/EGI $HOME/EGI-HUB $HOME/NATAN_LOC $HOME/EGI-HUB-HOME-REACT $HOME/EGI-INFO $HOME/EGI-STAT $HOME/EGI-Credential ${ORACODE_DOC_ROOT:-$HOME/.oracode}"
FOUND_REFS=""
BLOCKED_FILES=""

for FILE_PATH in $ALL_FILES; do
  BASENAME=$(basename "$FILE_PATH")
  # Rimuovi tutte le estensioni per ottenere il nome della classe
  CLASSNAME=$(echo "$BASENAME" | sed 's/\.blade\.php$//' | sed 's/\.[^.]*$//')

  # Salta nomi troppo generici (< 6 caratteri) — "test", "index", "app", ecc.
  if [ ${#CLASSNAME} -lt 6 ]; then
    continue
  fi

  # Cerca pattern specifici di riferimento (import, use, extends, implements, new)
  # evita match su nomi di variabili generici o commenti casuali
  REFS=$(grep -rl \
    --include="*.php" \
    --include="*.ts" \
    --include="*.tsx" \
    --include="*.py" \
    --include="*.blade.php" \
    --exclude-dir=vendor \
    --exclude-dir=node_modules \
    --exclude-dir=.history \
    --exclude-dir=.git \
    -E "(use |import |extends |implements |new |from )[^;\"']*${CLASSNAME}|${CLASSNAME}::|${CLASSNAME}Service|${CLASSNAME}Controller|${CLASSNAME}Model" \
    $PROJECTS 2>/dev/null \
    | grep -v "$(realpath "$FILE_PATH" 2>/dev/null || echo "$FILE_PATH")" \
    | head -8)

  if [ -n "$REFS" ]; then
    REFS_ONELINE=$(echo "$REFS" | tr '\n' '|' | sed 's/|$//')
    FOUND_REFS="${FOUND_REFS}[${CLASSNAME}]: ${REFS_ONELINE} /// "
    BLOCKED_FILES="${BLOCKED_FILES} ${BASENAME}"
  fi
done

if [ -n "$FOUND_REFS" ]; then
  REASON="BLOCCO rm —${BLOCKED_FILES} ha riferimenti attivi nel codebase: ${FOUND_REFS}Fai grep manuale e rimuovi i riferimenti prima di eliminare."
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"},"systemMessage":"🛑 rm-guard: riferimenti trovati — vedi reason per dettagli"}' \
    "$(echo "$REASON" | sed 's/"/\\"/g' | tr '\n' ' ')"
  exit 2
fi

exit 0
