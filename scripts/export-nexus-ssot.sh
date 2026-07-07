#!/usr/bin/env bash
# export-nexus-ssot.sh — Esporta TUTTI gli SSOT del paradigma Oracode Nexus in una cartella flat
# Uso: ./export-nexus-ssot.sh [cartella_destinazione]
# Default: /home/fabio/oracode/tmp/nexus-ssot-export/
#
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0 (Oracode Nexus — paradigma)
# @date 2026-05-31
# @purpose Copia flat (no sottocartelle) di tutti i doc SSOT del paradigma per
#          import in LLM esterni che NON supportano le directory (chatbot, NotebookLM,
#          Claude Project, ecc.). Gemello di EGI-DOC/scripts/export-ssot.sh, ma per
#          il LIVELLO 1 (paradigma Oracode Nexus), non per l'istanza FlorenceEGI.
# @mission M-OS3-025 (estensione)

set -euo pipefail

ORACODE="/home/fabio/oracode"
REGISTRY="${ORACODE}/docs/lso/SSOT_REGISTRY.json"
# M-OS3-139: lettore canonico format-agnostic (annidato/JSON-Lines), risolto dall'anchor engine.
REG_READER="$(jq -r '(.projects[]?|select(.anchor=="engine")|.root)//empty' "$HOME/oracode-engine/projects.json" 2>/dev/null)/bin/oracode-registry-docs"
DEST="${1:-${ORACODE}/tmp/nexus-ssot-export}"

if [ ! -f "$REGISTRY" ]; then
  echo "ERRORE: SSOT_REGISTRY.json paradigma non trovato in $REGISTRY"
  exit 1
fi

# Pulisci e ricrea
rm -rf "$DEST"
mkdir -p "$DEST"

TOTAL=0; COPIED=0; MISSING=0

echo "=== Oracode Nexus — SSOT Export (paradigma, L1) ==="
echo "Registry: $REGISTRY"
echo "Destinazione: $DEST"
echo "Data: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Copia i 39 doc paradigma. Prefisso = cluster (dir sotto docs/paradigm/), flat.
while IFS='|' read -r SSOT_ID DOC_PATH; do
  TOTAL=$((TOTAL + 1))
  FULL_PATH="${ORACODE}/${DOC_PATH}"
  if [ -f "$FULL_PATH" ]; then
    # cluster = porzione tra docs/paradigm/ e il filename (es. execution/OS3 -> execution-OS3)
    CLUSTER=$(dirname "${DOC_PATH#docs/paradigm/}" | tr '/' '-')
    [ "$CLUSTER" = "." ] && CLUSTER="root"
    BASENAME=$(basename "$DOC_PATH")
    cp "$FULL_PATH" "${DEST}/${CLUSTER}__${BASENAME}"
    COPIED=$((COPIED + 1))
  else
    echo "  MANCANTE: ${DOC_PATH}"
    MISSING=$((MISSING + 1))
  fi
done < <( { if [ -x "$REG_READER" ]; then "$REG_READER" "$REGISTRY"; else jq -c '[.documents[]?]' "$REGISTRY"; fi; } | jq -r '.[] | "\(.ssot_id)|\(.path)"')

# Documenti chiave NON nel registry ma vitali per capire Oracode Nexus
add_extra() {
  local src="$1" name="$2"
  if [ -f "$src" ]; then cp "$src" "${DEST}/${name}"; COPIED=$((COPIED + 1)); TOTAL=$((TOTAL + 1)); fi
}
add_extra "${ORACODE}/docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md" "00-LEGGE__ORACODE_NEXUS_3_TIER.md"  # già nel registry? se sì verrà sovrascritto, ok
add_extra "${ORACODE}/templates/CLAUDE_ORACODE_CORE.md"                    "00-BOOT__CLAUDE_ORACODE_CORE.md"
add_extra "${ORACODE}/README.md"                                          "00-README__oracode.md"

# Indice di lettura della cartella flat
{
  echo "# Oracode Nexus — SSOT export flat"
  echo ""
  echo "Snapshot di tutti gli SSOT del paradigma Oracode Nexus, appiattiti per import in"
  echo "contesti che non supportano le directory. Aggiornato: $(date '+%Y-%m-%d %H:%M:%S')."
  echo ""
  echo "**Leggi per primi:** \`00-LEGGE__ORACODE_NEXUS_3_TIER.md\` (la gerarchia a 3 livelli),"
  echo "\`00-BOOT__CLAUDE_ORACODE_CORE.md\` (regole/pilastri/P0), \`00-README__oracode.md\`."
  echo ""
  echo "Convenzione nome: \`<cluster>__<file-originale>.md\`. Cluster = area del paradigma"
  echo "(kernel, execution-OS3, education, lso, nomenclature, missions, ssot, padmin,"
  echo "standards, tech-specs, doc-sync, roadmap, index)."
  echo ""
  echo "File totali: ${COPIED}."
} > "${DEST}/000-INDEX.md"

echo ""
echo "Copiati: ${COPIED}/${TOTAL} file"
[ "$MISSING" -gt 0 ] && echo "Mancanti: ${MISSING}"
echo "Dimensione: $(du -sh "$DEST" | cut -f1)"
echo ""
echo "Cartella pronta: $DEST"
