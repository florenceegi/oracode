# DOC-SYNC v2 — Piano Implementativo Supervisor

> **Versione**: 2.1.0
> **Data**: 2026-05-15 (aggiornato da v1.1.0 in M-189)
> **Autore**: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
> **Stato**: Implementato e in produzione dal 2026-05-08 (M-160a)
> **Specifica di riferimento**: `DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` v2.1.0 (2026-05-12)
> **Driver revisione**: `DOC-SYNC_v2_RICHIESTA_REVISIONE.md` v1.0.0 (2026-04-30) — 5 punti
> **Attivazione produzione**: M-160a (2026-05-08) — agent, guard, mission Phase 6 operativi
> **Estensione coverage**: v2.1.0 (2026-05-12) — hook coverage nativo, CLI, cron settimanale

---

## 1. Architettura di alto livello

### 1.1 Componenti

```
                     ┌──────────────────────────────────────────────┐
                     │            MISSION ENGINE                    │
                     │  (.claude/commands/mission.md)                │
                     │                                              │
                     │  Mission Phase 6 — Closing                   │
                     │  → spawn doc-sync-v2 agent                   │
                     └──────────────┬───────────────────────────────┘
                                    │
                     ┌──────────────▼───────────────────────────────┐
                     │     AGENT: doc-sync-v2                       │
                     │  (~/.claude/agents/doc-sync-v2.md)           │
                     │                                              │
                     │  Step 1: Semantic analysis (LLM)             │
                     │  Step 2: Direct SSOT match                   │
                     │  Step 3: Lateral discovery (LLM)             │
                     │  Step 4: Generate & apply patches            │
                     │         (batch approval for substitutive)    │
                     │  Step 5: Call RAG reindexer (blocking)       │
                     │  Step 6: Write audit trail                   │
                     └──────┬────────────────┬──────────────────────┘
                            │                │
              ┌─────────────▼──┐   ┌────────▼──────────────────────┐
              │ SSOT_REGISTRY  │   │  Python CLI                    │
              │    .json       │   │  oracode/bin/                  │
              │ (read/write)   │   │  rag_natan_reindex.py          │
              └────────────────┘   │                                │
                                   │  - Chunk markdown              │
                                   │  - OpenAI embeddings           │
                                   │  - pgvector upsert             │
                                   │  - Blocking sanity check       │
                                   └───────────┬────────────────────┘
                                               │
                                   ┌───────────▼────────────────────┐
                                   │  PostgreSQL RDS                │
                                   │  rag_natan.documents           │
                                   │  rag_natan.chunks              │
                                   │  rag_natan.embeddings          │
                                   └────────────────────────────────┘

Guard (enforcement):
  doc-sync-v2-guard.sh (PostToolUse Bash on git push EGI-DOC)
  → BLOCK if completed mission lacks doc_sync_log
```

### 1.2 Interfacce esplicite

| Componente | Interfaccia con Mission Engine | Interfaccia con DB |
|------------|-------------------------------|-------------------|
| Agent doc-sync-v2 | Riceve: mission_id, files_modified, diff (da Mission Phase 6). Restituisce: doc_sync_log JSON | Legge: SSOT_REGISTRY.json. Scrive: SSOT .md files, audit trail |
| Python CLI rag_natan_reindex | Riceve: lista SSOT file paths da agent. Restituisce: rag_reindex_log JSON | Scrive: rag_natan.documents, chunks, embeddings (transazionale per doc) |
| Guard hook | Legge: MISSION_REGISTRY.json → verifica doc_sync_log presente | Nessuna |

### 1.3 Flusso dati

```
Mission Phase 6 — Closing (mission skill)
  │
  ├─ 1. Raccoglie: mission_id, lista file modificati, git diff della mission
  │     (dai commit_hashes nel registry + git diff <first>^..<last>)
  │
  ├─ 2. Spawn agent doc-sync-v2 con prompt contenente tutti gli input
  │
  ├─ 3. Agent esegue Steps 1-6 (vedi § 3)
  │     - Se sostitutivo: presenta batch, attende risoluzione completa
  │     - Se fallisce: restituisce errore, mission resta in closing
  │
  ├─ 4. Agent restituisce doc_sync_log
  │
  └─ 5. Mission skill scrive doc_sync_log nel MISSION_REGISTRY
         e procede a closed (o resta closing se fallito/non risolto)
```

### 1.4 Convenzione naming (disambiguazione)

Per evitare collisione terminologica:
- **"Mission Phase N"** = fase del protocollo mission (`mission.md`). Es: "Mission Phase 6 — Closing"
- **"Step N"** (o **"DOC-SYNC Step N"**) = fase interna a DOC-SYNC v2. Es: "Step 4 — Generazione e applicazione"

Questa convenzione si applica in tutto il documento e nell'implementazione.

---

## 2. Anti-pattern check

Per ogni anti-pattern di § 2 della specifica, dimostrazione che l'implementazione lo esclude strutturalmente.

### Anti-pattern 1 — Watcher su file save
**Esclusione strutturale**: DOC-SYNC v2 e un agent Claude Code invocato esplicitamente da Mission Phase 6. Non esiste alcun hook PostToolUse Write/Edit associato. Il trigger e lo spawn dell'agent nel codice di `mission.md`, non un hook su evento file.

### Anti-pattern 2 — Tracking temporale
**Esclusione strutturale**: L'agent riceve il diff semantico della mission (contenuto delle modifiche), non date. Non legge `last_verified` come input decisionale. Lo aggiorna solo come output dopo aver modificato contenuto.

### Anti-pattern 3 — Segnalazione passiva
**Esclusione strutturale**: L'agent ha due modalita: scrittura diretta (additivo) o proposta-approvazione (sostitutivo). Non esiste un terzo path "warning". In caso di rifiuto sostitutivo, la mission resta bloccata in `awaiting_doc_sync_resolution` con tre opzioni di risoluzione — non esiste "procedi senza fare nulla" (vedi § 3, Step 4).

### Anti-pattern 4 — Cron come trigger
**Esclusione strutturale**: Nessun componente cron nel ciclo DOC-SYNC v2. `ssot-living-check.sh` sopravvive come rete secondaria (§ 8.3 spec) ma non triggera DOC-SYNC v2.

### Anti-pattern 5 — Lettura del solo registry senza il codice
**Esclusione strutturale**: L'input primario e il diff della mission (codice modificato). Il registry serve solo per identificare quali SSOT watchano quei file. Flusso: codice modificato → registry lookup → SSOT impattati.

### Anti-pattern 6 — Aggiornamento del solo `last_verified`
**Esclusione strutturale**: Il prompt dell'agent richiede per ogni SSOT impattato: o contenuto modificato (con diff narrativo), o giustificazione esplicita tracciata del perche non servono modifiche. L'aggiornamento di `last_verified` avviene SOLO come effetto collaterale di una modifica di contenuto o di un no-change giustificato.

### Anti-pattern 7 — Re-indexing asincrono
**Esclusione strutturale**: L'agent chiama il Python CLI `rag_natan_reindex.py` in modo sincrono (Bash call, non run_in_background). Attende il risultato. Sanity check e bloccante: fallimento del sanity check dopo retry impedisce chiusura mission (vedi § 6).

