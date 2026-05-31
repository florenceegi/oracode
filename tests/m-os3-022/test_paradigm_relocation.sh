#!/usr/bin/env bash
# @package oracode — M-OS3-022 acceptance
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0
# @date 2026-05-29
# @purpose Verify 38 paradigm docs relocated from EGI-DOC → oracode/docs/paradigm/ paradigma-nativa structure.
# @mission M-OS3-022

set -e
ROOT="/home/fabio/oracode/docs/paradigm"
FAIL=0
green() { printf '\033[32m✓\033[0m %s\n' "$1"; }
red()   { printf '\033[31m✗\033[0m %s\n' "$1"; FAIL=$((FAIL+1)); }
check() { if [ -e "$ROOT/$1" ]; then green "$1"; else red "MISSING $1"; fi; }

echo "── Struttura paradigma-nativa ──"
for d in kernel execution/OS3 execution/OSMx education lso nomenclature/proposals missions padmin ssot standards tech-specs doc-sync roadmap index; do
  check "$d"
done

echo "── Kernel OSZ (1) ──"
check "kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md"

echo "── Execution OS3 (6) ──"
for f in 00_OS3_Executive_Summary 01_Modulo_0_Il_Manifesto_OS3 02_Modulo_1_I_6_Pilastri_Cardinali 03_Modulo_2_REGOLA_ZERO 04_Modulo_3_Sistema_Priorita_P0_P3 05_Modulo_4_TOON_Format_Standard; do
  check "execution/OS3/${f}.md"
done

echo "── Education OS4 (1) ──"
check "education/OS4_FOUNDATION_DOCUMENT.md"

echo "── LSO (4) ──"
for f in MANIFESTO_LSO 00_LSO_LIVING_SOFTWARE_ORGANISM LSO_GUARD_TESTING_PROTOCOL_v1 LSO_GUARD_TESTING_PROTOCOL_INDEX; do
  check "lso/${f}.md"
done

echo "── Nomenclatura (3) ──"
for f in LSO_NOMENCLATURE_v2 LSO_NOMENCLATURE_INDEX; do
  check "nomenclature/${f}.md"
done
check "nomenclature/proposals/M-NOMENCL-OSMX-002_DELTA.md"

echo "── Missions (1) ──"
check "missions/MISSION_PROTOCOL.md"

echo "── SSOT (1) ──"
check "ssot/00_ORACODE_SYSTEM_SSOT.md"

echo "── Padmin (10) ──"
for f in PADMIN_INDEX PADMIN_ONBOARDING PADMIN_AI_IDENTITY; do
  check "padmin/${f}.md"
done
for f in PADMIN_IDENTITY_OS3_CORE PADMIN_IDENTITY_OS3_INDEX PADMIN_IDENTITY_OS3_INTEGRATION_GUIDE PADMIN_IDENTITY_OS3_P1_PRINCIPLES PADMIN_IDENTITY_OS3_P2_PATTERNS PADMIN_IDENTITY_OS3_P3_REFERENCE; do
  check "padmin/${f}.md"
done

echo "── Standards (3) ──"
for f in NAMING_STANDARD_CODE WEB_PAGE_QUALITY_GATE LEGACY_STACK_POLICY; do
  check "standards/${f}.md"
done

echo "── Tech specs (2) ──"
for f in READ_TRACKING_TECH_SPEC RETROSPECTIVE_TECH_SPEC; do
  check "tech-specs/${f}.md"
done

echo "── DOC-SYNC v2 (3) ──"
for f in DOC-SYNC_v2_SPECIFICA_OPERATIVA DOC-SYNC_v2_PIANO_IMPLEMENTATIVO DOC-SYNC_v2_STATO_DELLARTE; do
  check "doc-sync/${f}.md"
done

echo "── Roadmap (2) ──"
check "roadmap/ROADMAP_ORACODE.md"
check "roadmap/ORACODE_PARADIGM_v2_draft.md"

echo "── Index + misc (2) ──"
check "index/Oracode-Nexus-index.md"
check "padmin/PDTDP_Paradigma_Torre_di_Pisa.md"

echo "── No leftover in EGI-DOC ──"
for src in /home/fabio/EGI-DOC/docs/oracode/MISSION_PROTOCOL.md /home/fabio/EGI-DOC/docs/lso/LSO_NOMENCLATURE_v2.md /home/fabio/EGI-DOC/docs/oracode/Oracode_Systems/00_OSZ_ORACODE_SYSTEM_ZERO.md; do
  if [ -e "$src" ]; then red "LEFT BEHIND: $src"; else green "moved: $(basename $src)"; fi
done

echo ""
if [ $FAIL -eq 0 ]; then
  green "TUTTI I TEST PASSATI (M-OS3-022 — 38/38 doc relocated)"
  exit 0
else
  red "$FAIL test FALLITI (M-OS3-022)"
  exit 1
fi
