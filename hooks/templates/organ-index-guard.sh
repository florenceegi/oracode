#!/usr/bin/env bash
# organ-index-guard.sh — PreToolUse hook (Write|Edit)
# Regola enforce: P0-13 (Organ Index — no duplicati cross-organo)
# v1.0.0 — 2026-04-10
#
# LOGICA:
# 1. Intercetta Write/Edit su file PHP, Python, TS/TSX
# 2. Estrae dichiarazioni di nuove classi, interfacce, trait, service, funzioni esportate
# 3. Cerca ogni nome nell'ORGAN_INDEX.json
# 4. Se trovato in un ALTRO organo → WARN (non BLOCK — potrebbe essere intenzionale)
# 5. Se trovato nello STESSO organo/file → skip (è un edit, non una duplicazione)

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ]; then
  exit 0
fi

INDEX="/home/fabio/EGI-DOC/docs/ecosistema/ORGAN_INDEX.json"
if [ ! -f "$INDEX" ]; then
  exit 0
fi

# Solo file sorgente
EXT="${FILE##*.}"
case "$EXT" in
  php|py|ts|tsx) ;;
  *) exit 0 ;;
esac

# Estrai il contenuto
if [ "$TOOL" = "Write" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty' 2>/dev/null)
elif [ "$TOOL" = "Edit" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty' 2>/dev/null)
  # Skip edit piccoli (< 3 righe = fix puntuale)
  LINECOUNT=$(echo "$CONTENT" | wc -l)
  if [ "$LINECOUNT" -lt 3 ]; then
    exit 0
  fi
else
  exit 0
fi

if [ -z "$CONTENT" ]; then
  exit 0
fi

# Determina in quale organo siamo
CURRENT_ORGAN=""
case "$FILE" in
  /home/fabio/EGI/*) CURRENT_ORGAN="EGI" ;;
  /home/fabio/EGI-HUB/*) CURRENT_ORGAN="EGI-HUB" ;;
  /home/fabio/NATAN_LOC/*) CURRENT_ORGAN="NATAN_LOC" ;;
  /home/fabio/EGI-Credential/*) CURRENT_ORGAN="EGI-Credential" ;;
  /home/fabio/EGI-SIGILLO/*) CURRENT_ORGAN="EGI-SIGILLO" ;;
  /home/fabio/EGI-HUB-HOME-REACT/*) CURRENT_ORGAN="EGI-HUB-HOME-REACT" ;;
  /home/fabio/EGI-INFO/*) CURRENT_ORGAN="EGI-INFO" ;;
  /home/fabio/EGI-STAT/*) CURRENT_ORGAN="EGI-STAT" ;;
  /home/fabio/YURI-BIAGINI/*) CURRENT_ORGAN="YURI-BIAGINI" ;;
  *) exit 0 ;;
esac

# Estrai nomi di nuove dichiarazioni dal contenuto
NAMES=()

# PHP: class, interface, trait, enum
if [ "$EXT" = "php" ]; then
  while IFS= read -r name; do
    [ -n "$name" ] && NAMES+=("$name")
  done < <(echo "$CONTENT" | grep -oP '(?:class|interface|trait|enum)\s+\K\w+' 2>/dev/null | sort -u)
fi

# Python: class
if [ "$EXT" = "py" ]; then
  while IFS= read -r name; do
    [ -n "$name" ] && NAMES+=("$name")
  done < <(echo "$CONTENT" | grep -oP '^class\s+\K\w+' 2>/dev/null | sort -u)
fi

# TS/TSX: export class, export interface, export function, export const fn
if [ "$EXT" = "ts" ] || [ "$EXT" = "tsx" ]; then
  while IFS= read -r name; do
    [ -n "$name" ] && NAMES+=("$name")
  done < <(echo "$CONTENT" | grep -oP 'export\s+(?:default\s+)?(?:abstract\s+)?(?:class|interface|function|type|enum)\s+\K\w+' 2>/dev/null | sort -u)
  # export const Name = (
  while IFS= read -r name; do
    [ -n "$name" ] && NAMES+=("$name")
  done < <(echo "$CONTENT" | grep -oP 'export\s+const\s+\K\w+(?=\s*=\s*(?:async\s*)?\()' 2>/dev/null | sort -u)
fi

if [ ${#NAMES[@]} -eq 0 ]; then
  exit 0
fi

# Cerca ogni nome nell'indice
WARNINGS=()

for NAME in "${NAMES[@]}"; do
  # Skip nomi generici troppo corti
  if [ ${#NAME} -lt 4 ]; then
    continue
  fi

  # Cerca nell'indice: simboli con lo stesso nome ESATTO in altri organi
  MATCHES=$(python3 -c "
import json, sys
with open('$INDEX') as f:
    idx = json.load(f)
for organ, odata in idx.get('organs', {}).items():
    if organ == '$CURRENT_ORGAN':
        continue
    for fpath, syms in odata.get('files', {}).items():
        for s in syms:
            if s['name'] == '$NAME' and s['type'] in ('class','interface','trait','enum','function','async_function'):
                print(f\"{organ}:{fpath}:{s['line']}\")
" 2>/dev/null)

  if [ -n "$MATCHES" ]; then
    WARNINGS+=("⚠️  $NAME — esiste già in:")
    while IFS= read -r match; do
      WARNINGS+=("     → $match")
    done <<< "$MATCHES"
  fi
done

if [ ${#WARNINGS[@]} -gt 0 ]; then
  >&2 echo ""
  >&2 echo "━━━ P0-13 ORGAN INDEX — POSSIBILI DUPLICATI ━━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo "File: $FILE"
  >&2 echo "Organo corrente: $CURRENT_ORGAN"
  >&2 echo ""
  for W in "${WARNINGS[@]}"; do
    >&2 echo "  $W"
  done
  >&2 echo ""
  >&2 echo "AZIONE: Verifica se puoi riusare il componente esistente."
  >&2 echo "  Se la duplicazione è intenzionale, procedi."
  >&2 echo "  Ricerca: cd /home/fabio/oracode/bin && python3 -m organ_index --search \"Nome\""
  >&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  # WARN, non BLOCK — exit 0 per non bloccare, ma il messaggio appare
  exit 0
fi

exit 0
