#!/usr/bin/env bash
# @package oracode — M-NEXUS-005 acceptance
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0
# @date 2026-06-08
# @purpose Verify E1 Egida — clausola costitutiva difesa + matrice proporzionalità nel kernel OSZ,
#          riflessa nel Nexus index, charter RATIFICATO e copia downstream Fucina sincronizzata.
# @mission M-NEXUS-005

KERNEL="/home/fabio/oracode/templates/CLAUDE_ORACODE_CORE.md"
NEXUS="/home/fabio/oracode/docs/paradigm/index/Oracode-Nexus-index.md"
CHARTER="/home/fabio/EGI-DOC/docs/oracode/Egida/00_EGIDA_CHARTER.md"
FUCINA="/home/fabio/Fucina/CLAUDE_ORACODE_CORE.md"
FAIL=0
green() { printf '\033[32m✓\033[0m %s\n' "$1"; }
red()   { printf '\033[31m✗\033[0m %s\n' "$1"; FAIL=$((FAIL+1)); }
has()   { if grep -qiF "$2" "$1"; then green "$3"; else red "MANCA: $3"; fi; }

echo "── Kernel OSZ: clausola costitutiva Egida ──"
has "$KERNEL" "Asse Difesa Costitutivo" "sezione asse difesa nel kernel"
has "$KERNEL" "Un LSO si difende e prova la propria difesa" "clausola costitutiva (frase esatta)"
has "$KERNEL" "Egida" "nome Egida nel kernel"
has "$KERNEL" "proporzionale alla superficie di rischio" "principio proporzionalità nel kernel"

echo "── Kernel OSZ: matrice proporzionalità ──"
has "$KERNEL" "Banco di Prova" "matrice cita Banco di Prova (gate consegna)"
has "$KERNEL" "Fortino" "matrice cita Fortino (difesa runtime)"
has "$KERNEL" "vetrina" "profilo sito vetrina (L1)"
has "$KERNEL" "denaro/PII/blockchain" "profilo organo a rischio alto"

echo "── Nexus index: Egida come asse costitutivo ──"
has "$NEXUS" "Egida" "Egida presente nel Nexus index"
has "$NEXUS" "DeepDebug" "DeepDebug citato nel Nexus index"

echo "── Charter ratificato ──"
has "$CHARTER" "RATIFICATO" "charter status RATIFICATO"

echo "── Copia downstream Fucina sincronizzata ──"
if diff -q "$KERNEL" "$FUCINA" >/dev/null 2>&1; then
  green "Fucina CLAUDE_ORACODE_CORE.md identico al kernel canonico"
else
  red "Fucina copy DISALLINEATA dal kernel canonico"
fi

echo ""
if [ $FAIL -eq 0 ]; then
  green "TUTTI I TEST PASSATI (M-NEXUS-005 — Egida nel kernel)"
  exit 0
else
  red "$FAIL test FALLITI (M-NEXUS-005)"
  exit 1
fi
