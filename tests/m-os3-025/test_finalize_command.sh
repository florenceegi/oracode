#!/usr/bin/env bash
# @package oracode/os3-matrix — M-OS3-025 acceptance
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0
# @date 2026-05-29
# @purpose Verify bin/mission finalize + REPO_MAP + .oracode/project.json + backfill stats 022/023/024.
# @mission M-OS3-025
set -e
ORA="/home/fabio/oracode"
MISSION="/home/fabio/os3-matrix/bin/mission"
REG="$ORA/docs/missions/MISSION_REGISTRY.json"
FAIL=0
green() { printf '\033[32m✓\033[0m %s\n' "$1"; }
red()   { printf '\033[31m✗\033[0m %s\n' "$1"; FAIL=$((FAIL+1)); }

echo "── REPO_MAP.json ──"
[ -f "$ORA/docs/missions/REPO_MAP.json" ] && green "REPO_MAP.json esiste" || red "MISSING REPO_MAP"
node -e "const r=JSON.parse(require('fs').readFileSync('$ORA/docs/missions/REPO_MAP.json')); process.exit((r.oracode&&r['os3-matrix'])?0:1)" && green "REPO_MAP ha oracode+os3-matrix" || red "REPO_MAP incompleto"

echo "── .oracode/project.json descrittore ──"
[ -f "$ORA/.oracode/project.json" ] && green ".oracode/project.json esiste" || red "MISSING project.json"
node -e "const p=JSON.parse(require('fs').readFileSync('$ORA/.oracode/project.json')); process.exit((p.registry_path&&p.repo_map_path&&p.instance_root)?0:1)" && green "project.json ha registry_path+repo_map_path+instance_root" || red "project.json incompleto"

echo "── bin/mission finalize command ──"
grep -q "finalize" "$MISSION" && green "finalize registrato in bin/mission" || red "finalize assente"
"$MISSION" finalize --help 2>&1 | grep -qi "finalize\|enrich\|retrospective" && green "finalize --help risponde" || red "finalize --help muto"

echo "── Backfill stats 022/023/024 ──"
for id in M-OS3-022 M-OS3-023 M-OS3-024; do
  node -e "
    const r=JSON.parse(require('fs').readFileSync('$REG'));
    const m=r.missions.find(x=>x.id==='$id');
    if(m && m.stats && typeof m.stats.productivity_index==='number') process.exit(0);
    process.exit(1);
  " && green "$id ha stats (productivity_index)" || red "$id senza stats"
done

echo "── Ghost 016/018/020 documentate irrecuperabili ──"
for id in M-OS3-016 M-OS3-018 M-OS3-020; do
  node -e "
    const r=JSON.parse(require('fs').readFileSync('$REG'));
    const m=r.missions.find(x=>x.id==='$id');
    if(m && (m.stats_status==='unrecoverable' || /irrecuperabil/i.test(m.note||''))) process.exit(0);
    process.exit(1);
  " && green "$id marcata irrecuperabile" || red "$id non documentata"
done

echo ""
[ $FAIL -eq 0 ] && { green "TUTTI I TEST PASSATI (M-OS3-025)"; exit 0; } || { red "$FAIL FALLITI"; exit 1; }
