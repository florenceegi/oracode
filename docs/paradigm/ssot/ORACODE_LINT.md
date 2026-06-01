---
visibility: public
rag: public
---

# oracode-lint — Linter semantico artefatti Oracode

```
@package  oracode/paradigm/ssot
@author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
@version  1.2.0
@date     2026-06-01
@purpose  SSOT del linter Oracode: codifica in enforcement automatico il drift-detection
          che prima era manuale (audit). Layer 3 LSO — sistema auto-correttivo.
@status   PRODUCTION (static R1-R5 + wiring event-driven + R6 semantico LLM + cron) — M-OS3-037/038/043/044.
```

> Licenza: MIT. Parte del paradigma Oracode pubblico. Questo SSOT è il **contratto del linter** (regole R1-R6, severità, innesto). L'implementazione concreta (codice, invocazione esatta) vive nell'enforcement OS3 Matrix (repo privato).

---

## 1. Cosa è e perché

`oracode-lint` analizza gli artefatti Oracode (agent definitions, skill, hook) e rileva
**drift** in modo **deterministico e gratuito** (static). È la **codifica in regole** della
classe di difetti che prima si trovava solo a mano negli audit (es. P0 driftati, path
organismo baked, divergenza source↔deploy). Posizionamento: **Layer 3 LSO** (sistema
autonomo auto-correttivo). Origine: Q-001.

Principio: lo **static gratis** sta nei trigger event-driven (gira spesso); il **semantico
costoso** (R6, Claude API) sta nel cron (raro) — realizzato in M-OS3-044. Lo static non
sostituisce il giudizio LLM — lo **complementa** front-line sul drift meccanico/strutturale.

## 2. Le regole

| Regola | Rileva | Severità |
|--------|--------|----------|
| **R1** broken-ref | riferimento a file (.md/.json/.sh/.py) inesistente su disco | warn |
| **R2** organism-coupling | path organismo / var doc-root baked (`${ORACODE_DOC_ROOT}`, `@@..@@`, `/home/fabio/EGI-DOC/`, `NATAN_LOC/`) invece che runtime `{{}}` | error |
| **R3** source-deploy-drift | sorgente enforcement `{agents,hooks}` ≠ `~/.claude/{agents,hooks}` (deploy non in parità) | error |
| **R4** doctrine-drift | P0 enumerati negli artefatti ≠ CORE (nome sbagliato, P0 inventato, range errato) | error |
| **R5** cross-organ | costanti condivise (`shared-constants.json`) con valore divergente tra organi (`projects.json`) — attivata da `--cross-organ` | error |
| **R6** semantic | contraddizioni/ambiguità di **significato** tra `CLAUDE.md` degli organi (drift in prosa che lo static R1-R5 non vede) — attivata da `--semantic`, via Claude API | warn |

R6 è opt-in (`--semantic`) ed è la prima regola **non deterministica**: raccoglie i `CLAUDE.md`
degli organi (`projects.json`) e invoca un LLM per rilevare contraddizioni di *significato* (ciò
che R1-R5 non vedono perché non meccaniche). Chiamata LLM **overridabile** (`ORACODE_LINT_LLM_CMD`
per test/CI; default Anthropic API via `ANTHROPIC_API_KEY`+`urllib`, no SDK), con timeout
parametrico (`ORACODE_LINT_LLM_TIMEOUT`, default 120s). **Graceful** senza key/cmd → R6 skip +
warning (no falso clean). `--json` espone `r6_skipped` per disambiguare "LLM non configurato" da
"nessuna contraddizione". Costosa → vive nel cron, non event-driven (vedi §3). Istituita da M-OS3-044.

R5 è opt-in (`--cross-organ`): confronta i valori delle costanti condivise dichiarate in
`shared-constants.json` (+ `.example`, default vuoto = generico) tra i `CLAUDE.md` degli organi
in `projects.json`, flaggando le divergenze (es. scala/`tokens_per_egili` incoerenti). Regex con
1 gruppo = valore. Override `--organs`/`--shared-constants` per test. Senza config attiva →
warning su stderr (no falsa sicurezza, simmetria col warning R4). Config live
(`etc/shared-constants.json`) è gitignored: versionato solo il `.example`. Istituita da M-OS3-043.

Tarature anti-rumore: R4 solo claim `P0-N (nome-corto)` (non checklist `**P0-N** —`), **skip
delle skill** (proiezione verbatim del CORE, verificate altrove). CORE non caricato → R4
**disattivata** + warning (no inversione semantica). Gate-semantics: solo `[ERROR]` → exit 1.

## 3. Innesto event-driven (wiring)

`oracode-lint` non è "a mano se mi ricordo" (sarebbe il drift che combatte). Si innesta come
gli altri guard, stratificato per costo:

| Livello | Trigger | Hook/meccanismo | Blocca? |
|---------|---------|-----------------|---------|
| guard | PostToolUse Write\|Edit su artefatto | hook PostToolUse (privato) | no (segnala subito) |
| gate | PreToolUse Bash `git push` | hook gate pre-push (privato) | sì su `ERROR` (exit 2) |
| cron | settimanale | wrapper cron (privato) — sweep R5 (cross-organo) + R6 (semantico, Claude API) | no (rete di sicurezza: logga l'esito) |

Risoluzione runtime: guard/gate trovano `oracode-lint` via engine anchor (`projects.json`),
graceful se assente. Dipendenza runtime: `python3` + `jq`. Dettaglio deploy/risoluzione-root
degli hook: `AGENT_DEPLOY_RUNTIME_MODEL.md` §2c.

Il livello **cron** (M-OS3-044) è `bin/oracode-lint-cron`: wrapper schedulabile (settimanale —
es. crontab `0 3 * * 0` o routine `/schedule`) che esegue lo sweep costoso R5+R6 e ne logga
l'esito (`LINT_CRON_LOG`, default `~/oracode-engine/lint-cron.log`). È una **rete di sicurezza**:
non blocca nulla, segnala il drift periodico. R6 senza key configurata → skip graceful.

## 4. Follow-up (iterazioni)
- **Cross-organo — slice deterministico REALIZZATO (M-OS3-043 → R5)**: divergenza di valore
  su costanti condivise tra CLAUDE.md di organi diversi (via `projects.json` +
  `shared-constants.json`). Residuo: detection *semantica* delle contraddizioni in prosa
  (significato, non solo valore) → **REALIZZATO (M-OS3-044 → R6)**.
- **Claude-API (cron) — REALIZZATO (M-OS3-044 → R6 + `bin/oracode-lint-cron`)**: detection
  semantica (ambiguità, contraddizioni di significato) via LLM, schedulata nel cron settimanale.
  Completa Q-001 (lo static gratis event-driven + il semantico costoso periodico).
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
| M-OS3-043 | R5 cross-organo (`--cross-organ`) — costanti condivise divergenti tra organi |
| M-OS3-044 | R6 semantico (`--semantic`, Claude API, graceful skip) + `bin/oracode-lint-cron` (sweep R5+R6 schedulabile). Completa Q-001 |

---

*Oracode System — SSOT paradigma. Istituito da M-OS3-037/038, esteso da M-OS3-043/044. Licenza MIT.*
