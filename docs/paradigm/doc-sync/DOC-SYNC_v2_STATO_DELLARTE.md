---
visibility: public
rag: public
---

# DOC-SYNC v2 — Stato dell'Arte

> **Versione documento**: 1.0.0
> **Data**: 2026-05-15
> **Autore**: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
> **Fonte dati**: audit strutturale sessione 2026-05-15 (M-189)
> **Aggiornamento**: questo documento va aggiornato quando cambia lo stato operativo di un componente

---

## 1. Sintesi

DOC-SYNC v2 è il closing hook semantico della Mission Engine. Alla chiusura di ogni mission, garantisce che SSOT e RAG riflettano il codice modificato. Operativo in produzione dal 2026-05-08 (M-160a).

**Stato complessivo**: operativo con copertura parziale. Il ciclo core (analisi → patch → RAG → audit) funziona. La coverage nativa (v2.1.0) è stata completata il 2026-05-15 con il wiring dell'ultimo hook (M-189).

---

### Collocazione Oracode Nexus

> DOC-SYNC v2 è un meccanismo di **LIVELLO 3 (istanza LSO)** della gerarchia Oracode Nexus (paradigma + 3 livelli + ecosistema HUB/istanze): opera alla **chiusura mission del singolo progetto**, allineando il suo `MISSION_REGISTRY.json` e il suo RAG. Si innesta sul **ponte L1→L3** (`bin/mission` auto-registra/propaga lo stato via `<progetto>/.oracode/project.json`, FATTO con M-OS3-025 Unità 3).
>
> Le metriche di copertura/organi riportate in §3 sono dell'**istanza FlorenceEGI** (EGI-DOC), un'**istanza accoppiata HUB+istanza** ("caso unico" al 2026, perché ad oggi serve un solo cliente). Per **istanze nuove** la coverage è **per-progetto** e i path `~/.claude/...` / `EGI-DOC/...` qui citati vanno letti come **esempi d'istanza**, non come canone universale. Riferimento: `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

---

## 2. Componenti — Mappa operativa

| Componente | Path | Versione | Stato | Note |
|-----------|------|----------|-------|------|
| **Agent semantico** | `~/.claude/agents/doc-sync-v2.md` | v2.1.0 | Operativo | Spawned da Mission Phase 6 |
| **Guard enforcement** | `~/.claude/hooks/doc-sync-v2-guard.sh` | v4.0.0 | Operativo | Blocca push del repo-DOC dell'istanza (es. EGI-DOC su FlorenceEGI) senza doc_sync. 2 livelli |
| **Coverage hook** | `~/.claude/hooks/coverage-check-precheck.sh` | v2.1.0 | Operativo | Wired in settings.json M-189 (2026-05-15) |
| **CLI reindex** | `/home/fabio/os3-matrix/bin/rag_reindex.py` | — | Operativo | RAG re-indexing sincrono bloccante |
| **CLI query** | `/home/fabio/os3-matrix/bin/rag_query.py` | — | Operativo | Discovery laterale via RAG piattaforma |
| **CLI coverage** | `/home/fabio/oracode/bin/rag_natan_coverage.py` | v2.1.0 | Operativo | Misura copertura watch per organo |
| **Config soglie** | `<DOC-istanza>/docs/lso/COVERAGE_CONFIG.json` (es. EGI-DOC su FlorenceEGI) | — | Operativo | Soglie per organo + esclusioni |
| **Coverage history** | `~/.local/state/docsync_coverage_history.jsonl` | — | Operativo | Append-only, snapshot per run |
| **Cron settimanale** | `/home/fabio/oracode/bin/docsync_weekly_reglob.py` | — | **Non schedulato** | Script esiste, crontab vuoto |
| **Specifica** | `oracode/docs/paradigm/doc-sync/DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` | v2.1.0 | Aggiornato | Documento autoritativo |
| **Piano implementativo** | `oracode/docs/paradigm/doc-sync/DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md` | v2.1.0 | Aggiornato | Allineato in M-189 |

### Componenti archiviati (v1)

| Componente | Path | Stato |
|-----------|------|-------|
| `ssot-registry-auto-update.sh` | `~/.claude/hooks/archive/` | Archiviato — anti-pattern 6 (solo metadati) |
| `ssot-reflex-guard.sh` | `~/.claude/hooks/` | Attivo come rete secondaria (PostToolUse Write\|Edit, non blocca). v2.1.0 — **cross-repo** (M-OS3-028, chiude M-OS3-017): legge l'indice progetti `~/oracode-engine/projects.json`, aggrega le REPO_MAP di tutti i progetti e scandisce **tutti** gli `SSOT_REGISTRY`, segnalando anche i watcher cross-repo (SSOT del progetto A su codice del repo B). Eredita il de-coupling istanza di v1.1.0 (M-OS3-027): registry/nerve-log risolti via `.oracode/project.json`, no hardcode EGI-DOC |

