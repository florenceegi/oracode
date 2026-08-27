#!/usr/bin/env bash
# verify_rimando_egida.sh — Test-First (P0-13) per M-NEXUS-018 (sorella di M-FORTINO-003, lato Paradigma).
# Il CORE (prodotto, caricato da ogni istanza) non deve rimandare al charter d'istanza in EGI-DOC (fuori dal prodotto,
# decisione CEO 2026-07-11 confermata 2026-08-27): rimanda al modulo generico EGIDA_ASSE_DIFESA.md. Il Nexus index
# non cita piu' i documenti Fortino in EGI-DOC (ricollocati in FORTINO). Exit 0 = conforme; 1 = violazione.
# @author Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
set -u
O=/home/fabio/oracode; fail=0; bad(){ echo "  ✗ $*"; fail=1; }; ok(){ echo "  ✓ $*"; }
T=$O/templates/CLAUDE_ORACODE_CORE.md
grep -q "EGI-DOC/docs/oracode/Egida" "$T" && bad "template CORE cita il charter d'istanza" || ok "template CORE non cita il charter d'istanza"
grep -q "modules/EGIDA_ASSE_DIFESA.md" "$T" && ok "template CORE rimanda al modulo generico" || bad "template CORE non rimanda al modulo"
[ -f "$O/docs/paradigm/modules/EGIDA_ASSE_DIFESA.md" ] && ok "modulo presente" || bad "modulo assente"
[ -f "$O/docs/paradigm/modules/EGIDA_CHARTER.md" ] && bad "charter d'istanza copiato nel repo MIT" || ok "nessun charter d'istanza nel repo MIT"
grep -q "Versione template: 2.2.1" "$T" && ok "versione template 2.2.1" || bad "versione template non aggiornata"
grep -q "EGIDA_CHARTER.md\` + CORE" "$O/docs/paradigm/index/Oracode-Nexus-index.md" && bad "Nexus index r.28 rimanda ancora al charter" || ok "Nexus index r.28 rimanda al modulo"
grep -q "5 file: ORGANO, GUARDIANO" "$O/docs/paradigm/index/Oracode-Nexus-index.md" && bad "Nexus index cita ancora i doc Fortino in EGI-DOC" || ok "Nexus index aggiornato su Fortino"
[ $fail -eq 0 ] && { echo "✓ CONFORME"; exit 0; } || { echo "✗ NON conforme"; exit 1; }
