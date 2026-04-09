#!/usr/bin/env bash
# oracode mission-stats-guard — verifies completed missions have stats
# Trigger: PostToolUse Bash (on git push)
# If any completed mission lacks the stats field, warns the developer.

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

[ -z "$CMD" ] && exit 0
echo "$CMD" | grep -q 'git push' || exit 0

REGISTRY="{{ORACODE_DIR}}/mission-registry.json"
[ ! -f "$REGISTRY" ] && exit 0

MISSING=$(jq -r '.missions[] | select(.status == "completed" and .stats == null and .title != null) | .mission_id' "$REGISTRY" 2>/dev/null)

if [ -n "$MISSING" ]; then
  COUNT=$(echo "$MISSING" | wc -l)
  echo "ORACODE MISSION-STATS-GUARD: ${COUNT} completed mission(s) without stats:"
  echo "$MISSING" | while read mid; do echo "  - $mid"; done
  echo ""
  echo "Run: node mission/stats-calculator.js"
fi

exit 0
