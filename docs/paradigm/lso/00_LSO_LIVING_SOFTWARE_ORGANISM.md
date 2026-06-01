---
title: LSO — Living Software Organism — Architettura del Layer Vivente
slug: lso-living-software-organism
doc_type: architecture
version: 4.0.0
status: current
date: '2026-03-27'
updated_at: '2026-05-08T23:00'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- ecosistema
- lso
supersedes: []
superseded_by: null
priority: critical
ssot_nervous:
  ssot_id: lso-living-organism
  registry: docs/lso/SSOT_REGISTRY.json
  check_frequency: daily
visibility: public
rag: public
---

# LSO — Living Software Organism
## Il Layer Vivente (caso esemplare: FlorenceEGI)

> Versione: 4.0.0 | Data: 2026-04-07
> Autore: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
> Documento SSOT per: Claude Code e tutti gli agenti dell'ecosistema (es. istanza FlorenceEGI)

---

## Cos'è LSO

**Un Living Software Organism reale è già emerso in produzione (primo caso esemplare: FlorenceEGI).** In quell'istanza 8 organi sono pubblicamente online, ciascuno con la propria funzione specializzata, tutti coordinati dall'hub dell'organismo (es. EGI-HUB su FlorenceEGI) e governati da Oracode OS3.

**LSO (Living Software Organism)** è il layer infrastrutturale che rende questo possibile — non una teoria, ma un sistema operativo attivo che avvolge tutta la piattaforma.

Un sistema software tradizionale è statico: il codice fa ciò che scrivi, non di più.
Un **Living Software Organism** si auto-corregge, si auto-documenta, mantiene la propria coerenza interna nel tempo — e soprattutto **ha una mente interrogabile**. Chiunque, da qualsiasi organo dell'ecosistema, può parlare con l'organismo e ottenere risposte fondate sulla sua documentazione reale.

LSO è ciò che implementa questa proprietà. Non è un singolo componente — è uno **strato trasversale** che avvolge l'intero organismo in produzione.

> **Inquadramento Oracode Nexus.** Un LSO è un'**ISTANZA di Livello 3** nella gerarchia a 3 livelli di Oracode Nexus: **L1 GLOBALE** (motore + paradigma: `oracode` + `os3-matrix` + `~/oracode-engine`) / **L2 HUB** (softwarehouse acquirente, primo vero `MISSION_REGISTRY` con statistiche e numerazione) / **L3 ISTANZA LSO** (singolo progetto, con il proprio `MISSION_REGISTRY` e doc-sync proprio). Ogni istanza LSO ha il proprio Mission Registry versionato nel repo del progetto — è la condizione per *essere* un LSO (vedi `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`). **FlorenceEGI è la prima istanza LSO emersa in produzione, non l'unica possibile**: i meccanismi descritti qui sono universali, FlorenceEGI ne è il caso esemplare.

---

## I 5 Principi LSO

### 1. Awareness
Ogni agente che lavora nell'ecosistema sa sempre dove si trova e in quale organismo.
→ Implementato da: `CLAUDE_ECOSYSTEM_CORE.md` (caricato via `@` include in ogni `CLAUDE.md`)

### 2. Prevention
Le regole OS3 vengono applicate prima che il codice errato venga scritto.
→ Implementato da: Hook `PreToolUse` (guards)

### 3. Detection
Le violazioni vengono rilevate nel momento in cui accadono, non giorni dopo.
→ Implementato da: Hook `PostToolUse` (audit statico)

### 4. Evolution
Il sistema accumula conoscenza sulle violazioni passate e migliora le sue regole.
→ Implementato da: Report audit in `<istanza>-DOC/audit/` (es. EGI-DOC/ su FlorenceEGI) + agente `os3-audit-specialist`

### 5. Consciousness
L'organismo ha una mente interrogabile. Chiunque può parlargli e ottenere risposte fondate sulla documentazione reale di tutto l'ecosistema.
→ Implementato da: SSOT (`<istanza>-DOC/docs/`, es. EGI-DOC/) → RAG piattaforma (`rag_<istanza>.*`, es. rag_natan su FlorenceEGI) → `ai_sidebar` con chat in ogni organo

