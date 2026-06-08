#!/usr/bin/env bash
# @package oracode — M-NEXUS-007 acceptance
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0
# @date 2026-06-09
# @purpose Verify Dottrina del Supervisor (generica) nel kernel CORE + copia Fucina sincronizzata.
# @mission M-NEXUS-007
KERNEL="/home/fabio/oracode/templates/CLAUDE_ORACODE_CORE.md"
FUCINA="/home/fabio/Fucina/CLAUDE_ORACODE_CORE.md"
FAIL=0
green(){ printf '\033[32m✓\033[0m %s\n' "$1"; }
red(){ printf '\033[31m✗\033[0m %s\n' "$1"; FAIL=$((FAIL+1)); }
has(){ if grep -qiF "$2" "$KERNEL"; then green "$3"; else red "MANCA: $3"; fi; }

echo "── Kernel: Dottrina del Supervisor (generica) ──"
has x "Dottrina del Supervisor" "sezione Dottrina del Supervisor"
has x "riflesso" "i riflessi del Supervisor"
has x "esecutore di default" "pool grounded = esecutore di default"
has x "misura" "riflesso misura-prima"
has x "non risponde" "riflesso grounding (non da memoria)"

echo "── Copia Fucina sincronizzata ──"
if diff -q "$KERNEL" "$FUCINA" >/dev/null 2>&1; then green "Fucina CORE identico al kernel"; else red "Fucina CORE disallineato"; fi

echo ""
if [ $FAIL -eq 0 ]; then green "TUTTI I TEST PASSATI (M-NEXUS-007)"; exit 0
else red "$FAIL test FALLITI (M-NEXUS-007)"; exit 1; fi