---

## 3. Metriche di produzione (al 2026-05-15)

### Mission processate

| Metrica | Valore |
|---------|--------|
| Mission totali completate | 136 |
| Con `doc_sync_executed` | 100 (73.5%) |
| Con `doc_sync_log` strutturato (v2) | 24 |
| Con audit trail directory completa | 7 |
| Senza doc_sync | 44 (pre-v1, missioni antiche) |

### Post attivazione v2 (dal 2026-05-08)

| Metrica | Valore |
|---------|--------|
| Mission completate | 32 |
| Con `doc_sync_log` strutturato | 24 (75%) |
| Senza log strutturato | 8 (gap periodo 30/04–08/05, booleano v1) |

### Gap storico M-148..M-159

12 mission nel periodo 2026-04-30 → 2026-05-08 hanno `doc_sync_executed: true` senza `doc_sync_log` strutturato. Analizzate in M-189: 7 meta-mission LSO, 2 feature di un organo dell'istanza (es. EGI-Credential su FlorenceEGI) in costruzione, 1 bugfix puntuale. Decisione CEO: gap accettabile, nessuna retroazione.

### Coverage ecosistema

| Organo | Totale file | Coperti | % | Soglia | Stato |
|--------|------------|---------|---|--------|-------|
| LA-BOTTEGA | 181 | 141 | 77.9% | 50% | OK |
| CREATOR-STAGING | 183 | 133 | 72.7% | 50% | OK |
| EGI-HUB | 505 | 363 | 71.9% | 50% | OK |
| EGI-SIGILLO | 56 | 40 | 71.4% | 50% | OK |
| EGI-Credential | 408 | 265 | 65.0% | 50% | OK |
| NATAN_LOC | 848 | 503 | 59.3% | 50% | OK |
| EGI-INFO | 394 | 200 | 50.8% | 50% | OK |
| EGI-SALES | 64 | 29 | 45.3% | 30% | OK |
| EGI-STAT | 45 | 17 | 37.8% | 30% | OK |
| EGI-HUB-HOME-REACT | 310 | 110 | 35.5% | 30% | OK |
| EGI | 3460 | 1126 | 32.5% | 30% | OK |
| EGI-DOC | 1296 | 121 | 9.3% | 5% | OK |
| **Ecosistema** | **7750** | **3048** | **39.3%** | — | — |

Pattern broken: 94/482 (19.5%) — sotto soglia 25%.
Dead SSOT: 0/149 — nessuno.
SSOT con watches definiti: 99/149.

---

## 4. Architettura runtime

```
Mission chiusa da operatore
  │
  ├─ Mission Phase 6 (mission.md)
  │   └─ spawn agent doc-sync-v2
  │       ├─ Step 1: Analisi semantica diff (LLM)
  │       ├─ Step 2: Match diretto via SSOT_REGISTRY watches
  │       ├─ Step 3: Discovery laterale via RAG (LLM + rag_query.py)
  │       ├─ Step 4: Genera patch (additive = applica, substitutive = chiede approvazione)
  │       ├─ Step 5: RAG re-indexing sincrono (rag_reindex.py + sanity check)
  │       ├─ Step 5b: Aggiornamento metadati SSOT_REGISTRY (last_verified, verified_in_mission)
  │       └─ Step 6: Audit trail → doc_sync_log nel MISSION_REGISTRY
  │
  ├─ Guard enforcement (doc-sync-v2-guard.sh)
  │   └─ PreToolUse Bash su git push del repo-DOC dell'istanza (es. EGI-DOC su FlorenceEGI)
  │       ├─ Livello 1: mission post 2026-04-30 senza doc_sync_executed → BLOCK
  │       └─ Livello 2: mission post 2026-05-09 senza doc_sync_log strutturato → BLOCK
  │
  └─ Coverage hook (coverage-check-precheck.sh)
      └─ PreToolUse Write|Edit su qualsiasi file ecosistema
          └─ File non coperto da watch SSOT → stderr WARN (non blocca)
```

### Rete secondaria (non parte del ciclo v2)

- `ssot-reflex-guard.sh` — PostToolUse Write|Edit: segnala se file modificato è watchato da SSOT. v2.1.0 **cross-repo** (M-OS3-028, chiude M-OS3-017): legge `~/oracode-engine/projects.json`, aggrega le REPO_MAP e scandisce tutti gli `SSOT_REGISTRY` → segnala anche i watcher cross-repo (SSOT progetto A su codice repo B). Eredita il de-coupling istanza M-OS3-027 (registry/nerve-log via `.oracode/project.json`). Resta passivo
- `ssot-living-check.sh` — dormiente (nelle permissions, non negli hook): cattura drift da bypass

---

## 5. Cosa NON funziona / gap noti

