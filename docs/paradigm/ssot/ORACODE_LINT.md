# oracode-lint — Linter semantico artefatti Oracode

```
@package  oracode/paradigm/ssot
@author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
@version  1.0.0
@date     2026-06-01
@purpose  SSOT del linter Oracode: codifica in enforcement automatico il drift-detection
          che prima era manuale (audit). Layer 3 LSO — sistema auto-correttivo.
@status   PRODUCTION (MVP static + wiring event-driven) — istituito da M-OS3-037/038.
```

> Licenza: MIT. Parte del paradigma Oracode pubblico. Implementazione: `os3-matrix/bin/oracode-lint`.

---

## 1. Cosa è e perché

`oracode-lint` analizza gli artefatti Oracode (agent definitions, skill, hook) e rileva
**drift** in modo **deterministico e gratuito** (static). È la **codifica in regole** della
classe di difetti che prima si trovava solo a mano negli audit (es. P0 driftati, path
organismo baked, divergenza source↔deploy). Posizionamento: **Layer 3 LSO** (sistema
autonomo auto-correttivo). Origine: Q-001.

Principio: lo **static gratis** sta nei trigger event-driven (gira spesso); il **semantico
costoso** (Claude API) andrà nel cron (raro). Lo static non sostituisce il giudizio LLM —
lo **complementa** front-line sul drift meccanico/strutturale.

## 2. Le 4 regole (MVP)

| Regola | Rileva | Severità |
|--------|--------|----------|
| **R1** broken-ref | riferimento a file (.md/.json/.sh/.py) inesistente su disco | warn |
| **R2** organism-coupling | path organismo / var doc-root baked (`${ORACODE_DOC_ROOT}`, `@@..@@`, `/home/fabio/EGI-DOC/`, `NATAN_LOC/`) invece che runtime `{{}}` | error |
| **R3** source-deploy-drift | `os3-matrix/{agents,hooks}` ≠ `~/.claude/{agents,hooks}` (deploy non in parità) | error |
| **R4** doctrine-drift | P0 enumerati negli artefatti ≠ CORE (nome sbagliato, P0 inventato, range errato) | error |

Tarature anti-rumore: R4 solo claim `P0-N (nome-corto)` (non checklist `**P0-N** —`), **skip
delle skill** (proiezione verbatim del CORE, verificate altrove). CORE non caricato → R4
**disattivata** + warning (no inversione semantica). Gate-semantics: solo `[ERROR]` → exit 1.

## 3. Innesto event-driven (wiring)

`oracode-lint` non è "a mano se mi ricordo" (sarebbe il drift che combatte). Si innesta come
gli altri guard, stratificato per costo:

| Livello | Trigger | Hook/meccanismo | Blocca? |
|---------|---------|-----------------|---------|
| guard | PostToolUse Write\|Edit su artefatto | `hooks/oracode-lint-guard.sh` | no (segnala subito) |
| gate | PreToolUse Bash `git push` | `hooks/oracode-lint-gate.sh` | sì su `ERROR` (exit 2) |
| (futuro) cron | settimanale | sweep olistico + Claude API | — |

Risoluzione runtime: guard/gate trovano `oracode-lint` via engine anchor (`projects.json`),
graceful se assente. Dipendenza runtime: `python3` + `jq`. Dettaglio deploy/risoluzione-root
degli hook: `AGENT_DEPLOY_RUNTIME_MODEL.md` §2c.

## 4. Follow-up (iterazioni)
- **R3 cross-organo**: contraddizioni tra CLAUDE.md di organi diversi (serve organ index).
- **Claude-API (cron)**: detection semantica (ambiguità, contraddizioni di significato).
- **Auto-lint**: le regole vanno tenute allineate al paradigma (il linter può driftare).
  Nota: se l'auto-lint estendesse il target ai doc SSOT, serve **allow-list per i blocchi
  esempio** (skip dentro fence ```` ``` ````) — un SSOT che *cita* i pattern R2 come esempi
  (es. questo file) altrimenti si auto-trippa. Oggi non raggiungibile (guard/gate non
  scansionano `docs/**/ssot/`).

## 5. Storia
| Mission | Cosa |
|---------|------|
| M-OS3-037 | MVP static `bin/oracode-lint` (R1-R4) + report md/json + exit code |
| M-OS3-038 | wiring event-driven: guard PostToolUse + gate pre-push |

---

*Oracode System — SSOT paradigma. Istituito da M-OS3-037/038. Licenza MIT.*
