#!/usr/bin/env bash
# mission-report-guard.sh — PostToolUse hook: BLOCCA push se missione incompleta
# Trigger: PostToolUse Bash (git push su EGI-DOC)
# Verifica: report_tecnico + report_esteso (_FULL) per ogni missione completed
# v2.0.0 — 2026-04-09 (M-039: da warning a bloccante)

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

[ -z "$CMD" ] && exit 0

# Solo su git push
echo "$CMD" | grep -q 'git push' || exit 0

# Solo se il diff include MISSION_REGISTRY.json (push EGI-DOC con missioni)
REGISTRY="${ORACODE_MISSION_REGISTRY:-$HOME/.oracode/mission-registry.json}"
[ ! -f "$REGISTRY" ] && exit 0

# Verifica che siamo in EGI-DOC o che il push sia verso main di EGI-DOC
CWD=$(echo "$INPUT" | jq -r '.tool_input.cwd // empty' 2>/dev/null)
if [ -n "$CWD" ]; then
  echo "$CWD" | grep -q "EGI-DOC" || exit 0
fi

# Controlla missioni completed senza report_tecnico O senza report_esteso
PROBLEMS=$(python3 -c "
import json, sys, os
try:
    with open('$REGISTRY') as f:
        data = json.load(f)
    missions_dir = '${ORACODE_DOC_ROOT:-$HOME/.oracode/docs/}missions'
    issues = []
    for m in data.get('missions', []):
        mid = m.get('mission_id', '?')
        stato = m.get('stato', '')
        titolo = m.get('titolo')
        if stato != 'completed' or titolo is None:
            continue
        # Check report_tecnico
        rt = m.get('report_tecnico')
        if not rt:
            issues.append(f'  {mid}: MANCA report_tecnico')
        elif not os.path.exists(os.path.join(missions_dir, os.path.basename(rt))):
            issues.append(f'  {mid}: report_tecnico dichiarato ma file non esiste ({rt})')
        # Check report_esteso (_FULL)
        re = m.get('report_esteso')
        if not re:
            issues.append(f'  {mid}: MANCA report_esteso (_FULL)')
        elif not os.path.exists(os.path.join(missions_dir, os.path.basename(re))):
            issues.append(f'  {mid}: report_esteso dichiarato ma file non esiste ({re})')
    if issues:
        print('\n'.join(issues))
except Exception as e:
    pass
" 2>&1)

if [ -n "$PROBLEMS" ]; then
  >&2 echo ""
  >&2 echo "━━━ 🛑 MISSION REPORT GUARD — BLOCCO ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo "Missioni COMPLETED con report incompleti:"
  >&2 echo "$PROBLEMS"
  >&2 echo ""
  >&2 echo "AZIONE OBBLIGATORIA (Fase 6 protocollo /mission):"
  >&2 echo "  1. Scrivi report tecnico: M-NNN_TITOLO.md"
  >&2 echo "  2. Scrivi report esteso:  M-NNN_TITOLO_FULL.md"
  >&2 echo "  3. Aggiorna report_tecnico e report_esteso nel MISSION_REGISTRY.json"
  >&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo ""
  exit 2
fi

exit 0
