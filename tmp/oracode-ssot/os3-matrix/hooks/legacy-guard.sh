#!/usr/bin/env bash
# legacy-guard.sh — PreToolUse hook: richiede conferma prima di modificare file [LEGACY]
# Matcher: Edit|Write
# Usa permissionDecision: "ask" — non blocca, ma chiede conferma esplicita

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ]; then
  exit 0
fi

BASENAME=$(basename "$FILE")

# Lista file [LEGACY] critici da CLAUDE.md
LEGACY_FILES=(
  # Python
  "pipeline.py"
  "use_pipeline.py"
  "strategic_queries.py"
  "faro.py"
  "retriever.py"
  "query_analyzer.py"
  "scanner.py"
  "postgres_service.py"
  "commands.py"
  # Laravel PHP
  "DataExportService.php"
  "NatanChatService.php"
  "ConsentService.php"
  "PythonScraperService.php"
  "GdprService.php"
  "NatanScrapersController.php"
  "AuditLogService.php"
  # Frontend TS
  "app.ts"
  "Message.ts"
  "ChatInterface.ts"
  "prompt-builder.ts"
  "ProjectDetail.ts"
  "api.ts"
)

for LEGACY in "${LEGACY_FILES[@]}"; do
  if [ "$BASENAME" = "$LEGACY" ]; then
    LINE_COUNT=$(wc -l < "$FILE" 2>/dev/null || echo "?")
    printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"⚠️ LEGACY FILE: %s (%s righe). Regola OS3: applica SOLO fix minimo, nessun refactoring non richiesto. Hai dichiarato il piano?"},"systemMessage":"⚠️ legacy-guard: %s è un file [LEGACY] critico — conferma richiesta"}' \
      "$BASENAME" "$LINE_COUNT" "$BASENAME"
    exit 0
  fi
done

exit 0
