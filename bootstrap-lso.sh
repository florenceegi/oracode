#!/usr/bin/env bash
# =============================================================================
# bootstrap-lso.sh — FlorenceEGI LSO Environment Bootstrap
# =============================================================================
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0 (FlorenceEGI — oracode)
# @date 2026-04-17
# @purpose Ricrea l'intero ambiente LSO su qualsiasi macchina:
#          clone/pull tutti i repo, installa hook, agenti, settings.json, workspace
#
# USAGE:
#   ./bootstrap-lso.sh                     # default: $HOME come base
#   ./bootstrap-lso.sh /percorso/custom    # directory custom
#   ./bootstrap-lso.sh --dry-run           # mostra cosa farebbe, non esegue
#
# PREREQUISITI:
#   - git + ssh key configurata per GitHub (florenceegi + AutobookNft)
#   - jq  (per merge settings.json)
#   - python3 (per organ_index)
# =============================================================================

set -euo pipefail

# ── Colori ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

ok()   { echo -e "${GREEN}  ✓${RESET} $*"; }
warn() { echo -e "${YELLOW}  ⚠${RESET} $*"; }
info() { echo -e "${CYAN}  →${RESET} $*"; }
err()  { echo -e "${RED}  ✗${RESET} $*" >&2; }
hdr()  { echo -e "\n${BOLD}${BLUE}══ $* ══${RESET}"; }

# ── Argomenti ────────────────────────────────────────────────────────────────
DRY_RUN=false
BASE_DIR="$HOME"

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    -*)        err "Opzione sconosciuta: $arg"; exit 1 ;;
    *)         BASE_DIR="$arg" ;;
  esac
done

CLAUDE_DIR="$HOME/.claude"
HOOKS_DIR="$CLAUDE_DIR/hooks"
AGENTS_DIR="$CLAUDE_DIR/agents"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

# Directory di questo script (= radice di oracode)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_TEMPLATES="$SCRIPT_DIR/hooks/templates"
AGENTS_TEMPLATES="$SCRIPT_DIR/agents/templates"

# ── Mappa repo ───────────────────────────────────────────────────────────────
# Formato: "NOME_DIR|GIT_REMOTE|BRANCH_DEFAULT"
declare -a REPOS=(
  "oracode|git@github.com:florenceegi/oracode.git|main"
  "EGI-DOC|git@github.com:florenceegi/EGI-DOC.git|main"
  "EGI|git@github.com:florenceegi/EGI.git|develop"
  "EGI-HUB|git@github.com:AutobookNft/EGI-HUB.git|main"
  "EGI-HUB-HOME-REACT|git@github.com:AutobookNft/EGI-HUB-HOME-REACT.git|main"
  "EGI-INFO|git@github.com:AutobookNft/EGI-INFO.git|main"
  "EGI-Credential|git@github.com:florenceegi/egi-credential.git|main"
  "NATAN_LOC|git@github.com:AutobookNft/NATAN_LOC.git|perfect-with-timeout"
  "LA-BOTTEGA|git@github.com:florenceegi/la-bottega.git|main"
  "EGI-SIGILLO|git@github.com:florenceegi/EGI-SIGILLO.git|new_domain"
  "EGI-STAT|git@github.com:AutobookNft/EGI-STAT.git|main"
  "CREATOR-STAGING|git@github.com:florenceegi/creator-staging.git|main"
  "FABIO-CHERICI-SITE|git@github.com:florenceegi/fabiocherici.git|main"
)

# ── Funzioni helper ──────────────────────────────────────────────────────────
run() {
  if $DRY_RUN; then
    echo -e "${YELLOW}  [DRY-RUN]${RESET} $*"
  else
    eval "$@"
  fi
}

check_prereqs() {
  hdr "Prerequisiti"
  local missing=0

  for cmd in git jq python3; do
    if command -v "$cmd" &>/dev/null; then
      ok "$cmd trovato: $(command -v $cmd)"
    else
      err "$cmd NON trovato — installalo prima di continuare"
      missing=$((missing + 1))
    fi
  done

  # Verifica SSH key GitHub
  if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    ok "SSH key GitHub OK"
  else
    warn "SSH GitHub: verifica manualmente con 'ssh -T git@github.com'"
    warn "      Necessaria per clonare repo privati"
  fi

  if [ "$missing" -gt 0 ]; then
    err "Prerequisiti mancanti. Installa e riprova."
    exit 1
  fi
}

