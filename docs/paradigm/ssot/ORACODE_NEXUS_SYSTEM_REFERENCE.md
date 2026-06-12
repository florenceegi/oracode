---
title: Oracode Nexus — Riferimento di Sistema (SSOT tecnico completo)
slug: oracode-nexus-system-reference
doc_type: architecture
version: 1.5.0
status: current
date: '2026-05-31'
updated_at: '2026-06-12'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- ecosistema
- oracode
- lso
supersedes:
- docs/oracode/index.md
- docs/oracode/ORACODE_SYSTEM_MANIFESTO_IT_v1.0.0.md
superseded_by: null
priority: critical
visibility: public
rag: public
---

# Oracode Nexus — Riferimento di Sistema

> Versione: 1.5.0 | Data: 2026-06-12
> Autore: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
> Documento SSOT consolidato: tutto Oracode/LSO in un unico riferimento autorevole.
>
> **v1.2.0 (M-OS3-018):** allineamento con M-OS3 sessioni 1+2+3 — riferimento esplicito a `bin/mission` CLI, state machine 7 stati, multi-write per `session_id`, hook hardening M-OS3-013. Per il dettaglio operativo del Mission Protocol vedere `MISSION_PROTOCOL.md` v4.0.0.
>
> **v1.5.0 (M-FUC-029):** §14 — indice Nexus dei registry (`ssot-registry-index.json` + check `ssot-index-check`): ogni nuovo `SSOT_REGISTRY.json` nato dal bootstrap (`/oracode-scaffold` step 5b, forzante f.1 ADR M-FUC-029) è censito alla nascita — nessun registry nasce orfano.

---

## 1. Cos'e Oracode Nexus

Oracode Nexus e un **«[CATEGORIA DI PRODOTTO — PLACEHOLDER]»**: un sistema che sta **tra l'AI e il codice e impedisce — mentre l'AI scrive — che entri qualcosa che rompe le regole.** Previene *prima*, non verifica *dopo*. Non e un linter ne una pipeline di review post-scrittura: e **paradigma + motore di enforcement** (regole, hook meccanici, agenti specializzati e audit) che garantisce coerenza, sicurezza e tracciabilita quando l'AI e co-autore del codice.

Per la gerarchia a 3 livelli (motore / HUB / istanza) vedi `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

<!-- INTERNO — NON PUBBLICO: la categoria di prodotto reale (che sostituisce il PLACEHOLDER qui sopra) e l'intero naming stack — brand / categoria / pratica — vivono nel documento privato ~/.florenceegi-private/naming-strategy/NAMING_STACK_SSOT.md (fuori da git). Pubblicabili solo dopo trademark check. Comprensibile solo a noi finche il file resta privato. -->
<!-- NOTA coerenza: questa definizione risolve la contraddizione "metodologia vs framework" (vecchia §1 vs sezione 19) inquadrando Oracode Nexus come paradigma + motore. Allineare le altre occorrenze quando si tocca la sezione 19. -->

**Dati di produzione (caso esemplare: istanza FlorenceEGI, aprile 2026):** 7 organi online, ~500k LOC, 34+ missioni completate, zero regressioni non rilevate.

**Nasce da un'istanza reale (la prima: FlorenceEGI)**, marzo 2026: un ecosistema software trattato come organismo vivente. Ogni regola del sistema nasce da un incidente reale — non da precauzione teorica.

### Architettura a livelli

| Livello | Nome | Funzione |
|---------|------|----------|
| **OSZ** | Kernel | Verita assoluta. I primitivi dell'organismo. Non si modifica. Si obbedisce. |
| **OS3** | Execution | Protocollo operativo attivo: regole P0-P3, hook, enforcement. Si aggiorna per allinearsi a OSZ. |
| **OS4** | Education | Educazione epistemica dell'umano. 4 regole epistemiche (futuro). |

**Regola fondamentale:** OSZ e la verita assoluta. OS3 si aggiorna per allinearsi a OSZ. Mai il contrario.

### Oracode Nexus — gerarchia a 3 livelli

**Oracode Nexus** = il sistema completo: il paradigma (regole, docs, templates) + i 3 livelli architetturali + l'ecosistema HUB/istanze. La gerarchia a 3 livelli è la **LEGGE locked** dell'architettura attuale — SSOT in `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

| Livello | Cos'è | MISSION_REGISTRY | Statistiche / Numerazione |
|---------|-------|------------------|---------------------------|
| **L1 — GLOBALE** | il **motore + paradigma** (`oracode` + `os3-matrix` + cartella globale **VISIBILE** `~/oracode-engine/`). Tiene solo lo **scratch runtime** (focus, lock, stato in volo). **NON un registro.** | NO | — |
| **L2 — HUB** | softwarehouse acquirente. Il **primo vero MISSION_REGISTRY** consolidato, versionato nel repo `HUB-DOC`. | SÌ — file unico consolidato | statistiche calcolate qui + **numerazione globale unica** (contatore centrale, no collisioni cross-istanza) |
| **L3 — ISTANZA LSO** | singolo progetto/cliente. Registry **proprio** nel repo del progetto (`<progetto>-DOC/docs/missions/`). | SÌ — per-progetto | no (solo dati grezzi) |

