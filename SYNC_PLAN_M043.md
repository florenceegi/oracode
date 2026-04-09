# SYNC PLAN — Allineamento Oracode repo a produzione FlorenceEGI

**Data**: 2026-04-09
**Trigger**: M-043 ha rivelato che oracode ha solo 9/19 hook e 2/8 agenti
**Obiettivo**: Un nuovo progetto che installa oracode deve avere TUTTO il sistema LSO operativo

---

## 1. HOOK MANCANTI (11 file)

Copiare da `/home/fabio/.claude/hooks/` a `oracode/hooks/templates/`:

```bash
# Da eseguire nella directory del repo oracode
cp /home/fabio/.claude/hooks/cross-project-guard.sh    hooks/templates/
cp /home/fabio/.claude/hooks/deploy-pipeline-guard.sh  hooks/templates/
cp /home/fabio/.claude/hooks/git-main-guard.sh         hooks/templates/
cp /home/fabio/.claude/hooks/hardcoded-strings-guard.sh hooks/templates/
cp /home/fabio/.claude/hooks/mica-guard.sh             hooks/templates/
cp /home/fabio/.claude/hooks/mission-report-guard.sh   hooks/templates/
cp /home/fabio/.claude/hooks/os3-audit-on-complete.sh  hooks/templates/
cp /home/fabio/.claude/hooks/os3-deep-audit.sh         hooks/templates/
cp /home/fabio/.claude/hooks/os3-mission-reinject.sh   hooks/templates/
cp /home/fabio/.claude/hooks/rm-guard.sh               hooks/templates/
cp /home/fabio/.claude/hooks/ssot-living-check.sh      hooks/templates/
chmod +x hooks/templates/*.sh
```

**NOTA**: Alcuni hook contengono path hardcoded (`/home/fabio/EGI-DOC/...`).
Devono essere parametrizzati con variabili d'ambiente o con il config di oracode.
Verificare ogni file e sostituire path assoluti con `$ORACODE_DOC_ROOT` o simile.

Hook da parametrizzare:
- `os3-audit-static.sh` → contiene `/home/fabio/EGI-DOC/audit/`
- `os3-deep-audit.sh` → contiene path multipli EGI-DOC
- `ssot-living-check.sh` → contiene `/home/fabio/EGI-DOC/`
- `ssot-reflex-guard.sh` → contiene `/home/fabio/EGI-DOC/`
- `deploy-pipeline-guard.sh` → contiene instance ID EC2 (specifico FlorenceEGI)
- `mission-report-guard.sh` → contiene `/home/fabio/EGI-DOC/`
- `mission-stats-guard.sh` → contiene `/home/fabio/EGI-DOC/`

Hook universali (nessun path da cambiare):
- `cross-project-guard.sh`
- `git-main-guard.sh`
- `hardcoded-strings-guard.sh`
- `mica-guard.sh`
- `os3-audit-on-complete.sh`
- `os3-mission-reinject.sh`
- `rm-guard.sh`
- `p04-method-guard.sh`
- `os3-preflight-guard.sh`
- `env-guard.sh`
- `immutable-values-guard.sh`
- `legacy-guard.sh`

---

## 2. AGENTI MANCANTI (6 file)

Copiare da `/home/fabio/.claude/agents/` a `oracode/agents/templates/`:

```bash
cp /home/fabio/.claude/agents/corporate-finance-specialist.md  agents/templates/
cp /home/fabio/.claude/agents/node-ts-specialist.md            agents/templates/
cp /home/fabio/.claude/agents/oracode-alignment-interpreter.md agents/templates/
cp /home/fabio/.claude/agents/oracode-specialist.md            agents/templates/
cp /home/fabio/.claude/agents/organ-gap-scout.md               agents/templates/
cp /home/fabio/.claude/agents/ssot-living-agent.md             agents/templates/
```

**NOTA**: Anche gli agenti contengono path hardcoded.
- `corporate-finance-specialist.md` → `/home/fabio/EGI-DOC/tmp/ssot-export/`
- `ssot-living-agent.md` → `/home/fabio/EGI-DOC/docs/lso/SSOT_REGISTRY.json`
- `oracode-specialist.md` → verificare path

