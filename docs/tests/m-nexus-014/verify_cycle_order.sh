#!/usr/bin/env bash
# @package  oracode/docs/tests/m-nexus-014
# @author   Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version  1.0.0 (M-NEXUS-014 — ordine ciclo Anello: ratifica PRIMA di propagazione)
# @date     2026-06-29
# @purpose  Rete anti-drift: nei documenti VIVI il ciclo dell'Anello deve avere la
#           RATIFICA umana PRIMA della propagazione nei SSOT (correzione CEO). Verifica
#           che l'ordine vecchio/fuorviante ("propagazione → ratifica") sia ASSENTE e
#           che l'ordine giusto sia presente nel pattern doc. Documenti storici/handoff
#           sono esclusi di proposito (fotografie nel tempo, non si riscrivono).
set -u
ROOT="${ORACODE_ROOT:-/home/fabio/oracode}"
PATTERN="$ROOT/docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md"
INDEX="$ROOT/docs/paradigm/index/Oracode-Nexus-index.md"
WRONG='propagazione *→ *ratifica'          # ordine vecchio (con o senza spazi attorno alla freccia)
RIGHT='ratifica umana *→ *propagazione'    # ordine corretto (ratifica prima)
fail=0
no_wrong() {
  if grep -Eq "$WRONG" "$1"; then echo "  ✗ ordine VECCHIO ancora presente: $1"; fail=1
  else echo "  ✓ ordine vecchio assente: $1"; fi
}
has_right() {
  if grep -Eq "$RIGHT" "$1"; then echo "  ✓ ordine giusto presente: $1"
  else echo "  ✗ ordine giusto ASSENTE: $1"; fail=1; fi
}
echo "== M-NEXUS-014 — coerenza ordine ciclo (ratifica → propagazione) =="
no_wrong "$PATTERN"
no_wrong "$INDEX"
has_right "$PATTERN"
echo
[ "$fail" -eq 0 ] && echo "RISULTATO: ✅ ordine coerente nei doc vivi" || echo "RISULTATO: ❌ drift ordine"
exit "$fail"
