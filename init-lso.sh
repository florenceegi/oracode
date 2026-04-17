#!/usr/bin/env bash
# =============================================================================
# init-lso.sh — Bootstrap zero-to-hero su macchina fresca
# =============================================================================
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0 (FlorenceEGI — oracode)
# @date 2026-04-17
# @purpose Setup completo su macchina nuova da zero assoluto.
#          Risolve uovo-gallina: no SSH key → no clone privato.
#
# USAGE (sulla nuova macchina, dopo aver ricevuto file via scp/USB):
#   ./init-lso.sh <path/bundle.tgz.gpg>
#
# PREREQUISITI (da trasferire insieme al bundle):
#   - init-lso.sh              (questo file)
#   - bootstrap-secrets.sh     (da oracode)
#   - lso-secrets-*.tgz.gpg    (bundle cifrato)
#
# FLOW:
#   1. Installa prereq (apt)
#   2. Importa secret (include SSH key)
#   3. Clona oracode via SSH
#   4. Esegue bootstrap-lso.sh (clone tutti repo + hook + agent + workspace)
# =============================================================================

set -euo pipefail

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

BUNDLE="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOTSTRAP_SECRETS="$SCRIPT_DIR/bootstrap-secrets.sh"

# ── Validazione ──────────────────────────────────────────────────────────────
banner() {
  echo ""
  echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${BLUE}║   FlorenceEGI — LSO Zero-Init v1.0.0                        ║${RESET}"
  echo -e "${BOLD}${BLUE}║   Da macchina vuota ad ambiente completo                     ║${RESET}"
  echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"
  echo ""
}

validate() {
  if [ -z "$BUNDLE" ]; then
    err "Usage: $0 <path/bundle.tgz.gpg>"
    exit 1
  fi

  if [ ! -f "$BUNDLE" ]; then
    err "Bundle non trovato: $BUNDLE"
    exit 1
  fi

  if [ ! -f "$BOOTSTRAP_SECRETS" ]; then
    err "bootstrap-secrets.sh non trovato in $SCRIPT_DIR"
    echo ""
    echo "  Trasferisci insieme al bundle. Dalla vecchia macchina:"
    echo "    scp ~/oracode/init-lso.sh ~/oracode/bootstrap-secrets.sh \\"
    echo "        ~/lso-secrets-*.tgz.gpg nuovahost:~/"
    exit 1
  fi

  ok "Bundle: $BUNDLE ($(du -h "$BUNDLE" | cut -f1))"
  ok "bootstrap-secrets.sh presente"
}

install_prereqs() {
  hdr "Step 1/4 — Prerequisiti sistema"

  local need_install=()
  for cmd in git jq gnupg python3 python3-pip curl; do
    local check_cmd="$cmd"
    [ "$cmd" = "gnupg" ] && check_cmd="gpg"
    [ "$cmd" = "python3-pip" ] && check_cmd="pip3"
    if ! command -v "$check_cmd" &>/dev/null; then
      need_install+=("$cmd")
    fi
  done

  if [ ${#need_install[@]} -eq 0 ]; then
    ok "Tutti i prereq già installati"
  else
    info "Installo: ${need_install[*]}"
    if command -v sudo &>/dev/null; then
      sudo apt update -qq
      sudo apt install -y "${need_install[@]}"
    else
      err "sudo non disponibile. Installa manualmente: ${need_install[*]}"
      exit 1
    fi
    ok "Prereq installati"
  fi
}

import_secrets() {
  hdr "Step 2/4 — Import secret (SSH key, AWS, .env)"

  chmod +x "$BOOTSTRAP_SECRETS"

  info "Richiede passphrase bundle"
  if ! "$BOOTSTRAP_SECRETS" import "$BUNDLE"; then
    err "Import fallito"
    exit 1
  fi

  # Verifica SSH funzionante
  info "Test SSH GitHub..."
  if ssh -o StrictHostKeyChecking=accept-new -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    ok "SSH GitHub OK"
  else
    warn "SSH GitHub fallito — verifica manualmente: ssh -T git@github.com"
    warn "Continuo comunque, ma clone oracode potrebbe fallire"
  fi
}

clone_oracode() {
  hdr "Step 3/4 — Clone oracode"

  local oracode_dir="$HOME/oracode"

  if [ -d "$oracode_dir/.git" ]; then
    info "oracode già presente, aggiorno..."
    git -C "$oracode_dir" fetch origin --quiet 2>/dev/null || true
    git -C "$oracode_dir" pull origin main --quiet 2>/dev/null || true
    ok "oracode aggiornato"
  else
    info "Clone git@github.com:florenceegi/oracode.git → $oracode_dir"
    if git clone git@github.com:florenceegi/oracode.git "$oracode_dir" --quiet; then
      ok "oracode clonato"
    else
      err "Clone oracode fallito"
      echo ""
      echo "  Possibili cause:"
      echo "  1. SSH key non installata correttamente (verifica: ls -la ~/.ssh/)"
      echo "  2. Key non registrata su GitHub (test: ssh -T git@github.com)"
      echo "  3. Accesso revocato al repo privato"
      exit 1
    fi
  fi
}

run_bootstrap_lso() {
  hdr "Step 4/4 — Bootstrap LSO (13 repo + hook + agent + workspace)"

  local bootstrap="$HOME/oracode/bootstrap-lso.sh"

  if [ ! -f "$bootstrap" ]; then
    err "bootstrap-lso.sh non trovato in oracode"
    exit 1
  fi

  chmod +x "$bootstrap"

  info "Esecuzione bootstrap-lso.sh (può richiedere qualche minuto)..."
  if "$bootstrap"; then
    ok "Bootstrap LSO completato"
  else
    warn "Bootstrap LSO con warning — verifica output sopra"
  fi
}

final_summary() {
  hdr "Completato"
  echo ""
  echo -e "  ${BOLD}${GREEN}Ambiente LSO pronto su questa macchina.${RESET}"
  echo ""
  echo -e "  ${BOLD}Prossimi passi manuali:${RESET}"
  echo -e "  1. ${CYAN}code ~/florenceegi.code-workspace${RESET}   (apri workspace)"
  echo -e "  2. Installa Claude Code CLI:"
  echo -e "     ${CYAN}curl -fsSL https://claude.ai/install.sh | sh${RESET}"
  echo -e "  3. Installa runtime (se mancano):"
  echo -e "     ${CYAN}nvm${RESET} (Node), ${CYAN}php 8.3${RESET}, ${CYAN}python 3.11+${RESET}"
  echo -e "  4. Per organo: ${CYAN}composer install${RESET} + ${CYAN}npm install${RESET}"
  echo -e "  5. Rigenera organ index:"
  echo -e "     ${CYAN}cd ~/oracode/bin && python3 -m organ_index${RESET}"
  echo ""
  echo -e "  ${YELLOW}SICUREZZA:${RESET} elimina il bundle dopo verifica:"
  echo -e "     ${CYAN}shred -u $BUNDLE${RESET}"
  echo ""
}

# ── Main ─────────────────────────────────────────────────────────────────────
banner
validate
install_prereqs
import_secrets
clone_oracode
run_bootstrap_lso
final_summary