### Anti-pattern 8 — Scrittura cieca senza diff
**Esclusione strutturale**: L'agent produce un `diffs/<ssot_name>.md` per ogni SSOT modificato, contenente il diff narrativo prima/dopo. L'audit trail in `EGI-DOC/audit/doc_sync/<mission_id>/` conserva tutti i diff.

### Anti-pattern 9 — Confusione DOC-SYNC / DOC-DISCOVERY
**Esclusione strutturale**: L'agent lavora SOLO sui file della mission (Step 1 riceve lista esplicita). La discovery laterale (Step 3) cerca SSOT correlati semanticamente, ma non scansiona codice non toccato dalla mission.

### Anti-pattern 10 — Piano minimo plausibile
**Esclusione strutturale**: Questo piano implementa tutti i 6 step, tutti gli output, tutta la logica additivo/sostitutivo con gestione rifiuti a tre opzioni, tutta la discovery laterale, tutto il re-indexing sincrono con sanity check bloccante. Nessun step rimandato.

---

## 3. Mappa dei 6 step

### Step 1 — Analisi semantica delle modifiche

| Aspetto | Dettaglio |
|---------|-----------|
| **Componente** | Agent doc-sync-v2 (LLM Claude) |
| **Input** | Diff unificato della mission, lista file modificati con tipo (created/modified/deleted/renamed) |
| **Logica** | L'agent legge il diff e produce una sintesi semantica strutturata JSON: nuove funzioni/classi, funzioni rimosse, comportamenti modificati, nuovi contenuti narrativi, modifiche a contenuti narrativi |
| **Output** | `mission_semantic_summary.json` scritto in `EGI-DOC/audit/doc_sync/<mission_id>/` |
| **Failure points** | (a) Diff troppo grande per context window → mitigazione: chunking del diff per file, analisi file-per-file, merge risultati. (b) LLM genera JSON malformato → mitigazione: retry con prompt semplificato (max 2 retry) |
| **Gestione failure** | Se fallisce dopo retry: doc_sync_log.outcome = "failed", failure_reason = "semantic_analysis_failed", mission resta in closing |

### Step 2 — Identificazione SSOT impattati (diretti)

| Aspetto | Dettaglio |
|---------|-----------|
| **Componente** | Agent doc-sync-v2 (logica deterministica, no LLM) |
| **Input** | Lista file modificati + SSOT_REGISTRY.json |
| **Logica** | Per ogni file modificato, scansiona `watches.paths[]` e `watches.patterns[]` di ogni SSOT nel registry. Match via glob pattern (fnmatch). Tipo impatto: `direct_watcher` o `pattern_match` |
| **Output** | `directly_impacted_ssots.json` |
| **Failure points** | (a) SSOT_REGISTRY.json non trovato o malformato → mitigazione: errore esplicito, abort con failure_reason. (b) Nessun SSOT impattato → non e un errore: procede con lista vuota (la mission potrebbe non impattare SSOT) |
| **Gestione failure** | Se registry assente: abort con "ssot_registry_not_found" |

### Step 3 — Discovery laterale

| Aspetto | Dettaglio |
|---------|-----------|
| **Componente** | Agent doc-sync-v2 (LLM Claude per estrazione concetti + Bash per query RAG) |
| **Input** | `mission_semantic_summary.json` (Step 1) + accesso RAG piattaforma |
| **Logica** | (1) LLM estrae concetti chiave dalla sintesi semantica (sostantivi tematici, entita nominate). (2) Per ogni concetto, query vettoriale su `rag_natan.embeddings` via Python CLI `rag_natan_query.py --concept "..."`. (3) Risultati filtrati: rimuove SSOT gia identificati in Step 2. (4) Score di rilevanza: cosine similarity > 0.55 (soglia discovery, piu alta di retrieval normale per ridurre falsi positivi). (5) LLM valida i candidati: "questo SSOT descrive concettualmente qualcosa che la mission ha cambiato?" |
| **Output** | `laterally_impacted_ssots.json` con score per ogni candidato |
| **Failure points** | (a) RAG vuoto (nessun SSOT indicizzato) → procede con lista laterale vuota. (b) Troppi candidati (>15) → filtro: prende top-5 per score. (c) Query RAG fallisce → procede senza discovery laterale, segnala in log |
| **Gestione failure** | Discovery laterale e best-effort. Fallimento non blocca la mission, ma viene registrato nel log |

### Step 4 — Generazione e applicazione modifiche SSOT

| Aspetto | Dettaglio |
|---------|-----------|
| **Componente** | Agent doc-sync-v2 (LLM Claude per generazione testo, Write/Edit tool per applicazione) |
| **Input** | Lista SSOT impattati (diretti + laterali) + `mission_semantic_summary.json` + contenuto attuale di ogni SSOT |
| **Logica** | Vedi sotto-sezioni 4.1-4.4 |
| **Output** | `doc_sync_actions.json` + `diffs/<ssot_name>.md` per ogni SSOT |

#### 4.1 Modello di stato per azione (idempotenza granulare)

Ogni azione in `doc_sync_actions.json` ha uno stato esplicito:

```json
{
  "actions": [
    {
      "ssot_path": "EGI-DOC/docs/natan-loc/Core/00_STATO_DELLARTE.md",
      "mode": "additive|substitutive",
      "status": "<stato>",
      "ssot_content_hash": "<SHA-256 del contenuto SSOT al momento dell'analisi>",
      "diff_path": "diffs/00_STATO_DELLARTE.md",
      "proposed_patch": "<testo proposto, per sostitutive>",
      "justification": "<motivazione classificazione>",
      "timestamp": "<ISO 8601>",
      "resolution_method": null | "approved" | "manual_edit" | "rewrite_mission"
    }
  ]
}
```

**Stati possibili per ogni azione:**

| Stato | Significato | Transizioni ammesse |
|-------|-------------|---------------------|
| `pending` | Non ancora processata | → `applied`, `failed`, `awaiting_approval` |
| `applied` | Modifica additiva applicata con successo | Stato finale |
| `failed` | Modifica tentata ma fallita | → `pending` (su retry) |
| `awaiting_approval` | Patch sostitutiva in attesa di decisione | → `approved`, `rejected` |
| `approved` | Approvazione ricevuta, patch da applicare | → `applied`, `failed` |
| `rejected` | Patch rifiutata dall'operatore | → `awaiting_resolution` |
| `awaiting_resolution` | Rifiuto in corso di risoluzione (vedi § 4.3) | → `applied`, `superseded`, `flagged_for_rewrite` |
| `superseded` | SSOT modificato manualmente tra esecuzioni | Stato finale (azione obsoleta) |
| `flagged_for_rewrite` | SSOT marcato per riscrittura completa in mission separata | Stato finale |
| `no_change` | SSOT analizzato, nessuna modifica necessaria (con giustificazione) | Stato finale |

#### 4.2 Flusso per azione singola