clone_or_pull() {
  local name="$1"
  local remote="$2"
  local branch="$3"
  local target="$BASE_DIR/$name"

  if [ -d "$target/.git" ]; then
    info "$name — già presente, aggiorno (branch: $branch)..."
    if $DRY_RUN; then
      echo -e "${YELLOW}  [DRY-RUN]${RESET} git -C $target fetch origin && git -C $target checkout $branch && git -C $target pull origin $branch"
    else
      # Fetch silenzioso, poi checkout + pull
      git -C "$target" fetch origin --quiet 2>/dev/null || true
      git -C "$target" checkout "$branch" --quiet 2>/dev/null || \
        warn "  Branch $branch non trovato localmente per $name — uso branch corrente"
      git -C "$target" pull origin "$branch" --quiet 2>/dev/null || \
        warn "  Pull fallito per $name — continuo"
      ok "$name aggiornato"
    fi
  else
    info "$name — clono da $remote (branch: $branch)..."
    if $DRY_RUN; then
      echo -e "${YELLOW}  [DRY-RUN]${RESET} git clone --branch $branch $remote $target"
    else
      if git clone --branch "$branch" "$remote" "$target" --quiet 2>/dev/null; then
        ok "$name clonato"
      else
        warn "$name — clone fallito (SSH key? repo privato?) — skip"
      fi
    fi
  fi
}

