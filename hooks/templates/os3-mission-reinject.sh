#!/usr/bin/env bash
# os3-mission-reinject.sh — PreToolUse hook: reiniezione OS3/LSO header all'invocazione agenti
# Trigger: PreToolUse Agent
# Scopo: contrasta il degrado del contesto nelle sessioni lunghe
# v1.0.0 — 2026-04-02

>&2 echo "━━━ OS3/LSO REINIEZIONE HEADER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
>&2 echo "STRUTTURA: SUPERVISOR (tu) → DEV (laravel-specialist) → AUDIT (os3-audit-specialist)"
>&2 echo "CONTESTO OBBLIGATORIO: CLAUDE.md + 00_LSO_LIVING_SOFTWARE_ORGANISM.md + CLAUDE_ECOSYSTEM_CORE.md"
>&2 echo "FLUSSO: 1 file per volta. PASS→avanza / WARN→SUPERVISOR decide / BLOCK→DEV riscrive"
>&2 echo "LEGGI: WARN su MiCA-SAFE/valori immutabili/secrets = BLOCK automatico. Loop max 3 → ESCALATION."
>&2 echo "DIVIETI: no deduzione, no naming inventato, no schema DB dedotto, no fallback creativi."
>&2 echo "/gate pre-push obbligatorio. doc-sync-guardian post-task obbligatorio."
>&2 echo "LEGGE ASSOLUTA: OS3+LSO > TASK. Conflitto → STOP + Fabio informato."
>&2 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

exit 0
