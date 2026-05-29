#!/usr/bin/env bash
# @package oracode — M-OS3-023 acceptance
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0
# @date 2026-05-29
# @purpose Verify SSOT_REGISTRY.json canonical bootstrap — 39 paradigm docs registered, schema valid, paths resolve.
# @mission M-OS3-023

set -e
REG="/home/fabio/oracode/docs/lso/SSOT_REGISTRY.json"
FAIL=0
green() { printf '\033[32m✓\033[0m %s\n' "$1"; }
red()   { printf '\033[31m✗\033[0m %s\n' "$1"; FAIL=$((FAIL+1)); }

echo "── Esistenza + JSON valido ──"
if [ -f "$REG" ]; then green "SSOT_REGISTRY.json esiste"; else red "MISSING"; exit 1; fi
node -e "JSON.parse(require('fs').readFileSync('$REG'))" && green "JSON valido" || { red "JSON invalido"; exit 1; }

echo "── Schema _meta canonical ──"
node -e "
const r=JSON.parse(require('fs').readFileSync('$REG'));
const m=r._meta||{};
if(m.level===1 && m.organ_type && m.schema==='canonical-paradigm' && r.documents && Array.isArray(r.documents)) process.exit(0);
console.error('schema _meta non conforme'); process.exit(1);
" && green "_meta canonical (level 1, schema canonical-paradigm)" || red "_meta NON conforme"

echo "── 39 documenti registrati ──"
N=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$REG')).documents.length)")
if [ "$N" -eq 39 ]; then green "39 documenti registrati"; else red "atteso 39, trovato $N"; fi

echo "── Tutti i path risolvono a file reali ──"
node -e "
const fs=require('fs');
const r=JSON.parse(fs.readFileSync('$REG'));
let bad=0;
for(const d of r.documents){
  const p='/home/fabio/oracode/'+d.path;
  if(!fs.existsSync(p)){ console.error('PATH NON ESISTE: '+d.path); bad++; }
}
process.exit(bad>0?1:0);
" && green "39/39 path risolvono" || red "alcuni path non risolvono"

echo "── Ogni entry ha campi obbligatori ──"
node -e "
const r=JSON.parse(require('fs').readFileSync('/home/fabio/oracode/docs/lso/SSOT_REGISTRY.json'));
const req=['ssot_id','path','title','doc_type','priority','watches','registered_by','verified_in_mission','verification_mode'];
let bad=0;
for(const d of r.documents){
  for(const k of req){ if(!(k in d)){ console.error('MANCA '+k+' in '+d.ssot_id); bad++; } }
  if(!d.watches || !Array.isArray(d.watches.repos) || !Array.isArray(d.watches.paths)){ console.error('watches malformato in '+d.ssot_id); bad++; }
}
process.exit(bad>0?1:0);
" && green "tutti i campi obbligatori presenti" || red "campi mancanti"

echo "── ssot_id univoci ──"
node -e "
const r=JSON.parse(require('fs').readFileSync('/home/fabio/oracode/docs/lso/SSOT_REGISTRY.json'));
const ids=r.documents.map(d=>d.ssot_id);
const dup=ids.filter((x,i)=>ids.indexOf(x)!==i);
if(dup.length){ console.error('DUPLICATI: '+dup.join(',')); process.exit(1);}
process.exit(0);
" && green "ssot_id tutti univoci" || red "ssot_id duplicati"

echo "── spec-ssot watch os3-matrix enforcement ──"
node -e "
const r=JSON.parse(require('fs').readFileSync('/home/fabio/oracode/docs/lso/SSOT_REGISTRY.json'));
const spec=r.documents.filter(d=>d.doc_type==='spec-ssot');
const withWatch=spec.filter(d=>d.watches.paths.length>0);
if(spec.length>=10 && withWatch.length>=10) process.exit(0);
console.error('spec-ssot='+spec.length+' withWatch='+withWatch.length+' (atteso >=10 entrambi)');
process.exit(1);
" && green "spec-ssot watchano enforcement os3-matrix" || red "spec-ssot watches insufficienti"

echo ""
if [ $FAIL -eq 0 ]; then green "TUTTI I TEST PASSATI (M-OS3-023)"; exit 0; else red "$FAIL test FALLITI (M-OS3-023)"; exit 1; fi
