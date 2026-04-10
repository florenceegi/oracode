#!/usr/bin/env bash
# deploy-pipeline-guard.sh — PostToolUse hook: ricorda il deploy SSM dopo git push
# Matcher: Bash
# Pattern coperto: INCIDENT V-02 — pipeline post-commit mai eseguita
# v2.0.0 — 2026-03-30: detection primaria via CWD, aggiunto EGI principale

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Intercetta solo git push
if ! echo "$COMMAND" | grep -q "git push"; then
  exit 0
fi

# Detection primaria: CWD (più affidabile del testo del comando che non contiene il nome progetto)
CWD=$(pwd)
PROJECT=""
DEPLOY_CMD=""

# Estrai il nome reale del path (priorità: match specifico prima del generico)
if echo "$CWD" | grep -q "EGI-Credential\|egi-credential"; then
  PROJECT="EGI-Credential"
  DEPLOY_CMD="SSM EC2 ${ORACODE_EC2_INSTANCE:-}: sudo -u forge bash -c 'cd /home/forge/egi-credential.florenceegi.com && git pull origin main && cd backend && php artisan migrate --force && php artisan config:cache && php artisan view:clear'"
elif echo "$CWD" | grep -q "EGI-DOC\|egi-doc"; then
  PROJECT="EGI-DOC"
  DEPLOY_CMD="Nessun deploy EC2 — solo RAG sync se necessario"
elif echo "$CWD" | grep -q "EGI-HUB-HOME\|egi-hub-home"; then
  PROJECT="EGI-HUB-HOME"
  DEPLOY_CMD="Verifica CLAUDE.md di EGI-HUB-HOME per il comando SSM esatto"
elif echo "$CWD" | grep -q "EGI-HUB\|egi-hub"; then
  PROJECT="EGI-HUB"
  DEPLOY_CMD="SSM EC2 — verifica CLAUDE.md di EGI-HUB per il comando esatto"
elif echo "$CWD" | grep -q "EGI-SIGILLO\|egi-sigillo"; then
  PROJECT="EGI-SIGILLO (egi-sigillo.florenceegi.com)"
  DEPLOY_CMD="SSM EC2 ${ORACODE_EC2_INSTANCE:-}: sudo -u forge bash -c 'cd /home/forge/egi-sigillo.florenceegi.com && git pull origin new_domain && php artisan migrate --force && php artisan config:cache && php artisan view:clear'"
elif echo "$CWD" | grep -q "NATAN_LOC\|natan-loc"; then
  PROJECT="NATAN_LOC"
  DEPLOY_CMD="SSM EC2 ${ORACODE_EC2_INSTANCE:-}: sudo -u forge bash -c 'cd /home/forge/natan-loc.florenceegi.com && git pull && php artisan migrate --force && php artisan config:cache && php artisan view:clear'"
elif echo "$CWD" | grep -qE "^$HOME/EGI$|^${ORACODE_PROJECT_ROOT:-$HOME}/EGI/"; then
  # EGI principale — deve matchare SOLO $HOME/EGI, non EGI-HUB/EGI-Credential ecc.
  PROJECT="EGI (art.florenceegi.com)"
  DEPLOY_CMD="SSM EC2 ${ORACODE_EC2_INSTANCE:-}: sudo -u forge bash -c 'cd /home/forge/art.florenceegi.com && git pull origin develop && php artisan migrate --force && php artisan cache:clear && php artisan config:cache && php artisan view:clear'"
fi

# Fallback: cerca nel testo del comando se CWD non ha matchato
if [ -z "$PROJECT" ]; then
  if echo "$COMMAND" | grep -q "EGI-Credential\|egi-credential"; then
    PROJECT="EGI-Credential"
    DEPLOY_CMD="SSM EC2 ${ORACODE_EC2_INSTANCE:-}: cd /home/forge/egi-credential.florenceegi.com && git pull + artisan"
  elif echo "$COMMAND" | grep -q "NATAN_LOC\|natan-loc"; then
    PROJECT="NATAN_LOC"
    DEPLOY_CMD="SSM EC2 ${ORACODE_EC2_INSTANCE:-}: cd /home/forge/natan-loc.florenceegi.com && git pull + artisan"
  fi
fi

if [ -n "$PROJECT" ]; then
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🚀 DEPLOY PIPELINE — $PROJECT"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Push completato. Prossimo step OBBLIGATORIO:"
  echo ""
  echo "  $DEPLOY_CMD"
  echo ""
  echo "OS3 P0 — il deploy è parte atomica del commit. Non è opzionale."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

exit 0
