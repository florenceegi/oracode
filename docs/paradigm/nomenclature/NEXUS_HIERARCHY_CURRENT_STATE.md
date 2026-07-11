---
title: "Gerarchia Oracode Nexus — Stato Corrente (correzione della cornice «accoppiato»)"
slug: nexus-hierarchy-current-state
doc_type: architecture
version: "2.0.0"
status: current
date: "2026-07-06"
updated_at: "2026-07-11"
author: "Padmin D. Curtis (Supervisor-CTO) per Fabio Cherici (CEO)"
scope: [oracode]
rag_indexed: true
priority: high
mission: M-OS3-138
updated_by_mission: "M-OS3-144 — cablaggio 6 ruoli (ratifica CEO 2026-07-11)"
supersedes_clauses:
  # Clausole di STATO superate (NON le definizioni core L1/L2/L3, che restano valide):
  - "ORACODE_NEXUS_3_TIER.md:88,106,127,161,162 (LOCKED — clausole di stato accoppiato/differito)"
  - "kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md:31,45,230,257"
  - "ssot/ORACODE_NEXUS_SYSTEM_REFERENCE.md:373,520,563,721,737"
  - "missions/MISSION_PROTOCOL.md:56,61,131,231,548"
  - "standards/NAMING_STANDARD_CODE.md:23,237,254,266,278"
  - "standards/LEGACY_STACK_POLICY.md:14,123,139"
  - "index/Oracode-Nexus-index.md:43,135"
  - "roadmap/ROADMAP_ORACODE.md:35,37"
  - "nomenclature/LSO_NOMENCLATURE_v2.md:1072,1085,1158"
  - "nomenclature/proposals/M-NOMENCL-OSMX-002_DELTA.md:16"
  - "index/SSOT_NEXUS_COHERENCE_AUDIT_2026-05-31.md:146,157,179,195,201,206,217,232,268,270 (riscritto)"
  - "os3-matrix/docs/stats/STATS_SYSTEM_SSOT.md:543-546,575-579,821-859"
  - "os3-matrix/docs/tech-specs/READ_TRACKING_TECH_SPEC.md:37-38,64-65,95-96,313"
  - "os3-matrix/docs/tech-specs/RETROSPECTIVE_TECH_SPEC.md:41-42"
  - "os3-matrix/docs/design/STATS_HUB_L2_HANDOFF.md:15,29,39"
  - "os3-matrix/docs/design/SESSION_3_HANDOFF_TO_NEXT.md:116,173,191,226,266"
  - "os3-matrix/docs/doc-sync/DOC-SYNC_v2_STATO_DELLARTE.md:30"
  - "os3-matrix/docs/adr/M-OS3-138_ADR_gerarchia_operativa_L1.md (rifatto sulla base corretta)"
  - "nexus-cockpit/backend/aggregate_to_sqlite.py:202 (docstring)"
---

# Gerarchia Oracode Nexus — Stato Corrente

> **Perché questo doc.** La cornice «FlorenceEGI/EGI-DOC = HUB+istanza *accoppiato*, *caso unico*; L2 *differito* finché non arrivano 2+ clienti» risale a maggio 2026 ed è **superata dai fatti**. Ha già indotto in errore l'analisi (confondere FlorenceEGI-prodotto con la software house). Questo doc fissa lo **stato corrente** e **depreca** le clausole di stato stale elencate in frontmatter. **NON** depreca le *definizioni core* (restano valide): depreca solo i **claim di stato**.

> 🏷️ **Nomenclatura (decisioni CEO 2026-07-08 e 2026-07-11, ratificate — M-OS3-144).** I ruoli
> della gerarchia si nominano con parole, mai con numeri: **Paradigma · Softwarehouse ·
> Libreria LSO · Progetto · Organismo · Organo**. Le sigle L1/L2/L3 e T1/T2/T3 sono in
> pensione nei doc di nomenclatura; qui compaiono solo tra parentesi *(ex …)* come riferimento
> storico. Definizioni CEO (verbatim): **Organismo = un LSO multi-organo · Progetto = un LSO
> mono-organo · Organo = un LSO appartenente a un Organismo.** Il concetto coniato in questo
> doc come «L3-hub» (direttiva CEO 2026-07-06) è superato: si dice così — **FlorenceEGI è
> l'Organismo; EGI-DOC è il suo repo-centro.**

## I fatti che superano la vecchia cornice
- Il **disaccoppiamento** degli artefatti del **Paradigma** *(ex L1)* dall'organismo FlorenceEGI è **fatto**: gli hook/agenti risolvono i root a runtime (`{{instance_root}}`/`{{engine_root}}`/`{{paradigm_root}}`), zero path FlorenceEGI baked (`ROADMAP_ORACODE.md:111`, M-OS3-031/036/040). Girano su qualsiasi organismo.
- I **clienti sono già molti**, non uno: ledger perpetui reali per **FlorenceEGI, Capasso, LeVespe** (+ descrittori Pinocapasso, FABIO-GIANNI…). A parte stanno le **Librerie LSO della software house** (strumenti propri, non clienti): **DeepDebug, Fucina, Cockpit (nexus-cockpit), EGI-STAT (nexus), SNC** — corretto l'errore che elencava DeepDebug tra i clienti (ratifica CEO 2026-07-11). Quindi «caso unico / serve a 2+ clienti» è **falso**.
- **Florence EGI S.R.L. è la Softwarehouse** *(ex L2)*: la software house acquirente con licenza d'uso di Oracode Nexus (codename *Magicsoft 2.0*, `ROADMAP_ORACODE.md:37`). La Softwarehouse **esiste** come entità/ruolo; ciò che manca è solo l'**artefatto** HUB-DOC aggregatore (`mission-hub-aggregate.py` non ancora costruito) — un gap di *implementazione*, non «la Softwarehouse non esiste».