```
Per ogni SSOT impattato:

  1. Calcola SHA-256 del contenuto corrente → ssot_content_hash
  2. Se doc_sync_actions.json esiste gia per questa mission:
     a. Cerca azione per questo ssot_path
     b. Se status = "applied" o "no_change" o "flagged_for_rewrite" → SKIP
     c. Se status = "superseded" → SKIP
     d. Se status = "approved" → applica patch, marca "applied"
     e. Se status = "failed" o "pending" → rielabora
     f. Se status = "awaiting_approval" o "awaiting_resolution" → ripresenta
     g. Se ssot_content_hash attuale ≠ hash salvato → marca "superseded"
        (SSOT modificato manualmente tra esecuzioni)

  3. Se azione nuova:
     a. LLM discrimina: ADDITIVE / SUBSTITUTIVE / NO_CHANGE
     b. ADDITIVE → genera testo, applica con Edit, status = "applied"
     c. SUBSTITUTIVE → genera patch, status = "awaiting_approval"
     d. NO_CHANGE → registra giustificazione, status = "no_change"

  4. Produce diff narrativo per ogni SSOT con status ≠ "no_change"
  5. Aggiorna metadati SSOT_REGISTRY
```

#### 4.3 Gestione rifiuto patch sostitutiva

Quando l'operatore rifiuta una patch sostitutiva, la mission **non procede a `closed`**. Resta in `closing` con sub-stato `awaiting_doc_sync_resolution`.

L'operatore riceve tre opzioni:

**Opzione 1 — Riconsidera e approva**
L'agent ripresenta la patch. L'operatore puo approvarla. Status: `awaiting_approval` → `approved` → `applied`.

**Opzione 2 — Modifica manuale + rivalida**
L'operatore modifica il SSOT manualmente e segnala "fatto, rivalida". L'agent:
1. Ricalcola `ssot_content_hash` (rileva che il contenuto e cambiato)
2. Re-esegue discriminazione su quel singolo SSOT con il nuovo contenuto
3. Se il SSOT e ora coerente con il codice → status = `applied` (via modifica manuale)
4. Se ancora incoerente → nuova proposta sostitutiva
5. Procede a Step 5 (re-indexing) per il SSOT modificato manualmente

**Opzione 3 — Crea mission di rewrite**
L'operatore dichiara che il SSOT e fondamentalmente obsoleto. L'agent:
1. Marca il SSOT come `flagged_for_rewrite` in `doc_sync_actions.json`
2. Aggiorna `SSOT_REGISTRY.json`: `known_drift[] += {type: "flagged_for_rewrite", mission: "<id>", date: "<iso>"}`
3. Crea entry in `MISSION_QUEUE.json` (non una mission completa — un item in coda di triage):
   ```json
   {"type": "doc_sync_rewrite", "ssot_path": "...", "source_mission": "<id>", "reason": "Rejected substitutive patch — SSOT needs full rewrite"}
   ```
4. La mission corrente puo procedere a chiusura con nota nel `doc_sync_log`:
   `rewrite_flagged: ["<ssot_path>"]`

**L'opzione "procedi senza fare nulla" non esiste.**

#### 4.4 Cascading sostitutivo (multipli SSOT in approvazione)

Quando una mission impatta piu SSOT in modalita sostitutiva:

**Presentazione: batch unico**
L'operatore vede tutte le patch sostitutive insieme in un unico prompt strutturato:

```
DOC-SYNC v2 — Patch sostitutive per mission M-XXX

SSOT 1: Sigillo__01_PRICING_MODEL.md (diretto)
  Sezione impattata: "## Pricing per target"
  Prima: "Target market: notai, avvocati, commercialisti"
  Dopo:  "Target market: notai, avvocati, commercialisti, compro-oro"
  → [APPROVA] [RIFIUTA]

SSOT 2: Sigillo__00_OVERVIEW.md (laterale)
  Sezione impattata: "## Mercato"
  Prima: "Sigillo serve 3 segmenti professionali"
  Dopo:  "Sigillo serve 4 segmenti professionali"
  → [APPROVA] [RIFIUTA]

SSOT 3: EGI__panoramica.md (laterale)
  Sezione impattata: "## Prodotti — Sigillo"
  Prima: "Target: professionisti legali e contabili"
  Dopo:  "Target: professionisti legali, contabili e settore orafo"
  → [APPROVA] [RIFIUTA]
```

**Applicazione: atomica per batch**
- L'agent raccoglie TUTTE le decisioni prima di applicare qualsiasi patch
- Le patch approvate restano in stato `approved` (non `applied`) fino a completamento del batch
- Una volta raccolte tutte le decisioni:
  - Tutte le `approved` vengono applicate insieme
  - Per ogni `rejected`: si entra nel flusso § 4.3 per quel singolo SSOT

**Gestione rifiuti misti**
Se N patch sono approvate e M patch sono rifiutate:
1. Le N approvate restano in `approved` (non ancora `applied`)
2. Per ogni M rifiutata, l'operatore risolve con una delle 3 opzioni (§ 4.3)
3. Solo quando TUTTI gli SSOT sono in stato risolvibile (`approved`, `no_change`, `applied`, `flagged_for_rewrite`, `superseded`) → le approvate vengono applicate → Step 5 procede
4. La mission resta in `closing/awaiting_doc_sync_resolution` finche tutti gli SSOT non sono risolti

**Motivazione dell'atomicita**: applicare 2 patch su 3 quando le 3 sono semanticamente correlate (come nell'esempio pricing) produce stato documentale incoerente. Meglio attendere la risoluzione completa.

**Step 5 al termine del batch**: il re-indexing RAG si avvia SOLO quando tutte le decisioni sono prese e tutte le patch approvate/risolte sono state applicate.

#### Step 4 — Failure points e gestione

| Failure point | Gestione |
|---------------|----------|
| SSOT file non trovato sul disco | Segnala in `doc_sync_actions.json` con status `failed`, reason `ssot_file_not_found`. Procede con gli altri |
| Edit tool fallisce | Retry 1 volta. Se fallisce ancora: status `failed` |
| LLM genera testo incoerente | Il diff narrativo permette review post-hoc. Non blocca |
| Tutti gli SSOT in `failed` | doc_sync_log.outcome = "failed", mission resta closing |
| Almeno 1 SSOT `applied` o `no_change`, altri `failed` | doc_sync_log.outcome = "partial_failure", mission resta closing (Step 5 esegue solo sugli `applied`) |

### Step 5 — Re-indexing RAG sincrono

