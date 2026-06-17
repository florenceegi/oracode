#!/usr/bin/env bash
# Test P0-13 (RED→GREEN) per M-NEXUS-000 — valida che i due SSOT costituzionali
# dell'Anello di Auto-Miglioramento esistano e contengano le clausole OBBLIGATORIE.
# È l'anticorpo costituzionale: se un domani una clausola Tier-0 sparisce, questo test va RED.
set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
W1="$ROOT/docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md"
W2="$ROOT/docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md"

fail=0
check() { # check <file> <pattern> <descrizione>
  if grep -qi -- "$2" "$1" 2>/dev/null; then
    echo "  ✓ $3"
  else
    echo "  ✗ MANCA: $3   [$2]"; fail=1
  fi
}
exists() {
  if [ -f "$1" ]; then echo "✓ esiste: $1"; else echo "✗ MANCA FILE: $1"; fail=1; fi
}

echo "== W1 — Pattern Anello =="
exists "$W1"
check "$W1" "NexusNotificationHandler"      "W1: trigger handler UEM nominato"
check "$W1" "nexus.florenceegi.com"          "W1: destinatario segnale = nexus.florenceegi.com (D5/D6)"
check "$W1" "anelli annidati"                "W1: due anelli annidati"
check "$W1" "punti-di-stop"                  "W1: 4 punti-di-stop agente"
check "$W1" "CAUSA-RIMOSSA"                   "W1: gate anti-soppressione Q6/D9 (causa-rimossa, non sintomo)"
check "$W1" "stop-al-plateau"                "W1: gate anti-collapse Q7/D10"
check "$W1" "SSOT_LOOP_PROTOCOL"             "W1: cross-ref al metodo-padre Fucina (no duplicazione)"

echo "== W2 — Denylist Tier 0 =="
exists "$W2"
check "$W2" "REGOLA ZERO"                    "W2: Tier0 costituzionale — REGOLA ZERO"
check "$W2" "OSZ"                            "W2: Tier0 — gerarchia OSZ→OS3→OS4"
check "$W2" "invariante #4"                  "W2: Tier0 — invariante #4 (agency umana)"
check "$W2" "meta-clausola"                  "W2: Tier0 — meta-clausola immutabilità"
check "$W2" "safety-classifier"             "W2: Tier0 operativo — enforcer safety-classifier"
check "$W2" "mission-state-guard"           "W2: Tier0 operativo — enforcer mission-state-guard"
check "$W2" "rm-guard"                       "W2: Tier0 operativo — enforcer rm-guard"
check "$W2" "Tier 1"                          "W2: gerarchia mutabilità (skill=Tier 1, D8)"

echo "----"
if [ "$fail" -eq 0 ]; then echo "GREEN — costituzione Anello completa"; exit 0
else echo "RED — costituzione incompleta/assente"; exit 1; fi
