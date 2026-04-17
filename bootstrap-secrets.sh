#!/usr/bin/env bash
# =============================================================================
# bootstrap-secrets.sh — Trasferimento sicuro secret LSO tra macchine
# =============================================================================
# @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
# @version 1.0.0 (FlorenceEGI — oracode)
# @date 2026-04-17
# @purpose Esporta/importa secret (AWS, SSH, .env, Claude memory) tra
#          macchine con cifratura GPG simmetrica. Mai committato.
#
# USAGE:
#   ./bootstrap-secrets.sh export [output.tgz.gpg]
#   ./bootstrap-secrets.sh import <file.tgz.gpg>
#   ./bootstrap-secrets.sh list                    # mostra cosa verrebbe esportato
#
# SICUREZZA:
#   - Cifratura AES256 via GPG (symmetric, passphrase)
#   - File temporanei in /tmp → rimossi dopo uso
#   - NULLA viene committato o loggato in chiaro
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

# ── Path da includere ────────────────────────────────────────────────────────
# Formato: path relativo a $HOME (più sicuro per trasferimento cross-machine)
declare -a SECRET_PATHS=(
  ".aws/credentials"
  ".aws/config"
  ".ssh/id_ed25519"
  ".ssh/id_ed25519.pub"
  ".ssh/id_rsa"
  ".ssh/id_rsa.pub"
  ".ssh/config"
  ".ssh/known_hosts"
  ".claude/policy-limits.json"
  ".claude/settings.local.json"
  ".claude/.credentials.json"
)

# Directory da includere ricorsivamente
declare -a SECRET_DIRS=(
  ".claude/projects"
)

# Organi con .env da esportare
declare -a ORGANS=(
  "EGI"
  "EGI-HUB"
  "EGI-HUB-HOME-REACT"
  "EGI-INFO"
  "EGI-Credential"
  "NATAN_LOC"
  "NATAN_LOC/laravel_backend"
  "NATAN_LOC/python_ai_service"
  "LA-BOTTEGA"
  "EGI-SIGILLO"
  "EGI-STAT"
  "CREATOR-STAGING"
  "FABIO-CHERICI-SITE"
)

TMP_DIR=""
cleanup() {
  if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
  fi
}
trap cleanup EXIT INT TERM

# ── Funzioni ─────────────────────────────────────────────────────────────────
check_gpg() {
  if ! command -v gpg &>/dev/null; then
    err "gpg non trovato. Installa: sudo apt install gnupg"
    exit 1
  fi
  ok "gpg trovato"
}

list_secrets() {
  hdr "Secret individuati sulla macchina"
  local found=0 missing=0

  echo ""
  echo -e "${BOLD}File singoli:${RESET}"
  for rel in "${SECRET_PATHS[@]}"; do
    local abs="$HOME/$rel"
    if [ -f "$abs" ]; then
      ok "$rel ($(stat -c%s "$abs") bytes)"
      found=$((found + 1))
    else
      warn "$rel (non trovato — skip)"
      missing=$((missing + 1))
    fi
  done

  echo ""
  echo -e "${BOLD}Directory:${RESET}"
  for rel in "${SECRET_DIRS[@]}"; do
    local abs="$HOME/$rel"
    if [ -d "$abs" ]; then
      local count
      count=$(find "$abs" -type f 2>/dev/null | wc -l)
      ok "$rel ($count file)"
      found=$((found + 1))
    else
      warn "$rel (non trovato — skip)"
      missing=$((missing + 1))
    fi
  done

  echo ""
  echo -e "${BOLD}File .env per organo:${RESET}"
  for organ in "${ORGANS[@]}"; do
    local env_file="$HOME/$organ/.env"
    if [ -f "$env_file" ]; then
      ok "$organ/.env"
      found=$((found + 1))
    else
      warn "$organ/.env (non trovato — skip)"
      missing=$((missing + 1))
    fi
  done

  echo ""
  info "Totale: $found presenti, $missing mancanti"
}

do_export() {
  local output="${1:-$HOME/lso-secrets-$(date +%Y%m%d-%H%M%S).tgz.gpg}"

  hdr "EXPORT secret → $output"

  check_gpg

  TMP_DIR=$(mktemp -d /tmp/lso-secrets.XXXXXX)
  chmod 700 "$TMP_DIR"
  local bundle_dir="$TMP_DIR/bundle"
  mkdir -p "$bundle_dir"

  local count=0

  # File singoli
  for rel in "${SECRET_PATHS[@]}"; do
    local abs="$HOME/$rel"
    if [ -f "$abs" ]; then
      local dest_dir="$bundle_dir/$(dirname "$rel")"
      mkdir -p "$dest_dir"
      cp -a "$abs" "$bundle_dir/$rel"
      count=$((count + 1))
    fi
  done
  ok "File singoli: $count"

  # Directory
  local dir_count=0
  for rel in "${SECRET_DIRS[@]}"; do
    local abs="$HOME/$rel"
    if [ -d "$abs" ]; then
      local dest="$bundle_dir/$rel"
      mkdir -p "$(dirname "$dest")"
      cp -a "$abs" "$dest"
      dir_count=$((dir_count + 1))
    fi
  done
  ok "Directory: $dir_count"

  # .env per organo
  local env_count=0
  for organ in "${ORGANS[@]}"; do
    local env_file="$HOME/$organ/.env"
    if [ -f "$env_file" ]; then
      local dest="$bundle_dir/$organ/.env"
      mkdir -p "$(dirname "$dest")"
      cp -a "$env_file" "$dest"
      env_count=$((env_count + 1))
    fi
  done
  ok ".env organi: $env_count"

  # Manifest
  cat > "$bundle_dir/MANIFEST.txt" <<MANIFEST
LSO Secrets Bundle
Hostname:  $(hostname)
User:      $USER
Exported:  $(date -Iseconds)
Script:    bootstrap-secrets.sh v1.0.0
Files:     $count single + $dir_count dirs + $env_count env
MANIFEST

  # Tarball
  local tar_tmp="$TMP_DIR/bundle.tgz"
  tar -czf "$tar_tmp" -C "$TMP_DIR" bundle 2>/dev/null
  local size
  size=$(du -h "$tar_tmp" | cut -f1)
  info "Tarball: $size"

  # Cifratura GPG symmetric
  echo ""
  warn "INSERISCI UNA PASSPHRASE FORTE (verrà richiesta due volte)"
  warn "Salvala in password manager — senza, il bundle è illeggibile"
  echo ""

  if gpg --symmetric --cipher-algo AES256 --output "$output" "$tar_tmp" 2>&1; then
    chmod 600 "$output"
    ok "Bundle cifrato creato: $output"
    echo ""
    echo -e "${BOLD}${GREEN}Trasferisci il file in modo sicuro:${RESET}"
    echo -e "  ${CYAN}scp${RESET}    $output new-host:~/"
    echo -e "  ${CYAN}USB${RESET}    cp $output /media/usb/"
    echo -e "  ${CYAN}NON${RESET}    cloud pubblico (Drive/Dropbox) senza ulteriore cifratura"
    echo ""
    echo -e "Sulla nuova macchina:"
    echo -e "  ${CYAN}./bootstrap-secrets.sh import$(dirname "$output" | sed "s|$HOME|~|")/$(basename "$output")${RESET}"
    echo ""
  else
    err "Cifratura GPG fallita"
    exit 1
  fi
}

