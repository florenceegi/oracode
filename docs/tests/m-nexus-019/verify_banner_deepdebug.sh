#!/usr/bin/env bash
# @package  oracode/docs/tests/m-nexus-019
# @author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
# @version  1.0.0 (M-NEXUS-019)
# @date     2026-08-28
# @purpose  Il banner DEPRECATO (M-OS3-138) non elenca DeepDebug tra le istanze-clienti: e' Libreria LSO (CEO 2026-08-28).
#           Esclude il kernel OSZ (Tier-0, deny-always: si corregge solo con cerimonia CEO).
set -u; O="$(cd "$(dirname "$0")/../../.." && pwd)"; fail=0
while IFS= read -r f; do
  case "$f" in *kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md) echo "  · escluso (Tier-0): ${f#$O/}"; continue;; esac
  if grep -n "DEPRECATO" "$f" | grep -q "Capasso, LeVespe, DeepDebug"; then echo "  ✗ banner cita ancora DeepDebug come cliente: ${f#$O/}"; fail=1; else echo "  ✓ ${f#$O/}"; fi
done < <(grep -rl "DEPRECATO — clausole di stato" "$O/docs/paradigm" --include=*.md)
[ $fail -eq 0 ] && { echo "✓ CONFORME"; exit 0; } || { echo "✗ NON conforme"; exit 1; }