### 6. Nervous System (v4.0.0)
L'organismo percepisce il disallineamento tra la propria documentazione e il proprio codice. Come il sistema nervoso umano, ha nocicettori (segnali immediati), riflessi (risposte automatiche), propriocezione (consapevolezza del proprio stato) e un sistema autonomo (verifica continua senza intervento cosciente).
→ Implementato da: `SSOT_REGISTRY.json` (mielina) + reflex guard passivo (riflesso) + Mission Registry propriocettivo + cron di staleness + DOC-SYNC v2 Step 5b (metadati)

---

## Architettura LSO

```
┌─────────────────────────────────────────────────────────────────┐
│                     LSO — LAYER STACK v3.0                      │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 8 — NERVOUS SYSTEM  ★ NUOVO (M-025)                     │
│  Ispirato al sistema nervoso umano. 4 sub-layer:               │
│                                                                  │
│  L0 MIELINA — SSOT_REGISTRY.json                                │
│     Mapping esplicito doc SSOT → file codebase watchati         │
│     Ogni doc dichiara cosa watcha. Il segnale viaggia           │
│     istantaneamente dal file al doc senza analisi semantica.    │
│                                                                  │
│  L1 RIFLESSO — reflex guard passivo (PostToolUse)               │
│     Arco riflesso: file modificato → lookup registry →          │
│     segnale immediato al SUPERVISOR. Automatico, <1s.           │
│     Log: <istanza>-DOC/audit/ssot_nerve_signals.log             │
│                                                                  │
│  L1b AUTO-UPDATE — [ARCHIVIATO: hook auto-update]               │
│     Rimosso (anti-pattern 6: solo metadati senza verifica).     │
│     Responsabilita trasferita a DOC-SYNC v2 Step 5b: aggiorna   │
│     last_verified SOLO dopo verifica semantica + RAG confermato.│
│     Hook originale M-132. Archiviato post M-160b (2026-05-08).  │
│                                                                  │
│  L2 PROPRIOCEZIONE — Mission Registry esteso                    │
│     Campi: doc_sync_executed, doc_verified, files_modified      │
│     L'organismo sa quali doc dovrebbero essere aggiornati       │
│     e se la verifica post-mission è avvenuta.                   │
│                                                                  │
│  L3 AUTONOMO — cron di staleness (04:00)                        │
│     Cron attivo: ogni notte alle 04:00 (tutti gli organi).     │
│     145 documenti SSOT registrati e monitorati.                 │
│     Script bash per check leggero basato su timestamp+git.     │
│     agente living archiviato (2026-05-08): funzionalita        │
│     assorbita da DOC-SYNC v2. Report: <istanza>-DOC/audit/drift/│
├─────────────────────────────────────────────────────────────────┤
│  LAYER 7 — CONTRACTS                                            │
│  <istanza>-DOC/contracts/*.json → contratti machine-readable    │
│  Validabili automaticamente dal GATE e dagli agenti             │
│  core.egis · core.users · egili.rules · algorand.patterns       │
│  interface.HasAggregations · core.ai_feature_pricing            │
│  credential.schema                                              │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 6 — GATE  ★ NUOVO                                        │
│  os3-gate agent  →  validatore AI pre-push                      │
│  Legge CONTRACTS + diff → PASS / WARN / BLOCK                   │
│  /gate command  →  attivabile dal pilota                        │
│  ~95% cattura violazioni (vs ~60% grep-based)                   │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 5 — KNOWLEDGE (compressed 2026-05-25, -55% token)        │
│  CLAUDE_ECOSYSTEM_CORE.md  →  regole P0 compresse (auto-loaded) │
│  CLAUDE.md per organo      →  overlay specifico compresso       │
│  CLAUDE_ECOSYSTEM_REF.md   →  dettagli estesi (on-demand Read)  │
│  MEMORY.md                 →  memoria persistente cross-sessione│
│  *.human.md                →  backup leggibili per CEO          │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 4 — PREVENTION (19 PreToolUse hooks)                     │
│  Write|Edit: cross-project-guard, os3-preflight-guard,          │
│    legacy-guard, immutable-values-guard, mica-guard,            │
│    hardcoded-strings-guard, check-no-legacy-stack,              │
│    seo-public-content-guard, p04-method-guard,                  │
│    organ-index-guard, coverage-check-precheck                   │
│  Bash: rm-guard, git-main-guard, env-guard,                    │
│    doc-sync-v2-guard, mission-report-guard,                     │
│    mission-stats-guard, web-quality-gate-guard                  │
│  Agent: os3-mission-reinject                                    │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 3 — DETECTION (6 PostToolUse hooks)                      │
│  Write|Edit: os3-audit-static, ssot-reflex-guard               │
│  Bash: deploy-pipeline-guard, m094-supervisor-reminder          │
│  TodoWrite: os3-audit-on-complete                               │
│  Read|Bash|Write|Edit: mission-read-tracker                     │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 2 — DEEP AUDIT (periodico / on-demand)                   │
│  deep-audit (privato)    →  scansione grep completa tutti organi│
│  agente di audit AI      →  analisi contestuale                 │
│  agente gap-scout        →  diagnostica gap evolutivi per organo│
│  oracode-alignment-interp→  verità semantica/intenzionale organo│
│  Report: <istanza>-DOC/audit/ → storico audit con timestamp     │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 1 — SYNC (DOC-SYNC v2 — automatico a chiusura mission)   │
│  doc-sync-v2 agent      →  sincronizza SSOT via analisi semant.│
│  <istanza>-DOC/docs/     →  SSOT documentazione tutti gli organi│
└─────────────────────────────────────────────────────────────────┘
```