Questi dovrebbero usare path relativi o variabili configurabili.

**NOTA 2**: Rinominare i template gia presenti per coerenza:
- `audit-specialist.md` → `os3-audit-specialist.md`
- `gate.md` → `os3-gate.md`

---

## 3. SETTINGS.JSON TEMPLATE

Creare un template completo di settings.json con tutti gli hook configurati:

```bash
# Creare: oracode/templates/settings.json
```

Deve contenere:
- PreToolUse Bash: rm-guard, git-main-guard, env-guard
- PreToolUse Write|Edit: mica-guard, immutable-values-guard, legacy-guard,
  cross-project-guard, os3-preflight-guard, hardcoded-strings-guard, p04-method-guard
- PreToolUse Agent: os3-mission-reinject
- PostToolUse Bash: deploy-pipeline-guard, mission-report-guard, mission-stats-guard
- PostToolUse Write|Edit: os3-audit-static, ssot-reflex-guard
- PostToolUse TodoWrite: os3-audit-on-complete

I path nel template devono usare `~/.claude/hooks/` (non `/home/fabio/`).

---

## 4. CLI INSTALLER (bin/cli.js)

Verificare che `oracode init` faccia:
1. Copia tutti i hook da `templates/` a `~/.claude/hooks/`
2. Copia tutti gli agenti da `templates/` a `~/.claude/agents/`
3. Genera `settings.json` con tutti gli hook registrati
4. Crea la struttura mission (`MISSION_REGISTRY.json`)
5. Crea la struttura nervous-system (`SSOT_REGISTRY.json`)

Se `oracode init` non fa tutto questo, va aggiornato.

---

## 5. NAMING COERENZA

Il repo oracode usa nomi abbreviati, la produzione usa nomi completi:

| Oracode template | Produzione | Azione |
|-----------------|------------|--------|
| `audit-static.sh` | `os3-audit-static.sh` | Rinominare in oracode |
| `audit-specialist.md` | `os3-audit-specialist.md` | Rinominare in oracode |
| `gate.md` | `os3-gate.md` | Rinominare in oracode |
| `gate.sh` | Non usato come hook (e uno skill /gate) | Chiarire ruolo |

---

## 6. ORDINE DI ESECUZIONE

1. Rinominare file esistenti per coerenza naming
2. Copiare gli 11 hook mancanti
3. Copiare i 6 agenti mancanti
4. Parametrizzare path hardcoded
5. Creare settings.json template
6. Aggiornare `bin/cli.js` per installare tutto
7. Aggiornare README.md con la lista completa
8. Test: `oracode init` su directory vuota, verificare che tutto sia presente
9. Commit e push

---

## INVENTARIO FINALE ATTESO

### Hook (19 totali)
```
PreToolUse Bash:
  rm-guard.sh
  git-main-guard.sh
  env-guard.sh

PreToolUse Write|Edit:
  mica-guard.sh
  immutable-values-guard.sh
  legacy-guard.sh
  cross-project-guard.sh
  os3-preflight-guard.sh (v2.0.0 — enforcement)
  hardcoded-strings-guard.sh
  p04-method-guard.sh

PreToolUse Agent:
  os3-mission-reinject.sh

PostToolUse Bash:
  deploy-pipeline-guard.sh
  mission-report-guard.sh
  mission-stats-guard.sh

PostToolUse Write|Edit:
  os3-audit-static.sh
  ssot-reflex-guard.sh

PostToolUse TodoWrite:
  os3-audit-on-complete.sh

Cron (non hook Claude, script standalone):
  os3-deep-audit.sh
  ssot-living-check.sh
```

### Agenti (8 totali)
```
os3-audit-specialist.md
os3-gate.md
organ-gap-scout.md
oracode-alignment-interpreter.md
oracode-specialist.md
ssot-living-agent.md
node-ts-specialist.md
corporate-finance-specialist.md
```

### Config
```
settings.json (template con tutti gli hook)
```
