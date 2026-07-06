---
title: "Gerarchia Oracode Nexus — Stato Corrente (correzione della cornice «accoppiato»)"
slug: nexus-hierarchy-current-state
doc_type: architecture
version: "1.0.0"
status: current
date: "2026-07-06"
author: "Padmin D. Curtis (Supervisor-CTO) per Fabio Cherici (CEO)"
scope: [oracode]
rag_indexed: true
priority: high
mission: M-OS3-138
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

> **Perché questo doc.** La cornice «FlorenceEGI/EGI-DOC = HUB+istanza *accoppiato*, *caso unico*; L2 *differito* finché non arrivano 2+ clienti» risale a maggio 2026 ed è **superata dai fatti**. Ha già indotto in errore l'analisi (confondere FlorenceEGI-prodotto con la software house). Questo doc fissa lo **stato corrente** e **depreca** le clausole di stato stale elencate in frontmatter. **NON** depreca le *definizioni core* di L1/L2/L3 (restano valide): depreca solo i **claim di stato**.

## I fatti che superano la vecchia cornice
- Il **disaccoppiamento** degli artefatti L1 dall'organismo FlorenceEGI è **fatto**: gli hook/agenti risolvono i root a runtime (`{{instance_root}}`/`{{engine_root}}`/`{{paradigm_root}}`), zero path FlorenceEGI baked (`ROADMAP_ORACODE.md:111`, M-OS3-031/036/040). Girano su qualsiasi organismo.
- Le **istanze L3-clienti sono già molte**, non una: ledger perpetui reali per **FlorenceEGI, Capasso, LeVespe, DeepDebug** (+ descrittori Pinocapasso, FABIO-GIANNI, SNC…). Quindi «caso unico / serve a 2+ clienti» è **falso**.
- **Florence EGI S.R.L. è la software house acquirente (L2)** con licenza d'uso di Oracode Nexus (codename *Magicsoft 2.0*, `ROADMAP_ORACODE.md:37`). L2 **esiste** come entità/ruolo; ciò che manca è solo l'**artefatto** HUB-DOC aggregatore (`mission-hub-aggregate.py` non ancora costruito) — un gap di *implementazione*, non «L2 non esiste».

## Il modello corrente (metro unico)

| Livello | Cos'è | Cross-repo di una sua mission |
|---|---|---|
| **L1** | Lo **strumento**: `oracode` (paradigma, MIT) + `os3-matrix` (enforcement) + `~/oracode-engine` (motore). «Cosa gira adesso». | **Globale** — qualunque organo di qualunque LSO (è il tool che enforcea ovunque). |
| **L2** | La **software house acquirente** con licenza Nexus = **Florence EGI S.R.L.** (*Magicsoft 2.0*). Tiene l'HUB: statistiche consolidate + numerazione globale su **tutti** i suoi LSO-clienti. | (concerne registry/stat/numerazione, non lo span di commit) |
| **L3** | Un **LSO/cliente** generato dalla software house. Due forme ↓ | vedi sotto |
| **↳ L3 mono-organo** | LSO a singola applicazione. | **Contenuto** al proprio repo. |
| **↳ L3-hub** | Il **repo core di un LSO multi-organo** (es. **EGI-DOC** per FlorenceEGI). | **Ristretto agli organi del proprio LSO** (una mission aperta sul core spazia negli organi di *quel* LSO multi-organo). |
| **↳ organo di L3-hub** | Un organo membro di un LSO multi-organo (EGI, EGI-HUB, EGI-Credential, …). | **Contenuto** al proprio repo. |

**Regola cross-repo (tre casi):**
1. **Mission L1** (oracode/os3-matrix) → qualunque organo/LSO.
2. **Mission L3-hub** (repo core di un LSO multi-organo) → gli **organi del proprio LSO** (dichiarati in `organs[]`, ⊆ organi di quell'LSO).
3. **Mission L3** (mono-organo o singolo organo) → il **proprio** repo.

> **EGI-DOC = L3-hub di FlorenceEGI.** NON è L2 (L2 = Florence EGI S.R.L. software house, sopra *tutti* i clienti), NON è L3 puro. È il core del solo LSO multi-organo FlorenceEGI.

## Rapporto con `ORACODE_NEXUS_3_TIER.md` (🔒 LOCKED)
Le **definizioni** di L1/L2/L3 del 3_TIER (strumento / softwarehouse-HUB / istanza) **restano valide e non si toccano**. Sono superate solo le sue **clausole di stato** (accoppiato/caso-unico/differito), perché i fatti sono cambiati (disaccoppiamento fatto + N clienti). Aggiunta di questo doc: il concetto **L3-hub** per il caso multi-organo (direttiva CEO 2026-07-06).

## Il campo `level` dei descrittori
Il campo `level` in `.oracode/project.json` **non** codifica il tier Nexus: codifica il *livello di maturità/applicazione* Oracode (cfr. `CLAUDE_ORACODE_CORE.md:327`, Layer Stack) — un **altro asse** (valori 1–4; FlorenceEGI=2, os3-matrix=3, EGI=4, impossibili nel 3-tier) e **nessun guard lo legge**. Il tier operativo (L1/L2/L3/L3-hub) va codificato in un campo dedicato **`tier`** (design in M-OS3-138); si valuta di rinominare `level`→`maturity_level` per non collidere.

---
*Stato corrente gerarchia Oracode Nexus — M-OS3-138 (Fabio Cherici / Padmin D. Curtis) — 2026-07-06. Depreca le clausole di stato elencate in frontmatter; non le definizioni core.*