---

## Componenti Implementati

### Hook System

L'enforcement runtime usa **hook** stratificati per momento di intervento. Questo è il **modello**
per categoria; l'**inventario concreto** (nomi file, versioni, trigger esatti) è `visibility:private`
nell'OS3 Matrix — SSOT `oracode-nexus-index-impl`. Confine mono (M-OS3-048).

- **PreToolUse / Write|Edit** — guardie che bloccano o avvisano *prima* di scrivere codice:
  coerenza cross-organo, P0 contestuali, file legacy, valori immutabili, compliance di dominio,
  stringhe hardcoded, stack vietati, SEO contenuti pubblici, esistenza metodi/Organ Index, coverage SSOT.
- **PreToolUse / Bash** — guardie su comandi rischiosi: secrets/`.env`, push su `main`, `rm`,
  push doc senza DOC-SYNC, completezza report/stats di mission, gate qualità web.
- **PreToolUse / Agent** — reiniezione del contesto mission allo spawn di un sotto-agente.
- **PostToolUse** — segnali e analisi *dopo* l'operazione: analisi statica OS3, riflesso passivo
  SSOT (Sistema Nervoso L1), report findings a task completato, verifica pipeline post-push,
  tracking accessi filesystem.
- **Cron / manuale** — reti di sicurezza periodiche: staleness SSOT (L3), deep-audit notturno.

### Knowledge Base

| File | Scopo |
|------|-------|
| `/home/fabio/*/CLAUDE_ECOSYSTEM_CORE.md` | Regole P0 universali compresse — auto-caricato via `@` (~1.6k token) |
| `/home/fabio/*/CLAUDE.md` | Overlay specifico per organo compresso (~1k token) |
| `/home/fabio/*/CLAUDE_ECOSYSTEM_REF.md` | Dettagli estesi (organi, Egili, remediation, agenti) — Read on-demand, non auto-caricato |
| `/home/fabio/*/CLAUDE.md.human.md` | Backup leggibile CLAUDE.md per CEO — zero token cost |
| `/home/fabio/*/CLAUDE_ECOSYSTEM_CORE.md.human.md` | Backup leggibile CORE per CEO — zero token cost |
| `/home/fabio/.claude/projects/*/memory/MEMORY.md` | Memoria persistente cross-sessione (~1.8k token) |

### Agenti Specializzati

L'organismo di livello 2+ si avvale di **agenti** specializzati (sotto-istanze LLM con scope
definito), coordinati dal Supervisor. Categorie tipiche: audit/conformità OS3, gate pre-push,
diagnostica gap d'organo, allineamento semantico, consulenza dottrina, DOC-SYNC, specialisti di
dominio/linguaggio, CFO. L'**inventario concreto** (roster, file sorgente) è `visibility:private`
nell'OS3 Matrix — SSOT `oracode-nexus-index-impl`.

> Le skill built-in di Claude Code (es. laravel/python/frontend) non sono agent globali; ogni
> organo può personalizzarli con un `.claude/agents/<name>.md` locale.

### Deep Audit