install_hooks() {
  hdr "Hook LSO → $HOOKS_DIR"

  if ! $DRY_RUN; then
    mkdir -p "$HOOKS_DIR"
  fi

  local count=0
  for hook in "$HOOKS_TEMPLATES"/*.sh; do
    [ -f "$hook" ] || continue
    local name
    name="$(basename "$hook")"
    local dest="$HOOKS_DIR/$name"

    if $DRY_RUN; then
      echo -e "${YELLOW}  [DRY-RUN]${RESET} cp $hook → $dest && chmod +x"
    else
      cp "$hook" "$dest"
      chmod +x "$dest"
      ok "$name"
      count=$((count + 1))
    fi
  done

  $DRY_RUN || info "Installati $count hook"
}

install_agents() {
  hdr "Agenti LSO → $AGENTS_DIR"

  if ! $DRY_RUN; then
    mkdir -p "$AGENTS_DIR"
  fi

  local count=0
  for agent in "$AGENTS_TEMPLATES"/*.md; do
    [ -f "$agent" ] || continue
    local name
    name="$(basename "$agent")"
    local dest="$AGENTS_DIR/$name"

    if $DRY_RUN; then
      echo -e "${YELLOW}  [DRY-RUN]${RESET} cp $agent → $dest"
    else
      cp "$agent" "$dest"
      ok "$name"
      count=$((count + 1))
    fi
  done

  $DRY_RUN || info "Installati $count agenti"
}

install_settings_hooks() {
  hdr "settings.json — merge hooks LSO"

  # Struttura hooks da iniettare
  local hooks_json
  hooks_json=$(cat <<'HOOKSJSON'
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "HOOKS_DIR/rm-guard.sh",
          "timeout": 15,
          "statusMessage": "rm-guard: verifico riferimenti attivi..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/git-main-guard.sh",
          "timeout": 5,
          "statusMessage": "git-main-guard: verifico push sicuro..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/env-guard.sh",
          "timeout": 5,
          "statusMessage": "env-guard: verifico esposizione secrets..."
        }
      ]
    },
    {
      "matcher": "Write|Edit",
      "hooks": [
        {
          "type": "command",
          "command": "HOOKS_DIR/mica-guard.sh",
          "timeout": 5,
          "statusMessage": "mica-guard: verifico compliance MiCA..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/immutable-values-guard.sh",
          "timeout": 5,
          "statusMessage": "immutable-values-guard: verifico valori immutabili..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/legacy-guard.sh",
          "timeout": 5,
          "statusMessage": "legacy-guard: verifico file LEGACY..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/cross-project-guard.sh",
          "timeout": 10,
          "statusMessage": "cross-project-guard: verifico CLAUDE.md del progetto..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/os3-preflight-guard.sh",
          "timeout": 5,
          "statusMessage": "os3-preflight: enforcement regole OS3..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/hardcoded-strings-guard.sh",
          "timeout": 10,
          "statusMessage": "hardcoded-strings-guard: verifico stringhe i18n..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/p04-method-guard.sh",
          "timeout": 10,
          "statusMessage": "p04-method-guard: verifico esistenza metodi/service (P0-4)..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/organ-index-guard.sh",
          "timeout": 15,
          "statusMessage": "organ-index-guard: verifico duplicati cross-organo (P0-13)..."
        }
      ]
    },
    {
      "matcher": "Agent",
      "hooks": [
        {
          "type": "command",
          "command": "HOOKS_DIR/os3-mission-reinject.sh",
          "timeout": 5,
          "statusMessage": "OS3: reiniezione header..."
        }
      ]
    }
  ],
  "PostToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "HOOKS_DIR/deploy-pipeline-guard.sh",
          "timeout": 10,
          "statusMessage": "deploy-pipeline-guard: verifico pipeline post-push..."
        }
      ]
    },
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "HOOKS_DIR/mission-report-guard.sh",
          "timeout": 10,
          "statusMessage": "mission-report-guard: verifico registrazione missione..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/mission-stats-guard.sh",
          "timeout": 10,
          "statusMessage": "mission-stats-guard: verifico stats nelle mission..."
        }
      ]
    },
    {
      "matcher": "Write|Edit",
      "hooks": [
        {
          "type": "command",
          "command": "HOOKS_DIR/os3-audit-static.sh",
          "timeout": 10,
          "statusMessage": "os3-audit: analisi statica OS3 sul file modificato..."
        },
        {
          "type": "command",
          "command": "HOOKS_DIR/ssot-reflex-guard.sh",
          "timeout": 10,
          "statusMessage": "ssot-nerve: verifico se file watchato da doc SSOT..."
        }
      ]
    },
    {
      "matcher": "TodoWrite",
      "hooks": [
        {
          "type": "command",
          "command": "HOOKS_DIR/os3-audit-on-complete.sh",
          "timeout": 10,
          "statusMessage": "os3-audit: report findings per task completato..."
        }
      ]
    }
  ]
}
HOOKSJSON
)

  # Sostituisce HOOKS_DIR con il path reale
  hooks_json="${hooks_json//HOOKS_DIR/$HOOKS_DIR}"

  if $DRY_RUN; then
    echo -e "${YELLOW}  [DRY-RUN]${RESET} merge hooks in $SETTINGS_FILE"
    return
  fi

  mkdir -p "$CLAUDE_DIR"

  if [ ! -f "$SETTINGS_FILE" ]; then
    # Settings non esiste: crea minimo con soli hooks
    echo '{}' > "$SETTINGS_FILE"
    info "settings.json creato da zero"
  fi

  # Merge con python3 (jq non gestisce bene merge deep)
  python3 - "$SETTINGS_FILE" "$HOOKS_DIR" <<PYEOF
import json, sys

settings_path = sys.argv[1]
hooks_dir = sys.argv[2]

with open(settings_path, 'r') as f:
    settings = json.load(f)

hooks_config = ${hooks_json}

settings['hooks'] = hooks_config
with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2, ensure_ascii=False)
    f.write('\n')

print(f"  settings.json aggiornato: {settings_path}")
PYEOF

  ok "settings.json aggiornato con hooks LSO"
}

create_workspace() {
  hdr "Workspace multi-root → $BASE_DIR/florenceegi.code-workspace"

  # Genera folders list per tutti i repo presenti
  local folders=""
  local sep=""
  for repo_spec in "${REPOS[@]}"; do
    local name
    name="$(cut -d'|' -f1 <<< "$repo_spec")"
    local dir="$BASE_DIR/$name"
    # Includi sempre (anche se non ancora clonato — sarà clonato dopo)
    folders+="${sep}    { \"path\": \"$dir\" }"
    sep=$',\n'
  done

  local workspace_content
  workspace_content=$(cat <<WORKSPACE
{
  "folders": [
$folders
  ],
  "settings": {
    "editor.tabSize": 2,
    "editor.formatOnSave": true,
    "typescript.tsdk": "node_modules/typescript/lib",
    "files.exclude": {
      "**/node_modules": true,
      "**/.git": false,
      "**/vendor": true
    },
    "search.exclude": {
      "**/node_modules": true,
      "**/vendor": true,
      "**/storage": true
    }
  },
  "extensions": {
    "recommendations": [
      "bmewburn.vscode-intelephense-client",
      "onecentlin.laravel-blade",
      "onecentlin.laravel5-snippets",
      "esbenp.prettier-vscode",
      "dbaeumer.vscode-eslint",
      "mikestead.dotenv",
      "eamodio.gitlens",
      "ms-python.python",
      "bradlc.vscode-tailwindcss"
    ]
  }
}
WORKSPACE
)

  if $DRY_RUN; then
    echo -e "${YELLOW}  [DRY-RUN]${RESET} crea $BASE_DIR/florenceegi.code-workspace"
    return
  fi

  echo "$workspace_content" > "$BASE_DIR/florenceegi.code-workspace"
  ok "florenceegi.code-workspace creato"
  info "Apri con: code $BASE_DIR/florenceegi.code-workspace"
}

