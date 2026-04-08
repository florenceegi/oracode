#!/usr/bin/env bash
# oracode ssot-reflex-guard — nervous system Layer 1 (reflex)
# Trigger: PostToolUse Write|Edit
# When a file is modified, checks if any SSOT document watches it.
# If yes, alerts the developer that documentation may need updating.

REGISTRY="{{ORACODE_DIR}}/ssot-registry.json"

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

[ -z "$FILE" ] || [ ! -f "$FILE" ] && exit 0
[ ! -f "$REGISTRY" ] && exit 0

# Normalize path: extract repo name and relative path
REL_PATH=""
REPO=""
for DIR in {{PROJECT_DIRS}}; do
  if echo "$FILE" | grep -q "^${DIR}/"; then
    REPO=$(basename "$DIR")
    REL_PATH=$(echo "$FILE" | sed "s|^${DIR}/||")
    break
  fi
done

[ -z "$REPO" ] || [ -z "$REL_PATH" ] && exit 0

# Look up in registry
MATCHES=$(jq -r --arg repo "$REPO" --arg relpath "$REL_PATH" '
  .documents[]? |
  select(.watches.repos[]? == $repo) |
  . as $doc |
  if (.watches.paths // []) | any(. as $pattern |
    if ($pattern | contains("*")) then
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

[ -z "$MATCHES" ] && exit 0

MSG=""
DOC_COUNT=0
while IFS='|' read -r SSOT_ID TITLE DOC_PATH PRIORITY; do
  [ -z "$SSOT_ID" ] && continue
  DOC_COUNT=$((DOC_COUNT + 1))
  MSG="${MSG}\n  - [${PRIORITY}] ${TITLE} -> ${DOC_PATH}"
done <<< "$MATCHES"

if [ "$DOC_COUNT" -gt 0 ]; then
  echo "ORACODE NERVE SIGNAL: ${REL_PATH} (${REPO}) is watched by ${DOC_COUNT} SSOT doc(s):${MSG}"
  echo ""
  echo "Documentation may need updating before closing this task."
fi

exit 0