La softwarehouse installa **L1** (una volta) + **L2** (il suo `HUB-DOC`) e **genera L3** via `/project` (un'istanza per cliente). Dettaglio e direttive CEO: `ORACODE_NEXUS_3_TIER.md` (🔒 LOCKED).

**Proprieta intellettuale:** Fabio Cherici (CEO & OS3 Architect) + Padmin D. Curtis (CTO & AI Partner). Manifesto certificato su blockchain Algorand via Sigillo (24 marzo 2026).

### Oracode e Open-Source

**Oracode e pubblico e open-source sotto licenza MIT.** Chiunque puo usarlo, modificarlo, distribuirlo e integrarlo nei propri progetti senza restrizioni.

| Campo | Valore |
|-------|--------|
| **Licenza** | MIT (libera, gratuita, senza restrizioni) |
| **Repository** | [github.com/florenceegi/oracode](https://github.com/florenceegi/oracode) |
| **Copyright** | FlorenceEGI S.r.l. — Fabio Cherici |
| **Installazione** | `npx oracode init` (wizard interattivo) |
| **Missione di rilascio** | M-032 (2026-04-08) |

Oracode nasce dall'esperienza di FlorenceEGI ma e progettato per essere usato da **qualsiasi team o progetto** che lavora con agenti AI. Non e vincolato all'ecosistema FlorenceEGI — e un framework indipendente e universale.

---

## 2. Il Living Software Organism (LSO)

Un organismo Oracode (caso esemplare: FlorenceEGI) non e una piattaforma: e un **organismo software vivente**. Ogni progetto e un organo con funzione propria, identita codificata, sistema immunitario attivo e memoria persistente.

Un software tradizionale e statico: il codice fa cio che scrivi, non di piu. Un **LSO** si auto-corregge, si auto-documenta, mantiene la propria coerenza interna nel tempo — e ha una **mente interrogabile**: chiunque puo parlare con l'organismo e ottenere risposte fondate sulla documentazione reale.

### I 6 Principi LSO

| # | Principio | Definizione | Implementazione |
|---|-----------|-------------|-----------------|
| 1 | **Awareness** | Ogni agente sa dove si trova e in quale organismo | `CLAUDE_ECOSYSTEM_CORE.md` caricato via `@` in ogni `CLAUDE.md` |
| 2 | **Prevention** | Le regole si applicano prima che il codice errato venga scritto | Hook `PreToolUse` (9 guard) |
| 3 | **Detection** | Le violazioni vengono rilevate nel momento in cui accadono | Hook `PostToolUse` (audit statico + reflex) |
| 4 | **Evolution** | Il sistema accumula conoscenza e migliora le regole | Report audit in `<istanza>-DOC/audit/` (es. EGI-DOC su FlorenceEGI) + agente `os3-audit-specialist` |
| 5 | **Consciousness** | L'organismo ha una mente interrogabile | SSOT → RAG piattaforma (`rag_<istanza>.*`, es. rag_natan su FlorenceEGI) → `ai_sidebar` in ogni organo |
| 6 | **Nervous System** | L'organismo percepisce il disallineamento doc/codice | SSOT Registry + reflex hook + living agent + cron |

---

## 3. Layer Stack (8 livelli)

```
┌──────────────────────────────────────────────────────────────┐
│  L8 — NERVOUS SYSTEM                                         │
│  SSOT_REGISTRY.json + ssot-reflex-guard + living agent       │
│  4 sub-layer ispirati al sistema nervoso umano               │
├──────────────────────────────────────────────────────────────┤
│  L7 — CONTRACTS                                              │
│  <istanza>-DOC/contracts/*.json (es. EGI-DOC) — 7 contratti  │
│  Validabili da GATE e agenti                                 │
├──────────────────────────────────────────────────────────────┤
│  L6 — GATE                                                   │
│  os3-gate agent — validatore AI pre-push                     │
│  Legge CONTRACTS + diff → PASS / WARN / BLOCK                │
├──────────────────────────────────────────────────────────────┤
│  L5 — KNOWLEDGE                                              │
│  CLAUDE_ECOSYSTEM_CORE.md + CLAUDE.md per organo + MEMORY.md │
├──────────────────────────────────────────────────────────────┤
│  L4 — PREVENTION (PreToolUse hooks)                          │
│  9 hook che bloccano meccanicamente violazioni P0             │
├──────────────────────────────────────────────────────────────┤
│  L3 — DETECTION (PostToolUse hooks)                          │
│  audit-static + audit-on-complete + deploy-pipeline-guard    │
├──────────────────────────────────────────────────────────────┤
│  L2 — DEEP AUDIT (periodico / on-demand)                     │
│  deep-audit periodico + agenti diagnostici + report storico   │
├──────────────────────────────────────────────────────────────┤
│  L1 — SYNC (post-task)                                       │
│  doc-sync-guardian → <istanza>-DOC/docs/ (es. EGI-DOC)       │
└──────────────────────────────────────────────────────────────┘
```

---

## 4. I 6+1 Pilastri Fondamentali

| # | Pilastro | Principio | Enforcement |
|---|----------|-----------|-------------|
| 1 | **Intenzionalita Esplicita** | Dichiara sempre perche fai quello che fai | `@purpose` obbligatorio in DocBlock |
| 2 | **Semplicita Potenziante** | Scegli l'opzione che massimizza la liberta futura | No over-abstraction, no premature optimization |
| 3 | **Coerenza Semantica** | Parole e azioni allineate | Terminologia OSZ unificata in tutto il codice |
| 4 | **Circolarita Virtuosa** | Crea valore che ritorna amplificato | Bug → test; Feature → pattern; Errore → UEM |
| 5 | **Evoluzione Ricorsiva** | Ogni successo migliora il sistema | DOC-SYNC P0 — mai skippabile |
| 6 | **Sicurezza Proattiva** | Security by design | GDPR + Sanctum + scope sempre |
| 7 | **REGOLA ZERO** | MAI dedurre. SE NON SAI → CHIEDI | P0-1 — zero tolerance |

---

## 5. Sistema Priorita P0-P3

```
Viola → sistema si rompe immediatamente?      → P0  STOP TOTALE
Viola → codice non production-ready?           → P1  MUST
Viola → accumulo debito tecnico?               → P2  SHOULD
Altrimenti                                     → P3  REFERENCE
```

| Priorita | Nome | Conseguenza violazione |
|----------|------|------------------------|
| **P0** | BLOCKING | Stop totale. Si corregge. Non esiste "sistemo dopo". |
| **P1** | MUST | Codice non production-ready. Correggere prima del deploy. |
| **P2** | SHOULD | Debito tecnico accumulato. Refactoring consigliato. |
| **P3** | REFERENCE | Linea guida non cogente. I 12 Pilastri Derivati da OS2. |

---

## 6. Regole P0 Universali

| # | Regola | Azione obbligatoria |
|---|--------|---------------------|
| P0-0 | **No framework vietati** | Solo Vanilla TS. MAI Alpine/Livewire/React (organo-specifico) |
| P0-1 | **REGOLA ZERO** | Info mancante → CHIEDI. MAI dedurre. |
| P0-2 | **Translation keys** | `__('key')` Atomic. MAI testo hardcoded. MAI `__('k',['p'=>$v])`. |
| P0-3 | **Statistics Rule** | No `take(N)` nascosti — parametri sempre espliciti. |
| P0-4 | **Anti-Method-Invention** | grep verifica esistenza metodo PRIMA di usarlo. |
| P0-5 | **UEM-First** | Errori → `$errorManager->handle()`, mai solo log. |
| P0-6 | **Anti-Service-Method** | `Read` + `grep` prima di qualsiasi service call. |
| P0-7 | **Anti-Enum-Constant** | Verifica costanti enum esistano con grep. |
| P0-8 | **Complete Flow Analysis** | Mappa flusso COMPLETO (4 fasi) prima di qualsiasi fix. |
| P0-9 | **i18n 6 lingue** | `it` `en` `de` `es` `fr` `pt` — SEMPRE tutte e sei. |
| P0-10 | **Anti-MongoDB** | MAI `MongoDBService` diretto → usa `get_db_service()` da `db_factory.py`. |
| P0-11 | **DOC-SYNC** | Task NON chiusa senza il doc-store dell'istanza aggiornato (es. EGI-DOC su FlorenceEGI). Zero eccezioni. |
| P0-12 | **Anti-Infra-Invention** | URL/path EC2/branch → verifica da SSM/git. MAI dedurre. |

**P0 = Zero Tolerance.** Non si passa P0. Si corregge P0. P0 aperte > 0 → audit FAIL, indipendentemente dal punteggio.

---

## 7. P0-8 Complete Flow Analysis

**Tempo:** 15-35 min. **Risparmio:** 2+ ore di debugging.

### Fase 1 — Flow Mapping

```
User Action     → Come inizia? Click? Form submit? API call?
Entry Point     → Route · Method · Controller@metodo
Processing      → Controller → Service/Job (sync/async?) → External calls?
Exit Point      → Success · Error (come gestito?)
Critical Points → Dove puo fallire? Dove cambiano i tipi? Branch logic?
```

### Fase 2 — Type Tracing

Per ogni variabile: tipo in ogni step. Ogni trasformazione esplicita.
`string → Collection → array → Model`

### Fase 3 — All Occurrences

```bash
grep -r "nomeMetodo\|nomeClasse" --include="*.php" .
```

Tutte le occorrenze prima di modificare qualsiasi cosa.

### Fase 4 — Context Verification

Verificare pattern esistenti nel codebase. Poi e solo poi: codice.

---

## 8. Firma OS3

Obbligatoria (P1) su ogni file nuovo o significativamente modificato.

```php
/**
 * @package App\Http\[Area]
 * @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
 * @version 1.0.0 (<istanza> — [Organo])
 * @date YYYY-MM-DD
 * @purpose [Scopo chiaro e specifico in una riga]
 */
```

```typescript
/**
 * @package [Organo] — [ComponentName]
 * @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
 * @version 1.0.0 (<istanza> — [Organo])
 * @date YYYY-MM-DD
 * @purpose [Scopo specifico del componente]
 */
```

---

## 9. Strategia Delta

```
NUOVO CODICE  → TUTTE le regole OS3. Config → nasce sull'HUB (es. EGI-HUB su FlorenceEGI).
                File max 500 righe tassativo. DOC-SYNC P0.

CODICE LEGACY → Resta dove e. Si migra SOLO quando si tocca per altra ragione.
                Mai refactoring "di principio" su codice production funzionante.
                Ogni migrazione: piano approvato da Fabio + test before/after.
```

---

## 10. Tag Commit

| Tag | Uso |
|-----|-----|
| `[FEAT]` | Nuova funzionalita |
| `[FIX]` | Correzione bug |
| `[REFACTOR]` | Ristrutturazione senza cambio behavior |
| `[DOC]` | Documentazione |
| `[CONFIG]` | Configurazione |
| `[I18N]` | Traduzioni |
| `[SECURITY]` | Sicurezza |
| `[PERF]` | Performance |
| `[TEST]` | Test |
| `[CHORE]` | Manutenzione |
| `[WIP]` | Work in progress |
| `[DEPLOY]` | Deploy |
| `[DEBITO]` | Debito tecnico documentato |
| `[ARCH]` | Architettura |

---

## 11. Hook System (14 hook)

Deployati nel layer di deploy locale (inventario concreto privato — OS3 Matrix). Attivi su ogni operazione Claude Code.

Gli hook di enforcement (prevenzione/detection) sono stratificati per momento. L'**inventario
concreto** (nomi, trigger, versioni) e `visibility:private` nell'OS3 Matrix — SSOT `oracode-nexus-index-impl`.
Categorie (modello):
- **PreToolUse / Write|Edit** — coerenza cross-organo, P0 contestuali, file legacy, valori immutabili, compliance dominio (es. MiCA), stringhe hardcoded, secrets.
- **PreToolUse / Bash** — push su `main`, `rm`, comandi rischiosi.
- **PostToolUse** — analisi statica OS3, report findings a task completato, riflesso passivo SSOT (Sistema Nervoso L1).
- **Cron/manuale** — staleness SSOT (L3), deep-audit periodico.

**Hardening M-OS3-013 (sessione 3).** Hook hardening pass risolve i finding S2-14/15/18/19/21 e introduce il nuovo guard `S2-23 uem-code-validation`. Dettaglio in `docs/oracode/audit/08_HOOK_ENFORCEMENT_SYSTEM.md`.

---

## 12. Hook Enforcement Meccanico

Oltre agli hook globali, il paradigma prevede **hook progetto-specifici** che bloccano
meccanicamente le violazioni P0 piu critiche. Il **modello** (categorie, principi) e parte del
paradigma pubblico; l'**inventario concreto** (nomi, logica, struttura sorgente, procedura di
deploy) e `visibility:private` nell'OS3 Matrix — SSOT `oracode-nexus-index-impl`.

### Modello — enforcement P0-6 (route ↔ controller)

**Regola:** prima di modificare una route che referenzia un Controller, quel Controller deve
essere stato letto (`Read`) nella sessione corrente. Estrazione dell'entita dal codice → ricerca
nel filesystem → verifica presenza nel transcript → block se non letto.

**Origine:** incidente 2026-03-23 (istanza FlorenceEGI). Middleware aggiunto a una route senza
leggere il controller che gia gestiva i permessi → regressione silenziosa in produzione.

### Modello — enforcement P0-4 (esistenza metodo)

**Regola:** i metodi chiamati su Service/Repository/Manager/Handler devono esistere nel file
della classe. **Architettura a 2 livelli:** guard (detection progetto) → analizzatore di codice.
Whitelist framework per metodi standard.

**Principio:** un falso negativo e preferibile a un falso positivo. Gli hook assistono la review,
non la sostituiscono.

### Attivi su: gli organi dell'istanza (es. NATAN_LOC, EGI-HUB, EGI su FlorenceEGI).

### Come si estende (principio)

1. Guard generosi (escludere vendor, tests, migrations), uscita pulita sui dubbi, messaggio chiaro.
2. Registrazione del guard nel layer di enforcement dell'istanza.
3. La procedura concreta di scaffolding/deploy per nuovo hook o nuovo progetto e nell'OS3 Matrix
   (impl privata — SSOT `oracode-nexus-index-impl`).

---

## 13. Git Hooks — Protezione Rimozioni

| Regola | Trigger | Azione |
|--------|---------|--------|
| R1 | >100 righe rimosse per file | BLOCCA |
| R2 | 50-100 righe rimosse per file | WARNING |
| R3 | >50% contenuto rimosso per file | BLOCCA |
| R4 | >500 righe totali rimosse nel commit | BLOCCA |

Bypass: `git commit --no-verify` — solo con approvazione esplicita di Fabio.

**MAI `git clean -fd`** su server — distrugge `.env` e config critiche.

---

## 14. Sistema Nervoso (4 sub-layer)

Ispirato al sistema nervoso umano. Risolve il problema del DOC-SYNC dimenticato.

| Sub-layer | Analogia biologica | Implementazione | Tempo |
|-----------|--------------------|-----------------|-------|
| **L0 MIELINA** | Guaina mielinica accelera trasmissione | `SSOT_REGISTRY.json` — mapping esplicito doc → file watchati | Statico |
| **L1 RIFLESSO** | Arco riflesso senza cervello | reflex guard passivo (PostToolUse) — file modificato → lookup → segnale | <1s, costo AI zero |
| **L2 PROPRIOCEZIONE** | Sapere dove sei senza guardare | Mission Registry esteso (`doc_sync_executed`, `doc_verified`, `files_modified`), popolato **automaticamente** dal ponte L1→L3 (`bin/mission` propaga lo stato nel registry del progetto via `.oracode/project.json`) | Per missione |
| **L3 AUTONOMO** | Respira senza pensarci | cron di staleness (04:00) — drift report | Periodico |

**Come si compensano:** il drift deve "scappare" da tutti e 3 i layer attivi per restare inosservato. L1 segnala in sessione → L2 registra nella missione → L3 trova alla prossima verifica notturna.

File critici:
- Registry: `<istanza>-DOC/docs/lso/SSOT_REGISTRY.json` (es. /home/fabio/EGI-DOC su FlorenceEGI)
- Indice Nexus dei registry: `ssot-registry-index.json` (contratto OS3 Matrix, `os3-matrix/contracts/`) — censimento di tutti gli `SSOT_REGISTRY.json` delle istanze. Ogni nuovo registry creato dal bootstrap viene censito alla nascita (`/oracode-scaffold` step 5b, forzante f.1 ADR M-FUC-029) con check `ssot-index-check` verde (exit 0) prima di proseguire: **nessun registry nasce orfano**.
- Hook: reflex guard passivo (impl privata — OS3 Matrix)
- Propriocezione (istanza FlorenceEGI, L3 accoppiato): `/home/fabio/EGI-DOC/docs/missions/MISSION_REGISTRY.json`
- Agente: living agent (archiviato; impl privata — OS3 Matrix)
- Cron script: cron di staleness (impl privata — OS3 Matrix)
- Report drift: `<istanza>-DOC/audit/drift/` (es. /home/fabio/EGI-DOC su FlorenceEGI)

---

## 15. Agenti Specializzati (11 agenti)

Deployati nella dir agenti privata (OS3 Matrix).

### Agenti DEV (scrivono codice)

| Agente | Dominio | Quando si usa |
|--------|---------|---------------|
| `laravel-specialist` | PHP/Laravel | Controller, Service, Model, Migration, Route, Lang |
| `python-rag-specialist` | Python/FastAPI | RAG-Fortress, USE Pipeline, endpoint AI, PostgresService |
| `frontend-ts-specialist` | TypeScript/CSS | Componenti UI, Blade, Tailwind, accessibilita |
| `node-ts-specialist` | Node.js/TS | vc-engine, algokit-service, SD-JWT, OID4VCI/VP, Express, Redis |

### Agenti AUDIT (verificano conformita)

| Agente | Funzione | Output |
|--------|----------|--------|
| `os3-audit-specialist` | Audit AI contestuale completo | Report con findings e scoring |
| `os3-gate` | Validazione pre-push | PASS / WARN / BLOCK |

### Agenti DIAGNOSTICI (analisi profonda)

| Agente | Funzione | Output |
|--------|----------|--------|
| `organ-gap-scout` | Gap evolutivi organo vs organismo | Report, PENDING_BRAIN_APPROVAL |
| `oracode-alignment-interpreter` | Verita semantica/intenzionale organo | Report, PENDING_BRAIN_APPROVAL |
| `ssot-living-agent` | Verifica semantica profonda doc-codebase | Drift report + Health Score |

### Agenti SYNC e SPECIALISTI

| Agente | Funzione | Quando si usa |
|--------|----------|---------------|
| `doc-sync-guardian` | Sincronizza il <istanza>-DOC (es. EGI-DOC) dopo feature | Dopo ogni task Tipo 2+ |
| `corporate-finance-specialist` | CFO/Advisor digitale | Documenti per banche, investitori, fundraising, M&A |

---

## 16. GATE vs AUDIT

| Aspetto | GATE (`/gate`) | AUDIT (`os3-audit-specialist`) |
|---------|----------------|--------------------------------|
| **Scope** | Diff corrente (pre-push) | Organo intero o area specifica |
| **Timing** | Prima del push | Periodico o on-demand |
| **Output** | PASS / WARN / BLOCK | Report dettagliato con scoring 0-100 |
| **Durata** | 2-5 minuti | 30 min - 4 ore |
| **Usa contratti** | Si (L7 CONTRACTS) | Si + Evidence Pack |

---

## 17. Sistema Audit

### Trigger Matrix (Tipo 1-6)

| Tipo | Nome | DOC-SYNC? | Approvazione Fabio? |
|------|------|-----------|---------------------|
| 1 | Locale (fix puntuale, output invariato) | NO | NO |
| 2 | Comportamentale (cambia output/API/behavior) | SI su <istanza>-DOC (es. EGI-DOC) | NO |
| 3 | Architetturale (nuovo endpoint/model/service) | SI su <istanza>-DOC (es. EGI-DOC) + CLAUDE.md | NO |
| 4 | Contrattuale (GDPR/MiCA/compliance/ToS) | SI + approvazione Fabio | SI, prima |
| 5 | Naming dominio (rinomina entita/concetto) | SI, grep tutti i file | NO |
| 6 | Cross-project (impatta piu organi) | SI su ecosistema + approvazione | SI |

**Regola del dubbio:** se non sai se Tipo 1 o 2, tratta come Tipo 2.

### Target Matrix

8 organi (T-001 a T-008) + 6 flussi cross-project (T-D01 a T-D06). Ogni target ha: owner, SSOT locale/centrale, criticita, stato audit. SSOT: `EGI-DOC/docs/oracode/audit/01_TARGET_MATRIX.md`.

### Scoring (6 aree pesate su 100)

| Area | Peso | Cosa verifica |
|------|------|---------------|
| A — P0 Compliance | 40 | Tutte le 8 regole P0 con evidenza |
| B — P1 Compliance | 25 | Docblock, SSOT update, zero placeholder, testing, GDPR |
| C — SSOT Alignment | 15 | CLAUDE.md + <istanza>-DOC (es. EGI-DOC) allineati al codice |
| D — Claude Code Enforcement | 10 | Config agenti, identita, escalation |
| E — Semantic Consistency | 5 | Terminologia coerente codice/doc/business |
| F — Evidence Quality | 5 | Evidenze verificabili e riproducibili |

### Verdetti

| Score | Verdict |
|-------|---------|
| 95-100 | PASS |
| 85-94 | PASS WITH CONDITIONS |
| 70-84 | PASS WITH CONDITIONS (con remediation) |
| < 70 | FAIL |

**Regola P0 assoluta:** P0 aperte > 0 → FAIL, indipendentemente dal punteggio.

### Anti-frode documentale

1. Compilare checklist senza leggere i file → invalido
2. PASS su P0 senza evidenza specifica → invalido
3. Aggiornare SSOT cosmeticamente per far quadrare il report → invalido
4. Saltare Fase 2 (P0) → invalido
5. "Non applicabile" su P0-1 (Regola Zero) → invalido (sempre applicabile)

---

## 18. Mission Protocol — summary

> **Specifica completa:** `docs/paradigm/missions/MISSION_PROTOCOL.md` v4.0.0 (2026-05-31). Questa sezione è un sommario operativo. In caso di divergenza, prevale `MISSION_PROTOCOL.md`.

> **PONTE AUTOMATICO L1→L3 (M-OS3-025 Unità 3).** `bin/mission` auto-registra e propaga lo stato della mission nel MISSION_REGISTRY del progetto, risolto dal **CWD** tramite il descrittore `<progetto>/.oracode/project.json` (`syncToRepoRegistry`). Niente sincronizzazione manuale state↔registry, niente mission fantasma. Operazione **parallel-safe** (lock per-registry, `withRegistryLock`).

### Flusso operativo Nexus

```
/discovery (acquisizione pre-vendita)
    ↓
/project   (bootstrap istanza L3 — scaffolda <progetto>/.oracode/project.json
            + difesa Egida-by-default per i progetti con Matrix, liv 2+)
    ↓
/mission   (lavoro — auto-registrato nel registry del progetto via ponte L1→L3)
```

Il comando `/mission` è **globale e context-aware**: rileva l'istanza dal CWD (wrapper di `bin/mission`, M-OS3-025 Unità 2).

> **Difesa Egida-by-default nel bootstrap (M-NEXUS-006 E5).** `/project` installa di default la difesa Egida
> per i progetti **con Matrix** (livello 2+), operazionalizzando l'Asse Difesa Costitutivo (OSZ, M-NEXUS-005)
> tramite `EGIDA_INSTALL_CONTRACT §6`: `/oracode-configure` (Q8) sceglie `egida_profile` ∈ `{L1, L2-L3, L3-L4}`
> — default dal livello, **upgrade a `L3-L4` se l'organo tratta denaro/PII/blockchain** (segnale chiesto, non
> dedotto — REGOLA ZERO); `/oracode-scaffold` (step 6b) scaffolda `<repo>/SECURITY_INVARIANTS.json` (target
> `<PLACEHOLDER>`, riempiti dalla corsia dell'organo) e scrive `egida_gate`/`egida_profile` nel descrittore.
> Un **livello 1 paradigm-only (senza Matrix)** NON riceve Egida-by-default (proporzionalità — "dove ha senso").
> `fortino-check` resta concern di **runtime** (corsia Fortino, fuori scope `/project`).

### 18.1 Fasi narrative (livello Oracode)

| Fase | Nome | Azione |
|------|------|--------|
| 0 | Prenotazione ID | Counter mission → entry minima registry → commit immediato (anti-collisione cross-session) |
| 1 | Apertura + bootstrap mirato | Intent CEO → `type` + `organs` → carica solo moduli rilevanti |
| 2 | Analisi | Read + grep + flow mapping + identificazione rischi |
| 3 | Piano | FILE COINVOLTI + SEQUENCE + RISCHI + DOC-SYNC → **approvazione esplicita CEO** |
| 4 | Esecuzione | Un file per volta, firma OS3, max 500 righe, tracking moduli consultati |
| 5 | Review deliverable | Watchdog → approvazione CEO |
| 6 | Chiusura: DOC-SYNC v2 + retrospective | Spawn `doc-sync-v2` → ESITO A/B/C → retrospective bootstrap → close |

> **Chiavi registry canoniche = INGLESE** (decisione CEO 2026-05-30): `id`, `title`, `type`, `organs`, `status`, `date_open`, `date_close`. Le chiavi italiane `tipo_missione`/`organi_coinvolti`/`data_apertura`/`stato` sono **LEGACY** (EGI-DOC accoppiato), in migrazione graduale — mai canoniche per le nuove istanze.

### 18.2 State machine codificata (livello Oracode-tooling)

Ogni mission attraversa 7 stati operativi enforced dal CLI `bin/mission`:

```
draft → planned → executing → auditing → closed
                                  ↓
                          auditing_failed → closed_with_debt
                                  ↓
                              aborted
```

Transizioni non ammesse bloccate dal CLI. Stati `auditing_failed` e `closed_with_debt` introdotti da M-OS3-006. Stato `aborted` da M-OS3-009.

### 18.3 ESITO A/B/C — verifica DOC-SYNC v2 pre-close

| Esito | Significato | Azione |
|---|---|---|
| **ESITO A** | SSOT già allineati | Procedi a `closed` |
| **ESITO B** | Patch additiva applicata | Procedi a `closed` con `doc_sync_log` |
| **ESITO C** | Patch sostitutiva proposta | Mission in `awaiting_doc_sync_approval` → decisione CEO |

### 18.4 Campi Mission Registry (estensione v3)

```json
{
  "id": "M-NNN",
  "title": "...",
  "status": "draft|planned|executing|auditing|auditing_failed|closed|closed_with_debt|aborted",
  "type": "feat | fix | refactor | arch | doc | config",
  "organ": "NATAN_LOC | EGI | ...",
  "files_modified": [],
  "scope_hash": "sha256...",
  "spawn_fingerprint": { "agent_name": "...", "input_hash": "...", "tool_use_id": "..." },
  "doc_sync_log": { "esito": "A|B|C", "outcome": "success|failed_*" },
  "doc_sync_executed": true,
  "retrospective_executed": true,
  "debt_reason": "..."
}
```

**Dove vive il registry (gerarchia Nexus 3-livelli).** Ogni **ISTANZA LSO (L3)** ha il proprio MISSION_REGISTRY nel suo repo: `<progetto>-DOC/docs/missions/MISSION_REGISTRY.json`. Le **statistiche** e la **numerazione globale unica** sono responsabilità del **L2 HUB** (MISSION_REGISTRY consolidato nel repo `HUB-DOC`). `/home/fabio/EGI-DOC/docs/missions/MISSION_REGISTRY.json` è il caso **accoppiato HUB+istanza** di FlorenceEGI (caso unico finché c'è un solo cliente, chiavi italiane = legacy), **NON** il modello canonico per le nuove istanze. Vedi `ORACODE_NEXUS_3_TIER.md`.

---

## 18bis. CLI `bin/mission` — implementazione di riferimento

Il CLI `bin/mission` è l'implementazione di riferimento del Mission Protocol. Vive nel repo os3-matrix ed è **Oracode-universale** (nessun riferimento hardcoded a istanze).

### Evoluzione

| Versione | Mission | Cambiamento |
|---|---|---|
| v0.1 | M-OS3-001 | State machine 7 stati non-aggirabile, scope hash, lock globale single-mission |
| v0.2 | M-OS3-012 | Multi-mission concurrency, focus-based isolation, test-red whitelist `tests/**` in `planned` |
| v0.3 | M-OS3-016 | Multi-write per `session_id` — focus per-session via env `CLAUDE_CODE_SESSION_ID` |

### Subcomandi principali

```
open <ID> --title="..." --trigger=N [--scope="..."]
advance --to=<state> --mission=<ID> [--test-file=...]
status [--mission=<ID> | --all]
focus <ID> | unfocus | focused
suspend / resume
gc-focus / check-timeout
close
```

### Multi-write per session_id (M-OS3-016)

N sessioni Claude Code parallele = N focus paralleli in `~/oracode-engine/focus/<session_id>.json`. Zero collisione. **AMENDMENT 1 CEO**: env presente + file assente = BLOCK, no eredità da legacy `focus.json`.

> **Nota path (M-OS3-025 Unità 1).** La cartella globale (L1 motore) è **VISIBILE** in `~/oracode-engine/` — non più `~/.oracode` nascosta. `bin/mission` usa `ORACODE_HOME = ~/oracode-engine`. `~/.oracode` resta come **symlink di compatibilità** verso `~/oracode-engine`, rimovibile.

### Spawn fingerprint (M-OS3-005)

Ogni spawn di sub-agent registra hash input + timestamp + tool_use_id + file letti, come evidenza anti-allucinazione verificabile cross-session.

---

## 19. DOC-SYNC e RAG Pipeline

### P0-11 — DOC-SYNC

Una task NON e chiusa senza il doc-store dell'istanza aggiornato. Zero eccezioni. Ogni modifica Tipo 2+ richiede aggiornamento della documentazione corrispondente nel repo SSOT dell'istanza (es. `EGI-DOC/docs/` su FlorenceEGI).

### RAG Pipeline (<istanza>-DOC → rag_<istanza>.*; es. EGI-DOC → rag_natan su FlorenceEGI)

```
<istanza>-DOC/docs/**/*.md (frontmatter OS3 + body Markdown)
    ↓
manifest.py     → snapshot corpus, diff incrementale (hash SHA256)
    ↓
chunker.py      → split semantico: heading → paragrafo → overlap (500 token, 50 overlap)
    ↓
embedder.py     → OpenAI text-embedding-3-small (1536 dim)
    ↓
db.py           → PostgreSQL rag_<istanza>.documents + chunks + embeddings
    ↓
sync.py         → confronto versioni semver + hash → delta incrementale
```

Cron: sync automatico ogni 4 ore. Pipeline: `<istanza>-DOC/pipeline/` (es. EGI-DOC su FlorenceEGI).

### La Mente dell'Organismo

```
<istanza>-DOC/docs/ (SSOT) → rag_<istanza>.* (RAG piattaforma) → ai_sidebar (ogni organo)
```

L'utente parla con l'organismo da qualsiasi organo e riceve risposte contestuali fondate sulla documentazione reale. Quando un doc viene aggiornato (DOC-SYNC), il RAG si aggiorna. L'organismo sa cosa e e te lo puo dire.

RAG multipli specializzati:

| Schema | Dominio | Usato da |
|--------|---------|----------|
| `rag_<istanza>.*` (es. rag_natan) | Piattaforma (SSOT ecosistema) | ai_sidebar di tutti gli organi |
| `natan.rag_*` (schema RAG di un organo, es. NATAN_LOC) | PA verticale (56k atti comunali) | NATAN_LOC USE Pipeline |
| `marketing_rag.*` | NPE/marketing (catalogo arte) | Narrative Promotion Engine |

---

## 20. Checklist Pre-Risposta

```
1. Ho TUTTE le info necessarie?           NO  → CHIEDI (P0-1)
2. Metodi/componenti verificati con grep? NO  → grep prima (P0-4/P0-6)
3. Esiste pattern simile nel codebase?    ?   → CERCA prima
4. Sto assumendo qualcosa?                SI  → DICHIARA e CHIEDI
5. Sto toccando file LEGACY?              SI  → DICHIARA + piano Fabio
6. i18n in tutte le lingue richieste?     NO  → NON PROCEDERE (P0-9)
7. Tipo modifica → [1-6]?                 ?   → classifica con Trigger Matrix
8. DOC-SYNC eseguito (se Tipo 2+)?        NO  → NON CHIUDERE (P0-11)
```

---

## 21. Pattern Avanzati

### TOON Format (AI-AI, -45% token)

```
array_name[N]{campo1,campo2}:
valore1_c1|valore1_c2
valore2_c1|valore2_c2
```

Riduzione token vs JSON: 26% (piccoli), 45% (medi), 60% (grandi). Lossless, type inference, human-readable.

### Atomic Translation (UTM)

```php
// CACHEATO con il primo utente — VIETATO
__('key', ['name' => $user->name])

// Solo parti statiche cachate — OBBLIGATORIO
__('key.prefix') . ' ' . $user->name . ' ' . __('key.suffix')
```

### A11Y — WCAG 2.1 Level AA

P2, non blocca deploy. Applicata incrementalmente.

- P1-MUST: `<label for="id">` su ogni input, `alt="..."` su ogni `<img>`
- P2-SHOULD: HTML semantico, `aria-label` su icon-only buttons, `aria-hidden="true"` su SVG decorativi, `focus:ring-2`, `aria-live="polite"` su notifiche dinamiche

---

## 22. Roadmap

### Priorita alta

- [ ] **Audit differenziale** — confronta ultimo report con precedente, mostra solo nuovi finding
- [ ] **Dashboard LSO** — pagina EGI-STAT che visualizza LSO Score per organo in tempo reale
- [ ] **Notifiche** — alert su Slack/email quando audit trova finding critici

### Priorita media

- [ ] **GitHub Actions** — il deep-audit + GATE ad ogni PR, blocca merge su BLOCK
- [ ] **Auto-remediation** — agente che propone e applica fix per finding standard
- [ ] **GATE integrato in pre-push hook** — attivazione automatica
- [ ] **Pilot Console completa** — `/health`, `/audit [organo]`, `/new-organ [nome]`

### Priorita bassa

- [ ] **LSO Score** — punteggio 0-100 di conformita OS3 per organo, storicizzato
- [ ] **Trend chart** — grafico EGI-STAT con andamento nel tempo
- [ ] **Cross-organ dependency check** — verifica Interface stabili non modificate
- [ ] **Semantic audit** — analisi AI dei commit per violazioni logiche non catturabili da grep

---

## Riferimenti

I doc di **paradigma** sono stati rilocati in `/home/fabio/oracode/docs/paradigm/` (M-OS3-022). I path che restano in `EGI-DOC` sono **artefatti dell'istanza FlorenceEGI (L3 accoppiato)** — registry, audit, report runtime — non doc di paradigma universale.

### Paradigma (universale)

| Risorsa | Path |
|---------|------|
| Nexus 3-livelli (SSOT locked) | `/home/fabio/oracode/docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md` |
| LSO architettura | `/home/fabio/oracode/docs/paradigm/lso/00_LSO_LIVING_SOFTWARE_ORGANISM.md` |
| Manifesto LSO | `/home/fabio/oracode/docs/paradigm/lso/MANIFESTO_LSO.md` |
| Mission Protocol | `/home/fabio/oracode/docs/paradigm/missions/MISSION_PROTOCOL.md` |
| OS3 Executive Summary | `/home/fabio/oracode/docs/paradigm/execution/OS3/00_OS3_Executive_Summary.md` |
| Sistema Priorità P0-P3 | `/home/fabio/oracode/docs/paradigm/execution/OS3/04_Modulo_3_Sistema_Priorita_P0_P3.md` |
| Standards (naming, quality gate, legacy stack) | `/home/fabio/oracode/docs/paradigm/standards/` |
| Hook directory | privata (OS3 Matrix) |
| Agenti directory | privata (OS3 Matrix) |

### Istanza FlorenceEGI (L3 accoppiato — runtime / legacy)

| Risorsa | Path |
|---------|------|
| Regole ecosistema (boot context istanza) | `/home/fabio/EGI-DOC/CLAUDE_ECOSYSTEM_CORE.md` |
| Report audit | `/home/fabio/EGI-DOC/audit/` |
| Report drift SSOT | `/home/fabio/EGI-DOC/audit/drift/` |
| SSOT Registry | `/home/fabio/EGI-DOC/docs/lso/SSOT_REGISTRY.json` |
| Mission Registry (legacy chiavi IT) | `/home/fabio/EGI-DOC/docs/missions/MISSION_REGISTRY.json` |
| Target / Trigger / Scoring / Runbook / Hook Enforcement | `/home/fabio/EGI-DOC/docs/oracode/audit/` |
| EGI-DOC Pipeline | `/home/fabio/EGI-DOC/docs/oracode/EGI_DOC_PIPELINE.md` |

---

*Oracode OS3.0 — Oracode Nexus SSOT v1.5.0 (2026-06-12)*
*Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici*