print_summary() {
  hdr "Riepilogo"
  echo ""
  echo -e "  ${BOLD}Base directory:${RESET}  $BASE_DIR"
  echo -e "  ${BOLD}Claude dir:${RESET}      $CLAUDE_DIR"
  echo -e "  ${BOLD}Hooks:${RESET}           $HOOKS_DIR"
  echo -e "  ${BOLD}Agents:${RESET}          $AGENTS_DIR"
  echo -e "  ${BOLD}Workspace:${RESET}       $BASE_DIR/florenceegi.code-workspace"
  echo ""
  echo -e "  ${BOLD}Repo mappati:${RESET}    ${#REPOS[@]}"
  echo ""
  echo -e "  ${GREEN}${BOLD}Bootstrap completato.${RESET}"
  echo ""
  echo -e "  ${CYAN}Prossimi passi:${RESET}"
  echo -e "  1. code $BASE_DIR/florenceegi.code-workspace"
  echo -e "  2. Verifica hook attivi: ls $HOOKS_DIR"
  echo -e "  3. Rigenera organ index:"
  echo -e "     cd $BASE_DIR/oracode/bin && python3 -m organ_index"
  echo ""
}

# ── Main ─────────────────────────────────────────────────────────────────────
main() {
  echo ""
  echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${BLUE}║   FlorenceEGI — LSO Bootstrap v1.0.0                        ║${RESET}"
  echo -e "${BOLD}${BLUE}║   Oracode OS3 — Living Software Organism                     ║${RESET}"
  echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"
  echo ""

  if $DRY_RUN; then
    echo -e "  ${YELLOW}${BOLD}MODALITÀ DRY-RUN — nessuna modifica effettiva${RESET}"
  fi

  info "Base directory: $BASE_DIR"
  info "Claude dir:     $CLAUDE_DIR"
  info "Oracode:        $SCRIPT_DIR"

  check_prereqs

  # 1. Clone / pull repo
  hdr "Repository (${#REPOS[@]} organi)"
  mkdir -p "$BASE_DIR"
  for repo_spec in "${REPOS[@]}"; do
    IFS='|' read -r name remote branch <<< "$repo_spec"
    clone_or_pull "$name" "$remote" "$branch"
  done

  # 2. Hook (dopo aver clonato oracode, HOOKS_TEMPLATES è aggiornato)
  install_hooks

  # 3. Agenti
  install_agents

  # 4. settings.json
  install_settings_hooks

  # 5. Workspace
  create_workspace

  print_summary
}

main "$@"
