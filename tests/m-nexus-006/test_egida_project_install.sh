#!/usr/bin/env bash
# @package oracode — M-NEXUS-006 acceptance
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0
# @date 2026-06-08
# @purpose Verify E5-/project — Egida difesa-by-default nel bootstrap: configure determina egida_profile,
#          install persiste starter, scaffold copia starter + scrive egida_gate/egida_profile, descrittore esteso.
# @mission M-NEXUS-006

CMD=/home/fabio/oracode/.claude/commands
CONFIGURE="$CMD/oracode-configure.md"
INSTALL="$CMD/oracode-install.md"
SCAFFOLD="$CMD/oracode-scaffold.md"
PROJECT="$CMD/project.md"
DESCRIPTOR=/home/fabio/oracode/templates/PROJECT-DOC/.oracode/project.json
STARTERS=/home/fabio/os3-matrix/templates/egida
FAIL=0
green() { printf '\033[32m✓\033[0m %s\n' "$1"; }
red()   { printf '\033[31m✗\033[0m %s\n' "$1"; FAIL=$((FAIL+1)); }
has()   { if grep -qiF "$2" "$1"; then green "$3"; else red "MANCA: $3"; fi; }

echo "── Dipendenza: starter os3-matrix presenti (M-OS3-101) ──"
for t in L1 L2-L3 L3-L4; do
  if [ -f "$STARTERS/SECURITY_INVARIANTS.starter.$t.json" ]; then green "starter $t"; else red "MANCA starter $t (dipendenza os3-matrix)"; fi
done

echo "── oracode-configure: determina egida_profile ──"
has "$CONFIGURE" "egida_profile" "configure cita egida_profile"
has "$CONFIGURE" "L3-L4" "configure mappa profilo L3-L4"
has "$CONFIGURE" "denaro" "configure: segnale rischio denaro/PII/blockchain"

echo "── oracode-install: persiste starter (G1) ──"
has "$INSTALL" ".oracode/etc/egida" "install persiste starter in .oracode/etc/egida"
has "$INSTALL" "SECURITY_INVARIANTS.starter" "install nomina gli starter Egida"

echo "── oracode-scaffold: copia starter + scrive flag ──"
has "$SCAFFOLD" "SECURITY_INVARIANTS.json" "scaffold scaffolda SECURITY_INVARIANTS.json"
has "$SCAFFOLD" ".oracode/etc/egida" "scaffold copia dalla copia persistita"
has "$SCAFFOLD" "egida_gate" "scaffold scrive egida_gate nel descrittore"
has "$SCAFFOLD" "egida_profile" "scaffold scrive egida_profile nel descrittore"

echo "── Prerequisito Matrix (G2): Egida da liv 2+ ──"
has "$SCAFFOLD" "livello 2" "scaffold: Egida solo con Matrix (liv 2+)"

echo "── descrittore template esteso ──"
has "$DESCRIPTOR" "egida_gate" "template descrittore documenta egida_gate"

echo "── /project Fase 5: riepilogo cita difesa Egida ──"
has "$PROJECT" "Egida" "Fase 5 riepilogo cita Egida"

echo ""
if [ $FAIL -eq 0 ]; then
  green "TUTTI I TEST PASSATI (M-NEXUS-006 — Egida nel bootstrap /project)"
  exit 0
else
  red "$FAIL test FALLITI (M-NEXUS-006)"
  exit 1
fi
