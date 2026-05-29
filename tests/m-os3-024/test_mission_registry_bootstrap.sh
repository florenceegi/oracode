#!/usr/bin/env bash
# @package oracode — M-OS3-024 acceptance
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0
# @date 2026-05-29
# @purpose Verify MISSION_REGISTRY.json canonical bootstrap — English schema, 6 Nexus missions registered retroactively.
# @mission M-OS3-024
set -e
REG="/home/fabio/oracode/docs/missions/MISSION_REGISTRY.json"
FAIL=0
green() { printf '\033[32m✓\033[0m %s\n' "$1"; }
red()   { printf '\033[31m✗\033[0m %s\n' "$1"; FAIL=$((FAIL+1)); }

echo "── Esistenza + JSON valido ──"
[ -f "$REG" ] && green "MISSION_REGISTRY.json esiste" || { red "MISSING"; exit 1; }
node -e "JSON.parse(require('fs').readFileSync('$REG'))" && green "JSON valido" || { red "JSON invalido"; exit 1; }

echo "── Schema inglese (fabiocherici) ──"
node -e "
const r=JSON.parse(require('fs').readFileSync('$REG'));
if(!r._meta||!r.counter===undefined||!Array.isArray(r.missions)){console.error('top-level non conforme');process.exit(1);}
const e=r.missions[0];
const eng=['id','title','status','date_open','date_close'];
for(const k of eng){if(!(k in e)){console.error('manca chiave inglese '+k);process.exit(1);}}
// no chiavi italiane
const ita=['mission_id','titolo','stato','data_apertura','data_chiusura'];
for(const k of ita){if(k in e){console.error('chiave italiana presente '+k);process.exit(1);}}
process.exit(0);
" && green "schema inglese confermato (id/title/status/date_open/date_close)" || red "schema NON inglese"

echo "── 7 mission Nexus registrate (6 retroattive + M-OS3-024 self) ──"
N=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$REG')).missions.length)")
[ "$N" -eq 7 ] && green "7 mission registrate" || red "atteso 7, trovato $N"

echo "── Mission attese presenti ──"
for id in M-OS3-016 M-OS3-018 M-OS3-020 M-OS3-021 M-OS3-022 M-OS3-023 M-OS3-024; do
  node -e "const r=JSON.parse(require('fs').readFileSync('$REG'));process.exit(r.missions.find(m=>m.id==='$id')?0:1)" && green "$id presente" || red "$id MANCANTE"
done

echo "── M-OS3-021 suspended + M-OS3-022/023 closed ──"
node -e "
const r=JSON.parse(require('fs').readFileSync('$REG'));
const g=id=>r.missions.find(m=>m.id===id);
if(g('M-OS3-021').status!=='suspended'){console.error('021 non suspended');process.exit(1);}
if(g('M-OS3-022').status!=='closed'){console.error('022 non closed');process.exit(1);}
if(g('M-OS3-023').status!=='closed'){console.error('023 non closed');process.exit(1);}
process.exit(0);
" && green "stati corretti" || red "stati errati"

echo "── counter coerente ──"
node -e "const r=JSON.parse(require('fs').readFileSync('$REG'));process.exit(r.counter>=23?0:1)" && green "counter >= 23" || red "counter errato"

echo ""
[ $FAIL -eq 0 ] && { green "TUTTI I TEST PASSATI (M-OS3-024)"; exit 0; } || { red "$FAIL FALLITI"; exit 1; }