## Il modello corrente (metro unico)

| Ruolo | Cos'è | Cross-repo di una sua mission |
|---|---|---|
| **Paradigma** *(ex L1)* | Lo **strumento-legge**: `oracode` (paradigma, MIT) + `os3-matrix` (enforcement) + `~/oracode-engine` (motore). «Cosa gira adesso». | **Globale** — qualunque Organo di qualunque LSO (è il tool che enforcea ovunque). |
| **Softwarehouse** *(ex L2)* | L'**acquirente con licenza Nexus** = **Florence EGI S.R.L.** (*Magicsoft 2.0*). Tiene l'HUB: statistiche consolidate + numerazione globale su **TUTTA** la produzione — clienti E Librerie LSO (argomento CEO 2026-07-11). | (concerne registry/stat/numerazione, non lo span di commit) |
| **Libreria LSO** *(nuovo, 2026-07-11)* | Repo di **proprietà della software house**, al servizio di tutti i lavori, nessun cliente committente: **DeepDebug, Fucina, Cockpit (nexus-cockpit), EGI-STAT (nexus), SNC**. Il ruolo si dichiara alla creazione via `/project` (design M-OS3-144). | **Contenuto** al proprio repo (strumento, non commessa). |
| **Progetto** *(ex L3 mono-organo)* | **Un LSO mono-organo** (definizione CEO): sta per conto suo (es. Capasso). | **Contenuto** al proprio repo. |
| **Organismo** *(ex L3-hub)* | **Un LSO multi-organo** (definizione CEO): es. **FlorenceEGI**, il cui **repo-centro** è **EGI-DOC** (`ssot_home` = sé, gli Organi gli puntano). | Una mission aperta sul repo-centro è **ristretta agli Organi del proprio LSO**. |
| **Organo** *(ex organo di L3-hub)* | **Un LSO appartenente a un Organismo** (definizione CEO): EGI, EGI-HUB, EGI-Credential, … (`ssot_home` = il repo-centro dell'Organismo). | **Contenuto** al proprio repo. |

**Regola cross-repo (tre casi):**
1. **Mission del Paradigma** (oracode/os3-matrix) → qualunque Organo/LSO.
2. **Mission dell'Organismo** (aperta sul repo-centro, es. EGI-DOC) → gli **Organi del proprio LSO** (dichiarati in `organs[]`, ⊆ organi di quell'LSO).
3. **Mission di Progetto, di Organo o di Libreria LSO** → il **proprio** repo.

> **FlorenceEGI è l'Organismo; EGI-DOC è il suo repo-centro.** EGI-DOC NON è la Softwarehouse
> (= Florence EGI S.R.L., sopra *tutti* i clienti e le Librerie), NON è una Libreria LSO (non è
> uno strumento della software house: è il centro di un CLIENTE), NON è un Progetto. È il
> repo-centro del solo LSO multi-organo FlorenceEGI: gli Organi gli puntano via `ssot_home`.

## Rapporto con `ORACODE_NEXUS_3_TIER.md` (🔒 LOCKED)
Le **definizioni** del 3_TIER (strumento / softwarehouse / istanza) **restano valide e non si toccano**: si NOMINANO però coi ruoli — Paradigma, Softwarehouse (col corredo delle sue Librerie LSO), e per le istanze Progetto / Organismo / Organo (decisioni CEO 2026-07-08 e 2026-07-11). Il 3_TIER usa i nomi storici nel corpo (LOCKED): un banner in testa fa la traduzione. Sono superate solo le sue **clausole di stato** (accoppiato/caso-unico/differito), perché i fatti sono cambiati (disaccoppiamento fatto + N clienti). Il concetto qui coniato come «L3-hub» (direttiva CEO 2026-07-06) è superato: si dice **Organismo** (FlorenceEGI) e **repo-centro** (EGI-DOC).

## Il campo `level` dei descrittori
Il campo `level` in `.oracode/project.json` **non** codifica il ruolo Nexus: codifica il *livello di maturità/applicazione* Oracode (cfr. `CLAUDE_ORACODE_CORE.md:327`, Layer Stack) — un **altro asse** (valori 1–4; FlorenceEGI=2, os3-matrix=3, EGI=4, impossibili nei ruoli) e **nessun guard lo legge**. Il **ruolo** (Paradigma / Softwarehouse / Libreria LSO / Progetto / Organismo / Organo) va codificato in un campo dedicato **`role`**, **dichiarato alla creazione via `/project`** (design M-OS3-144, che supera il campo `tier` previsto da M-OS3-138); si valuta di rinominare `level`→`maturity_level` per non collidere.

---
*Stato corrente gerarchia Oracode Nexus — M-OS3-138 (Fabio Cherici / Padmin D. Curtis) — 2026-07-06. Cablaggio 6 ruoli: M-OS3-144, ratifica CEO 2026-07-11. Depreca le clausole di stato elencate in frontmatter; non le definizioni core.*