| Gap | Severità | Descrizione |
|-----|----------|-------------|
| Cron settimanale non schedulato | Bassa | Script `docsync_weekly_reglob.py` esiste ma nessun crontab entry. Safety net secondaria assente |
| 50 SSOT senza watches | Media | 50/149 SSOT non hanno `watches.paths`. Non partecipano alla detection automatica |
| 94 pattern broken | Bassa | 19.5% dei pattern non matcha alcun file. Sotto soglia 25% ma indica drift nei watch |
| Coverage ecosistema 39.3% | Informativo | 60.7% dei file non è osservato da alcun SSOT. Deliberato per il legacy dell'istanza (es. EGI su FlorenceEGI) (Strategia Delta) |
| Mission registry dual-tracking sincronizzazione manuale | **Risolto/Storico** | **SUPERATO (M-OS3-025 Unità 3, commit ponte L1→L3).** Contesto storico: dal bootstrap OS3 Matrix (M-OS3-001, 25 maggio 2026) il Mission Engine usava due fonti dati distinte. La `state machine` di `bin/mission` scrive in `~/oracode-engine/missions/<ID>/state.json` (cartella globale **VISIBILE**, Unità 1; `~/.oracode` resta symlink di compat — condivisa fra progetti); il Mission Registry del progetto applicativo vive in `<progetto-DOC>/docs/missions/MISSION_REGISTRY.json` (versionato col repo). In origine la coerenza fra i due registri era responsabilità dell'operatore (Edit manuale del registry a ogni transizione), con drift rilevato in sessione 2 Poli (M-002 — finding S2-1, `os3-matrix/docs/design/BACKLOG.md` SEZIONE 9). **Oggi il ponte automatico L1→L3 è FATTO**: `bin/mission` auto-registra/propaga lo stato della state machine nel `MISSION_REGISTRY.json` del progetto risolvendo il descrittore `<progetto>/.oracode/project.json` dal CWD (funzione `syncToRepoRegistry`, `os3-matrix/bin/mission`), parallel-safe con lockfile per-registry (`withRegistryLock`). La vecchia sincronizzazione manuale `state.json`↔`registry` e le mission fantasma (finding S2-1) **non sono più stato attuale**. Il riferimento storico al "fix candidato M-OS3-014" è superato da **M-OS3-025 Unità 3 (FATTO)**. |

---

## 6. Documenti di riferimento

| Documento | Path | Contenuto |
|-----------|------|-----------|
| Specifica Operativa v2.1.0 | `docs/lso/DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` | Cosa deve fare, anti-pattern, test accettazione, coverage |
| Piano Implementativo v2.1.0 | `docs/lso/DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md` | Come è implementato, step dettagliati, costi, latenza |
| Agent definition | `~/.claude/agents/doc-sync-v2.md` | Istruzioni runtime per l'agente |
| SSOT Registry | `docs/lso/SSOT_REGISTRY.json` | 149 documenti, watches, repos |
| Coverage Config | `docs/lso/COVERAGE_CONFIG.json` | Soglie per organo, esclusioni |
| Trigger Matrix | `docs/oracode/audit/02_TRIGGER_MATRIX.md` | Tipi 1-6 che determinano se DOC-SYNC si attiva |
| Audit trail | `audit/doc_sync/M-*/` | 7 directory con summary + actions JSON |

---

## 7. Cronologia

| Data | Evento | Mission |
|------|--------|---------|
| 2026-04-30 | Specifica v2.0.0 approvata, Piano v1.1.0 proposto | — |
| 2026-05-04 | Guard v1 operativo | M-149 |
| 2026-05-08 | **v2.0.0 attivato in produzione**: agent + guard + mission Phase 6 | M-160a |
| 2026-05-08 | Validazione end-to-end | M-160b |
| 2026-05-09 | Guard Livello 2 attivo (cutoff doc_sync_log) | — |
| 2026-05-11 | Audit consolidato | M-166 |
| 2026-05-11 | Audit metodologico | M-178 |
| 2026-05-12 | **v2.1.0 specifica**: coverage nativa, CLI, config, hook | M-179 |
| 2026-05-15 | Coverage hook wired, Piano e Agent allineati a v2.1.0 | M-189 |
| 2026-06-01 | DOC-SYNC fine-tuning: agente esaustivo (Step 4.3 — aggiorna TUTTE le tabelle changelog + grep verifica) + reflex de-coupled (v1.1.0, generico via `.oracode/project.json`) | M-OS3-027 |
| 2026-06-01 | **Reflex cross-repo** (v2.1.0): `ssot-reflex-guard.sh` legge `~/oracode-engine/projects.json`, aggrega le REPO_MAP e scandisce tutti gli `SSOT_REGISTRY` → segnala i watcher cross-repo. Chiude M-OS3-017 | M-OS3-028 |
