#!/usr/bin/env bash
# @package  oracode/docs/tests/m-nexus-015
# @author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
# @version  1.0.0 (M-NEXUS-015)
# @date     2026-08-27
# @purpose  Misura la deprecazione della cornice stale della gerarchia Nexus: esiste lo SSOT dello stato corrente
#           e ogni documento del paradigma che porta le vecchie clausole di stato lo dice con un banner.
# Exit 0 = conforme; 1 = violazione.
set -u
O="$(cd "$(dirname "$0")/../../.." && pwd)"; fail=0; bad(){ echo "  ✗ $*"; fail=1; }; ok(){ echo "  ✓ $*"; }
D="$O/docs/paradigm/nomenclature/NEXUS_HIERARCHY_CURRENT_STATE.md"
[ -f "$D" ] && ok "SSOT stato corrente presente" || { bad "SSOT stato corrente assente"; echo "✗ NON conforme"; exit 1; }
grep -q "^status: current" "$D" && ok "status: current" || bad "status non current"
n=$(awk '/^supersedes_clauses:/{p=1;next} p&&/^[^ ]/{exit} p&&/^  - /{c++} END{print c+0}' "$D"); [ "$n" -gt 0 ] && ok "supersedes_clauses: $n voci" || bad "supersedes_clauses vuoto"
# ogni file oracode elencato in supersedes_clauses porta il banner DEPRECATO che rimanda allo stato corrente
awk '/^supersedes_clauses:/{p=1;next} p&&/^[^ ]/{exit} p&&/^  - /{print}' "$D" | sed -E 's/^  - "//; s/:.*//' | grep -v '^os3-matrix/' | sort -u | while read -r rel; do
  f="$O/docs/paradigm/$rel"; [ -f "$f" ] || { echo "  · $rel non esiste piu' (gitignored o rimosso): salto"; continue; }
  grep -q "DEPRECATO" "$f" && grep -q "NEXUS_HIERARCHY_CURRENT_STATE" "$f" && echo "  ✓ banner: $rel" || { echo "  ✗ manca il banner: $rel"; echo FAIL >> "$O/docs/tests/m-nexus-015/.fail"; }
done
[ -f "$O/docs/tests/m-nexus-015/.fail" ] && { rm -f "$O/docs/tests/m-nexus-015/.fail"; fail=1; }
T="$O/docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md"; grep -q "DEPRECATO" "$T" && ok "3_TIER: banner in testa" || bad "3_TIER senza banner"
[ $fail -eq 0 ] && { echo "✓ CONFORME"; exit 0; } || { echo "✗ NON conforme"; exit 1; }