| Aspetto | Dettaglio |
|---------|-----------|
| **Componente** | Python CLI `rag_natan_reindex.py` (chiamato dall'agent via Bash) |
| **Input** | Lista file SSOT con status `applied` (path assoluti) |
| **Logica** | Per ogni SSOT file: (1) Legge contenuto markdown. (2) Chunking: split per heading H2/H3 (sezioni semantiche). Chunk max 1500 chars, overlap 100 chars. (3) Genera embedding per ogni chunk via OpenAI text-embedding-3-small. (4) Transazione PostgreSQL per SSOT: DELETE vecchi chunks/embeddings del documento → INSERT nuovi. (5) Sanity check bloccante (vedi § 6) |
| **Output** | JSON su stdout: `{ssot_path, chunks_updated, embeddings_generated, index_transaction_id, sanity_check_passed}` per ogni SSOT. Agent lo parsa e scrive `rag_reindex_log.json` |
| **Failure points** | (a) PostgreSQL connection failure → retry 2 volte con backoff. (b) OpenAI API rate limit → retry con backoff esponenziale (max 30s). (c) Sanity check fallisce dopo retry → **BLOCCA** (vedi § 6). (d) Transazione rollback → SSOT resta con vecchi chunk (consistente) |
| **Gestione failure** | Se re-indexing fallisce dopo retry: doc_sync_log.outcome = "failed", failure_reason = "rag_reindex_failed_<ssot>", mission resta closing. Retry manuale puo completare da Step 5 senza ripetere 1-4 (idempotenza) |
| **Timeout** | 120s per SSOT (include embedding generation). 600s totale (max 5 SSOT per mission tipica) |

### Step 6 — Audit trail e chiusura

| Aspetto | Dettaglio |
|---------|-----------|
| **Componente** | Agent doc-sync-v2 (Write tool per audit trail) |
| **Input** | Output di tutti gli step precedenti |
| **Logica** | (1) Scrive `doc_sync_summary.md` (narrativo, leggibile). (2) Compone `doc_sync_log` JSON. (3) Restituisce log a mission skill. (4) Mission skill scrive log nel MISSION_REGISTRY, marca doc_sync_executed: true |
| **Output** | Tutti i file in `EGI-DOC/audit/doc_sync/<mission_id>/` + doc_sync_log nella mission |
| **Failure points** | Scrittura file fallisce → retry |
| **Gestione failure** | Se audit trail non scrivibile: log degradato (solo JSON inline nel registry) |

---

## 4. Strategia discriminazione additivo vs sostitutivo

### Algoritmo

L'agent legge il contenuto attuale del SSOT e la sintesi semantica della mission, poi applica:

```
PER OGNI modifica semantica rilevante per questo SSOT:

  1. CERCA nel SSOT corrente testo che descriva la stessa entita/funzione/concetto

  2. SE non trovato → ADDITIVE
     Il SSOT non menziona ancora questa entita. Aggiungere sezione.

  3. SE trovato E il significato non cambia → NO_CHANGE
     Es: una funzione esistente ha solo refactoring interno,
     il SSOT descrive gia il comportamento corretto.

  4. SE trovato E il significato cambia → SUBSTITUTIVE
     Es: la funzione prima faceva X, ora fa Y. Il SSOT dice X.

  5. SE ambiguo → SUBSTITUTIVE (default sicuro, chiede approvazione)
```

### Esempi concreti dal codebase

**Caso additivo**: Mission aggiunge `EgiliCostCalculator` a NATAN_LOC (M-136). Il SSOT `00_NATAN_LOC_STATO_DELLARTE_v2.md` non menziona questa classe. DOC-SYNC v2 aggiunge una sezione sotto "Architettura" che descrive il nuovo componente. Status: `pending` → `applied`.

**Caso sostitutivo approvato**: Mission modifica il threshold di `EvidenceVerifier.MIN_SIMILARITY` da 0.45 a 0.50 (ipotetico). Il SSOT documenta "MIN_SIMILARITY = 0.45". DOC-SYNC v2 propone patch, operatore approva. Status: `pending` → `awaiting_approval` → `approved` → `applied`.

**Caso sostitutivo rifiutato — opzione 2**: Come sopra, ma l'operatore rifiuta perche vuole riscrivere la sezione diversamente. Modifica il SSOT, segnala "rivalida". DOC-SYNC v2 ricontrolla: hash cambiato, re-discrimina, trova coerente. Status: `pending` → `awaiting_approval` → `rejected` → `awaiting_resolution` → `applied` (via manual edit).

**Caso sostitutivo rifiutato — opzione 3**: L'operatore rifiuta e dichiara SSOT obsoleto. DOC-SYNC v2 crea item in MISSION_QUEUE. Status: `pending` → `awaiting_approval` → `rejected` → `awaiting_resolution` → `flagged_for_rewrite`.

**Caso nessuna modifica**: Mission fa refactoring interno di `NatanChatService` (estrae metodo privato). Il SSOT descrive il servizio a livello di responsabilita, non di metodi interni. Status: `pending` → `no_change` (con giustificazione tracciata).

**Caso ambiguo → default sostitutivo**: Mission aggiunge un parametro opzionale a un endpoint API documentato. Potrebbe essere additivo (nuovo parametro) o sostitutivo (cambia la firma). Default: sostitutivo, chiede approvazione. Status: `pending` → `awaiting_approval`.

**Caso superseded**: DOC-SYNC v2 fallisce a Step 5 su una mission. Nel frattempo l'operatore modifica manualmente il SSOT. Alla riesecuzione, l'agent rileva hash diverso → status: `applied` → `superseded` (l'azione originale non e piu valida). Re-discrimina sul nuovo contenuto.

### Prompt LLM per discriminazione

L'agent riceve un prompt strutturato:

```
Dato il contenuto attuale del SSOT [path] e la modifica semantica [summary],
determina:

1. Il SSOT descrive gia l'entita/funzione/concetto modificato? (SI/NO)
2. Se SI: il significato descritto nel SSOT resta valido dopo la modifica? (SI/NO/AMBIGUO)
3. Classificazione:
   - Non trovato → ADDITIVE
   - Trovato + significato valido → NO_CHANGE (con giustificazione)
   - Trovato + significato cambiato → SUBSTITUTIVE
   - Trovato + ambiguo → SUBSTITUTIVE

Output JSON: {classification, justification, ssot_section_affected, proposed_action}
```

---

## 5. Strategia discovery laterale

### Pipeline

```
mission_semantic_summary.json
        │
        ▼
   ┌────────────────────────┐
   │ 1. Estrazione concetti │  LLM: "Quali concetti di dominio sono
   │    chiave               │   toccati da queste modifiche?"
   └───────────┬────────────┘  Output: ["target market", "pricing",
               │                        "compro-oro", ...]
               ▼
   ┌────────────────────────┐
   │ 2. Query vettoriale    │  Per ogni concetto:
   │    RAG piattaforma     │  SELECT rag_natan.embeddings
   └───────────┬────────────┘  WHERE cosine_sim > 0.55
               │               ORDER BY similarity DESC LIMIT 10
               ▼
   ┌────────────────────────┐
   │ 3. Filtraggio          │  Rimuovi SSOT gia in directly_impacted
   │                        │  Rimuovi duplicati (stesso SSOT da piu concetti)
   └───────────┬────────────┘  Prendi max score per SSOT
               │
               ▼
   ┌────────────────────────┐
   │ 4. Validazione LLM     │  "Questo SSOT parla di [concetto X].
   │    (riduce falsi pos.) │   La mission ha modificato [riassunto].
   └───────────┬────────────┘   L'SSOT e semanticamente impattato?" (SI/NO)
               │
               ▼
   laterally_impacted_ssots.json
   (max 5 SSOT, score > 0.55, validati da LLM)
```

### Soglia e falsi positivi

- **Soglia discovery**: cosine similarity 0.55 (piu alta di retrieval 0.45 per ridurre rumore)
- **Cap**: max 5 SSOT laterali (evita esplosione su mission grandi)
- **Validazione LLM**: riduce falsi positivi. Costo aggiuntivo ~$0.01 per candidato
- **Fallback**: se RAG piattaforma vuoto o non raggiungibile, discovery laterale restituisce lista vuota e il log lo registra

### Implementazione tecnica query RAG

Il Python CLI `rag_natan_query.py` esegue:

```python
# Genera embedding del concetto
embedding = openai.embeddings.create(input=concept, model="text-embedding-3-small")

# Query pgvector
SELECT d.id, d.title, d.slug, 1 - (e.embedding <=> %s) as similarity
FROM rag_natan.embeddings e
JOIN rag_natan.chunks c ON e.chunk_id = c.id
JOIN rag_natan.documents d ON c.document_id = d.id
WHERE 1 - (e.embedding <=> %s) > 0.55
ORDER BY similarity DESC
LIMIT 10
```

L'agent riceve i risultati e filtra/valida.

---

## 6. Strategia re-indexing sincrono

### Transazionalita per SSOT

Ogni SSOT e re-indicizzato in una singola transazione PostgreSQL:

```python
async with db.transaction():
    # 1. Trova documento esistente (by slug = ssot_filename_without_extension)
    doc = SELECT * FROM rag_natan.documents WHERE slug = %s

    if doc:
        # 2. DELETE vecchi chunks + embeddings (CASCADE)
        DELETE FROM rag_natan.chunks WHERE document_id = doc.id
        # 3. UPDATE documento
        UPDATE rag_natan.documents SET content = %s, updated_at = NOW() WHERE id = doc.id
    else:
        # 2b. INSERT nuovo documento
        INSERT INTO rag_natan.documents (title, slug, content, language, document_type, status, tags)
        VALUES (%s, %s, %s, 'it', 'ssot', 'published', %s)

    # 4. INSERT nuovi chunks
    for i, chunk in enumerate(chunks):
        INSERT INTO rag_natan.chunks (document_id, text, section_title, chunk_order, chunk_type, language)
        VALUES (doc.id, %s, %s, %s, 'paragraph', 'it')

    # 5. INSERT embeddings (1:1 con chunks)
    for chunk_id, embedding in zip(chunk_ids, embeddings):
        INSERT INTO rag_natan.embeddings (chunk_id, embedding, model)
        VALUES (%s, %s, 'text-embedding-3-small')
```

### Chunking markdown

```python
def chunk_markdown(content: str, max_chars: int = 1500, overlap: int = 100) -> list[dict]:
    """
    Split per heading H2/H3 (sezioni semantiche).
    Se sezione > max_chars, split per paragrafo.
    Se paragrafo > max_chars, split per frase.
    Overlap tra chunk consecutivi per continuita semantica.
    """
```

### Timeout e retry

| Operazione | Timeout | Retry |
|-----------|---------|-------|
| OpenAI embedding (per batch 20 chunk) | 30s | 2x con backoff esponenziale |
| PostgreSQL transazione (per SSOT) | 60s | 2x con backoff |
| Sanity check query | 10s | 2x con backoff (30s totali max) |
| Totale per SSOT | 120s | — |
| Totale per mission | 600s | — |

### Fallimento DB

Se la transazione PostgreSQL fallisce:
1. Rollback automatico (nessun chunk orfano)
2. Il vecchio contenuto nel RAG resta intatto (consistente, anche se stale)
3. Log registra `rag_reindex_failed` per quello SSOT
4. Gli altri SSOT vengono comunque processati
5. Se anche solo 1 SSOT fallisce il re-indexing: doc_sync_log.outcome = "failed"
6. Retry manuale riparte da Step 5 (idempotenza: Steps 1-4 non vengono rieseguiti se i file output esistono gia e gli hash corrispondono)

### Sanity check (bloccante)

Dopo ogni upsert transazionale, il sanity check verifica che il RAG sia effettivamente queryable:

```python
# Query il RAG con il primo chunk come query
test_embedding = embeddings[0]
results = SELECT chunk_id, 1 - (embedding <=> %s) as sim
          FROM rag_natan.embeddings
          ORDER BY sim DESC LIMIT 3

# Il chunk stesso deve apparire nei top-3
sanity_passed = any(r.chunk_id == first_chunk_id for r in results)
```

**Comportamento in caso di fallimento:**

1. Sanity check eseguito dopo ogni transazione PostgreSQL per SSOT
2. Se fallisce: retry con backoff esponenziale (2 retry, max 30s totali)
3. Se fallisce dopo retry:
   - `rag_reindex_log` per quel SSOT: `sanity_check_passed: false`
   - doc_sync_log.outcome = "failed"
   - failure_reason = `"rag_sanity_check_failed_<ssot_slug>"`
   - Mission resta in `closing` con sub-stato `doc_sync_failed_rag_sanity`
4. Diagnostica nel log:
   - Causa probabile: indice IVFFlat non aggiornato dopo bulk insert
   - Comando di riparazione suggerito: `REINDEX INDEX CONCURRENTLY idx_embeddings_vector_ivfflat`
   - Se causa e IVFFlat stale: l'operatore esegue REINDEX, poi retry manuale di DOC-SYNC v2 (riparte da Step 5)
5. Retry manuale completa il ciclo senza ripetere Steps 1-4 (idempotenza granulare: le azioni in `applied` non vengono ritoccate)

---

## 7. Mappa test di accettazione

### Test 1 — Trigger universale

| Aspetto | Dettaglio |
|---------|-----------|
| **Setup** | Creare 3 mission di test: (1) doc-only che modifica un SSOT direttamente, (2) codice che modifica un file PHP watchato, (3) strutturale che aggiunge nuovo endpoint. Chiuderle tutte via `/mission` skill |
| **Esecuzione** | Per ogni mission, Mission Phase 6 invoca `doc-sync-v2` agent. Verificare che lo spawn avvenga |
| **Verifica** | Ispezionare MISSION_REGISTRY.json: tutte e 3 le mission hanno `doc_sync_log` con `version: "2.0.0"`. Nessuna ha `doc_sync_log: null` |
| **Pass condition** | 3/3 mission con doc_sync_log valido |

### Test 2 — Riconoscimento additivo vs sostitutivo (incluso rifiuto)

| Aspetto | Dettaglio |
|---------|-----------|
| **Setup** | Mission A: aggiunge nuova classe `FooService.php` in area watchata da un SSOT. Mission B: modifica il comportamento di una funzione gia documentata. Mission C: come B, ma l'operatore rifiuta la patch |
| **Esecuzione** | DOC-SYNC v2 processa tutte e tre |
| **Verifica** | Mission A: `doc_sync_actions.json` contiene status: "applied", mode: "additive". Mission B: status "awaiting_approval" → operatore approva → status "applied". Mission C: status "awaiting_approval" → operatore rifiuta → status "rejected" → mission in `awaiting_doc_sync_resolution` → operatore sceglie opzione 2 (modifica manuale) → rivalida → status "applied" |
| **Pass condition** | (1) Discriminazione corretta per A e B. (2) Mission C non chiude con SSOT incoerente — risoluzione obbligatoria |

### Test 3 — Discovery laterale funzionante

| Aspetto | Dettaglio |
|---------|-----------|
| **Setup** | Pre-condizione: almeno 3 SSOT indicizzati nel RAG piattaforma con contenuti semanticamente correlati. Eseguire mission che tocca file watchato da 1 SSOT ma semanticamente correlato a 2 altri |
| **Esecuzione** | DOC-SYNC v2 Steps 1-3 |
| **Verifica** | `laterally_impacted_ssots.json` contiene almeno 1 SSOT non presente in `directly_impacted_ssots.json`, con score > 0.55 |
| **Pass condition** | Discovery laterale identifica almeno 1 SSOT correlato non-diretto |

### Test 4 — RAG sincrono, bloccante e sanity-checked

| Aspetto | Dettaglio |
|---------|-----------|
| **Setup** | Mission che modifica un SSOT. Monitorare timing |
| **Esecuzione** | DOC-SYNC v2 processa. Misurare tempo tra inizio Step 5 e passaggio a closed |
| **Verifica** | (1) La mission non passa a `closed` prima che `rag_reindex_log.json` sia scritto con `sanity_check_passed: true`. (2) Subito dopo chiusura, query RAG con concetto dal SSOT modificato restituisce contenuto aggiornato. (3) Se sanity check fallisce: mission NON passa a closed |
| **Pass condition** | RAG queryable con contenuto aggiornato immediatamente dopo chiusura. Sanity check failure blocca chiusura |

### Test 5 — Idempotenza granulare

| Aspetto | Dettaglio |
|---------|-----------|
| **Setup** | Eseguire DOC-SYNC v2 su una mission con 3 SSOT. Simulare fallimento a meta Step 4 (2 SSOT processati, 1 no). Rieseguire |
| **Esecuzione** | Seconda esecuzione dell'agent |
| **Verifica** | (1) I 2 SSOT con status `applied` non vengono riprocessati — hash match, skip. (2) Il terzo SSOT con status `pending` o `failed` viene processato. (3) Le proposte sostitutive gia `approved` vengono applicate senza richiedere nuova approvazione. (4) Se un SSOT e stato modificato manualmente tra le esecuzioni: hash mismatch → status `superseded` → re-discriminazione sul nuovo contenuto |
| **Pass condition** | Riesecuzione completa solo il lavoro mancante, senza duplicare ne ripresentare decisioni gia prese |
| **Meccanismo** | Per-action status + ssot_content_hash in `doc_sync_actions.json`. Per RAG: confronta text_hash dei chunk gia presenti |

### Test 6 — Fallimento gestito

| Aspetto | Dettaglio |
|---------|-----------|
| **Setup** | Mission che modifica SSOT. Simulare fallimento Step 5 (es: credenziali DB errate temporaneamente) |
| **Esecuzione** | DOC-SYNC v2 fallisce a Step 5 |
| **Verifica** | (1) SSOT file gia modificati in Step 4 restano modificati (no rollback contenuto). (2) Mission in closing con sub-stato `doc_sync_failed_rag_reindex`. (3) `doc_sync_actions.json` ha azioni con status `applied` (Steps 1-4 completati). (4) Retry manuale completa da Step 5 senza ripetere Steps 1-4 (riconosce azioni `applied` via hash) |
| **Pass condition** | Recovery parziale funziona, no perdita dati, nessun lavoro duplicato |

### Test 7 — Audit trail completo

| Aspetto | Dettaglio |
|---------|-----------|
| **Setup** | Mission che modifica 3 SSOT: 2 additivi, 1 sostitutivo |
| **Esecuzione** | DOC-SYNC v2 processa |
| **Verifica** | In `EGI-DOC/audit/doc_sync/<mission_id>/` esistono: `mission_semantic_summary.json`, `directly_impacted_ssots.json`, `laterally_impacted_ssots.json`, `doc_sync_actions.json` (con status granulari per ogni azione), `diffs/ssot1.md`, `diffs/ssot2.md`, `diffs/ssot3.md`, `rag_reindex_log.json`, `doc_sync_summary.md`. Il summary e leggibile da umano e riporta lo stato finale di ogni azione |
| **Pass condition** | Tutti i file presenti, summary narrativo coerente, stati azione tracciabili |

### Test 8 — Anti-pattern verification

| Aspetto | Dettaglio |
|---------|-----------|
| **Setup** | Review manuale dell'implementazione |
| **Esecuzione** | Checklist contro tutti i 10 anti-pattern di § 2 |
| **Verifica** | (1) Nessun PostToolUse hook su Write/Edit nel ciclo primario. (2) Nessun confronto temporale. (3) Nessun warning passivo — rifiuto patch porta a risoluzione obbligatoria, non a "procedi". (4) Nessun cron trigger. (5) Flusso parte dal diff, non dal registry. (6) Nessun update metadata senza contenuto. (7) RAG sincrono, sanity check bloccante. (8) Ogni modifica ha diff. (9) Solo codice della mission. (10) Tutti gli step implementati |
| **Pass condition** | 10/10 anti-pattern assenti |

---

## 8. Piano migrazione da v1

### Fase A — Pre-deploy (giorno 0)

1. **Snapshot stato v1**: documentare le 5 componenti v1 attive e il loro stato
2. **Aggiungere flag `doc_sync_version`** nel MISSION_REGISTRY per le prossime mission
3. **Deploy agent doc-sync-v2** + Python CLI

### Fase B — Attivazione v2 (giorno 0)

4. **Aggiornare mission.md**: Mission Phase 6 invoca doc-sync-v2 agent
5. **Test su mission di prova** (non di produzione): verificare Steps 1-6

### Fase C — Declassamento v1 (dopo prima mission v2 ok)

6. **Rimuovere `ssot-registry-auto-update.sh`**:
   - Rimuovere da `~/.claude/settings.json` la entry PostToolUse
   - Archiviare il file in `~/.claude/hooks/archive/`
   - Motivazione: Anti-pattern 6 — aggiorna solo metadati senza contenuto

7. **Rimuovere `ssot-living-agent.md`**:
   - Rimuovere da `~/.claude/agents/`
   - Archiviare in `~/.claude/agents/archive/`
   - Le sue capacita semantiche sono integrate in doc-sync-v2

8. **Declassare `ssot-reflex-guard.sh`**:
   - Mantenerlo attivo come rete di sicurezza
   - Aggiungere commento: "L1 propriocezione passiva — secondario rispetto a DOC-SYNC v2"
   - Output: nerve signals per auditing, non per azione

9. **Mantenere `ssot-living-check.sh`**:
   - Riposizionare come rete di sicurezza secondaria
   - Serve a catturare drift da mission chiuse forzatamente o bypass

### Fase D — Aggiornamento documentazione (giorno 0)

10. **Riscrivere P0-11** in CLAUDE.md e CLAUDE_ECOSYSTEM_CORE.md:
    - Da: "L'operatore deve aggiornare i SSOT dopo task Tipo 2+"
    - A: "DOC-SYNC v2 aggiorna automaticamente i SSOT alla chiusura di ogni mission. L'operatore non deve aggiornare manualmente i SSOT durante una mission."

11. **Aggiornare 00_LSO_LIVING_SOFTWARE_ORGANISM.md**: sezione DOC-SYNC riflette v2

### Periodo di transizione

Non esiste periodo di transizione. La migrazione e atomica:
- v2 si attiva → v1 componenti rimossi/declassati nello stesso giorno
- Le mission gia chiuse con v1 restano con `doc_sync_version: "1.0"` nel registry
- Le nuove mission usano v2 dal primo giorno

---

## 9. Stima costi AI in produzione

### Assunzioni

| Parametro | Valore | Fonte |
|-----------|--------|-------|
| Mission/mese | 20 | Media osservata (148 mission in ~5 mesi = ~30/mese, ma rallentando) |
| File modificati/mission | 8 | Media da stats registry |
| Dimensione diff media | 400 righe | Stima conservativa |
| SSOT impattati diretti/mission | 2 | Media stimata su 123 SSOT / 9 organi |
| SSOT impattati laterali/mission | 1 | Best-effort, spesso 0 |
| Dimensione SSOT media | 3000 chars | Tipico .md in EGI-DOC |
| Chunk per SSOT | 3 | ~3000 chars / 1500 max per chunk |

### Costi per mission

| Step | Modello | Input tokens | Output tokens | Costo |
|------|---------|-------------|--------------|-------|
| 1 — Analisi semantica | Claude Sonnet | ~2000 (diff) | ~500 (summary) | $0.009 |
| 3 — Estrazione concetti | Claude Sonnet | ~800 | ~200 | $0.003 |
| 3 — Validazione candidati (x3) | Claude Sonnet | ~1500 | ~300 | $0.006 |
| 4 — Discriminazione (x3 SSOT) | Claude Sonnet | ~3000 | ~600 | $0.012 |
| 4 — Generazione testo (x3 SSOT) | Claude Sonnet | ~3000 | ~1500 | $0.018 |
| 5 — Embedding (x9 chunk) | OpenAI ada | ~4500 | — | $0.0005 |
| **Totale per mission** | | | | **~$0.05** |

### Costo mensile aggregato

| Scenario | Mission/mese | Costo/mese |
|----------|-------------|-----------|
| Normale | 20 | $1.00 |
| Intenso | 40 | $2.00 |
| Picco | 60 | $3.00 |

**Nota**: il costo e trascurabile rispetto al costo LLM corrente del progetto. L'agent doc-sync-v2 e un Claude Code agent che usa il modello della sessione corrente, quindi il costo e incluso nell'uso CLI esistente (non genera API call separate per Steps 1-4). Solo Step 5 (embedding OpenAI) genera costo API aggiuntivo, stimato ~$0.01/mese.

---

## 10. Stima latenza per chiusura mission

### Mission normale (2-3 SSOT impattati, 1 additivo, 1 sostitutivo, 1 laterale)

| Step | Durata stimata | Note |
|------|---------------|------|
| 1 — Analisi semantica | 10-15s | 1 LLM call |
| 2 — Identificazione diretta | 2-3s | Pattern matching deterministico |
| 3 — Discovery laterale | 15-25s | Query RAG + validazione LLM |
| 4 — Generazione/applicazione | 20-40s | LLM generation + file write per SSOT |
| 5 — RAG re-indexing | 10-20s | Embedding + upsert per 3 SSOT + sanity check |
| 6 — Audit trail | 3-5s | File writes |
| **Totale** | **60-110s** | ~1.5 minuti mediana |

### Mission grande (5+ SSOT impattati, diff > 1000 righe)

| Step | Durata stimata | Note |
|------|---------------|------|
| 1 — Analisi semantica | 20-30s | Diff chunked, analisi per file |
| 2 — Identificazione diretta | 3-5s | Piu file da matchare |
| 3 — Discovery laterale | 20-35s | Piu concetti, piu candidati |
| 4 — Generazione/applicazione | 40-90s | Piu SSOT da processare |
| 5 — RAG re-indexing | 20-45s | Piu chunk, piu embedding, piu sanity check |
| 6 — Audit trail | 3-5s | File writes |
| **Totale** | **110-210s** | ~3 minuti mediana |

### Impatto sostitutivo (approvazione umana)

Se DOC-SYNC v2 rileva modifiche sostitutive, la mission si sospende in `awaiting_doc_sync_approval`. Il tempo di attesa dipende dall'operatore:
- Se l'operatore e presente: 10-30s per approvazione singola, 30-90s per batch multi-SSOT
- Se l'operatore non e presente: la mission resta sospesa fino al rientro
- Se l'operatore rifiuta: tempo addizionale per risoluzione (opzioni 1-3 di § 3 Step 4.3)

Questo non e overhead DOC-SYNC v2 — e il costo deliberato di garantire che modifiche distruttive agli SSOT siano supervisionate e che nessun drift documentale passi silenziosamente.

---

## Appendice A — File da creare

| File | Tipo | Righe stimate |
|------|------|---------------|
| `~/.claude/agents/doc-sync-v2.md` | Agent definition | ~200 |
| `~/oracode/bin/rag_natan_reindex.py` | Python CLI | ~250 |
| `~/oracode/bin/rag_natan_query.py` | Python CLI | ~80 |
| `~/.claude/hooks/doc-sync-v2-guard.sh` | PostToolUse hook | ~60 |
| `EGI-DOC/audit/doc_sync/.gitkeep` | Directory marker | 1 |

### File da modificare

| File | Modifica |
|------|----------|
| `~/.claude/commands/mission.md` (tutti gli organi) | Mission Phase 6 invoca doc-sync-v2 |
| `~/.claude/settings.json` | Registra guard hook |
| `CLAUDE_ECOSYSTEM_CORE.md` | P0-11 riscritta per v2 |
| `oracode/docs/paradigm/lso/00_LSO_LIVING_SOFTWARE_ORGANISM.md` | Sezione DOC-SYNC aggiornata |

### File da rimuovere/archiviare

| File | Azione |
|------|--------|
| `~/.claude/hooks/ssot-registry-auto-update.sh` | Archiviare in `archive/` |
| `~/.claude/agents/ssot-living-agent.md` | Archiviare in `archive/` |

---

## Appendice B — Dipendenze esterne

| Dipendenza | Versione | Uso |
|------------|---------|-----|
| Python 3.10+ | Sistema | CLI re-indexing |
| `openai` Python SDK | >=1.0 | Embedding generation |
| `psycopg2` o `asyncpg` | Latest | PostgreSQL connection |
| pgvector extension | 0.8.0 (gia installato) | Vector storage/search |
| OpenAI API key | `OPENAI_API_KEY` env | Embedding |

**Nota**: tutte le dipendenze sono gia disponibili nell'ambiente NATAN_LOC (`python_ai_service/requirements.txt`). Non servono installazioni aggiuntive.

---

## 11. Coverage nativa (v2.1.0)

Estensione approvata 2026-05-12 (specifica § 11). Implementa la **copertura** come categoria di prima classe, ortogonale al drift.

### Componenti implementati

| Componente | Path | Stato |
|-----------|------|-------|
| CLI coverage | `/home/fabio/oracode/bin/rag_natan_coverage.py` | Operativo |
| Config soglie | `EGI-DOC/docs/lso/COVERAGE_CONFIG.json` | Operativo |
| PreToolUse hook | `~/.claude/hooks/coverage-check-precheck.sh` | Operativo (wired M-189, 2026-05-15) |
| Cron settimanale | `docsync_weekly_reglob.py` | Previsto (specifica § 11.5) |
| History | `~/.local/state/docsync_coverage_history.jsonl` | Operativo |

### Comportamento hook

- Matcher: `Write|Edit` (posizione 9, dopo `organ-index-guard`)
- Default: **non-bloccante** (exit 0 + stderr `[COVERAGE-WARN]`)
- Bloccante con: `DOCSYNC_COVERAGE_HOOK_BLOCKING=1`
- Skip silenzioso su: file `.md`, `.lock`, `.json`, `README*`, `CHANGELOG*`, repo non-ecosistema

### Riferimento completo

Specifica: `DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` § 11 (soglie, definizioni formali, alert cron).

---

## Changelog v1.0.0 → v1.1.0

Modifiche in risposta a `DOC-SYNC_v2_RICHIESTA_REVISIONE.md` v1.0.0 (2026-04-30, Fabio Cherici / Astra).

### Punto 1 — Idempotenza granulare
- **§ 1.1**: Diagramma aggiornato — Step 4 menziona batch approval
- **§ 3 Step 4**: Riscritta interamente. Nuova sotto-sezione **4.1** definisce modello di stato con 10 stati espliciti (`pending`, `applied`, `failed`, `awaiting_approval`, `approved`, `rejected`, `awaiting_resolution`, `superseded`, `flagged_for_rewrite`, `no_change`). Transizioni ammesse definite per ogni stato. Nuova sotto-sezione **4.2** specifica flusso per azione singola con hash verification: se `ssot_content_hash` attuale ≠ hash salvato → azione marcata `superseded` (rileva modifiche manuali inter-esecuzione). `doc_sync_actions.json` schema esteso con `ssot_content_hash` e `resolution_method`
- **§ 4**: Esempi estesi per coprire casi rifiuto (opzione 2 e 3) e caso `superseded`
- **§ 7 Test 5**: Riscritto per testare idempotenza granulare — simulazione fallimento a meta Step 4, riesecuzione verifica hash match/mismatch, verifica che approvazioni gia concesse non vengano ripresentate
- **§ 7 Test 6**: Aggiornato per verificare che `doc_sync_actions.json` rifletta stati granulari al momento del fallimento

### Punto 2 — Gestione rifiuto patch sostitutiva
- **§ 2 Anti-pattern 3**: Aggiornato per menzionare `awaiting_doc_sync_resolution` e assenza dell'opzione "procedi senza fare nulla"
- **§ 3 Step 4**: Nuova sotto-sezione **4.3** definisce le 3 opzioni di risoluzione rifiuto: (1) Riconsidera e approva, (2) Modifica manuale + rivalida (con re-discriminazione e re-hash), (3) Crea mission di rewrite (via MISSION_QUEUE.json). Esplicito: "L'opzione 'procedi senza fare nulla' non esiste"
- **§ 7 Test 2**: Esteso con Mission C che testa il percorso rifiuto → risoluzione obbligatoria. Pass condition aggiornata: "Mission C non chiude con SSOT incoerente"

### Punto 3 — Cascading sostitutivo
- **§ 3 Step 4**: Nuova sotto-sezione **4.4** definisce: presentazione in batch unico, applicazione atomica per batch (approvate restano `approved` fino a completamento batch), gestione rifiuti misti (tutte le decisioni raccolte prima di applicare), Step 5 si avvia solo quando tutti gli SSOT risolti. Motivazione dell'atomicita: coerenza semantica cross-SSOT. Include esempio strutturato di prompt batch multi-patch
- **§ 10**: Stima latenza per batch sostitutivo aggiornata (30-90s per batch multi-SSOT)

### Punto 4 — Sanity check RAG bloccante
- **§ 1.1**: Diagramma aggiornato — Python CLI menziona "Blocking sanity check"
- **§ 2 Anti-pattern 7**: Aggiornato per menzionare sanity check bloccante
- **§ 3 Step 5**: Failure points aggiornati — sanity check da "WARNING" a "**BLOCCA**"
- **§ 6**: Sezione sanity check riscritta: (1) retry con backoff 2x/30s, (2) se fallisce dopo retry → outcome "failed", failure_reason "rag_sanity_check_failed_<slug>", mission resta closing, (3) diagnostica con comando REINDEX suggerito, (4) retry manuale riparte da Step 5
- **§ 6 Timeout**: Sanity check retry portato a 2x (era 1x)
- **§ 7 Test 4**: Titolo e contenuto aggiornati per includere "sanity-checked". Terza verifica aggiunta: "Se sanity check fallisce: mission NON passa a closed"
- **§ 7 Test 8**: Punto (7) aggiornato: "RAG sincrono, sanity check bloccante"

### Punto 5 — Disambiguazione naming
- **§ 1.1**: Diagramma: "Phase 6" → "Mission Phase 6 — Closing"; "Phase 1-6" → "Step 1-6"
- **§ 1.2**: "da Phase 6 mission skill" → "da Mission Phase 6"
- **§ 1.3**: "Phase 6 mission skill" → "Mission Phase 6 — Closing"; "Fasi 1-6" → "Steps 1-6"
- **§ 1.4**: Nuova sotto-sezione che formalizza la convenzione: "Mission Phase N" per il protocollo mission, "Step N" per DOC-SYNC v2
- **§ 2**: Tutti i riferimenti "Phase" interni a DOC-SYNC sostituiti con "Step"
- **§ 3**: Titolo sezione → "Mappa dei 6 step". Tutte le sotto-sezioni rinominate da "Fase N" a "Step N"
- **§ 6**: "Fasi 1-4" → "Steps 1-4" ovunque
- **§ 7**: Tutti i riferimenti "Phase 5", "Phase 6" → "Step 5", "Step 6". "Phase 6 di mission.md" → "Mission Phase 6"
- **§ 8**: "Phase 6 invoca" → "Mission Phase 6 invoca"
- **§ 9-10**: "Fase" → "Step" nelle tabelle costi e latenza
- Ricerca-e-sostituisci coerente in tutto il documento, incluse appendici

### Sezioni non modificate (confermate dalla review)
- § 2 Anti-pattern check (impianto generale invariato, solo aggiornamenti consequenziali)
- § 4 Algoritmo di discriminazione (invariato, solo esempi estesi)
- § 5 Discovery laterale (invariata)
- § 6 Transazionalita e chunking (invariati, solo sanity check aggiornato)
- § 8 Piano migrazione v1 (invariato, solo naming aggiornato)
- § 9 Stime costi (invariate)
- § 10 Stime latenza (invariate, solo nota batch sostitutivo)
- Appendici A e B (invariate, solo naming)

---

## Firma

Proposto da: **Padmin D. Curtis** (AI Partner OS3.0)
Per: **Fabio Cherici**, CEO/founder Florence EGI S.R.L.
Data originale: 2026-04-30
Aggiornamento: 2026-05-15 (M-189 — allineamento a stato reale v2.1.0)
Stato: **v2.1.0 — Implementato e in produzione**

Specifica di riferimento: `DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` v2.1.0
Driver revisione: `DOC-SYNC_v2_RICHIESTA_REVISIONE.md` v1.0.0

Cronologia:
- 2026-04-30: v1.1.0 proposto
- 2026-05-08: v2.0.0 attivato in produzione (M-160a)
- 2026-05-12: v2.1.0 specifica coverage approvata
- 2026-05-15: v2.1.0 piano allineato (M-189), coverage hook wired
