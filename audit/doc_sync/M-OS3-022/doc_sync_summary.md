# DOC-SYNC v2 Summary — M-OS3-022

> Paradigm relocation: 39 doc Oracode Nexus → oracode/docs/paradigm/
> Execution mode: **special — paradigm repo bootstrap (no registries yet)**
> Trigger Matrix: Tipo 6 (cross-organism)
> Outcome: **success**

## Contesto

Mission strutturale che sposta 39 documenti del paradigma Oracode dalla loro sede storica mista
(EGI-DOC/docs/oracode/ + oracode/docs/) verso la sede canonica MIT-pura
`oracode/docs/paradigm/{categoria}/`.

Repo `oracode/` non e' istanza LSO classica L3 — e' la **sede SSOT del paradigma stesso**.
Nessun SSOT_REGISTRY ne' MISSION_REGISTRY canonical esistono ancora qui — questa mission ha
appena CREATO il sostrato che li ospitera'.

## Esecuzione 6 step

| Step | Esito | Note |
|------|-------|------|
| 1 — Semantic analysis | done | Nature: structural_relocation. Additive (13 nuove dir + 3 file) + Substitutive (39 doc spostati + 17 file vivi con sed) + 1 fix nominale (oracode-specialist.md) |
| 2 — SSOT impattati diretti | empty | SSOT_REGISTRY assente in oracode/. Lista vuota legittima |
| 3 — Discovery laterale RAG | skipped | Nessuno schema RAG configurato (modalita' LSO ridotto) |
| 4 — Doc-sync actions | empty | Discriminazione paradosso: il paradigma diventa SSOT di se stesso, no patch retroattiva possibile in questa mission |
| 5 — RAG re-indexing | skipped | Coerente con Step 3 skip + Step 4 zero azioni |
| 5b — Metadati SSOT_REGISTRY | skipped | Nessun registry da aggiornare |
| 6 — Audit trail | done | Questo report + 5 JSON intermedi in `audit/doc_sync/M-OS3-022/` |

## Dettagli semantici

**Riposizionamento strutturale (non semantico):**
I 39 doc non cambiano contenuto. Cambia il loro path canonical:
- Prima: misti in EGI-DOC (istanza LSO) e oracode/docs/ (root)
- Ora: organizzati in 14 sottodirectory tematiche sotto `oracode/docs/paradigm/`

**Tassonomia paradigm/ creata:**
```
kernel/       — OSZ (verita' assoluta)
execution/    — OS3 (5 moduli) + OSMx (riservato runtime)
education/    — OS4 foundation
lso/          — Manifesto LSO + Guard Testing Protocol
padmin/       — Identita' Padmin (P1/P2/P3) + onboarding + AI identity
ssot/         — Canonical SSOT system
nomenclature/ — LSO v2 + index + proposals
missions/     — Mission Protocol
standards/    — Web Quality Gate + Legacy Stack + Naming
tech-specs/   — Read Tracking + Retrospective
doc-sync/     — DOC-SYNC v2 (specifica + stato + piano)
roadmap/      — Roadmap Oracode + Paradigm v2 draft
index/        — Oracode-Nexus-index
```

**File vivi aggiornati (17, via sed cross-progetto):**
- 5 hooks globali `.claude/hooks/*` (link paradigma aggiornati)
- 1 tool `os3-matrix/bin/*` (riferimento paradigma per enforcement)
- 1 agent `.claude/agents/oracode-specialist.md` + correzione MANUALE_OPERATIVO_LSO.md → MANIFESTO_LSO.md
- 10 doc paradigma con link interni cross-categoria

**Cross-organism notice (Trigger 6):**
- `EGI-DOC/docs/oracode/MOVED_TO_ORACODE_REPO.md` — forwarding pointer per chi cerca paradigma nel posto vecchio
- EGI-DOC torna istanza LSO pura (no piu' deposito misto)
- `oracode/README.md` — sezione "Paradigm SSOT" aggiunta per discoverability esterna

## Acceptance test

`/home/fabio/oracode/tests/m-os3-022/test_paradigm_relocation.sh` — **PASSED**

## Anti-pattern verificati

| # | Anti-pattern | Verifica |
|---|---|----------|
| 1 | Mai aggiornare solo metadati | OK — niente da aggiornare, nessun finto bump |
| 2 | Mai procedere senza risolvere rifiuti | OK — nessun rifiuto, nessuna azione proposta |
| 3 | RAG sincrono | N/A — RAG skipped |
| 4 | Sanity check bloccante | N/A — RAG skipped |
| 5 | Idempotenza | OK — esecuzione produce stesso outcome se ripetuta |
| 6 | Lavora solo sui file della mission | OK — scope strettamente nei file dichiarati |
| 7 | Diff per ogni modifica | N/A — zero azioni applicate da DOC-SYNC |
| 8 | Coverage check | Informativo — file nuovi creati (39 doc spostati + 13 dir + 3 file aggiuntivi) NON coperti da watch (perche' SSOT_REGISTRY non esiste). Flagged per future mission |
| 9 | Universalita' | OK — eseguito via `instance_root=/home/fabio/oracode` senza path hardcoded |

## Uncovered new files (informativo)

Tutti i 39 doc paradigma + 13 sottodirectory + 3 file aggiuntivi sono attualmente **non coperti**
da nessun watch in SSOT_REGISTRY (perche' SSOT_REGISTRY non esiste in oracode/).

Questo NON e' un errore della mission — e' la condizione attesa per il primo bootstrap.
La copertura sara' istituita dalla mission futura raccomandata sotto.

## Raccomandazioni — Future M-OS3-* mission

### Priorita' P1 — Bootstrap registries canonical paradigma

**M-OS3-023 (proposta): Bootstrap SSOT_REGISTRY canonical in oracode/docs/lso/**

Scope:
- Creare `oracode/docs/lso/SSOT_REGISTRY.json` con schema standard
- Registrare TUTTI i 39 doc paradigma come SSOT con:
  - `watches.paths[]` puntanti ai nuovi path `docs/paradigm/{cat}/`
  - `update_policy` per categoria (kernel = immutable senza approvazione CEO, others = standard)
  - Metadata `verified_in_mission: "M-OS3-022"` (registrazione retroattiva)
  - `last_verified: 2026-05-29`
- Definire `RAG_SCHEMA` per oracode/ in CLAUDE.md (decisione architetturale: vale la pena indicizzare il paradigma stesso?)

**M-OS3-024 (proposta): Bootstrap MISSION_REGISTRY canonical in oracode/docs/paradigm/missions/**

Scope:
- Creare `oracode/docs/paradigm/missions/MISSION_REGISTRY.json`
- Registrare retroattivamente le mission M-OS3-* gia' eseguite sul paradigma (almeno M-OS3-022 come root)
- Decidere relazione vs mission engine HOME (sync? duplica? sostituisce?)
- Vedere memoria CEO: `feedback_mission_engine_dual_tracking.md` — descrittore `.oracode/project.json` come tassello del fix

### Priorita' P2 — Discoverability esterna

- Aggiungere indice in `docs/paradigm/index/Oracode-Nexus-index.md` con TOC completo dei 39 doc
- Verificare anti-degradazione (vedi memoria CEO `feedback_nexus_index_anti_degradazione.md`)

## Esito

**SUCCESS** — mission chiusa, paradigma relocato, audit completo, raccomandazioni successori documentate.

---

@author DOC-SYNC v2.2.0
@mission M-OS3-022
@date 2026-05-29
@purpose Audit trail relocazione paradigma in sede canonica MIT-pura
