#!/usr/bin/env bash
# @package  oracode/docs/tests/m-os3-147
# @author   claude (AI dev) for Fabio Cherici (CEO)
# @version  1.0.0 (M-OS3-147 — correzione nomenclatura: Oracode = solo paradigma; OS3 Matrix separato)
# @purpose  Fotografa in P0-13 red-first la REGOLA CORRETTA (decisione CEO 2026-07-13): la
#   nomenclatura NON deve più inquadrare OS3 Matrix come "articolazione interna di Oracode"
#   (framing arrivato dalla proposta M-NOMENCL-OSMX-002, mai ratificata). Oracode = SOLO paradigma
#   (MIT); OS3 Matrix = prodotto commerciale della software house, stessa classe delle Librerie LSO,
#   NON è Oracode. Il test verifica gli invarianti del documento dopo la correzione.
#
# Uso:  bash oracode/docs/tests/m-os3-147/verify_osmx_not_oracode.sh
set -uo pipefail

NOM="/home/fabio/oracode/docs/paradigm/nomenclature/LSO_NOMENCLATURE_v3.md"
DELTA="/home/fabio/oracode/docs/paradigm/nomenclature/proposals/M-NOMENCL-OSMX-002_DELTA.md"

[ -f "$NOM" ]   || { echo "verifier: nomenclatura assente: $NOM" >&2; exit 2; }
[ -f "$DELTA" ] || { echo "verifier: proposta delta assente: $DELTA" >&2; exit 2; }

fail=0
note() { printf -- '── %s\n' "$*"; }
ok()   { echo "PASS: $1"; }
ko()   { echo "FAIL: $1"; fail=1; }

# ── N1 (negativo) — sparisce il framing "Oracode si articola in OS3 Matrix" ──────────────────────
note "N1: la nomenclatura NON dice più 'Oracode si articola ... in due piani interni' (incl. OS3 Matrix)"
if grep -q "Oracode si articola formalmente in due piani interni" "$NOM"; then
  ko "framing 'articolazione interna di Oracode (A+B)' ancora presente — OS3 Matrix risulta parte di Oracode"
else
  ok "framing 'Oracode si articola in A+B' rimosso"
fi

# ── N2 (negativo) — OS3 Matrix non è più una sotto-sezione §1.1.B DENTRO §1.1 Oracode ─────────────
note "N2: OS3 Matrix non è più intestato come '#### 1.1.B ...' sotto §1.1 Oracode"
if grep -qE '^#### 1\.1\.B OS3 Matrix' "$NOM"; then
  ko "OS3 Matrix ancora archiviato come §1.1.B dentro il capitolo Oracode"
else
  ok "OS3 Matrix non più sotto-sezione di §1.1 Oracode"
fi

# ── P1 (positivo) — affermazione esplicita: OS3 Matrix NON è Oracode ──────────────────────────────
note "P1: la nomenclatura afferma esplicitamente che OS3 Matrix NON è Oracode"
if grep -qE "OS3 Matrix (non è Oracode|NON è Oracode)" "$NOM"; then
  ok "presente l'affermazione 'OS3 Matrix non è Oracode'"
else
  ko "manca un'affermazione esplicita 'OS3 Matrix non è Oracode'"
fi

# ── P2 (positivo) — OS3 Matrix collocato al livello software house, con le Librerie LSO ───────────
note "P2: OS3 Matrix collocato al livello software house / stessa classe delle Librerie LSO"
if grep -iE "OS3 Matrix" "$NOM" | grep -iqE "software house|softwarehouse"; then
  ok "OS3 Matrix legato al livello software house"
else
  ko "OS3 Matrix non collocato esplicitamente al livello software house"
fi

# ── P3 (positivo) — Oracode definito come SOLO paradigma (MIT) ────────────────────────────────────
note "P3: Oracode = solo paradigma (MIT), non contiene OS3 Matrix"
if grep -qE "Oracode è (il|SOLO il|solo il) paradigma" "$NOM"; then
  ok "Oracode definito come paradigma"
else
  ko "manca la definizione netta 'Oracode = (solo) il paradigma'"
fi

# ── T4 (positivo) — la vecchia proposta M-NOMENCL-OSMX-002 è marcata SUPERATA da M-OS3-147 ────────
note "T4: la proposta M-NOMENCL-OSMX-002 è marcata superata/ribaltata da M-OS3-147"
if grep -q "M-OS3-147" "$DELTA"; then
  ok "proposta delta marcata come superata da M-OS3-147"
else
  ko "la proposta M-NOMENCL-OSMX-002 non è ancora marcata superata da M-OS3-147"
fi

echo
if [ "$fail" -eq 0 ]; then echo "RISULTATO: TUTTO VERDE"; else echo "RISULTATO: $fail FAIL"; fi
exit "$fail"
