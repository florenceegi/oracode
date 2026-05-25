#!/usr/bin/env bash
# p04-method-guard.sh — PreToolUse hook: BLOCCA scrittura di codice con metodi/service non verificati
# Matcher: Write|Edit (su file PHP e Python)
# Regole enforce: P0-4 (Anti-Method-Invention), P0-6 (Anti-Service-Method)
# v1.0.0 — 2026-04-09
#
# LOGICA:
# 1. Legge il contenuto che sta per essere scritto (new_string per Edit, content per Write)
# 2. Estrae gli import/use di service/class esterni
# 3. Per ogni service importato, verifica che il file esista nel filesystem
# 4. Per ogni metodo chiamato su quel service, verifica che il metodo esista nel file
# 5. Se un metodo non esiste → BLOCCO (exit 2)
#
# ECCEZIONI:
# - File non PHP/Python → skip
# - Edit di poche righe (< 3 righe new_string) → skip (fix puntuale)
# - Metodi di Laravel/framework (->validate, ->json, ->get, ->find, etc.) → skip
# - File di test → skip

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ]; then
  exit 0
fi

# Solo file PHP e Python
EXT="${FILE##*.}"
case "$EXT" in
  php|py) ;;
  *) exit 0 ;;
esac

# Estrai il contenuto che verra scritto
if [ "$TOOL" = "Write" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty' 2>/dev/null)
elif [ "$TOOL" = "Edit" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty' 2>/dev/null)
  # Skip edit piccoli (fix puntuale, < 3 righe)
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

# Skip file di test (solo directory tests/, non nomi di file con "Test" nel nome)
if echo "$FILE" | grep -qiE '/tests/|/test/|/spec/|/mock/|Seeder\.php$|Factory\.php$'; then
  exit 0
fi

VIOLATIONS=()

# ─── PHP: Verifica use statements e metodi ─────────────────────────────────
if [ "$EXT" = "php" ]; then

  # Trova la root del progetto (cerca composer.json risalendo)
  PROJECT_ROOT=$(dirname "$FILE")
  while [ "$PROJECT_ROOT" != "/" ] && [ ! -f "$PROJECT_ROOT/composer.json" ]; do
    PROJECT_ROOT=$(dirname "$PROJECT_ROOT")
  done
  if [ "$PROJECT_ROOT" = "/" ]; then
    exit 0
  fi

  # Estrai use statements di service dell'app (non vendor, non framework)
  APP_USES=$(echo "$CONTENT" | grep -oP 'use App\\[A-Za-z\\]+;' 2>/dev/null | sed 's/use //;s/;//')

  for USE_CLASS in $APP_USES; do
    # Converti namespace in path: App\Services\Foo -> app/Services/Foo.php
    RELATIVE_PATH=$(echo "$USE_CLASS" | sed 's|\\|/|g' | sed 's|^App/|app/|').php
    FULL_PATH="$PROJECT_ROOT/$RELATIVE_PATH"

    if [ ! -f "$FULL_PATH" ]; then
      VIOLATIONS+=("P0-4 BLOCK: use $USE_CLASS — file non esiste: $RELATIVE_PATH")
      continue
    fi

    # Estrai metodi chiamati su questo service nel contenuto
    # Pattern: ->metodoNome( o ::metodoNome(
    CLASS_SHORT=$(echo "$USE_CLASS" | rev | cut -d'\' -f1 | rev | sed 's/\\//g')
    # Cerca variabili tipizzate con questa classe e i metodi chiamati
    METHODS_CALLED=$(echo "$CONTENT" | grep -oP "\->[a-zA-Z_]+\(" 2>/dev/null | sed 's/->//;s/($//' | sort -u)

    # Filtra metodi di framework/base (non serve verificare questi)
    FRAMEWORK_METHODS="handle|__construct|validate|json|get|find|first|create|update|delete|where|with|select|save|fresh|count|exists|pluck|map|filter|each|render|view|redirect|response|abort|back|route|config|env|auth|log|info|warning|error|debug|dispatch|queue"

    for METHOD in $METHODS_CALLED; do
      # Skip metodi framework
      if echo "$METHOD" | grep -qE "^($FRAMEWORK_METHODS)$"; then
        continue
      fi

      # Skip metodi molto comuni (getter/setter/is/has)
      if echo "$METHOD" | grep -qE "^(get|set|is|has|can|should|make|to|from)[A-Z]"; then
        continue
      fi

      # Verifica se il metodo esiste nel file del service
      if ! grep -q "function ${METHOD}" "$FULL_PATH" 2>/dev/null; then
        # Cerca anche nelle interfacce e trait usati dal service
        FOUND=0
        INTERFACES=$(grep -oP 'implements\s+\K[A-Za-z,\s\\]+' "$FULL_PATH" 2>/dev/null | tr ',' '\n' | tr -d ' ')
        for IFACE in $INTERFACES; do
          IFACE_PATH=$(echo "$IFACE" | sed 's|\\|/|g' | sed 's|^App/|app/|').php
          if grep -q "function ${METHOD}" "$PROJECT_ROOT/$IFACE_PATH" 2>/dev/null; then
            FOUND=1
            break
          fi
        done

        if [ "$FOUND" -eq 0 ]; then
          VIOLATIONS+=("P0-4 BLOCK: ->$METHOD() non trovato in $CLASS_SHORT ($RELATIVE_PATH)")
        fi
      fi
    done
  done
fi

# ─── PYTHON: Verifica import e metodi ──────────────────────────────────────
if [ "$EXT" = "py" ]; then

  # Trova la root del progetto
  PROJECT_ROOT=$(dirname "$FILE")
  while [ "$PROJECT_ROOT" != "/" ] && [ ! -f "$PROJECT_ROOT/requirements.txt" ] && [ ! -f "$PROJECT_ROOT/pyproject.toml" ]; do
    PROJECT_ROOT=$(dirname "$PROJECT_ROOT")
  done
  if [ "$PROJECT_ROOT" = "/" ]; then
    exit 0
  fi

  # Estrai import locali (from app.* import *)
  APP_IMPORTS=$(echo "$CONTENT" | grep -oP 'from app\.[a-z_.]+\s+import\s+[A-Za-z_]+' 2>/dev/null)

  while IFS= read -r IMPORT_LINE; do
    [ -z "$IMPORT_LINE" ] && continue

    MODULE=$(echo "$IMPORT_LINE" | grep -oP 'from \K[a-z_.]+')
    CLASS=$(echo "$IMPORT_LINE" | grep -oP 'import \K[A-Za-z_]+')

    RELATIVE_PATH=$(echo "$MODULE" | sed 's|\.|/|g').py
    FULL_PATH="$PROJECT_ROOT/$RELATIVE_PATH"

    if [ ! -f "$FULL_PATH" ]; then
      VIOLATIONS+=("P0-4 BLOCK: from $MODULE import $CLASS — file non esiste: $RELATIVE_PATH")
      continue
    fi

    # Verifica metodi chiamati (self.service.metodo() o class.metodo())
    METHODS_CALLED=$(echo "$CONTENT" | grep -oP "\.[a-z_]+\(" 2>/dev/null | sed 's/\.//;s/($//' | sort -u)

    PY_FRAMEWORK="__init__|__str__|__repr__|get|set|post|put|delete|patch|json|dict|model_dump|items|keys|values|append|extend|format|strip|split|join|lower|upper|replace|encode|decode"

    for METHOD in $METHODS_CALLED; do
      if echo "$METHOD" | grep -qE "^($PY_FRAMEWORK)$"; then
        continue
      fi
      if echo "$METHOD" | grep -qE "^(get_|set_|is_|has_)"; then
        continue
      fi

      if ! grep -q "def ${METHOD}" "$FULL_PATH" 2>/dev/null; then
        VIOLATIONS+=("P0-4 BLOCK: .$METHOD() non trovato in $CLASS ($RELATIVE_PATH)")
      fi
    done
  done <<< "$APP_IMPORTS"
fi

# ─── OUTPUT ────────────────────────────────────────────────────────────────
if [ ${#VIOLATIONS[@]} -gt 0 ]; then
  >&2 echo ""
  >&2 echo "━━━ BLOCCO P0-4/P0-6: METODI NON VERIFICATI ━━━━━━━━━━━━━━━━━━━━━━"
  >&2 echo "File: $FILE"
  >&2 echo ""
  for V in "${VIOLATIONS[@]}"; do
    >&2 echo "  $V"
  done
  >&2 echo ""
  >&2 echo "AZIONE: Verifica con grep che il metodo/classe esista PRIMA di scrivere."
  >&2 echo "  grep -n 'function nomeMetodo' path/al/service.php"
  >&2 echo "  grep -n 'def nome_metodo' path/al/service.py"
  >&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  exit 2
fi

exit 0