do_import() {
  local input="${1:-}"

  if [ -z "$input" ]; then
    err "Specifica il file da importare"
    echo "  Usage: $0 import <file.tgz.gpg>"
    exit 1
  fi

  if [ ! -f "$input" ]; then
    err "File non trovato: $input"
    exit 1
  fi

  hdr "IMPORT secret da $input"

  check_gpg

  TMP_DIR=$(mktemp -d /tmp/lso-secrets.XXXXXX)
  chmod 700 "$TMP_DIR"

  # Decifratura
  echo ""
  warn "INSERISCI LA PASSPHRASE DEL BUNDLE"
  echo ""

  local tar_tmp="$TMP_DIR/bundle.tgz"
  if ! gpg --decrypt --output "$tar_tmp" "$input" 2>&1; then
    err "Decifratura fallita — passphrase errata?"
    exit 1
  fi

  ok "Decifratura OK"

  # Estrai
  tar -xzf "$tar_tmp" -C "$TMP_DIR" 2>/dev/null
  local bundle_dir="$TMP_DIR/bundle"

  if [ ! -d "$bundle_dir" ]; then
    err "Struttura bundle non valida"
    exit 1
  fi

  # Mostra manifest
  if [ -f "$bundle_dir/MANIFEST.txt" ]; then
    echo ""
    cat "$bundle_dir/MANIFEST.txt"
    echo ""
  fi

  # Conferma sovrascrittura
  warn "Questa operazione sovrascrive file esistenti su $HOME"
  echo -n "  Continuare? [y/N] "
  read -r reply
  if [ "$reply" != "y" ] && [ "$reply" != "Y" ]; then
    info "Annullato"
    exit 0
  fi

  # Copia preservando permessi, NO MANIFEST
  rm -f "$bundle_dir/MANIFEST.txt"

  # Usa cp con preservazione attributi
  local count=0
  while IFS= read -r -d '' src; do
    local rel="${src#$bundle_dir/}"
    local dest="$HOME/$rel"
    mkdir -p "$(dirname "$dest")"
    cp -a "$src" "$dest"
    count=$((count + 1))
  done < <(find "$bundle_dir" -type f -print0)

  ok "File ripristinati: $count"

  # Fix permessi critici
  [ -f "$HOME/.ssh/id_ed25519" ] && chmod 600 "$HOME/.ssh/id_ed25519"
  [ -f "$HOME/.ssh/id_rsa" ]     && chmod 600 "$HOME/.ssh/id_rsa"
  [ -f "$HOME/.aws/credentials" ] && chmod 600 "$HOME/.aws/credentials"
  [ -d "$HOME/.ssh" ]            && chmod 700 "$HOME/.ssh"
  ok "Permessi SSH/AWS normalizzati"

  echo ""
  echo -e "${BOLD}${GREEN}Import completato.${RESET}"
  echo ""
  echo -e "Verifica:"
  echo -e "  ${CYAN}ssh -T git@github.com${RESET}"
  echo -e "  ${CYAN}aws sts get-caller-identity${RESET}"
  echo ""
}

usage() {
  cat <<USAGE
${BOLD}bootstrap-secrets.sh — Trasferimento secret LSO tra macchine${RESET}

Usage:
  $0 list                          # Mostra secret sulla macchina corrente
  $0 export [output.tgz.gpg]       # Crea bundle cifrato (passphrase prompt)
  $0 import <file.tgz.gpg>         # Ripristina bundle su nuova macchina

Cifratura: GPG symmetric AES256 + passphrase
Default output: \$HOME/lso-secrets-YYYYMMDD-HHMMSS.tgz.gpg
USAGE
}

# ── Main ─────────────────────────────────────────────────────────────────────
case "${1:-}" in
  list)    list_secrets ;;
  export)  do_export "${2:-}" ;;
  import)  do_import "${2:-}" ;;
  -h|--help|help|"") usage ;;
  *)       err "Comando sconosciuto: $1"; usage; exit 1 ;;
esac