L'organismo dispone di uno **scan grep completo** cross-organo (rete di sicurezza periodica) e di
un **audit AI contestuale** via agente specializzato. Comandi, path e schedule concreti dello
scanner sono `visibility:private` nell'OS3 Matrix — SSOT `oracode-nexus-index-impl`. I report di
audit vivono nell'`<istanza>-DOC/audit/` con timestamp. L'audit AI si invoca dall'agente di audit
nel prompt.

---

## Cosa Manca (Roadmap LSO)

### Priorità Alta
- [x] ~~**CONTRACTS (Layer 7)**~~ — contratti JSON creati, in `<istanza>-DOC/contracts/` (es. EGI-DOC/)
- [x] ~~**GATE (Layer 6)**~~ — agente `os3-gate` + command `/gate` creati
- [x] ~~**Agenti diagnostici**~~ — `organ-gap-scout` + `oracode-alignment-interpreter` creati (solo report, PENDING_BRAIN_APPROVAL)
- [x] ~~**NERVOUS SYSTEM (Layer 8)**~~ — M-025: SSOT Registry + reflex hook + propriocezione Mission Registry + living agent + cron script. 4 sub-layer ispirati al sistema nervoso umano. Health Score operativo.
- [x] ~~**Cron periodico**~~ — cron di staleness SSOT (04:00) + deep-audit (03:00), ogni notte via crontab
- [ ] **Audit differenziale** — confronta l'ultimo report con il precedente, mostra solo i nuovi finding
- [ ] **Dashboard LSO** — pagina di statistiche dell'istanza (es. EGI-STAT su FlorenceEGI) che visualizza LSO Score per organo in tempo reale
- [ ] **Notifiche** — alert su Slack/email quando audit trova finding critici
- [x] ~~**SSOT Registry completo**~~ — documenti registrati per gli organi dell'istanza (es. FlorenceEGI: 17 documenti — NATAN_LOC (6), EGI (2), EGI-HUB (2), Credential (1), Sigillo (2), ecosistema (4)). Primo audit semantico eseguito su NATAN_LOC (Health Score 35%)

### Priorità Media
- [ ] **GitHub Actions** — esegui il deep-audit + GATE ad ogni PR, blocca merge su BLOCK
- [ ] **Auto-remediation** — agente che propone e applica fix per finding standard
- [ ] **Pilot Console completa** — `/health`, `/audit [organo]`, `/new-organ [nome]`, `/onboard`
- [ ] **GATE integrato in pre-push hook** — attivazione automatica senza `/gate` manuale

### Priorità Bassa
- [ ] **LSO Score** — punteggio 0-100 di conformità OS3 per organo, storicizzato
- [ ] **Trend chart** — grafico nella dashboard statistiche dell'istanza (es. EGI-STAT) con andamento LSO Score nel tempo
- [ ] **Cross-organ dependency check** — verifica Interface stabili non modificate senza consenso
- [ ] **Semantic audit** — analisi AI dei commit per violazioni logiche non catturabili da grep

---

## La Mente dell'Organismo

LSO non è solo infrastruttura di enforcement (hook, gate, audit). Ha una **mente**: un circuito che rende l'intero ecosistema interrogabile come un unico interlocutore.

### Il circuito SSOT → RAG → ai_sidebar

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│   <istanza>-DOC/docs/  (es. EGI-DOC/)                      │
│   (SSOT di tutto l'ecosistema)                             │
│       ↓                                                    │
│   Indicizzazione → schema rag_<istanza>.* (es. rag_natan)  │
│   (documents, chunks, embeddings, categories)              │
│       ↓                                                    │
│   RAG di piattaforma                                       │
│   (knowledge base condiviso, generico, multi-categoria)    │
│       ↓                                                    │
│   ai_sidebar con chat                                      │
│   (presente in OGNI organo dell'ecosistema)                │
│       ↓                                                    │
│   Utente parla con l'organismo                             │
│   (risposte contestuali al progetto + ecosistema)          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Come funziona

1. **SSOT come fonte di verità** — Tutta la documentazione dell'ecosistema vive nel repo SSOT dell'istanza (`<istanza>-DOC/docs/`, es. EGI-DOC/). Ogni organo ha la propria area. Ogni modifica al codice genera un DOC-SYNC che aggiorna i doc corrispondenti.

2. **RAG piattaforma (`rag_<istanza>.*`, es. rag_natan su FlorenceEGI)** — Gli SSOT vengono indicizzati nello schema `rag_<istanza>.*` del database condiviso. Questo schema è generico (documents, chunks con embedding vector, categories gerarchiche, metadata JSONB) e accoglie documentazione di qualsiasi dominio.

3. **ai_sidebar in ogni organo** — Ogni organo dell'ecosistema ha una sidebar AI con chat (es. su FlorenceEGI: `SigilloAdvisorService`, `CredentialAdvisorService`, ecc.). Tutte consumano lo stesso RAG piattaforma via `RagNatan\SearchService`.

4. **Risposte contestuali** — La sidebar risponde prima nel contesto del progetto in cui si trova (es. "come certifico un file?" su Sigillo), poi su qualsiasi domanda pertinente all'intero ecosistema (es. "cosa sono gli Egili?" da qualsiasi organo).

### Perché è "Living"

L'organismo non è solo codice che si auto-corregge. È un sistema con cui puoi **parlare**. Gli SSOT sono il suo "super white paper" sempre aggiornato, disponibile a tutti, interrogabile in linguaggio naturale da ogni punto dell'ecosistema.

Quando un doc viene aggiornato (DOC-SYNC), il RAG si aggiorna. Quando qualcuno chiede qualcosa alla sidebar, riceve la verità corrente dell'organismo — non una risposta statica scritta mesi fa.

Questo è ciò che rende LSO un organismo vivente: **sa cosa è, e te lo può dire**.

### RAG multipli specializzati

L'ecosistema non ha un solo RAG. Ha RAG specializzati per dominio, ciascuno ottimizzato per il proprio contesto:

| Schema | Dominio | Usato da |
|--------|---------|----------|
| `rag_<istanza>.*` (es. rag_natan) | Piattaforma (SSOT ecosistema) | ai_sidebar di tutti gli organi |
| `natan.rag_*` (schema RAG di un organo, es. su NATAN_LOC) | PA verticale (atti comunali) | NATAN_LOC USE Pipeline |
| `marketing_rag.*` | NPE/marketing (catalogo arte) | Narrative Promotion Engine (es. su FlorenceEGI) |

Il RAG piattaforma (`rag_<istanza>.*`, es. rag_natan) è la **mente condivisa**. Gli altri RAG sono organi sensoriali specializzati.

---

## Il Sistema Nervoso Documentale (v5.0.0 — DOC-SYNC v2)

Il DOC-SYNC v1 dipendeva dalla disciplina dell'agente in sessione: se il SUPERVISOR dimenticava, il doc non si aggiornava. DOC-SYNC v2 risolve il problema: l'agent `doc-sync-v2` sincronizza automaticamente i SSOT alla chiusura di ogni mission, con analisi semantica, discovery laterale via RAG, e re-indexing sincrono bloccante.

### Analogia biologica

| Sistema Nervoso Umano | Equivalente LSO | Implementazione |
|----------------------|------------------|-----------------|
| **Guaina mielinica** — accelera la trasmissione nervosa | **SSOT Registry** — mapping esplicito file→doc | `SSOT_REGISTRY.json` |
| **Nocicettori** — rilevano danno dove avviene | **ssot-reflex-guard** — rileva modifica a file watchati | Hook PostToolUse |
| **Arco riflesso** — risposta automatica senza cervello | **Segnale immediato** al SUPERVISOR | Output hook in sessione |
| **Propriocezione** — sapere dove sei senza guardare | **Mission Registry esteso** — l'organismo sa il suo stato | Campi `doc_sync_executed`, `doc_verified` |
| **Sistema autonomo** — respira senza pensarci | **DOC-SYNC v2** — sincronizzazione automatica a chiusura mission | Agent `doc-sync-v2` |
| **Dolore acuto** — ritiri la mano dal fuoco | **Segnale in-session** — impossibile ignorare | Hook output |
| **Dolore cronico** — problema strutturale persistente | **Drift report** — score che cresce nel tempo | `<istanza>-DOC/audit/drift/` (es. EGI-DOC/) |

### I 4 sub-layer

```
LAYER 0 — MIELINA (mapping statico)
  SSOT_REGISTRY.json → ogni doc SSOT dichiara quali file watcha
  Frontmatter docs   → ssot_nervous.ssot_id punta al registry
  Senza mielina il segnale è lento (analisi semantica).
  Con mielina il segnale è istantaneo (lookup JSON).

LAYER 1 — RIFLESSO (sincrono, in-session)
  reflex guard passivo → PostToolUse hook su Write|Edit (secondario)
  File modificato → lookup registry → doc SSOT watchanti → segnale passivo
  Tempo: <1 secondo. Costo AI: zero. Rete di sicurezza.
  Log: <istanza>-DOC/audit/ssot_nerve_signals.log (es. EGI-DOC/)

LAYER 2 — PROPRIOCEZIONE (Mission Registry + DOC-SYNC v2)
  Ogni missione registra:
    files_modified    → lista esplicita dei file toccati
    doc_sync_executed → true automaticamente da DOC-SYNC v2
    doc_sync_version  → "2.0.0"
    doc_sync_log      → JSON completo con outcome, SSOT impattati, audit trail
    doc_verified      → confermato da sanity check RAG
  DOC-SYNC v2 agent esegue automaticamente a Mission Phase 6:
    Step 1: Analisi semantica diff → Step 2: SSOT diretti (registry) →
    Step 3: Discovery laterale (RAG) → Step 4: Patch additivo/sostitutivo →
    Step 5: Re-indexing RAG sincrono + sanity check bloccante →
    Step 5b: Aggiornamento metadati SSOT_REGISTRY (last_verified, verified_in_mission) →
    Step 6: Audit trail completo

  PONTE AUTOMATICO L1→L3 (FATTO): la registrazione mission→registry non
  dipende più dalla disciplina dell'operatore. `bin/mission` auto-registra
  ogni mission nel MISSION_REGISTRY dell'istanza (L3), risolvendo
  `.oracode/project.json` risalendo dal CWD (`syncToRepoRegistry`). Lo stato
  della state machine in `~/oracode-engine/` (L1) viene propagato 1:1 nel
  registry del progetto a ogni transizione. La vecchia sincronizzazione
  manuale state↔registry e le "mission fantasma" sono SUPERATE; il ponte è
  parallel-safe via lockfile. Chiavi del registry in INGLESE
  (`id/title/type/organs/status/date_open/date_close`).

LAYER 3 — RETE DI SICUREZZA (asincrono, cron/manuale)
  cron di staleness → verifica leggera basata su timestamp e git log
  guard DOC-SYNC → blocca push <istanza>-DOC se mission senza doc_sync_log
  Report: <istanza>-DOC/audit/drift/ + <istanza>-DOC/audit/doc_sync/<mission_id>/ (es. EGI-DOC/)
```

### Come i layer si compensano

Con DOC-SYNC v2, la sincronizzazione non dipende piu dalla disciplina dell'operatore:

```
Un file di codebase viene modificato in una mission:

  Layer 1 (riflesso)  → segnala IN SESSIONE che il file è watchato (passivo)

  Layer 2 (DOC-SYNC v2) → alla chiusura della mission (Phase 6),
                            l'agent doc-sync-v2 analizza il diff,
                            identifica SSOT impattati (diretti + laterali),
                            discrimina additivo/sostitutivo,
                            applica patch (con approvazione per sostitutivo),
                            re-indicizza RAG piattaforma (sincrono + sanity check),
                            scrive audit trail completo.
                            La mission NON chiude senza doc_sync_log.

  Layer 3 (rete sicurezza) → ssot-living-check cattura drift da bypass/chiusure forzate.
                              doc-sync-v2-guard blocca push <istanza>-DOC senza doc_sync_log.

Il drift deve "scappare" da DOC-SYNC v2 automatico E dalla rete di sicurezza.
```

### File e componenti

| File | Tipo | Funzione |
|------|------|----------|
| `<istanza>-DOC/docs/lso/SSOT_REGISTRY.json` (es. EGI-DOC/) | Registry | Mapping doc→file watchati (Layer 0) |
| reflex guard passivo (privato) | Hook | Segnale riflesso passivo PostToolUse (Layer 1, secondario) |
| agente DOC-SYNC (privato) | Agente | DOC-SYNC v2: sincronizzazione automatica SSOT (Layer 2, primario) |
| CLI RAG re-index (enforcement L1, privato) | CLI Python | Re-indexing SSOT in RAG piattaforma (Layer 2) |
| CLI RAG query (enforcement L1, privato) | CLI Python | Discovery laterale SSOT via query vettoriale (Layer 2) |
| guard DOC-SYNC (privato) | Hook | Blocca push `<istanza>-DOC` senza doc_sync_log (Layer 3) |
| cron di staleness (privato) | Script | Check leggero cron/manuale (Layer 3, rete sicurezza) |
| `<istanza>-DOC/docs/missions/MISSION_REGISTRY.json` (es. EGI-DOC/) | Registry | Propriocezione (Layer 2) |
| `<istanza>-DOC/audit/doc_sync/<mission_id>/` | Audit | Audit trail DOC-SYNC v2 per mission |
| `<istanza>-DOC/audit/drift/` | Report | Storico drift report |
| `<istanza>-DOC/audit/ssot_nerve_signals.log` | Log | Storico segnali nervosi |

> **Collocazione tool (Oracode Nexus).** I tool Python di re-index/query RAG e il Mission Engine vivono nell'**enforcement L1 (OS3 Matrix, repo privato)**, **non** in `~/oracode/bin/` (paradigma: regole, docs, templates). Il Mission Engine (`bin/mission`) tiene lo stato runtime in `~/oracode-engine/` — la cartella globale **visibile** di Livello 1 (`ORACODE_HOME`), non un registro versionato. Il symlink di compat `~/.oracode → ~/oracode-engine` resta per retrocompatibilità.

### Componenti archiviati (v1 → v2 migration, 2026-04-30)

| File | Destinazione | Motivo archiviazione |
|------|-------------|---------------------|
| hook auto-update (archiviato) | archivio enforcement | Anti-pattern: aggiornava solo metadati senza contenuto |
| agente living (archiviato) | archivio enforcement | Capacita integrate in doc-sync-v2 |
| `doc-sync-guardian.md` | `EGI-DOC/docs/egi-team/_archived/` | Agente predecessore DOC-SYNC v1, sostituito da doc-sync-v2 (M-160b) |

### Specifiche DOC-SYNC v2

| Documento | Path |
|-----------|------|
| Specifica operativa | `oracode/docs/paradigm/doc-sync/DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` |
| Piano implementativo | `oracode/docs/paradigm/doc-sync/DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md` |

### Uso

```bash
# DOC-SYNC v2 e' automatico — invocato da Mission Phase 6
# Non serve invocazione manuale per mission standard

# Check leggero (cron o manuale) — rete di sicurezza
#   eseguito dal cron di staleness dell'enforcement (impl privata OS3 Matrix),
#   opzionale per singolo organo. DOC-SYNC v2 a Mission Phase 6 resta automatico.
```

---

## Il Ciclo Vitale LSO (v4.0.0)

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│   WRITE CODE                                           │
│       ↓                                                │
│   PreToolUse hooks → bloccano / avvisano su P0         │
│       ↓                                                │
│   codice scritto                                       │
│       ↓                                                │
│   PostToolUse audit-static → analisi pattern immediata │
│   PostToolUse ssot-reflex  → segnale passivo doc SSOT  │
│       ↓                                                │
│   task completato (TodoWrite)                          │
│       ↓                                                │
│   audit-on-complete → report sessione                  │
│       ↓                                                │
│   Mission Phase 6 → DOC-SYNC v2 agent (automatico)    │
│     → analisi semantica → SSOT diretti + laterali     │
│     → patch additivo/sostitutivo → RAG re-index       │
│     → audit trail completo                             │
│       ↓                                                │
│   Mission Registry → doc_sync_log + doc_sync_version  │
│       ↓                                                │
│   [periodico] SSOT Living Check → drift report         │ ← NUOVO
│       ↓                                                │
│   [periodico] deep-audit → report completo             │
│       ↓                                                │
│   findings → remediation tasks → nuovi commit          │
│       ↑                                                │
│       └────────────────────────────────────────────────┘
```

---

## Gli Organi dell'Organismo (caso esemplare: FlorenceEGI)

Stato degli organi in produzione ad aprile 2026. Tassonomia: `IN PRODUZIONE` (pubblico, online, utilizzabile) · `ONLINE / PARZIALE` (pubblico, non completo) · `IN SVILUPPO INTERNO` (privato) · `SOLO ARCHITETTURA` (documentato, non deployato) · `ROADMAP APPROVATA` (concept approvato).

### Organi IN PRODUZIONE

| Organo | URL | Path | Funzione |
|--------|-----|------|----------|
| **EGI-HUB** | hub.florenceegi.com | `/home/fabio/EGI-HUB` | Cervello frontale — control plane, config di tutti gli organi |
| **EGI-HUB-HOME** | florenceegi.com | `/home/fabio/EGI-HUB-HOME-REACT` | Vetrina 3D world-class — punto di accesso pubblico ecosistema |
| **EGI** | art.florenceegi.com | `/home/fabio/EGI` | Cuore operativo: AMMk + backend condiviso + host prodotti |
| **NATAN_LOC** | natan-loc.florenceegi.com | `/home/fabio/NATAN_LOC` | Organo cognitivo documentale — RAG su atti PA + AI per Comuni |
| **Sigillo** | egi-sigillo.florenceegi.com | FE: `/home/fabio/EGI-SIGILLO` · BE: `/home/fabio/EGI` | Certificazione blockchain di file (SHA-256 + Algorand + TSA RFC 3161) |
| **EGI-Credential** | egi-credential.florenceegi.com | `/home/fabio/EGI-Credential` | Wallet competenze professionali certificate su Algorand (W3C VC 2.0) |
| **EGI-INFO** | info.florenceegi.com | `/home/fabio/EGI-INFO` | SPA informativa pubblica FlorenceEGI |
| **CREATOR-STAGING** | creator-staging.florenceegi.com | `/home/fabio/CREATOR-STAGING` | Configuratore sito creator + template madre |

### Organi in Sviluppo / Interni

| Organo | Status | Path | Funzione |
|--------|--------|------|----------|
| **La Bottega** | IN PROGETTAZIONE | `/home/fabio/LA-BOTTEGA` | Strumenti sviluppo artista + valutazione collezionisti |
| **EGI-STAT** | IN SVILUPPO INTERNO | `/home/fabio/EGI-STAT` | Dashboard produttivita sviluppatori (GitHub metrics) |
| **EGI-SALES** | IN SVILUPPO INTERNO | `/home/fabio/EGI-SALES` | Strumenti vendita ecosistema |

> Il deep-audit (impl privata) copre tutti gli organi sopra (nell'esempio FlorenceEGI: 8 produzione + 3 sviluppo/interni = 11 monitorati).

### Organi in Architettura / Roadmap

| Organo | Status | Note |
|--------|--------|------|
| **EGI Proof** | SOLO ARCHITETTURA | Layer sociale LSO — Function Cards, Feed |
| **Sigillo Contratti** | ROADMAP APPROVATA | Certificazione contratti |
| **Sigillo Comunicazioni** | ROADMAP APPROVATA | Certificazione comunicazioni |
| **Data Room Blockchain** | ROADMAP APPROVATA | Storage certificato |
| **Perito AI** | ROADMAP APPROVATA | Perizia automatizzata |
| **Compliance Checker** | ROADMAP APPROVATA | Verifica conformita |
| **Eredita Digitale** | ROADMAP APPROVATA | Gestione successoria digitale |

Tutti gli organi futuri nascono coordinati dall'hub dell'organismo (es. EGI-HUB su FlorenceEGI). Infrastructure 80-99% riuso.

---

## Riferimenti

- Regole OS3 compresse (auto-loaded): `/home/fabio/*/CLAUDE_ECOSYSTEM_CORE.md`
- Dettagli estesi (on-demand): `/home/fabio/*/CLAUDE_ECOSYSTEM_REF.md`
- Versioni leggibili CEO: `/home/fabio/*/CLAUDE*.human.md`
- Hook/agenti enforcement: deployati sotto `~/.claude/` (inventario privato OS3 Matrix)
- Report audit: `<istanza>-DOC/audit/` (es. /home/fabio/EGI-DOC/audit/)
- Report drift SSOT: `<istanza>-DOC/audit/drift/` (es. /home/fabio/EGI-DOC/audit/drift/)
- SSOT Registry (Layer 0 Mielina): `<istanza>-DOC/docs/lso/SSOT_REGISTRY.json` (es. /home/fabio/EGI-DOC/)
- Mission Registry (Layer 2 Propriocezione): `<istanza>-DOC/docs/missions/MISSION_REGISTRY.json` (es. /home/fabio/EGI-DOC/)
- Settings Claude Code: `/home/fabio/.claude/settings.json`
- Memoria di un organo (es. NATAN_LOC): `/home/fabio/.claude/projects/-home-fabio-NATAN-LOC/memory/MEMORY.md`
